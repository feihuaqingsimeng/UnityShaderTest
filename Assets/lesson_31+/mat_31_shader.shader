// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/mat_31_shader" {
	
	

	SubShader
	{
		

		pass{

		Tags{ "LightMode" = "ForwardBase"  }

			CGPROGRAM


			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			float4x4 mvp;
			float4x4 rm;
			float4x4 sm;
			struct v2f
			{
				float4 pos:POSITION;
				fixed4 col:COLOR;
			};
			
			v2f vert(appdata_base v)
			{
				v2f o;
			
				o.pos = UnityObjectToClipPos(v.vertex);
				//float4x4 m = mul(UNITY_MATRIX_MVP, rm);
				//m = mul(m, sm);
				//o.pos = mul(m, v.vertex);
				//o.col = fixed4(1, 0, 0, 1);
				float3 N = normalize(v.normal);
				float3 L = normalize(_WorldSpaceLightPos0);
				N = mul(float4(N, 0), unity_WorldToObject).xyz;
				N = normalize(N);
				//N = mul(unity_ObjectToWorld, float4(N, 0)).xyz;
				float ndot1 = saturate(dot(N, L));
				o.col = _LightColor0 * ndot1;
				
				float3 wpos = mul(unity_ObjectToWorld, v.vertex).xyz;
				
				o.col.rgb = Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].rgb,
					unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
					unity_4LightAtten0, wpos,N);

				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				return IN.col + UNITY_LIGHTMODEL_AMBIENT;
			}
		

			ENDCG
		}
	
	}
	
}
