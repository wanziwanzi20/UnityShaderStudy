Shader "Hidden/wanzi/BoxBlur"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlurOffset ("模糊强度",Float) = 1
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
            //float4 _MainTex_TexelSize;   //x=1/width; y=1/height; w=height;   //方法1
            //float _BlurOffset;   //方法1
            float4 _BlurOffset;   

            half4 frag (v2f_img i) : SV_Target   //注意v2f_img
            {
                //half4 d = _MainTex_TexelSize.xyxy * half4(-1,-1,1,1) * _BlurOffset;   //方法1
                half4 d = _BlurOffset.xyxy * half4(-1,-1,1,1);
                half4 s = 0;
                s += tex2D(_MainTex, i.uv + d.xy);
                s += tex2D(_MainTex, i.uv + d.zy);
                s += tex2D(_MainTex, i.uv + d.xw);
                s += tex2D(_MainTex, i.uv + d.zw);
                s *= 0.25;
                return s;
            }
            ENDCG
        }
    }
}
