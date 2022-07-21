Shader "wanzi/Line1"
//该方法优点：简单、外描边比较准确；缺点：描边的粗细程度会和深度有关
{
    Properties
    {
        _LineCol("描边颜色",color) = (0,0,0,1)
        _LineSize("粗度",range(0,1)) = 0.1 
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        Pass
        {
            //模板测试
            Stencil
            {
                Ref 1
                Comp Always
                Pass Replace
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 posCW : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.posCW = UnityObjectToClipPos(v.vertex);
                return o;
            }

             half4 frag (v2f i) : SV_Target
            {
                half4 col = half4(1,1,1,1);
                return col;
            }
            ENDCG

        }

        //描边pass
        Pass
        {
            Stencil
            {
                Ref 1
                Comp NotEqual
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 posCW : SV_POSITION;
            };

            float _LineSize;
            half4 _LineCol;

            v2f vert (appdata v)
            {
                v2f o;

                float4 posVS = mul(UNITY_MATRIX_MV,v.vertex);  //观察空间顶点信息
                float3 normalVS = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);  //法线模型空间到观察空间
                normalVS.z = -0.5;  //观察空间顶点深度+0.5
                posVS += float4(normalize(normalVS), 0) * _LineSize;
                o.posCW = mul(UNITY_MATRIX_P,posVS);           //观察空间>>裁剪空间
                //o.posCW *= o.posCW.w ;
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = _LineCol;
                return col;
            }
            ENDCG
        }
    }
}
