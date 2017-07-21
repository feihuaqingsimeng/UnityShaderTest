Shader "Custom/matshader" {
	
	properties{
			_mainColor("Main Color",color)=(1,1,1,1)
			
		}

	SubShader
	{
		

		pass{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			
			float4 _mainColor;

			float4 _secondColor;

			struct v2f
			{
				float4 pos:POSITION;
				float2 objPos:TEXCOORD0;
				fixed4 col:COLOR;
			};
			struct appdata_base
			{
				float2 pos:POSITION;
				float4 col:COLOR;
			};
			v2f vert(appdata_base v)
			{
				v2f o;
			
				o.pos = float4(v.pos,0,1);
				o.objPos = float2(1,0);
				o.col = v.col;
				return o;
			}

			fixed4 frag(v2f o):COLOR
			{
			
				//return o.col;
				//return _mainColor * _secondColor;
				//return _mainColor * 0.5 + _secondColor*0.5;
				return lerp(_mainColor,_secondColor,0.7);
			}
		

			ENDCG
		}
	
	}
	
}
