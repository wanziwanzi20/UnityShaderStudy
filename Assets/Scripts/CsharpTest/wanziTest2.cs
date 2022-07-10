using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class wanziTest2 : MonoBehaviour
{
    enum Gender
    {男,女,其他}
    enum Occupation
    {领主,刺客,骑士,侍从}

    /*class People
    {
        public string code {get;}   //{}内表示只读
        Gender gender;
        Occupation occupation;
        Commands commands;
        Army army;
        int hp;
        //构造函数
        public People(string code,Gender gender,Occupation occupation,Commands commands,Army army)
        {
            this.code = code;
            this.gender = gender;
            this.occupation = occupation;
            this.commands = commands;
            this.army = army;
            hp = 100;
        }
    }*/

    /*class Commands
    {
        public delegate void Prepare(People commander,Occupation occupation);
        public Prepare concentrate;
        public delegate void War(People commander,Army target);
        public War attack,defeat;
    }*/

    class Army
    {}

    void Start()
    {
        
    }
}
