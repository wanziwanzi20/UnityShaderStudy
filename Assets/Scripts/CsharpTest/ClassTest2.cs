using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClassTest2 : MonoBehaviour
{
    enum Gender { 男,女,其他 }

    class BasicInformation
    {
        public string code;   //public：被公开    protected:可被继承不被外部访问
        public int ago;
        public Gender gender;
    }
    //继承:被继承者称之为基类或父类；被继承者称之为子类或派生类；一个类只能继承自一个类（一父多子）
    class Magician : BasicInformation
    {
        public void TellName()
        {
            //print是unity MonoBehaviour封装的方法，等效于Debug.Log();
            print("我是魔仙"+ code);    //子类可继承父类中公开的信息 比如code  
        }
    }
    class Blacksmith : BasicInformation
    {

    }
    class Musician : BasicInformation
    {

    }
    //实例化对象
    Magician xx1 = new Magician();
    void Start()
    {
        xx1.code = "游乐";
        xx1.TellName();
    }
}
