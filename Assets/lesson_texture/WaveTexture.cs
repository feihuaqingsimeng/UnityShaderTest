using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Threading;
public class WaveTexture : MonoBehaviour {

	public int waveWidth;
	public int waveHeight;
	float[,] waveA;
	float[,] waveB;
	Color[] colorBuffer;
	Texture2D tex_uv;
	bool isRun = true;
	int sleepTime;
	// Use this for initialization
	void Start () {
		waveA = new float[waveWidth, waveHeight];
		waveB = new float[waveWidth, waveHeight];
		tex_uv = new Texture2D(waveWidth, waveHeight);
		colorBuffer = new Color[waveWidth * waveHeight];
		GetComponent<Renderer>().material.SetTexture("_WaveTex", tex_uv);
		Thread th = new Thread(new ThreadStart(ComputeWave));
		th.Start();
	}

	void Putpop(int x, int y) {

		int radius = 10;
		float dist;

		for (int i = -radius; i <= radius; i++) {
			for (int j = -radius; j <= radius; j++) {

				if (((x + i >= 0) && (x + i < waveWidth - 1)) && ((y + j >= 0) && (y + j < waveHeight - 1))) {
					dist = Mathf.Sqrt(i * i + j * j);
					if (dist < radius) {
						waveA[x + i, y + j] = Mathf.Cos(dist * Mathf.PI / radius);

					}

				}

			}


		}

		
	}
	
	// Update is called once per frame
	void Update () {
		sleepTime =(int) (Time.deltaTime * 1000);

		tex_uv.SetPixels(colorBuffer);
		tex_uv.Apply();


		if (Input.GetMouseButton(0)) {
			RaycastHit hit;
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition) ;
			if (Physics.Raycast(ray, out hit)) {

				
				Vector3 pos = hit.point;
				pos = transform.worldToLocalMatrix.MultiplyPoint( hit.point);
				Debug.Log(pos);
				int w =(int)( (pos.x + 0.5f) * waveWidth);
				int h = (int)((pos.y + 0.5f) * waveHeight);
				Debug.Log(string.Format("{0},{1}  ;{2}，{3}",w,h, pos, hit.point));

				Debug.Log(transform.worldToLocalMatrix);
				Putpop(w, h);
			}

		}
		
		//ComputeWave();
	}

	void ComputeWave() {
		while (isRun) {
			for (int w = 1; w < waveWidth - 1; w++)
			{
				for (int h = 1; h < waveHeight - 1; h++)
				{
					waveB[w, h] = (waveA[w - 1, h] + waveA[w + 1, h] +
						waveA[w, h - 1] + waveA[w, h + 1] +
						waveA[w - 1, h - 1] + waveA[w + 1, h - 1] +
						waveA[w - 1, h + 1] + waveA[w + 1, h + 1]) / 4 - waveB[w, h];

					float value = waveB[w, h];
					if (value > 1)
					{
						waveB[w, h] = 1;

					}
					if (value < -1)
					{
						waveB[w, h] = -1;
					}

					float offset_u = (waveB[w - 1, h] - waveB[w + 1, h]) / 2;
					float offset_v = (waveB[w, h - 1] - waveB[w, h + 1]) / 2;


					float r = offset_u / 2 + 0.5f;
					float g = offset_v / 2 + 0.5f;
					//tex_uv.SetPixel(w, h, new Color(r, g, 0));
					colorBuffer[w + waveWidth * h] = new Color(r, g, 0);
					waveB[w, h] -= waveB[w, h] * 0.01f;
				}


			}
			//tex_uv.Apply();
			float[,] temp = waveA;
			waveA = waveB;
			waveB = temp;
			Thread.Sleep(sleepTime);
		}
		
		
		
	}
	void OnDestroy() {
		isRun = false;

	}
}
