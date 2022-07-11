using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class textTest : MonoBehaviour
{
    public Component textTest1;
    int number = 0;
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        for(int n=1; n<100; n++)
        {
            number += n;
        }
        textTest1.gameObject.GetComponent<Text>().text = "测试" + number;
    }
}
