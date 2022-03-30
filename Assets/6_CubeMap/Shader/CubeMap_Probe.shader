Shader "wanzi/CubeMap_probe"
{
    Properties
    {
        [normal]_NormalMap("法线贴图",2D) = "bump"{}
        _Rotate("y轴旋转数值",range(0,360)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float4 normal : NORMAL;    //物体空间法线信息
                float4 tangent : TANGENT;  //物体空间切线信息
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 posWS : TEXCOORD1;    //世界空间顶点信息
                float3 nDirWS : TEXCOORD2;   //世界空间法线信息
                float3 tDirWS : TEXCOORD3;   //世界空间切线信息
                float3 bDirWS : TEXCOORD4;   //世界空间副切线信息
            };

            sampler2D _NormalMap;
            float _Rotate;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld,v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);  // 副切线方向
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //获取向量
                float3x3 TBN = float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 var_NormalMap = UnpackNormal(tex2D(_NormalMap,i.uv));
                float3 nDirWS = normalize(mul(var_NormalMap,TBN));
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 rDirWS = reflect(vDirWS,nDirWS);
                //水平面旋转
                /*float rad = _Rotate * UNITY_PI / 180;    //unity角度转弧度
                float2x2 turn = float2x2(cos(rad),-sin(rad)
                                        ,sin(rad),cos(rad));  //水平面旋转矩阵
                float2 rDirRxz = mul(turn,rDirWS.xz);   //r向量xz平面旋转
                float3 rDirR = float3(rDirRxz.x , rDirWS.y , rDirRxz.y);*/

                float4 CubeMapcol = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0,-rDirWS);  //获取反射探测器捕捉的图像
                float3 MainRGB = DecodeHDR(CubeMapcol,unity_SpecCube0_HDR);   //确保HDR信息正确

                return float4(MainRGB,1);
            }
            ENDCG
        }
    }
}
