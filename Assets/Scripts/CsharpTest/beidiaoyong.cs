using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class beidiaoyong : MonoBehaviour
{
    void myMethod1()
    {
        Debug.Log("调用无参函数成功!");
    }
    void myMethod2(object[] method2Obj)
    {
        string code = (string) method2Obj[0];
        int number = (int) method2Obj[1];
        Debug.Log(code + "调用函数成功!" + number);
    }
    // Start is called before the first frame update
    void Start()
    {
    }
}
