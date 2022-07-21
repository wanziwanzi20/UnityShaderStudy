using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
//关键词：获取Ui文字；改变物体显示状态
public class textTest : MonoBehaviour
{
    public Component textTest1;
    float number = 0;
    // Start is called before the first frame update
    void Start()
    {
        textTest1.gameObject.GetComponent<Text>().text = "测试" + number;
        this.gameObject.SetActive(false); 
    }
}
