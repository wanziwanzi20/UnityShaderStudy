using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：多态；虚方法；重写； 
public class ClassTest3 : MonoBehaviour
{
    enum Gender { 男,女,其他 }
    BasicInformation[] many = new BasicInformation[3];   //职业类组

    class BasicInformation
    {
        public string code;   //public：被公开    protected:可被继承不被外部访问
        public int ago;
        public Gender gender;

        public virtual void TellName()
        {
            //print是unity MonoBehaviour封装的方法，等效于Debug.Log();
            print("我是"+ ago + "岁" + code);    //子类可继承父类中公开的信息 比如code  
        }
    }

    //继承:被继承者称之为基类或父类；被继承者称之为子类或派生类；一个类只能继承自一个类（一父多子）
    class Magician : BasicInformation
    {
        public override void TellName()
        {
            print("芭哒哒魔仙!");           //override:重写虚方法
            base.TellName();               //base：调用虚方法         
        }
    }
    class Blacksmith : BasicInformation
    {
        public override void TellName()
        {
            print("精神领袖!");
            base.TellName(); 
        }
    }
    class Musician : BasicInformation
    {
        public override void TellName()
        {
            print("致命高音!");
            base.TellName(); 
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
