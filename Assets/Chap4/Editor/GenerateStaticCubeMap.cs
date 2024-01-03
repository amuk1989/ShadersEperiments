using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class GenerateStaticCubeMap : ScriptableWizard
{
    public Transform _renderPosition;
    public Cubemap _cubemap;

    private void OnWizardCreate()
    {
        var go = new GameObject("Cubemap", typeof(Camera));
        go.transform.SetParent(_renderPosition, false);
        go.GetComponent<Camera>().RenderToCubemap(_cubemap);
        DestroyImmediate(go);
    }

    private void OnWizardUpdate()
    {
        helpString = $"Select transform to render from and cubemap to render info";
        isValid = _cubemap != null && _renderPosition != null;
    }

    [MenuItem("Custom/Render Cubemap")]
    private static void RenderCubeMap()
    {
        DisplayWizard("Render CubeMap", typeof(GenerateStaticCubeMap), "Render!");
    }
}
