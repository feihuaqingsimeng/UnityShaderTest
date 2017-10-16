using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreateNormalMap : MonoBehaviour {

	public Texture2D tex0;

	public Texture2D tex1;
	// Use this for initialization
	void Start () {
		Debug.Log(string.Format("{0},{1}", tex0.width, tex0.height));
		for (int h = 1; h < tex0.width - 1; h++) {
			for (int w = 1; w < tex0.height - 1; w++) {
				float uleft = tex0.GetPixel(w-1, h).b;
				float uright = tex0.GetPixel(w + 1, h).b;

				float u = uright - uleft;

				float vtop = tex0.GetPixel(w, h - 1).b;
				float vbottom = tex0.GetPixel(w, h + 1).b;

				float v = vbottom - vtop;

				Vector3 vector_u = new Vector3(1, 0, u);

				Vector3 vector_v = new Vector3(0, 1, v);

				Vector3 N = Vector3.Cross(vector_u, vector_v).normalized;

				float r = N.x * 0.5f + 0.5f;
				float g = N.y * 0.5f + 0.5f;
				float b = N.z * 0.5f + 0.5f;
				tex1.SetPixel(w, h, new Color(r,g,b));
			}

		}
		tex1.Apply(false);
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
