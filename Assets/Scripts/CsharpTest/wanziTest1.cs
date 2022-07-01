using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wanziTest1 : MonoBehaviour
{
    enum Gender
    {男,女,其他}

    struct Apprentice
    {
        public string code;
        public int ago;
        public Gender gender;
        public string[] allPower; 
        int target;    //血量

        public void invoke(int powerNumber , int round ,int harm)
        {
            target =  target - harm ;
            print("回合" +(round+1) +code + "使用了" + allPower[powerNumber]);
        }

        public int showTarget(bool end )
        {
            if(end == false)
            target = 100;
            else
            print(code + "命中的靶子剩余血量:" + target);

            return target;
        }
    }

    Apprentice xx1;
    Apprentice xx2;

    void Start()
    {
        xx1.code = "卧龙" ;
        xx1.ago = 12 ;
        xx1.gender = Gender.男;
        xx1.allPower = new string[9] {"龟","派","气","功","超","极","无","敌","波"};
        int xx1startBoold =  xx1.showTarget(false);
        print(xx1.code + "目标靶子初始血量:" + xx1startBoold);

        xx2.code = "凤雏" ;
        xx2.ago = 18 ;
        xx2.gender = Gender.其他;
        xx2.allPower = new string[1] {"忍"};
        int xx2startBoold =  xx2.showTarget(false);
        print(xx2.code + "目标靶子初始血量:" + xx2startBoold);
        for(int i=1;i<=9;i++)
        {   
            xx1.invoke(i-1,i-1,2);

            if (i==1 || i==9)                 //与
            {
                xx2.invoke(i-i,i-1,5);      //(技能序号，回合数，技能伤害)
            }
            
        }
        int xx1EndBoold = xx1.showTarget(true);
        int xx2EndBoold = xx2.showTarget(true);
        if(xx1EndBoold==xx2EndBoold)
        print("比赛结果为平手");
        else if(xx1EndBoold<xx2EndBoold)
        print("赢家是:"+ xx1.code);
        else if(xx1EndBoold>xx2EndBoold)
        print("赢家是:"+ xx2.code);
    }

}
