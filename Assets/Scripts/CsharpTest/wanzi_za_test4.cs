using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：获取指定物品；Component;子物体数量;调用其他物体的函数
public class wanzi_za_test4 : MonoBehaviour
{
    public Material matTest;
    public Shader shaderTest;
    public Component comTest;
    // Start is called before the first frame update
    void Start()
    {
        Transform transform = comTest.transform;      //Transform属于GameObject.Transform
        GameObject gameObject = comTest.gameObject;
        string tag = comTest.tag;

        gameObject.transform.eulerAngles = new Vector3(50,50,50);

        //print("该物体的旋转为" + gameObject.transform.eulerAngles);
        //print("该物体名为" + gameObject.name);
        //print("改物体标签为" + tag);
        //transform.childCount子物体数量
        //print(this.transform.childCount);  

        //SendMessage:仅向指定对象的所有脚本推送消息
        //SendmessageUpwards:向指定对象和它的父物体推送消息
        //BroadcastMessage:向指定对象和它的所有子物体推送消息
        //调用指定物体挂载的脚本的函数(不含参数的函数)
        comTest.BroadcastMessage("myMethod1");  
        //调用指定物体挂载的脚本的函数(含参数的函数)
        object[] method2Obj = new object[2];  //两个参数
        method2Obj[0] = "张三" ;
        method2Obj[1] = 2 ;
        //SendMessageOptions.DontRequireReceiver表示空指针时不报错
        comTest.BroadcastMessage("myMethod2", method2Obj); //默认空指针会报错
        comTest.BroadcastMessage("myMethod9", method2Obj,SendMessageOptions.DontRequireReceiver); 
    }
}
