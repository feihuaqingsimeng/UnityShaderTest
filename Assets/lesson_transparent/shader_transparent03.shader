// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/shader_transparent_03" {
	
	SubShader {
		tags{"queue"="transparent"}
		pass{
		//被遮罩
			blend srcalpha oneminussrcalpha

			ztest Greater
			//zwrite off
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "unityCG.cginc"


			struct v2f {
				float4 pos : POSITION;
			};

			v2f vert(appdata_base v){
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex); //UnityObjectToClipPos(v.vertex);

				return o;
			}
		
			fixed4 frag(v2f IN):COLOR
			{
				return fixed4(1,1,0,1);
			}
		
			ENDCG

		}
		pass{
			//blend srcalpha oneminussrcalpha
			//不被遮罩
			ztest less

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "unityCG.cginc"


			struct v2f {
				float4 pos : POSITION;
			};

			v2f vert(appdata_base v){
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex); //UnityObjectToClipPos(v.vertex);

				return o;
			}
		
			fixed4 frag(v2f IN):COLOR
			{
				return fixed4(0,0,1,1);
			}
		
			ENDCG

		}
	}
	
}
