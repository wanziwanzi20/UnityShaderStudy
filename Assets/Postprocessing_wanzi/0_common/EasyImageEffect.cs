using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode()]   //可预览
public class EasyImageEffect : MonoBehaviour
{
    public Material material;   //输入材质球

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
        Graphics.Blit(soure,destination,material,0);   //x:输入纹理；y：输出纹理；z：调用材质球中的shader；w：调用shader中的第几个pass，默认为第一个（0）
    }
}
