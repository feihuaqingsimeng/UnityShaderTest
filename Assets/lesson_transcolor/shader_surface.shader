Shader "Custom/shader_surface" {
	Properties {
		//_Color ("Color", Color) = (1,1,1,1)
		_maincolor("mainColor",color) = (1,1,1,1)
		_secondColor("secondColor",color) = (1,1,1,1)
		_center("center",range(-0.7,0.7)) = 0
		_r("r",range(0,0.5)) = 0.2
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard vertex:vert fullforwardshadows 

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _maincolor;
		fixed4 _secondColor;
		float _center;
		float _r;

		struct Input {
			float2 uv_MainTex;
			float x;
		};

		void vert(inout appdata_full v, out Input o) {
			o.uv_MainTex = v.texcoord.xy;
			o.x = v.vertex.x;
		}

		

		half _Glossiness;
		half _Metallic;
		

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;

			float d = IN.x - _center;
			float s = abs(d);
			d = d / s;
			float f = s / _r;
			f = saturate(f);

			d *= f;
			d = d*0.5 + 0.5;

			o.Albedo *= lerp(_maincolor, _secondColor, d);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
