using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Procedural : MonoBehaviour
{
    [SerializeField] private int _widthHeight = 512;
    [SerializeField] private Texture2D _generatedTexture;
    [SerializeField] private Renderer _renderer;

    private Material _currentMaterial;
    private Vector2 _centerPosition;
    private static readonly int MainTex = Shader.PropertyToID("_MainTex");

    // Start is called before the first frame update
    void Start()
    {
        if (!_currentMaterial)_currentMaterial = _renderer.sharedMaterial;
        _centerPosition = new Vector2(0.5f, 0.5f);
        _generatedTexture = GenerateGradient(_centerPosition);
        _currentMaterial.SetTexture(MainTex, _generatedTexture);
    }

    private Texture2D GenerateGradient(Vector2 centerPosition)
    {
        var proceduralTexture = new Texture2D(_widthHeight, _widthHeight);
        var centerPixelPosition = centerPosition * _widthHeight;

        for (int x = 0; x < _widthHeight; x++)
        {
            for (int y = 0; y < _widthHeight; y++)
            {
                var currentPosition = new Vector2(x, y);
                float pixelDistance = Vector2.Distance(currentPosition, centerPixelPosition) / (_widthHeight * 0.5f);
                pixelDistance = Mathf.Abs(1 - Mathf.Clamp01(pixelDistance));
                // pixelDistance = Mathf.Sin(pixelDistance * 30) * pixelDistance;

                var pixelColor = new Color(pixelDistance, pixelDistance, pixelDistance, 1f);
                proceduralTexture.SetPixel(x,y,pixelColor);
            }
        }
        
        proceduralTexture.Apply();

        return proceduralTexture;
    }
}
