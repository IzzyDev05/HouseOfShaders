Shader "Custom/StylizedLighting"
{
    Properties
    {
        _MainColor("Main Color", Color) = (1,1,1,1)
        [IntRange] _Shades("Shades", Range(1, 20)) = 3
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };

            float4 _MainColor;
            int _Shades;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // dotP is the amount of light that will hit the vertex
                float dotP = dot(normalize(i.worldNormal), normalize(_WorldSpaceLightPos0.xyz));
                dotP = max(dotP, 0); // We only need the positive values
                dotP = floor(dotP * _Shades) / _Shades; // Changing continuous shadows into discreet ones 
                
                return _MainColor * dotP;
            }
            
            ENDCG
        }
    }
}
