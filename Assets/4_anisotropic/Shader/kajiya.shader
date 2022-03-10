
Shader "wanzi/anisotropic" {
    Properties {
        _MainColor ( "主体颜色" , Color ) = (0.5,0.5,0.5,1)   //颜色
        _HighColor ( "高光颜色" , Color ) = (1,1,1,1)   //颜色
        _WarpInt ("扰动强度", Range(0,1) ) = 0.5    //扰动强度
        _WarpPowInt ("高光集中度", Range(0,200) ) = 100    //扰动pow的强度
        _NoiseTex ( "扰动纹理" , 2D ) = "white" {}   //扰动纹理
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        //Blend SrcAlpha OneMinusSrcAlpha    //混合模式 正常混合
        Pass {
            Name "MainColor"
            Tags {
                "LightMode"="ForwardBase"
            }


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform float3 _MainColor;
            uniform float3 _HighColor;
            uniform float _WarpInt;
            uniform float _WarpPowInt;
            uniform sampler2D _NoiseTex;
            uniform float4 _NoiseTex_ST;    //启用tile

            // 输入结构
            struct VertexInput {
                float4 vertex : POSITION;   // 将模型空间顶点信息输入进来
                float4 normal : NORMAL;     // 将模型法线信息输入进来
                float2 uv0 : TEXCOORD0;     // 需要UV坐标 采样法线贴图
                float4 tangent : TANGENT;   // 构建TBN矩阵 需要模型切线信息
            };
            // 输出结构
            struct VertexOutput {
                float4 pos : SV_POSITION;   // 由模型顶点信息换算而来的裁剪空间顶点/必须获取
                float2 uv0 : TEXCOORD0;
                float3 nDirWS : TEXCOORD1;  // 由模型法线信息换算来的世界空间法线信息
                float3 tDirWS : TEXCOORD2;  // 世界空间切线信息
                float3 bDirWS : TEXCOORD3;  // 世界空间副切线信息
                float4 posWS    : TEXCOORD4;  // 世界空间顶点位置
            };
            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;               // 新建一个输出结构
                o.posWS = mul(unity_ObjectToWorld, v.vertex);   // 顶点位置 物体空间到世界空间
                o.pos = UnityObjectToClipPos( v.vertex );       // 模型空间顶点位置转换到裁剪空间 并将其塞给输出结构
                //o.pos = mul(UNITY_MATRIX_MVP,v.vertex);       // 模型空间顶点位置转换到裁剪空间 并将其塞给输出结构 等同于上面方法性能较差
                o.uv0 = TRANSFORM_TEX(v.uv0, _NoiseTex);          // UV0支持TilingOffset的内置方法
                o.nDirWS = UnityObjectToWorldNormal(v.normal);  // 法线方向 OS>WS
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                //o.bDirWS = cross(o.nDirWS, o.tDirWS) * v.tangent.w;  // 副切线方向 
                return o;                                       // 将输出结构 输出
            }
            // 输出结构>>>像素
            float4 frag(VertexOutput i) : COLOR {
                float ver_NoiseTex = tex2D(_NoiseTex, i.uv0).g; //采样噪声贴图g通道
                float3 nDirWS = i.nDirWS;                         // 获取世界空间nDir
                float3 lDir = _WorldSpaceLightPos0.xyz;         // 获取世界空间lDir
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);  //获取世界空间视角方向
                float3 hDir = normalize( vDirWS + lDir);          //获取半角方向

                float uvBias = (ver_NoiseTex - 0.5) * _WarpInt;     // 计算UV偏移值/法线沿副切线方向偏移量
                float3 bDirWS = normalize(cross(i.tDirWS,nDirWS) + mul(nDirWS , uvBias));  //获取世界空间副切线方向
                float TdotH = dot(bDirWS ,hDir);               //副切线方向dot半角方向
                float kajiya= pow(sqrt( 1- mul(TdotH , TdotH) ),_WarpPowInt);  //卡吉亚模型
                float nDotv = max(dot(nDirWS,vDirWS),0);     //世界空间法线向量点乘世界空间观察向量
                float nvPow = pow(nDotv,1.5);

                float nDotl = dot(nDirWS, lDir);              // nDir点积lDir
                float HalfLambert = nDotl * 0.5 + 0.5 ;                // 半兰伯特
                float hlPow = pow(max(nDotl,0),1.2);
                float highlight = kajiya * nvPow * hlPow ;
                float3 maincolor = HalfLambert * _MainColor;
                float3 HighColor = highlight * _HighColor;
                float3 mainRGB = maincolor + HighColor;
                return float4(mainRGB, 1.0);  // 输出最终颜色
            }
            ENDCG
        }
    }
    //FallBack "Diffuse"
}