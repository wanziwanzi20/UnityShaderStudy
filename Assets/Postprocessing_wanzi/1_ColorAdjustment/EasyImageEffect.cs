using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode()]   //可预览
public class EasyImageEffect : MonoBehaviour   //命名必须与c#文件名一致
{
    public Material material;   //输入材质球
    //脚本面板显示参数
    public float _Brightness = 1.0f;
    [Range(0.0f,2.0f)]
    public float _Saturation = 1.0f;
    [Range(0.0f,2.0f)]
    public float _Contrast = 1.0f;
    [Range(0.05f,3.0f)]
    public float _DarkInt = 1.5f;
    [Range(1.0f,5.0f)]
    public float _DarkNess = 5.0f;
    [Range(0.05f,5.0f)]
    public float _DarkPow = 5.0f;

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
        material.SetFloat("_Brightness",_Brightness);
        material.SetFloat("_Saturation",_Saturation);
        material.SetFloat("_Contrast",_Contrast);
        material.SetFloat("_DarkInt",_DarkInt);
        material.SetFloat("_DarkNess",_DarkNess);
        material.SetFloat("_DarkPow",_DarkPow);
        Graphics.Blit(soure,destination,material,0);   //x:输入纹理；y：输出纹理；z：调用材质球中的shader；w：调用shader中的第几个pass，默认为第一个（0）
    }
}
