using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词:接口;抽象方法；interface
public class ClassTest5 : MonoBehaviour
{
    enum Gender { 男,女,其他 }
    ITell[] many = new ITell[3];   //职业类组 //有相同接口的类可以组成类组，类组要注意命名空间!!!

    //abstract:加在class前可将一个类声明为抽象类；抽象类只能被继承，自身无法实例化；抽象类的子类仍可以是抽象类
    abstract class BasicInformation   
    {
        public string code;   //public：被公开    protected:可被继承不被外部访问
        public int ago;
        public Gender gender;

    }
    interface ITell
    {
        //abstract：加在方法前面为抽象方法，不能私有；除非子类为抽象类，否则必须被重写
        void TellName();  //inerface(接口修饰符)中 public abstract 前缀可省略
    }

    //继承:被继承者称之为基类或父类；被继承者称之为子类或派生类；一个类只能继承自一个类（一父多子）
    //接口不限制个数，与父类或其他接口用逗号分隔
    class Magician : BasicInformation , ITell
    {
        public void TellName()   
        {
            print("芭哒哒魔仙!");           //override:重写虚方法 接口方法中需省略
        }
    }
    class Blacksmith : BasicInformation , ITell
    {
        public void TellName()
        {
            print("精神领袖!");
        }
    }
    class Musician : BasicInformation , ITell
    {
        public void TellName()
        {
            print("致命高音!");
        }
    }

    void Start()
    {
        many[0] = new Magician() {code = "游乐", ago = 3};  //逗号分隔
        many[1] = new Blacksmith() {code = "老六"};
        many[2] = new Musician() {code = "波澜姆"};
        
        for(int i=0; i<3; i++)
        {
            many[i].TellName();   //类组要注意命名空间!!!
        }
    }
}
