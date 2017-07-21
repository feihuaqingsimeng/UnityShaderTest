// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/MyDiffuseFrag" {
	
	properties{ 
		_mainColor("mainColor",color) = (1,1,1,1)
		_specularColor("specularColor",color) = (1,1,1,1)
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
		float4 _mainColor;
		float _shininess;
		struct v2f
		{
			float4 pos:POSITION;
			float3 normal:NORMAL;
			float4 vertex:COLOR;
		};

		v2f vert(appdata_base v)
		{
			v2f o;

			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			o.normal = v.normal;
			o.vertex = v.vertex;

			return o;
		}

		fixed4 frag(v2f IN) :COLOR
		{

			//ambinet color
			fixed4 col = UNITY_LIGHTMODEL_AMBIENT;


			//defuse color
			float3 L = normalize(WorldSpaceLightDir(IN.vertex));
			float3 N = UnityObjectToWorldNormal(IN.normal);
			float diffuseScale = saturate(dot(N, L));
			col += _LightColor0*_mainColor*diffuseScale;
			//specular color
			float3 V = normalize(WorldSpaceViewDir(IN.vertex));
			float3 R = 2 * dot(N, L)*N - L;//reflect(-WorldSpaceLightDir(IN.vertex), N);//
			R = normalize(R);
			float specularScale = pow(saturate(dot(R, V)), _shininess);
			col += _specularColor *specularScale;

			float3 wpos = mul(unity_ObjectToWorld, IN.vertex).xyz;
			col.rgb += Shade4PointLights(unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].rgb,
				unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
				unity_4LightAtten0, wpos, N);
			return col;
		}


			ENDCG
	}

	}

}
