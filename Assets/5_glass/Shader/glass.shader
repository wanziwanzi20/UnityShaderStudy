Shader "wanzi/glass"
{
    Properties
    {
        _MainMatCap ("主要纹理", 2D) = "white" {}
        _WarpMatCap ("扰动纹理", 2D) = "white" {}
        _WarpInt ("扰动强度",range(0,2)) = 1
        _MainCol ("主要颜色",Color) = (0.5,0.5,0.5,1)
    }
    SubShader
    {
        Blend SrcAlpha OneMinusSrcAlpha
        Tags { "RenderType"="Transparent" "Queue"="Transparent+10"}

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
                float4 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;    //存储世界空间法线信息
                float3 nDirVS : TEXCOORD2;    //存储观察空间法线信息
                float4 posVS : TEXCOORD3;     //存储观察空间顶点信息
                float4 posWS : TEXCOORD4;     //存储世界空间顶点信息

            };

            sampler2D _MainMatCap;
            sampler2D _WarpMatCap;
            float _WarpInt;
            float4 _MainCol;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld,v.vertex);  //模型空间顶点到世界空间顶点
                o.posVS = mul(UNITY_MATRIX_MV,v.vertex);    //模型空间到观察空间转换
                o.nDirWS = UnityObjectToWorldNormal(v.normal);   //世界空间法线信息获取
                o.nDirVS = mul(UNITY_MATRIX_IT_MV,v.normal);   //观察空间法线信息获取
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //获取向量
                float3 nDirWS = normalize(i.nDirWS);
                float3 nDirVS = normalize(i.nDirVS);
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);  

                //中间计算
                float3 nDirCpv = cross(normalize(i.posVS),nDirVS);
                float ndotv = dot(nDirWS,vDirWS);

                //公式
                float2 matcapUV = float2(-nDirCpv.y,nDirCpv.x) * 0.5 + 0.5;
                float fresnel = 1 - smoothstep(0,1,ndotv);
                float2 warpUV = fresnel * _WarpInt + matcapUV;
                float Lerpz = clamp(fresnel*_WarpInt,0,1);

                fixed4 MainMatCap = tex2D(_MainMatCap, matcapUV);
                fixed4 WarpMatCap = tex2D(_WarpMatCap, warpUV);
                fixed3 WarpCol = lerp(_MainCol.rgb*0.5 , _MainCol.rgb*WarpMatCap.rgb , Lerpz);
                fixed3 MianRGB = WarpCol + MainMatCap.rgb;
                fixed Alpha = max(MainMatCap.r , fresnel);
                
                return fixed4(MianRGB,Alpha);
            }
            ENDCG
        }
    }
}
