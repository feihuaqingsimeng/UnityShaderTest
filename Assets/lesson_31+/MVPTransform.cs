using UnityEngine;
using System.Collections;

public class MVPTransform : MonoBehaviour {

    // Use this for initialization
    Matrix4x4 rm = new Matrix4x4();
    Matrix4x4 sm = new Matrix4x4();
    void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        rm[0, 0] = Mathf.Cos(Time.realtimeSinceStartup);
        rm[0, 2] = Mathf.Sin(Time.realtimeSinceStartup);
        rm[1, 1] = 1;
        rm[2, 0] = -Mathf.Sin(Time.realtimeSinceStartup);
        rm[2, 2] = Mathf.Cos(Time.realtimeSinceStartup);
        rm[3, 3] = 1;

        sm[0, 0] = Mathf.Sin(Time.realtimeSinceStartup)/4 +0.5f;
        sm[1, 1] = Mathf.Sin(Time.realtimeSinceStartup)/8+0.5f;
        sm[2, 2] = Mathf.Sin(Time.realtimeSinceStartup) / 6 + 0.5f ;
        sm[3,3] = 1;
        Matrix4x4 mvp =  Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix * transform.localToWorldMatrix ;
        GetComponent<Renderer>().material.SetMatrix("sm", sm);
        GetComponent<Renderer>().material.SetMatrix("rm", rm);

    }
}
