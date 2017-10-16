﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/shader_wave_texture" {
	properties{
		_MainTex("MainTex",2D) = ""{}

	}
	SubShader {
		
		
		pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "unityCG.cginc"

				sampler2D _MainTex;
				sampler2D _WaveTex;
			struct v2f {
				float4 pos : POSITION;
				float2 uv:TEXCOORD0;
			};
			v2f vert(appdata_base v) {
				
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord.xy;
				//o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				
				float2 uv = tex2D(_WaveTex,IN.uv).xy;
				
				uv = uv*2-1;

				uv *= 0.3;
				IN.uv += uv;

				fixed4 color = tex2D(_MainTex, IN.uv); //+ fixed4(1,1,1,1)*saturate(scale)*100;

				return color;
				
				
			}

			ENDCG
	}
		
	}
	//FallBack "Diffuse"
}
