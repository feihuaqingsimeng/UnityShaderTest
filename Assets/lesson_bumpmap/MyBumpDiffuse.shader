// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MyBumpDiffuse" {
	properties{
		_BumpTex("NormalMap",2D) = ""{}
	}
	SubShader
	{
		

		pass {

			Tags{ "LightMode" = "ForwardBase" }

				CGPROGRAM

			#pragma multi_compile_fwbase
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			sampler2D _BumpTex;
			struct v2f
			{
				float4 pos:POSITION;
				float2 uv:TEXCOORD0;
				float wpos: TEXCOORD1;
				float3 lightDir:TEXCOORD2;
			};

			v2f vert(appdata_tan v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);
			
				o.uv = v.texcoord.xy;
				TANGENT_SPACE_ROTATION;
				//float3 binormal = cross(v.tangent.xyz,v.normal);
				//float3x3 rotation = float3x3(v.tangent.xyz,binormal,v.normal);
				o.lightDir = mul(rotation,_WorldSpaceLightPos0.xyz);
			

				o.wpos = mul(unity_ObjectToWorld,v.vertex);
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{

				float3 L = normalize(IN.lightDir);
				float3 N = normalize(UnpackNormal(tex2D(_BumpTex,IN.uv)));
			

				fixed4 col = UNITY_LIGHTMODEL_AMBIENT;
				//diffuse color
				float diffuseScale = saturate(dot(N, L));
				col += _LightColor0 * diffuseScale;


				col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].rgb,
					unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
					unity_4LightAtten0, IN.wpos, N);
				return col;
			}


			ENDCG
		}
		pass {
			blend one one
			Tags{ "LightMode" = "ForwardAdd" }

				CGPROGRAM

			#pragma multi_compile_fwbase
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			sampler2D _BumpTex;
			struct v2f
			{
				float4 pos:POSITION;
				float2 uv:TEXCOORD0;
				float wpos: TEXCOORD1;
				float3 lightDir:TEXCOORD2;
			};

			v2f vert(appdata_tan v)
			{
				v2f o;

				o.pos = UnityObjectToClipPos(v.vertex);
			
				o.uv = v.texcoord.xy;
				TANGENT_SPACE_ROTATION;
				//float3 binormal = cross(v.tangent.xyz,v.normal);
				//float3x3 rotation = float3x3(v.tangent.xyz,binormal,v.normal);
				o.lightDir = mul(rotation,_WorldSpaceLightPos0.xyz);
			

				o.wpos = mul(unity_ObjectToWorld,v.vertex);
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{

				float3 L = normalize(IN.lightDir);
				float3 N = normalize(UnpackNormal(tex2D(_BumpTex,IN.uv)));
			

				
				//点光源衰减系数
				float atten = 1;
				if (_WorldSpaceLightPos0.w != 0){
					atten = 1.0/length(IN.lightDir);

				}

				float diffuseScale = saturate(dot(N, L));
				fixed4 col = _LightColor0 * diffuseScale*atten;
				
				

				return col;
			}


			ENDCG
		}
	}

}
