Shader "Hidden/wanzi/BoxBlur"
{
    CGINCLUDE
    //自定义库
    #include "UnityCG.cginc"

    sampler2D _MainTex;
    //float4 _MainTex_TexelSize;   //x=1/width; y=1/height; w=height;   //方法1
    //float _BlurOffset;   //方法1
    float4 _BlurOffset;   

    half4 frag_BoxFilter_4Tap (v2f_img i) : SV_Target   //注意v2f_img
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

    half4 frag_BoxFilter_9Tap (v2f_img i) : SV_Target   //注意v2f_img
    {
        half4 d = _BlurOffset.xyxy * half4(-1,-1,1,1);
        half4 s = 0;
        s += tex2D(_MainTex, i.uv);   //中间像素点
        //四角像素点
        s += tex2D(_MainTex, i.uv + d.xy);
        s += tex2D(_MainTex, i.uv + d.zy);
        s += tex2D(_MainTex, i.uv + d.xw);
        s += tex2D(_MainTex, i.uv + d.zw);
        //上下左右像素点
        s += tex2D(_MainTex, i.uv + half2(0.0,d.w));  //0 1
        s += tex2D(_MainTex, i.uv + half2(0.0,d.y));   //0 -1
        s += tex2D(_MainTex, i.uv + half2(d.x,0.0));   //-1 0
        s += tex2D(_MainTex, i.uv + half2(d.z,0.0));   //1 0

        s = s/9.0;
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
            #pragma fragment frag_BoxFilter_4Tap
            ENDCG
        }

        Pass   //pass1
        {
            CGPROGRAM
            //_img可以只使用片元shader
            #pragma vertex vert_img   
            //调用自建库中的frag_BoxFilter_9Tap片元着色器
            #pragma fragment frag_BoxFilter_9Tap
            ENDCG
        }
    }
}
