Shader "wanzi/wood"
{
    Properties
    {
        [Header(GAME)]
        [PowerSlider(2.0)]_Game("打磨进度",range(0,1)) = 0   //_Game!!
        _Gray("灰化程度",range(0,1)) = 0
        [Header(Light)]
        _EmissionCol("发光颜色",Color) = (0,1,0.25,1)
        [Toggle]_IsShine("是否发光",int) = 0
        [Header(Alpha)]
        _AlphaTex("透明贴图",2D) = "white"{}
        [Header(Maincolor)]
        [Toggle] _Invert ("阴影开关", Float) = 0 
        _Texture("纹理贴图",2D) = "white"{}
        _BeseColInt("基础颜色提亮",range(0,1)) = 0
        [normal]_NormalMap("法线贴图",2D) = "bump"{}
        _RoughTex("粗糙度贴图;0:粗糙;1:光滑",2D) = "gray"{}
        _SpecTex("镜面贴图",2D) = "gray"{}
        _MatCap("清漆matcap贴图",2D) = "black"{}
        _CubeMap("立方体贴图",Cube) = "white"{}
        _Rotate("y轴旋转数值",range(0,360)) = 0
        _phongPow("高光次幂",range(1,10)) = 1
        _fresnelPow("菲涅尔次幂",range(1,10)) = 1
        _RoughMax("光滑部分程度",Range(0,1)) = 0.5
        _RoughMin("粗糙部分程度",Range(0,1)) = 0.5
        [Header(Varnish)]
        _VarnishInt("清漆强度",range(0,1)) = 0
        _VarnishRough("清漆粗糙度",range(0,1)) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("SrcBlend", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("DstBlend", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Blend [_SrcBlend] [_DstBlend]

        Pass
        {
            Tags {
                "LightMode"="ForwardBase"
            }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            sampler2D _Texture;
            sampler2D _AlphaTex;
            sampler2D _SpecTex;
            sampler2D _RoughTex;
            sampler2D _MatCap;
            samplerCUBE _CubeMap;
            float4 _CubeMap_HDR;   //确保HDR信息正确
            float4 _EmissionCol;   
            sampler2D _NormalMap;
            float _BeseColInt;
            float _VarnishInt;
            float _VarnishRough;
            float _Invert;
            float _Rotate;
            float _phongPow;
            float _fresnelPow;
            float _RoughMax;
            float _RoughMin;
            float _Game;
            float _Gray;
            float _IsShine;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 normal : NORMAL;    //物体空间法线信息
                float4 tangent : TANGENT;  //物体空间切线信息
            };

            struct v2f
            {
                float4 pos : SV_POSITION;    //使用内置阴影必须命名为pos
                float2 uv : TEXCOORD0;
                float3 posWS : TEXCOORD1;    //世界空间顶点信息
                float3 nDirWS : TEXCOORD2;   //世界空间法线信息
                float3 tDirWS : TEXCOORD3;   //世界空间切线信息
                float3 bDirWS : TEXCOORD4;   //世界空间副切线信息
                float3 posVS : TEXCOORD5;    //观察空间顶点信息
                LIGHTING_COORDS(5,6)          // 投影相关
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.posWS = mul(unity_ObjectToWorld,v.vertex);
                o.posVS = WorldSpaceViewDir(v.vertex);
                o.nDirWS = UnityObjectToWorldNormal(v.normal);
                o.tDirWS = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz); // 切线方向 OS>WS
                o.bDirWS = normalize(cross(o.nDirWS, o.tDirWS) * v.tangent.w);  // 副切线方向
                o.uv = v.uv;
                TRANSFER_VERTEX_TO_FRAGMENT(o)                  // 投影相关
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //_Game = 1.0 ;  //弃用_Game
                //阴影相关
                float shadow = LIGHT_ATTENUATION(i) ;
                float shadowLerp = lerp(1.0,shadow,_Invert);   //_Invert 开关
                //获取向量&向量计算
                float3 lDirWS = normalize(_WorldSpaceLightPos0.xyz);
                float3x3 TBN = float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 var_NormalMap = UnpackNormal(tex2D(_NormalMap,i.uv));
                float3 nDirWS = normalize(mul(var_NormalMap,TBN));
                float3 vDirWS = normalize(_WorldSpaceCameraPos.xyz - i.posWS.xyz);
                float3 rDirWS = reflect(vDirWS,nDirWS);   //=vrDir
                float3 ndotl = dot(nDirWS,lDirWS);
                float ndotv = max(dot(nDirWS,vDirWS),0);
                float vrdotr = dot(rDirWS,-lDirWS);
                float lambert = ndotl * 0.5 + 0.5 ;
                float phong = pow(max(vrdotr,0),_phongPow);  
                float fresnel = pow(1-ndotv,_fresnelPow);
                //matcapUV优化
                float3 nDirVS = mul(UNITY_MATRIX_V, nDirWS);        // 计算MatcapUV
                float3 npDir = cross(nDirVS,normalize(i.posVS));
                float2 matcapUV = float2(-npDir.y,npDir.x) * 0.5 + 0.5;   //新
                //float2 matcapUV = nDirVS.xy * 0.5 + 0.5 ;   //旧
                //采样纹理贴图
                float3 var_Texture = tex2D(_Texture,i.uv).rgb;
                float3 var_SpecTex = tex2D(_SpecTex,i.uv).rgb;
                float3 var_RoughTex = tex2D(_RoughTex,i.uv).rgb;
                float3 var_MatCap = tex2D(_MatCap,matcapUV).rgb;
                float var_AlphaTex = tex2D(_AlphaTex,i.uv).a;
                //打磨过程相关1
                float GrayInt = _Gray * (1-_Game);
                float3 GrayCol = lerp(var_Texture,0.9,_Gray);    //灰色化
                float3 GameCol = lerp(GrayCol,var_Texture,_Game);
                //Hdir水平面旋转
                float rad = _Rotate * UNITY_PI / 180;    //unity角度转弧度
                float2x2 turn = float2x2(cos(rad),-sin(rad),sin(rad),cos(rad));  //水平面旋转矩阵
                float2 rDirRxz = mul(turn,rDirWS.xz);   //r向量xz平面旋转
                float3 rDirR = float3(rDirRxz.x , rDirWS.y , rDirRxz.y);
                //解码Hdir
                float rough = lerp(_RoughMin,_RoughMax,var_RoughTex);
                float MipLevel = rough * 9;
                float4 CubeMapcol = texCUBElod(_CubeMap,float4(-rDirR,MipLevel));   //-rDirR = vrDir
                float3 MainHDR = DecodeHDR(CubeMapcol,_CubeMap_HDR);   //确保HDR信息正确
                float3 HDRlerp = lerp(MainHDR,1,GrayInt);
                //上色----
                //漫反射部分
                float3 BeseCol = HDRlerp * GameCol * (1.2 + _BeseColInt) * shadowLerp ; //1.2提亮基础色
                float3 HighLight = phong * max(var_SpecTex , var_RoughTex) * _Game;      //高光
                float3 fresnelCol = fresnel * var_SpecTex;    //菲涅尔
                float3 MainDiff = BeseCol * lambert + HighLight + fresnelCol;
                //镜面反射部分//清漆部分
                float3 VarnishR = lerp(var_MatCap,0.0,_VarnishRough);
                float3 MainVarnish = VarnishR * MainHDR * _VarnishInt * _Game;
                //发光部分
                float EmTime = sin(_Time.w) * 0.5 + 0.5;
                float3 Emission = (pow((1-ndotv),3) + (ndotv * 0.2)) * _EmissionCol * EmTime * _IsShine;
                //颜色整合
                float3 MainCol = MainDiff + MainVarnish + Emission; 
                //透明度剔除
                //clip(var_AlphaTex-0.5);
                
                return float4(MainCol * var_AlphaTex,var_AlphaTex);
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}
