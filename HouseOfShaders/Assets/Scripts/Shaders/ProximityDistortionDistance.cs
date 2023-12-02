using System;
using Unity.Mathematics;
using UnityEngine;

public class ProximityDistortionDistance : MonoBehaviour
{
    [SerializeField] private Transform target;
    [SerializeField] private float activationDistance = 5f;
    [SerializeField] private float distancePadding = 2f;

    private Material mat;
    private MeshRenderer mr;

    private void Start()
    {
        mr = GetComponent<MeshRenderer>();
        mat = mr.material;
    }

    private void Update()
    {
        float distance = Vector3.Distance(target.position, transform.position);
        float normalizedDistance = 1 - Mathf.Clamp01((distance - distancePadding) / activationDistance);
        mat.SetFloat("_Amount", normalizedDistance);
    }
}