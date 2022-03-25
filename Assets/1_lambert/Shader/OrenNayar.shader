Shader "wanzi/OrenNayar"
{
    Properties
    {
        _MianCol ("颜色",Color) = (1.0,1.0,1.0,1.0)
        _RoughTex ("粗糙度贴图", 2D) = "white" {}
        [PowerSlider(2)]_Roughness("粗糙度" , Range(0,5.0)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;  //模型法线信息
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float4 posWS : TEXCOORD1;    //世界空间顶点信息
                float3 nDirWS : TEXCOORD2;   //世界空间法线信息
            };

            float3 _MianCol;
            sampler2D _RoughTex;
            float4 _RoughTex_ST;
            float _Roughness;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);  //裁切空间顶点信息
                o.posWS = mul(unity_ObjectToWorld,v.vertex);   //世界空间顶点信息
                o.nDirWS = UnityObjectToWorldNormal(v.normal);   //模型空间法线转换为世界空间
                o.uv = v.uv * _RoughTex_ST.xy + _RoughTex_ST.zw;  //uv启用Tiling Offset
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //向量获取
                float3 nDirWS = normalize(i.nDirWS);              
                float3 lDirWS = _WorldSpaceLightPos0.xyz;
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                //采样贴图
                float RoughCol = tex2D(_RoughTex,i.uv).r * _Roughness;
                //计算中间值
                float PowRough = RoughCol * RoughCol;
                float ndotv = dot(nDirWS,vDirWS);
                float ndotl = dot(nDirWS,lDirWS);
                //计算公式
                float A = 1.0 - 0.5 * (PowRough/(PowRough+0.33));
                float B = 0.45 * (PowRough/(PowRough+0.09));
                float acosNV = acos(ndotv);  //acos 反余弦
                float acosNL = acos(ndotl);
                float x = max( acosNV , acosNL);   
                float y = min( acosNV , acosNL);
                float w = length( vDirWS - nDirWS * ndotv ) * length( lDirWS - nDirWS * ndotl);
                float Diffuse = 1;
                float OrenNayar = Diffuse * ndotl * (A + B * max(0.0,w) * sin(x) * tan(y) );
                float LightingModel = saturate(OrenNayar);  //钳制值为0-1，否则暗部会有亮点
                float3 maincol = LightingModel * _MianCol;

                return float4(maincol,1);
            }
            ENDCG
        }
    }
}
