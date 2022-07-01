using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：类
public class ClassTest : MonoBehaviour
{
    class Kami
    {
        public string code;

        public Kami(string code)
        {
            this.code = code;
            print("鸡掰人" + code + "诞生了");
        }

        public void RealizeWish()    //static 加在void前的话：归属于此类的方法，无需new变量
        {
            print(code + "吃饱了");
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        Kami Kami = new Kami("老六");
        Kami.RealizeWish();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
