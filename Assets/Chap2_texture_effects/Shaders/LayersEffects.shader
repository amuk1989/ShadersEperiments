Shader "Custom/Chapter2/LayersEffects"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		
		_inBlack ("Input Black", Range(0,255)) = 0
		_inGamma ("Input Gamma", Range(0,2)) = 1.61
		_inWhite ("Input White", Range(0,255)) = 255
		
		_outWhite ("Out White", Range(0,255)) = 255
		_outBlack ("Out Black", Range(0,255)) = 0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGPROGRAM
		#pragma surface surf Lambert
		#pragma target 3.5

		sampler2D _MainTex;
		float _inBlack;
		float _inGamma;
		float _inWhite;
		float _outWhite;
		float _outBlack;

		struct Input
		{
			float2 uv_MainTex;
		};
			
		void surf(Input IN, inout SurfaceOutput o)
		{
				float4 c = tex2D(_MainTex, IN.uv_MainTex); 
				float outRPixel = c.r * 255;
				outRPixel = max(0, outRPixel - _inBlack);
				outRPixel = saturate(pow(outRPixel/(_inWhite-_inBlack), _inGamma));
				outRPixel = (outRPixel*(_outWhite-_outBlack)+_outBlack)/255;
			c.r = outRPixel;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
}