// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MySpecular" {
	properties{
		_specularColor("specular",color) = (1,1,1,1)
		_shininess("shininess",range(1,64)) = 8
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

		float4 _specularColor;
		float _shininess;
		struct v2f
		{
			float4 pos:POSITION;
			fixed4 col : COLOR;
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			
			//ambient color
			o.col = UNITY_LIGHTMODEL_AMBIENT;
			
			float3 L = normalize(WorldSpaceLightDir(v.vertex));
			float3 N = UnityObjectToWorldNormal(v.normal);
			float3 V = normalize(WorldSpaceViewDir(v.vertex));
			//N = mul(unity_ObjectToWorld, float4(N, 0)).xyz;

			//diffuse color
			float diffuseScale = saturate(dot(N, L));
			o.col += _LightColor0 * diffuseScale;

			//specular color
			//float3 wpos = mul(unity_ObjectToWorld, v.vertex).xyz;
			//float3 i = -WorldSpaceLightDir(v.vertex);
			//float3 R = reflect(i, N);
			float3 R = 2 * dot(N, L)*N - L;
			float3 H = L + V;
			H = normalize(H);
			R = normalize(R);
			float specularScale = pow(saturate( dot(R,V)), _shininess);
			//float specularScale = pow(saturate(dot(H, N)), _shininess);
			o.col.rgb += _specularColor*specularScale;
			return o;
		}

		fixed4 frag(v2f IN) :COLOR
		{
			return IN.col;
		}


			ENDCG
	}

	}

}
