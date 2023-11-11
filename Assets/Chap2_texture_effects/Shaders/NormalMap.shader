Shader "Custom/Chapter2/NormalMap" {
	Properties {
		_MainTint ("Diffuse tint", Color) = (1,1,1,1)
		_NormalTex ("Normal texture", 2D) = "bump" {}
		_NormalIntensity ("Normal Map Intensity", Range(0,5)) = 1
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
			float2 uv_NormalTex;
		};

		sampler2D _NormalTex;
		float4 _MainTint;
		float _NormalIntensity;

		void surf (Input IN, inout SurfaceOutput o) {
			float3 normalMap = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
			normalMap = float3(normalMap.x * _NormalIntensity, normalMap.y * _NormalIntensity, normalMap.z);
			o.Normal = normalMap.rgb;
			o.Albedo = _MainTint.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}