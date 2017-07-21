using UnityEngine;
using System.Collections;
using System.Linq;
public class CheckVertex : MonoBehaviour {

    public MeshFilter mf1;
    public MeshFilter mf2;
    public MeshFilter mf3;

	// Use this for initialization
	void Start () {
        Vector3[] verts = mf1.mesh.vertices;
        verts.Max(v => v.x);
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
