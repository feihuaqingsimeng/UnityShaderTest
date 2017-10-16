// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/shader_transcolor" {
	properties{
		_maincolor("mainColor",color) = (1,1,1,1)
		_secondColor("secondColor",color) = (1,1,1,1)
		_center("center",range(-0.7,0.7)) = 0
		_r("r",range(0,0.5)) = 0.2
	}
	SubShader {
		tags{"queue" = "transparent"}

		pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "unityCG.cginc"

			fixed4 _maincolor;
				fixed4 _secondColor;
				float _center;
				float _r;
			struct v2f {
				float4 pos : POSITION;
				float y : COLOR;
			};
			v2f vert(appdata_base v) {
				
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.y = v.vertex.y;
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				
				float d = IN.y - _center;
				float s = abs(d);
				 d = d / s;
				float f = s / _r;
				f = saturate(f);

				d *= f;
				d = d*0.5 + 0.5;

				return lerp(_maincolor, _secondColor, d);
				
				
			}

			ENDCG
	}
		
	}
	//FallBack "Diffuse"
}
