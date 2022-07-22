Shader "wanzi/Line3"
//裁切空间描边；优点：描边大部分情况下宽度一致，不会受到物体远近的影响
//缺点：物体的顶点过于少的情况下，描边粗细变化还是会受到影响
{
    Properties
    {
        _LineCol("描边颜色",color) = (0,0,0,1)
        _LineSize("粗度",range(0,2)) = 0.1 
        [Toggle(ISTEST_ON)]_IsTest("开启黑色",float) = 0
        [Toggle(ISNORMALCOL_ON)]_IsNormalCol("顶点颜色是描边偏移方向",int) = 0
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
            //声明本地关键字
            #pragma shader_feature ISTEST_ON

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
                #if ISTEST_ON
                    half4 col = half4(0,0,0,1);
                #else
                    half4 col = half4(1,1,1,1);
                #endif
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
            //声明本地变量
            #pragma shader_feature ISNORMALCOL_ON

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;     //物体空间法线信息
                float4 color : COLOR;

                float2 uv0 : TEXCOORD0;     // 需要UV坐标 采样法线贴图
                float4 tangent : TANGENT;   // 构建TBN矩阵 需要模型切线信息
            };

            struct v2f
            {
                float4 posCW : SV_POSITION;
                float4 color :TEXCOORD0;
            };

            float _LineSize;
            half4 _LineCol;

            v2f vert (appdata v)
            {
                v2f o;
                o.color = v.color;
                float3 nDirWS = UnityObjectToWorldNormal(v.normal);  // 法线方向 OS>WS
                float3 tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                float3 bDirWS = normalize(cross(nDirWS, tDirWS) * v.tangent.w);  // 副切线方向
                float3x3 TBN = float3x3(tDirWS,bDirWS,nDirWS);
                //v.color.rgb = v.color.rgb * 0.5 + 0.5;
                v.color.rgb /= 255;
                float3 moveWS = normalize(mul(o.color.rgb, TBN)); 

                //float3 nDirWS = UnityObjectToWorldNormal(v.normal);  // 法线方向 OS>WS  //else备份
                
                float xyParams = _ScreenParams.x/_ScreenParams.y;  //_ScreenParams.x为屏幕宽 y高
                float3 normalCS = mul(UNITY_MATRIX_VP,moveWS);  //法线 世界空间到裁剪空间
                float2 LineOffset = normalize(normalCS.xy) * (_LineSize * 0.1); //计算偏移量
                LineOffset.x /= xyParams;
                o.posCW = UnityObjectToClipPos(v.vertex);
                float ctrl = clamp(1/o.posCW.w,0,1);  // 1/o.posCW.w:齐次除法  限制远处的描边不好太粗
                // *o.posCW.w ：因为后续会转换成NDC坐标，会除w进行缩放，所以先乘一个w，那么该偏移的距离就不会在NDC下有变换
                o.posCW.xy += LineOffset * o.posCW.w * ctrl;   
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
