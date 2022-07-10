using System.Collections;  //Unity兼容C#的.Net框架 System系列的命名空间属于.Net类库
using System.Collections.Generic;   //泛型List属于此命名空间
using UnityEngine;    //MonoBehaviour属于此命名空间
using System;

//关键词：命名空间；生命周期

//namespace + name 将类装进命名空间中
namespace MySpace
{
    public class MyClass
    {       
    }  
}

public class unityTest : MonoBehaviour
{
    //最开始时运行一次
    void Awake()
    {
    }

    //在Update开始前运行一次
    void Start()
    {       
    }

    //游戏运行时每一帧调用
    void Update()
    { 
    }

    //按固定时间而非按帧运行
    void FixedUpdate()
    {
    }

    //UPdate每次运行后运行
    void LateUpdate()
    {
    }
}
