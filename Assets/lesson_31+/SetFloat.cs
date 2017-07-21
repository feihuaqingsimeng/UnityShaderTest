using UnityEngine;
using System.Collections;

public class SetFloat : MonoBehaviour {

    // Use this for initialization
    private float dis = -1;
    private float r = 0.1f;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
        dis += Time.deltaTime;
        GetComponent<Renderer>().material.SetFloat("dis", dis);
        GetComponent<Renderer>().material.SetFloat("r", r);
    }
}
