using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//关键词：运算符重载；无参构造方法
public class player
{
    public int hp, mp;
    public player(int HPnumber , int MPnumber) { hp = HPnumber; mp = MPnumber; } 
}

public class health
{
    public int hp, mp;
    public health(int HPnumber , int MPnumber) { hp = HPnumber; mp = MPnumber; }  
    public health() {}      //无参构造方法;为下面的计算赋予默认值！！！
    
    //operator：方法的重载，公开且为静态(static)，后接算式运算符，参数顺序对应运算顺序
    //定义health间的加法
    public static health operator + (health a,health b)
    {
        return new health() 
        {
            hp = a.hp + b.hp,
            mp = a.mp + b.mp
        };
    }
    //定义player与health的加法
    public static health operator + (health p,player a)  //a p 变量只生存在运算中
    {
        return new health() 
        {
            hp = a.hp + p.hp,
            mp = a.mp + p.mp
        };
    }
}

public class HPMPTest : MonoBehaviour
{
    player xx1 = new player(50,50);
    health p1 = new health(30,0) , p2 = new health(0,50);

    void Start()
    {
        health xx1_1 = p1 + p2 + xx1;
        print("HP:" + xx1_1.hp + " " + "MP:" +xx1_1.mp);
    }
}
