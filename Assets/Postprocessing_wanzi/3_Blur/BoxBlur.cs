using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode()]   //可预览
public class BoxBlur : MonoBehaviour   //命名必须与c#文件名一致
{
    public Material material;   //输入材质球
    [Range(1,15)]
    public float _BlurRadius = 5.0f;  //模糊半径
    [Range(0,10)]
    public int _Iteration = 4;        //迭代次数
    [Range(1,10)]
    public float _DownSample = 2.0f;  //降采样值
    [Range(0,1)]
    public int _SampleTap = 0;        //采样像素点模式
    //public int _BlurOffset = 1;     //迭代偏移量（已弃用）

    //初始化判断,脚本仅运行一次
    void Start()
    {
        if (material == null || material.shader == null)    //SystemInFo.SupportsImageEffects == false
        {
            enabled = false;
            return;
        }
    }

    void Update()
    {
        
    }
    void OnRenderImage(RenderTexture soure,RenderTexture destination)
    {
        int width1 = (int)(soure.width/_DownSample);          //设置宽高为画布宽高(降采样)
        int height1 = (int)(soure.height/_DownSample);        //设置宽高为画布宽高(降采样)
        RenderTexture RT1 = RenderTexture.GetTemporary(width1,height1);   //创建纹理1
        RenderTexture RT2 = RenderTexture.GetTemporary(width1,height1);   //创建纹理2

        Graphics.Blit(soure,RT1);  //x:输入纹理；y：输出纹理；z：调用材质球中的shader；w：调用shader中的第几个pass，默认为第一个（0）
        material.SetVector("_BlurOffset",new Vector4(_BlurRadius/width1,_BlurRadius/height1,0,0));   //调用shader参数

        for ( int i = 0 ; i < _Iteration ; i++ )
        {
            Graphics.Blit(RT1,RT2,material,_SampleTap);   
            Graphics.Blit(RT2,RT1,material,_SampleTap); 
        }  

        Graphics.Blit(RT1,destination);   //x:输入纹理；y：输出纹理；z：调用材质球中的shader；w：调用shader中的第几个pass，默认为第一个（0）

        //释放已使用过的临时图片
        RenderTexture.ReleaseTemporary(RT1);
        RenderTexture.ReleaseTemporary(RT2);
    }
}
