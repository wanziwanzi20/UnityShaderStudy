using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词:抽象类;
public class ClassTest4 : MonoBehaviour
{
    enum Gender { 男,女,其他 }
    BasicInformation[] many = new BasicInformation[3];   //职业类组

    //abstract:加在class前可将一个类声明为抽象类；抽象类只能被继承，自身无法实例化；抽象类的子类仍可以是抽象类
    abstract class BasicInformation   
    {
        public string code;   //public：被公开    protected:可被继承不被外部访问
        public int ago;
        //public Gender gender;

        //abstract：加在方法前面为抽象方法，不能私有；除非子类为抽象类，否则必须被重写
        public abstract void TellName();
    }

    //继承:被继承者称之为基类或父类；被继承者称之为子类或派生类；一个类只能继承自一个类（一父多子）
    class Magician : BasicInformation
    {
        public override void TellName()
        {
            print("芭哒哒魔仙!");           //override:重写虚方法
            //base.TellName();                //不能调用抽象方法 只能重写！！！
        }
    }
    class Blacksmith : BasicInformation
    {
        public override void TellName()
        {
            print("精神领袖!");
        }
    }
    class Musician : BasicInformation
    {
        public override void TellName()
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
            many[i].TellName();
        }
    }
}
