using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Method : MonoBehaviour
{
    int alpha = 3;
    int Reverse(int origin)
    {
        origin *= -1;
        return origin;
    }
    //重载：相同方法名，数因类型或者个数不同。根据传入参数情况，会自动调用匹配的方法。跨脚本不生效。
    float Reverse(float origin)
    {
        origin *= -1;
        return origin;
    }

    void Start()
    {
        int minusAlpha = Reverse(alpha);
        print(minusAlpha);
    }
}
