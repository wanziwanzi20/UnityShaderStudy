Shader "Hidden/wanzi/BrokenGlass"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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

            half4 frag (v2f_img i) : SV_Target   //注意v2f_img
            {
                half4 col = tex2D(_MainTex, i.uv);
                return col;
            }
            ENDCG
        }
    }
}
