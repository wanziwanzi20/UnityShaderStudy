using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RTest : MonoBehaviour
{
    float speed = 360f;
    float upSpeed = 1;
    Vector2 startPos;
    Vector2 endPos;
    Vector3 mouseDir;
    void Start()
    {
    }

    void Update()
    {
        if(Input.GetMouseButtonDown(0))
        {
            startPos = Input.mousePosition;
        }

        else if(Input.GetMouseButton(0))
        {
            endPos = Input.mousePosition;
            mouseDir = new Vector3(endPos.y-startPos.y,-(endPos.x-startPos.x),0);   
            startPos = Input.mousePosition;

            //关联鼠标滑动速度;手感优化
            if(mouseDir.magnitude > 20f)
            {
            upSpeed += mouseDir.magnitude * 0.1f;
            //print(upSpeed);
            }
            else
            {
            upSpeed = 1; 
            }
        }

        else if(Input.GetMouseButtonUp(0))
        {
            upSpeed = 1;
            mouseDir = Vector3.zero;
        }
        this.transform.Rotate(Vector3.Normalize(mouseDir) * speed * upSpeed * Time.deltaTime,Space.World);
    }
}

        //mouseDir = Vector3.Slerp(norMouseDir,Vector3.zero,fracComplete);
        //Quaternion.rotation:（x：看向的方向，）