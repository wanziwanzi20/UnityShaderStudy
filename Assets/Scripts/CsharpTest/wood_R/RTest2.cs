using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//关键词：欧拉角锁死，欧拉角，四元数
public class RTest2 : MonoBehaviour
{
    Vector3 xuanzhuan;
    // Start is called before the first frame update
    void Start()
    {
        //print(this.transform.rotation);
        xuanzhuan = new Vector3(0,60,0);
    }

    void Update()
    {
        //Quaternion q = Quaternion.Euler(v):欧拉角转四元数方法; 
        //Vector3 v = q.eulerAngles :四元数转欧拉角方法
        this.transform.eulerAngles += xuanzhuan * Time.deltaTime;
        this.transform.rotation = Quaternion.Euler(this.transform.eulerAngles);
        print(this.transform.rotation);
    }
}
