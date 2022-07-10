using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：键盘输入；input;GetKey;KeyCode
public class PlayerTest : MonoBehaviour
{
    public float speed = 5f;
    //public float Upspeed = 2f;
    void Start()
    {
    }

    //运行时的每一帧调用
    /*void Update()
    {
        Vector3 qx = new Vector3(30,0,0);
        Vector3 hx = new Vector3(-10,0,0);
        Vector3 zx = new Vector3(0,0,10);
        Vector3 yx = new Vector3(0,0,-10);
        //前
        if(Input.GetKeyDown(KeyCode.W))    //按下按键
        {transform.localEulerAngles += qx;}
        if(Input.GetKeyUp(KeyCode.W))    //抬起按键
        {transform.localEulerAngles -= qx;}
        //后
        if(Input.GetKeyDown(KeyCode.S))    //按下按键
        {transform.localEulerAngles += hx;}
        if(Input.GetKeyUp(KeyCode.S))    //抬起按键
        {transform.localEulerAngles -= hx;}
        //左
        if(Input.GetKeyDown(KeyCode.A))    //按下按键
        {transform.localEulerAngles += zx;}
        if(Input.GetKeyUp(KeyCode.A))    //抬起按键
        {transform.localEulerAngles -= zx;}
        //右
        if(Input.GetKeyDown(KeyCode.D))    //按下按键
        {transform.localEulerAngles += yx;}
        if(Input.GetKeyUp(KeyCode.D))    //抬起按键
        {transform.localEulerAngles -= yx;}
    }
    void FixedUpdate()
    {
        //前
        if(Input.GetKeyDown(KeyCode.W))    //按下按键
        {transform.Translate(Vector3.forward * Time.deltaTime * speed,Space.World);}
        if(Input.GetKey(KeyCode.W))    //按住按键
        {transform.Translate(Vector3.forward * Time.deltaTime * speed,Space.World);}
        //后
        if(Input.GetKeyDown(KeyCode.S))    //按下按键
        {transform.Translate(Vector3.back * Time.deltaTime * speed,Space.World);}
        if(Input.GetKey(KeyCode.S))    //按住按键
        {transform.Translate(Vector3.back * Time.deltaTime * speed,Space.World);}
        //左
        if(Input.GetKeyDown(KeyCode.A))    //按下按键
        {transform.Translate(translation: Vector3.left * Time.deltaTime * speed,Space.World);}
        if(Input.GetKey(KeyCode.A))    //按住按键
        {transform.Translate(Vector3.left * Time.deltaTime * speed,Space.World);}
        //右
        if(Input.GetKeyDown(KeyCode.D))    //按下按键
        {transform.Translate(Vector3.right * Time.deltaTime * speed,Space.World);}
        if(Input.GetKey(KeyCode.D))    //按住按键
        {transform.Translate(Vector3.right * Time.deltaTime * speed,Space.World);}
        
    }*/
    
    //备份
    void Update()
    {
        Vector3 qx = new Vector3(30,0,0);
        Vector3 hx = new Vector3(-10,0,0);
        Vector3 zx = new Vector3(0,0,10);
        Vector3 yx = new Vector3(0,0,-10);
        //前
        if(Input.GetKeyDown(KeyCode.W))    //按下按键
        {transform.Translate(Vector3.forward * Time.deltaTime * speed,Space.World);
        transform.localEulerAngles += qx;}
        if(Input.GetKey(KeyCode.W))    //按住按键
        {transform.Translate(Vector3.forward * Time.deltaTime * speed,Space.World);}
        if(Input.GetKeyUp(KeyCode.W))    //抬起按键
        {transform.localEulerAngles -= qx;}
        //后
        if(Input.GetKeyDown(KeyCode.S))    //按下按键
        {transform.Translate(Vector3.back * Time.deltaTime * speed,Space.World);
        transform.localEulerAngles += hx;}
        if(Input.GetKey(KeyCode.S))    //按住按键
        {transform.Translate(Vector3.back * Time.deltaTime * speed,Space.World);}
        if(Input.GetKeyUp(KeyCode.S))    //抬起按键
        {transform.localEulerAngles -= hx;}
        //左
        if(Input.GetKeyDown(KeyCode.A))    //按下按键
        {transform.Translate(translation: Vector3.left * Time.deltaTime * speed,Space.World);
        transform.localEulerAngles += zx;}
        if(Input.GetKey(KeyCode.A))    //按住按键
        {transform.Translate(Vector3.left * Time.deltaTime * speed,Space.World);}
        if(Input.GetKeyUp(KeyCode.A))    //抬起按键
        {transform.localEulerAngles -= zx;}
        //右
        if(Input.GetKeyDown(KeyCode.D))    //按下按键
        {transform.Translate(Vector3.right * Time.deltaTime * speed,Space.World);
        transform.localEulerAngles += yx;}
        if(Input.GetKey(KeyCode.D))    //按住按键
        {transform.Translate(Vector3.right * Time.deltaTime * speed,Space.World);}
        if(Input.GetKeyUp(KeyCode.D))    //抬起按键
        {transform.localEulerAngles -= yx;}
    }
}
