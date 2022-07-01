using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StructTest : MonoBehaviour
{
    enum Gender
    {
        男,女,其他
    }
    struct Apprentice
    {
        public string monicker ; 
        public Gender gender ;
        public int ago ;
        public string[] allPower ; 

        public void bianshen(int powerNumber)
        {
            print(monicker + "马上就要" + allPower[powerNumber]);
        }
    }

    Apprentice xx1;
    Apprentice xx2;

    void Start()
    {
        xx1.monicker = "卧龙";
        xx1.gender = Gender.男;
        xx1.ago = 12;
        xx1.allPower = new string[1] {"金蝉脱壳"};
        xx1.bianshen(0);
        
        xx2.monicker = "凤雏";
        xx2.gender = Gender.其他;
        xx2.ago = 18;
        xx2.allPower = new string[2] {"黑化","emo了"};
        xx2.bianshen(1);
    }

}
