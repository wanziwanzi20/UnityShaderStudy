Shader "Hidden/wanzi/CutsomBloom"
{
    CGINCLUDE
    //自定义库
    #include "UnityCG.cginc"

    sampler2D _MainTex;
    float _Threshold;

    half4 frag_CutsomBloom (v2f_img i) : SV_Target   //注意v2f_img
    {
        half4 Mincol = tex2D(_MainTex, i.uv);
        half HighCol = max(max(Mincol.r,Mincol.g),Mincol.b);
        HighCol = max(0.0,(HighCol-_Threshold))/max(HighCol,0.000001);
        Mincol.rgb *= HighCol;
        return Mincol;
    }

    //结束自定义库
    ENDCG

    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Threshold ("阈值",Float) = 1
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
            #pragma fragment frag_CutsomBloom
            ENDCG
        }
    }
}
