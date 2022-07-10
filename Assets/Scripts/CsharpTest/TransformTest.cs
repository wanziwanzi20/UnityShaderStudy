using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：移动旋转缩放API；transform
public class TransformTest : MonoBehaviour
{
    void Start()
    {
        //世界空间坐标
        print(transform.position);          //移动
        print(transform.eulerAngles);   //欧拉旋转角度
        print(transform.lossyScale);    //缩放

        //局部空间坐标
        print(transform.localPosition);
        print(transform.localEulerAngles);
        print(transform.localScale);

        //Vector3.xxx表示此方向的标准向量，Vector3.forward表示(0,0,1)
        print("1" + Vector3.forward + Vector3.back + Vector3.right + Vector3.left);
        //给定物体位置
        transform.localPosition = new Vector3(1,2,3);
    }

    void Update()
    {
        //transform.localEulerAngles += new Vector3(0,0.01f,0);
        transform.Translate(0,0,0);     //位移方法
        transform.Rotate(0,0.01f,0);            //旋转方法
    }
}
