Shader "Custom/Chapter2/UVSpriteAnimated"
{
    Properties
    {
        _MainTint ("Diffuse Tint", Color) = (1,1,1,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _CellAmount ("Cell Amount", float) = 0.0
        _Speed ("Speed", Range(0.01, 32)) = 12
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
        };
        
        fixed4 _MainTint;
        fixed _ScrollXSpeed;
        fixed _ScrollYSpeed;
        fixed _CellAmount;
        fixed _Speed;
        sampler2D _MainTex;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 spriteUV = IN.uv_MainTex;
            float2 cellUV = 1/_CellAmount;

            float frame = fmod(_Time.y * _Speed, _CellAmount);
            frame = floor(frame);

            float xValue = (spriteUV.x + frame) * cellUV;
            spriteUV = float2(xValue, spriteUV.y);

            half4 c = tex2D(_MainTex, spriteUV);
            
            o.Albedo = c.rgb * _MainTint;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
