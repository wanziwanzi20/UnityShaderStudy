using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Array : MonoBehaviour
{
    enum Gender
    {
        男,女,其他
    }
    string job = "大哔抖子"; 
    string ago = "两年半";
    char[] allPower = new char [4];
    void Start()
    {
        print("性别:" + Gender.其他);   //枚举可使用中文，非必要不要使用
        print("职业:" + job);
        print("练习时长:" + ago);
        allPower[0] = '黑';
        allPower[1] = '魔';
        allPower[2] = '变';
        allPower[3] = '身';
        for(int i=0 ; i<4 ; i++)
        {                       
            print(allPower[i]);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
