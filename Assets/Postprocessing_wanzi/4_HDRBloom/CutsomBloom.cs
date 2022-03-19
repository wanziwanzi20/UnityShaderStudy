using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode()]   //可预览
public class CutsomBloom : MonoBehaviour   //命名必须与c#文件名一致
{
    public Material material;   //输入材质球
    [Range(1,15)]
    public float _Threshold = 1.0f;  //阈值

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
        int width1 = soure.width/2;          //设置宽高为画布宽高(降采样)
        int height1 = soure.height/2;        //设置宽高为画布宽高(降采样)
        RenderTexture RT1 = RenderTexture.GetTemporary(width1,height1);   //创建纹理1
        RenderTexture RT2 = RenderTexture.GetTemporary(width1,height1);   //创建纹理2
        material.SetFloat("_Threshold",_Threshold);
        Graphics.Blit(RT1,destination,material,0);   //阈值

        //模糊

    }
}
