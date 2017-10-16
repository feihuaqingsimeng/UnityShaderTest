// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/shader_uv_fuzzy" {
	Properties {
		_MainTex("MainTex",2D) = ""{}

	}
	SubShader {
		pass{
		
			Tags { "RenderType"="Opaque" }
		
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "unityCG.cginc"

			sampler2D _MainTex; 
			float4 _MainTex_ST;
			struct v2f{
				float4 pos:POSITION;
				float2 uv :TEXCOORD0;
				float z: TEXCOORD1;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;
				o.z = mul(unity_ObjectToWorld,v.vertex).z;
				return o;
			
			}
			fixed4 frag(v2f IN):COLOR
			{
				float offset_uv = 0.01;
				float2 uv = IN.uv;
				
				/*float dx = ddx(IN.uv.x)*10;
				float2 dsdx = float2(dx,dx);

				float dy = ddy(IN.uv.y)*20;
				float2 dsdy = float2(dy,dy);*/

				float2 dsdx = ddx(IN.z)*30;
				float2 dsdy = ddx(IN.z)*30;

				fixed4 color = tex2D(_MainTex,uv,float2(0,0),dsdy);
				return color;
		
			}
			ENDCG
		
		
		}
		

		
	}
	FallBack "Diffuse"
}
