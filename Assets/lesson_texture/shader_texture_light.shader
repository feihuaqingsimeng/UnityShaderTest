// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

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
				// sampler2D unity_Lightmap;
				float4 _MainTex_ST;
				// float4 unity_LightmapST;
				float tiling_x ;
				float tiling_y;
				float offset_x;
				float offset_y;

			struct v2f {
				float4 pos : POSITION;
				float2 uv:TEXCOORD0;
				float2 uv2:TEXCOORD1;
			};
			v2f vert(appdata_full v) {
				
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				//o.uv = v.texcoord.xy *_MainTex_ST.xy+ _MainTex_ST.zw;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.uv2 = v.texcoord1.xy*unity_LightmapST.xy+unity_LightmapST.zw;
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				/*IN.uv.x *= tiling_x;
				IN.uv.x += offset_x;
				IN.uv.y *= tiling_y;
				IN.uv.y += offset_y;
				*/
				float3 lm = DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap,IN.uv2));
				fixed4 color = tex2D(_MainTex,IN.uv);
				color.rgb *= lm*2;
				return color;
				
				
			}

			ENDCG
	}
		
	}
	//FallBack "Diffuse"
}
