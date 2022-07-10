using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：碰撞体；刚体；触发器;Rigidbody
public class CollisionTest : MonoBehaviour
{
    private void OnCollisionEnter(Collision other)  //碰撞发生瞬间调用一次
    {
        print("到达地面");
        //other.gameObject -碰到的物体
        //other.rigidbody -碰到的物体上挂载的刚体组件（如果有）
        //other.collider -碰到物体上挂载的碰撞体组件
        //other.transform -碰到物体上挂载的Transform组件
        //...
        //if()

        //获取被碰撞游戏对象的组件
        Rigidbody rigidbody = other.gameObject.GetComponent<Rigidbody>();
    }
    private void OnCollisionExit(Collision other)   //碰撞结束瞬间调用一次
    {
        print("离开地面");
    }
    private void OnCollisionStay(Collision other)   //碰撞接触中持续调用
    {
        //print("接触中");
    }

    //作为触发器时
    private void OnTriggerEnter(Collider other)  //碰撞发生瞬间调用一次
    { }
    private void OnTriggerExit(Collider other)   //碰撞结束瞬间调用一次
    { }
    private void OnTriggerStay(Collider other)   //碰撞接触中持续调用
    { }

    //2D碰撞体版本 所有2D版本规律如下
    private void OnCollisionEnter2D(Collision2D other)  //碰撞发生瞬间调用一次
    { }
    private void OnCollisionExit2D(Collision2D other)   //碰撞结束瞬间调用一次
    { }
    private void OnCollisionStay2D(Collision2D other)   //碰撞接触中持续调用
    { }
}
