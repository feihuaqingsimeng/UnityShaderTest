// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/mat_33_shader" {
	
	

	SubShader
	{
		

		pass{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			float4x4 mvp;
			float4x4 rm;
			float4x4 sm;
			struct v2f
			{
				float4 pos:POSITION;
				fixed4 col : COLOR;
			};
			
			v2f vert(appdata_base v)
			{
				v2f o;
			
				float4x4 m = UnityObjectToClipPos(sm);
				o.pos = mul(m, v.vertex);
				if (v.vertex.x == 0.5&&v.vertex.y == 0.5 && v.vertex.z == -0.5) {
					o.col = fixed4(_SinTime.w/2+0.5, _CosTime.w/2+0.5, _SinTime.y/2+0.5, 1);
				}
				else {
					o.col = fixed4(0, 0, 1, 1);
				}
				/*float4 wpos = mul(unity_ObjectToWorld, v.vertex);

				if (wpos.x > 0) {
					o.col = fixed4(1, 0, 0, 1);
				}
				else {
					o.col = fixed4(0, 0, 1, 1);
				}*/
				return o;
			}

			fixed4 frag(v2f IN):COLOR
			{
			
				return IN.col;
			}
		

			ENDCG
		}
	
	}
	
}
