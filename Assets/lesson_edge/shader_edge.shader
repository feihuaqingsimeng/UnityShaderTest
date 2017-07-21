Shader "Custom/shader_edge" {
	properties{
		_maincolor("mainColor",color) = (1,1,1,1)
		_scale("Scale",range(1,8)) = 1
		_outer("outer",range(0,1)) = 0.2
	}
	SubShader {
		tags{"queue" = "transparent"}

		pass {
			blend srcalpha OneMinusSrcAlpha
				zwrite off
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "unityCG.cginc"

				float _scale;
			fixed4 _maincolor;
			float _outer;
			struct v2f {
				float4 pos : POSITION;
				float4 vertex:TEXCOORD0;
				float3 normal:NORMAL;
			};
			v2f vert(appdata_base v) {
				v.vertex.xyz += v.normal*_outer;
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.vertex = v.vertex;
				o.normal = v.normal;
				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				float bright = saturate(dot(N, V));
				
				
				_maincolor.a *= bright;
				return _maincolor;
			}

			ENDCG
	}
		//=======================================

		pass {
			//blend zero one
			blendop revsub
			blend dstalpha one
			zwrite off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "unityCG.cginc"

			fixed4 _maincolor;
			struct v2f {
				float4 pos : POSITION;

			};
			v2f vert(appdata_base v) {

				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				return o;
			}

			fixed4 frag(v2f IN) :COLOR
			{
				return _maincolor;
			}

			ENDCG
	}

		//========================================
		
		pass {
			//blend one zero
			blend  srcalpha OneMinusSrcAlpha
			zwrite off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "unityCG.cginc"

			float _scale;
			struct v2f {
				float4 pos : POSITION;
				float4 vertex:TEXCOORD0;
				float3 normal:NORMAL;
			};
			v2f vert(appdata_base v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.vertex = v.vertex;
				o.normal = v.normal;
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
				float3 N = UnityObjectToWorldNormal(IN.normal);
				float3 V = normalize(WorldSpaceViewDir(IN.vertex));
				float dot1 = dot(N, V);
				//if (dot1 >= 0 && dot1 <= 0.2) {
				//	return fixed4(1, 0, 0, 1);
				//}
				float bright = pow(1 - dot1, _scale);
				return bright*fixed4(1,1,1,1);
			}

			ENDCG
		}
		
	}
	//FallBack "Diffuse"
}
