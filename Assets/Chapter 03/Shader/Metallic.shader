Shader "Custom/Chap3/Metallic"
{
	Properties
	{
		_MainTint ("Diffuse tint", Color) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RoughnessTex ("Roughness texture", 2D) = "" {}
		_Roughness ("Roughness", Range(0,1)) = 0.5
		_SpecularColor ("Specular color", Color) = (1,1,1,1)
		_SpecPower ("Specular power", Range(0,30)) = 2
		_Fresnel ("Fresnel Value", Range(0,1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma surface surf MetallicSoft
			#pragma target 4.0

			struct Input {
				float2 uv_MainTex;
			};

			sampler2D _MainTex;
			sampler2D _RoughnessTex;
			float _Roughness;
			float _Fresnel;
			float _SpecPower;
			
			float4 _MainTint;
			float4 _SpecularColor;

			inline fixed4 LightingMetallicSoft(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
			{
				float3 halfVector = normalize(lightDir + viewDir);
				float NdotL = saturate(dot(s.Normal, normalize(lightDir)));
				float NdotH_raw = dot(s.Normal, halfVector);
				float NdotH = saturate(NdotH_raw);
				float NdotV = saturate(dot(s.Normal, normalize(viewDir)));
				float VdotH = saturate(dot(halfVector, normalize(viewDir)));
			}
			
			void surf (Input IN, inout SurfaceOutput o)
			{
				
			}
			ENDCG
		}
	}
}