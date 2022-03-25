﻿Shader "wanzi/BlinnPhong" {
    Properties {
        _Pow ( "高光次幂" , Range(1,100) ) = 30   //浮点数
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform float _Pow;

            // 输入结构
            struct VertexInput {
                float4 vertex : POSITION;   // 将模型顶点信息输入进来
                float4 normal : NORMAL;     // 将模型法线信息输入进来
            };
            // 输出结构
            struct VertexOutput {
                float4 pos : SV_POSITION;   // 由模型顶点信息换算而来的顶点屏幕位置
                float4 posWS : TEXCOORD0;       // 世界空间顶点位置 : TEXCOORD0; 
                float3 nDirWS : TEXCOORD1;  // 由模型法线信息换算来的世界空间法线信息
            };
            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;               // 新建一个输出结构
                o.pos = UnityObjectToClipPos( v.vertex );       // 变换顶点信息 并将其塞给输出结构
                o.posWS = mul(unity_ObjectToWorld, v.vertex);   // 变换顶点位置 OS>WS
                o.nDirWS = UnityObjectToWorldNormal(v.normal);  // 变换法线信息 并将其塞给输出结构
                return o;                                       // 将输出结构 输出
            }
            // 输出结构>>>像素
            float4 frag(VertexOutput i) : COLOR {
                float3 nDir = normalize(i.nDirWS);                         // 获取nDir！！必须要规格化！！
                float3 lDir = _WorldSpaceLightPos0.xyz;         // 获取lDir
                float3 vDir = normalize(_WorldSpaceCameraPos.xyz -i.posWS.xyz);
                float3 hDir = normalize(lDir + vDir);

                float ndotl = dot(nDir,lDir);
                float ndoth = dot(hDir,nDir);
                float lambert = max(ndotl,0);
                float blinnphong = pow(max(ndoth,0),_Pow);
                float LightModel = lambert + blinnphong;
                return LightModel;  // 输出最终颜色
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}