using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wanzi_za_test : MonoBehaviour
{
    public class KeyTest : MonoBehaviour
    {
        MonoBehaviour keyTest = new KeyTest();
        //keyTest.GetInstanceID();
        /*if(Input.GetKeyDown(KeyCode.W))
        {
            print("W");
        }*/
    }
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.W))
        {
            print("W"); 
            
        }
        
    }
}
