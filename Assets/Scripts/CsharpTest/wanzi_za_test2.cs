using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：字段、变量、公共函数、静态函数、this、删除物体
public class wanzi_za_test2 : MonoBehaviour
{
    void Start()
    {
        //this可以直接使用此类的字段或方法；
        //获取字段/变量直接.XXX
        print("名字为：" + this.name);
        //公共函数返回值：调用函数需要.xxx() 获得的是返回值
        int code =  this.gameObject.GetInstanceID();
        //静态函数：print；可以直接使用，不用赋值
        print("编号为：" + code);
        //删除物体
        Destroy(this.gameObject);
        print("已删除" + this.name);
    }
}
