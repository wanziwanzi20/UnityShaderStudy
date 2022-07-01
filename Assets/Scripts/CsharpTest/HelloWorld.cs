using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HelloWorld : MonoBehaviour
{
    int firstInt = 0;                       //int整数类型
    //float firstFloat,secondFloat = 3.14f;   //逗号分隔 同时创建多个变量 浮点数后加“f”
    //const string myNeme = "wanzi";          //const:常量 string/char:字符
    //bool ForT = false;                      //bool逻辑类型 false or true
    // Start is called before the first frame update
    void Start()
    {
        for(int i=0 ; i<10 ; i++ )
        {
            firstInt++;
            if (i == 8)   break;
            if (i < 4)   continue;
            print( "for" + firstInt);
        }

        if(firstInt == 0)
        {
            firstInt++;
            print("if" + firstInt);
        }
        else
        {
            print("else"+ 0);
        }
        
        switch(firstInt)
        {
            case 0: firstInt++; break;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
