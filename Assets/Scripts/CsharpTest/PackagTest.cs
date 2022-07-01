using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//关键词:封装；接口

class PackagSet
{
    //新建私有数组
    string[] datapackag;   
    //定义构造函数
    public PackagSet(int length)
    {
        datapackag = new string[length];   //为数组开辟空间
    }
    //定义索引器  索引器固定格式
    public string this[int index]
    {
        get
        {
            if(index > datapackag.Length - 1 || index < 0)  //点后面必须大写开头
                return "超过上限";
            else
                return datapackag[index];
        }
        set
        {
            datapackag[index] = value;
        }
    }
}

public class PackagTest : MonoBehaviour
{
    //创建对象 并限制大小为1
    PackagSet datapackag = new PackagSet(1);

    void Start()
    {
        datapackag[0] = "第一个";
        print(datapackag[1]);
    }

}
