using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WoodTest : MonoBehaviour
{
    public Component comTest;
    Material woodTest2 = null;
    Component[] com2Test;
    void Start()
    {
        woodTest2 = new Material(comTest.gameObject.GetComponent<Renderer>().material.shader);
        woodTest2.name = "woodTest2";
        woodTest2.CopyPropertiesFromMaterial(comTest.gameObject.GetComponent<Renderer>().material);
        woodTest2.SetInt("_IsShine",1);
        //仅单个物体赋予材质
        //comTest.gameObject.GetComponent<Renderer>().material = woodTest2;

        //子级的物体赋予的方法
        com2Test = comTest.GetComponentsInChildren<Renderer>();
        for(int i=0; i< com2Test.Length; i++)
        {
            com2Test[i].gameObject.GetComponent<Renderer>().material = woodTest2;
            print( "赋予物体:" + (i+1) + com2Test[i].gameObject.GetComponent<Renderer>().material);
        }
    }
}
