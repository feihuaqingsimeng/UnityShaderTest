Shader "Custom/shader_texture01" {
	properties{
		_MainTex("MainTex",2D) = ""{}
		tiling_x("tiling_x",range(1,5)) = 1
		tiling_y("tiling_y",range(1,5)) = 1
		offset_x("offset_x",range(0,1)) = 0
		offset_y("offset_y",range(0,1)) = 0
	}
	SubShader {
		
		
		pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "unityCG.cginc"

				sampler2D _MainTex;
				float4 _MainTex_ST;
				float tiling_x ;
				float tiling_y;
				float offset_x;
				float offset_y;

			struct v2f {
				float4 pos : POSITION;
				float2 uv:TEXCOORD0;
			};
			v2f vert(appdata_base v) {
				
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				//o.uv = v.texcoord.xy *_MainTex_ST.xy+ _MainTex_ST.zw;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				/*IN.uv.x *= tiling_x;
				IN.uv.x += offset_x;
				IN.uv.y *= tiling_y;
				IN.uv.y += offset_y;
				*/
				
				fixed4 color = tex2D(_MainTex,IN.uv);

				return color;
				
				
			}

			ENDCG
	}
		
	}
	//FallBack "Diffuse"
}
