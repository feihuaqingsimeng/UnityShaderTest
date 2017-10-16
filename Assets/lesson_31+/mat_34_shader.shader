// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/mat_34_shader" {
	
	

	SubShader
	{
		

		pass{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			
			struct v2f
			{
				float4 pos:POSITION;
				fixed4 col : COLOR;
			};
			
			
			v2f vert(appdata_base v)
			{
				

				
				v.vertex.y += sin(v.vertex.x+v.vertex.z+_Time.y)*0.2;
				v.vertex.y += sin(v.vertex.x - v.vertex.z + _Time.w)*0.3;
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.col = fixed4(v.vertex.y, v.vertex.y, v.vertex.y, 1);
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
