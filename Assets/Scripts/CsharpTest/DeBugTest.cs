using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词:属性，类的命名成员,property,tay-catch-finally
public class DeBugTest : MonoBehaviour
{
    int alpha;   //创建私有数据
    //通过存储器实现对数据的保护，可省略get或set只读或只取,也可用于数据的二次处理
    public int intTest
    {
        get
        {
            Debug.Log("数值读取成功");
            return alpha;
        }
        set
        {
            Debug.Log("数值存储成功");
            //可在存储区对数值改变
            if(value<0)     
            alpha = 0;
            else      
            alpha = value;
        }
    }
    void Start()
    {
        intTest = -100;
        Debug.Log(intTest);
    }
}
