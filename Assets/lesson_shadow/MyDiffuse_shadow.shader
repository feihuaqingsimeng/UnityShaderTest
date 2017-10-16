// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MyDiffuse_shadow" {
	
		SubShader
	{

		
		pass {

			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM

			
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwbase
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			
			struct v2f
			{
				float4 pos:POSITION;
				fixed4 col : COLOR;
				LIGHTING_COORDS(0, 1)
				//unityShadowCoord3 _LightCoord : TEXCOORD0;
				//unityShadowCoord3 _ShadowCoord : TEXCOORD1;
			};

			v2f vert(appdata_base v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);

				//ambient color
				o.col = UNITY_LIGHTMODEL_AMBIENT;

				float3 L = normalize(WorldSpaceLightDir(v.vertex));
				float3 N = UnityObjectToWorldNormal(v.normal);
				float3 V = normalize(WorldSpaceViewDir(v.vertex));
				//N = mul(unity_ObjectToWorld, float4(N, 0)).xyz;

				//diffuse color
				float diffuseScale = saturate(dot(N, L));
				o.col += _LightColor0 * diffuseScale;

				
				float3 wpos = mul(unity_ObjectToWorld, v.vertex).xyz;

				//o.col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].rgb,
				//	unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
				//	unity_4LightAtten0, wpos, N);

				TRANSFER_VERTEX_TO_FRAGMENT(o)
				
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				float atten = LIGHT_ATTENUATION(IN);
				//UNITY_LIGHT_ATTENUATION(atten,IN,wpos)
				IN.col.rgb *= atten;
				return IN.col;
			}


				ENDCG
		}

	}
	fallback "Diffuse"
}
