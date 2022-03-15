Shader "Hidden/wanzi/ColorAdjustment"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Brightness("亮度",Float) = 1
        _Saturation("饱和度",Range(0,2)) = 1
        _Contrast("对比度",Range(0,2)) = 1
        _DarkInt("暗角范围",Range(0.05,3)) = 1.5
        _DarkNess("暗角闭塞程度",Range(1.,5)) = 5
        _DarkPow("暗角光滑度",Range(0.05,5)) = 5
    }
    SubShader
    {
        
        Cull Off       //剔除关闭
        ZWrite off     //深度写入关闭
        ZTest Always   //深度测试永远通过

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img   
            //_img可以只使用片元shader
            #pragma fragment frag
            #include "UnityCG.cginc"


            sampler2D _MainTex;
            float _Brightness;
            float _Saturation;
            float _Contrast;
            float _DarkInt;
            float _DarkNess;
            float _DarkPow;

            half4 frag (v2f_img i) : SV_Target   //注意v2f_img
            {
                half4 col = tex2D(_MainTex, i.uv);
                //亮度
                half3 brightcolor = col.rgb * _Brightness;
                //饱和度
                float lumin = dot(brightcolor,float3(0.22,0.707,0.071));   //伽马颜色空间转换灰度图
                half3 saturationcol = lerp(lumin,brightcolor,_Saturation);
                //对比度
                half3 midpoint = float3(0.5,0.5,0.5);
                half3 contrastcol = lerp(midpoint,saturationcol,_Contrast);
                //暗角
                half2 uvXY = abs(i.uv.xy-half2(0.5,0.5)) * _DarkInt;
                uvXY = pow(saturate(uvXY),_DarkNess);
                half darkdist = length(uvXY);
                half dark = pow(saturate(1.0-darkdist * darkdist),_DarkPow);
                half3 darkcol = contrastcol * dark;
                return half4(darkcol,col.a);
            }
            ENDCG
        }
    }
}
