using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//查找物品、删除物品
//https://docs.unity3d.com/cn/2019.4/ScriptReference/Camera.html
public class wanzi_za_test3 : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {   
        //查找物体，随机获取一个有camera组件的物体
        Camera mainCamera = (Camera)FindObjectOfType(typeof(Camera));
        if(mainCamera)
            print("找到了相机" + mainCamera.name);
        else
            print("未找到任何相机");
        print(mainCamera.transform.eulerAngles);
    }
}

