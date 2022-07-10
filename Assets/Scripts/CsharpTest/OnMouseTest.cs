using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：鼠标触发
public class OnMouseTest : MonoBehaviour
{
    //鼠标指针移到碰撞体瞬间调用
    void OnMouseEnter() 
    { 
        print("瞄准目标");
    } 
    //鼠标指针离开碰撞体瞬间调用
    void OnMouseExit() 
    { 
        print("离开目标");
    }
    //鼠标指针停留再碰撞体上时持续调用
    void OnMouseStay() 
    { 
        //print("持续瞄准目标中");
    }
    //鼠标指针在碰撞体上时，按下鼠标调用一次
    void OnMouseDown() 
    { 
        print("击中目标");
    }
    //鼠标指针在碰撞体上时，抬起鼠标调用一次
    void OnMouseUp()
    {
    }
    //鼠标指针在碰撞体上按下时，抬起鼠标调用一次
    void OnMouseUpAsButton()
    {
    }
    //鼠标指针在碰撞体上拖拽时持续调用
    void OnMouseDrag()
    {
        //print("拖拽中");
    }
}
