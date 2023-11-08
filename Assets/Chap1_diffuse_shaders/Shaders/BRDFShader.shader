Shader "Custom/BRDFShader"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _RampTex ("Ramp (RGB)", 2D) = "white" {}
        _EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
        _AmbientColor ("Ambient Color", Color) = (1,1,1,1)
        _MySliderValue ("Slider", Range (0,10)) = 2.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        float4 _EmissiveColor;
        float4 _AmbientColor;
        float _MySliderValue;
        
        sampler2D _RampTex;
        
        #pragma surface surf BasicDiffuse

        struct Input
        {
            float2 uv_MainTex;
        };

        inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightingDir, half3 viewDir, fixed atten)
        {
            float dif = dot(s.Normal, lightingDir);
            float rim = dot(s.Normal, viewDir);
            float hLambert = dif * 0.5f + 0.5f;
            float3 ramp = tex2D(_RampTex, float2(hLambert, rim)).rgb;
            
            float4 col;
            col.rgb = s.Albedo*_LightColor0.rgb*(ramp);
            col.a = s.Alpha;
            return col;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 c;
            c = _EmissiveColor+_AmbientColor * _MySliderValue;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
