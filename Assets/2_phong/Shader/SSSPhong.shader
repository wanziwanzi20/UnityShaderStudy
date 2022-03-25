Shader "wanzi/SSSPhong" {
    Properties {
        _SpecularInt ("1" , Range(0,1)) = 1 
        _WorapValue ("2" , Range(0.5,1)) = 1 
        _SpecularScale ("3镜面缩放" , Range(0,1)) = 1 
        _sssOffset ("透射偏移量" , Range(0,1)) = 0.5 
        _sssPow ( "透射能量" , Range(1,100) ) = 30   //浮点数
        _BackInt ( "透射强度" , Range(0,1) ) = 0  //浮点数
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

            uniform float _sssPow;
            uniform float _WorapValue;
            uniform float _SpecularInt;
            uniform float _SpecularScale;
            uniform float _sssOffset;
            uniform float _BackInt;

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
                float3 rDir = reflect(-lDir,nDir);
                float3 hDir = normalize(vDir + lDir);

                float vdotr = saturate(dot(vDir,rDir));
                float ndoth = saturate(dot(nDir,hDir));
                float ndotl = saturate(dot(nDir,lDir));

                //背光
                float3 N_shift = -normalize(nDir * _sssOffset + lDir);
                float ndotvBack = dot(N_shift,vDir);
                float BackLight = pow(saturate(ndotvBack),_sssPow) * _BackInt;

                float diffuse = pow(ndotl * _WorapValue + (1- _WorapValue),2);   //WrapLight环绕光照模型
                float Specular = pow( ndoth , _SpecularInt) * _SpecularScale;

                float LightingModel = diffuse + Specular + BackLight;
                return float4(LightingModel.xxx,1);  // 输出最终颜色
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}