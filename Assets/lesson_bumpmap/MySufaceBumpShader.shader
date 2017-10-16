Shader "Custom/MySufaceBumpShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("Normalmap",2D) = ""{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		
		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _BumpMap;
		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
			float4 cn = tex2D(_BumpMap,IN.uv_BumpMap);
			o.Normal = cn.rgb*2-1;
		}
		ENDCG
	}
	FallBack "Legacy Shaders/Diffuse"
}
