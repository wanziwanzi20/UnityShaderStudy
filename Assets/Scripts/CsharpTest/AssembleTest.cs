using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//关键词:泛型；集合;ref;out;Type

public class AssembleTest : MonoBehaviour
{
//智能集合List类
List<string> listTest = new List<string>();

//实际改变集合参数
string[] magics = new string[1];
    Type[] AddElment<Type>(Type[] array,Type newElement)
    {
        Type[] newArray = new Type[array.Length + 1];
        for(int i = 0; i < array.Length; i++)
            newArray[i] = array[i];
        newArray[newArray.Length - 1] = newElement;
        return newArray;
    }

//ref修饰方法 使方法不实际改变参数
//修改方法内的ref变量，将会直接改变调用者外部填入的变量
//ref和out区别在于ref可以不修改，out必须修改，且修改后才能在方法中使用
string[] refTest = new string[2];
    void RefAddElment<Type>(ref Type[] array,Type newElement)
    {
        Type[] newArray = new Type[array.Length + 1];
        for(int i = 0; i < array.Length; i++)
            newArray[i] = array[i];
        newArray[newArray.Length - 1] = newElement;
        array = newArray;
    }
    
    void Start()
    {
        //智能集合,不限制因子数量
        listTest.Add("加一");
        print(listTest[0]);

        //实际改变参数
        magics[0] = "第一";
        magics = AddElment<string>(magics,"第二");
        print(magics[1]);

        //不改变参数
        refTest[0] = "金";
        refTest[1] = "木";
        RefAddElment<string>(ref refTest,"水");
        print(refTest[2]);
    }
}
