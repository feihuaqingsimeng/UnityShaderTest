// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/shader_animation2" {
	properties{
		_MainTex("MainTex",2D) = ""{}
		_SecondTex("SecondTex",2D) = ""{}
		_F("F",range(1,10)) = 4
	}
	SubShader {
		
		
		pass {

				colormask b
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "unityCG.cginc"

				sampler2D _MainTex;

				float4 _MainTex_ST;
				sampler2D _SecondTex;
				float _F;
			struct v2f {
				float4 pos : POSITION;
				float2 uv:TEXCOORD0;
			};
			v2f vert(appdata_base v) {
				
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				//o.uv = v.texcoord.xy *_MainTex_ST.xy+ _MainTex_ST.zw;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				fixed4 mainColor = tex2D(_MainTex,IN.uv);

				float offset_uv = 0.05*sin(IN.uv*_F+_Time.x*2);
				float2 uv = IN.uv +offset_uv;
				uv.y+= 0.3;
				fixed4 color_1 = tex2D(_SecondTex,uv);
				mainColor.rgb *= color_1.b;
				mainColor.rgb *= 2;

				uv = IN.uv -offset_uv;
				uv.y+= 0.3;
				fixed4 color_2= tex2D(_SecondTex,uv);
				mainColor.rgb *= color_2.b;
				mainColor.rgb *= 2;

				return mainColor;
				/*float2 uv = IN.uv ;
				float offset_uv = 0.05*sin(IN.uv*_F+_Time.x*2);
				uv += offset_uv;
				fixed4 color = tex2D(_MainTex,uv); //+ fixed4(1,1,1,1)*saturate(scale)*100;
				uv = IN.uv;
				uv -= offset_uv;
				color.rgb += tex2D(_MainTex,uv); //+ fixed4(1,1,1,1)*saturate(scale)*100;
				color.rgb /= 2;
				return color;*/
				
				
			}

			ENDCG
	}
		
	}
	//FallBack "Diffuse"
}
