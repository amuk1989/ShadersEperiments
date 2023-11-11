Shader "Custom/Chapter2/UnpackTexture" {
	Properties {
		_MainTint ("Diffuse tint", Color) = (1,1,1,1)
		_ColorA ("Color A", Color) = (1,1,1,1)
		_ColorB ("Color B", Color) = (1,1,1,1)
		_RTexture ("Red chanel texture", 2D) = "" {}
		_GTexture ("Green chanel texture", 2D) = "" {}
		_BTexture ("Blue chanel texture", 2D) = "" {}
		_ATexture ("Alpha chanel texture", 2D) = "" {}
		_BlendTexture ("Blend texture", 2D) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.5

		struct Input {
			float2 uv_RTexture : TEXCOORD0;
			float2 uv_GTexture;
			float2 uv_BTexture;
			float2 uv_ATexture;
			float2 uv_BlendTexture;
		};

		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;

		sampler2D _RTexture;
		sampler2D _GTexture;
		sampler2D _BTexture;
		sampler2D _ATexture;
		sampler2D _BlendTexture;

		void surf (Input IN, inout SurfaceOutput o) {
			float4 blendTexData = tex2D(_BlendTexture, IN.uv_BlendTexture);
			float4 rTexData = tex2D(_RTexture, IN.uv_RTexture);
			float4 gTexData = tex2D(_GTexture, IN.uv_GTexture);
			float4 bTexData = tex2D(_BTexture, IN.uv_BTexture);
			float4 aTexData = tex2D(_ATexture, IN.uv_ATexture);

			float4 finalColor;
			finalColor = lerp(rTexData, gTexData, blendTexData.g);
			finalColor = lerp(finalColor, bTexData, blendTexData.b);
			finalColor = lerp(finalColor, aTexData, blendTexData.a);
			finalColor.a = 1.0;

			float4 terrainLayers = lerp(_ColorA, _ColorB, blendTexData.r);
			finalColor *= terrainLayers;
			finalColor = saturate(finalColor);

			o.Albedo = finalColor.rgb * _MainTint.rgb; 
			o.Alpha = finalColor.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}