Shader "Hidden/wanzi/GaussianBlur"
{
    CGINCLUDE
    //自定义库
    #include "UnityCG.cginc"

    sampler2D _MainTex;
    //float4 _MainTex_TexelSize;   //x=1/width; y=1/height; w=height;   //方法1
    float4 _BlurOffset;   

    half4 frag_HorizontalBlur (v2f_img i) : SV_Target   //注意v2f_img
    {
        half2 uv1 = i.uv + _BlurOffset.xy * half2(1,0) * -2.0;
        half2 uv2 = i.uv + _BlurOffset.xy * half2(1,0) * -1.0;
        half2 uv3 = i.uv;
        half2 uv4 = i.uv + _BlurOffset.xy * half2(1,0) * 1.0;
        half2 uv5 = i.uv + _BlurOffset.xy * half2(1,0) * 2.0;   //uv偏移计算可在顶点shader中计算 性能更优

        half4 s = 0;
        s += tex2D(_MainTex, uv1) * 0.05;
        s += tex2D(_MainTex, uv2) * 0.25;
        s += tex2D(_MainTex, uv3) * 0.40;
        s += tex2D(_MainTex, uv4) * 0.25;
        s += tex2D(_MainTex, uv5) * 0.05;
        return s;
    }

    half4 frag_VerticalBlur (v2f_img i) : SV_Target   //注意v2f_img
    {
        half2 uv1 = i.uv + _BlurOffset.xy * half2(0,1) * -2.0;
        half2 uv2 = i.uv + _BlurOffset.xy * half2(0,1) * -1.0;
        half2 uv3 = i.uv;
        half2 uv4 = i.uv + _BlurOffset.xy * half2(0,1) * 1.0;
        half2 uv5 = i.uv + _BlurOffset.xy * half2(0,1) * 2.0;   //uv偏移计算可在顶点shader中计算 性能更优

        half4 s = 0;
        s += tex2D(_MainTex, uv1) * 0.05;
        s += tex2D(_MainTex, uv2) * 0.25;
        s += tex2D(_MainTex, uv3) * 0.40;
        s += tex2D(_MainTex, uv4) * 0.25;
        s += tex2D(_MainTex, uv5) * 0.05;
        return s;
    }
    //结束自定义库
    ENDCG

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

        Pass    //pass0
        {
            CGPROGRAM
            //_img可以只使用片元shader
            #pragma vertex vert_img   
            //调用自建库中的frag_BoxFilter_4Tap片元着色器
            #pragma fragment frag_HorizontalBlur
            ENDCG
        }

        Pass   //pass1
        {
            CGPROGRAM
            //_img可以只使用片元shader
            #pragma vertex vert_img   
            //调用自建库中的frag_BoxFilter_9Tap片元着色器
            #pragma fragment frag_VerticalBlur
            ENDCG
        }
    }
}
