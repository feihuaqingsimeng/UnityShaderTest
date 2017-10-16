using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetTextureUVST : MonoBehaviour {

	public int width;
	public int height;
	public int fps;

	private int currentIndex;
	// Use this for initialization
	IEnumerator Start () {
		Material mat = GetComponent<Renderer>().material;
		float scaleX = 1.0f / width;
		float scaleY = 1.0f / height;
		float offsetX = 0;
		float offsetY = 0;
		while (true) {
			offsetX = currentIndex % width * scaleX;
			offsetY = currentIndex / height * scaleY;
			mat.SetTextureOffset("_MainTex", new Vector2(offsetX, offsetY));
			mat.SetTextureScale("_MainTex", new Vector2(scaleX, scaleY));
			yield return new WaitForSeconds(1.0f/fps);
			currentIndex = (++currentIndex) % (width * height);
		}
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
