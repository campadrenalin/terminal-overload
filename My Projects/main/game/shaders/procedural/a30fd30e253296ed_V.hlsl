//*****************************************************************************
// Torque -- HLSL procedural shader
//*****************************************************************************

// Dependencies:
#include "shaders/common/lighting.hlsl"
//------------------------------------------------------------------------------
// Autogenerated 'Light Buffer Conditioner [RGB]' Uncondition Method
//------------------------------------------------------------------------------
inline void autogenUncondition_bde4cbab(in float4 bufferSample, out float3 lightColor, out float NL_att, out float specular)
{
   lightColor = bufferSample.rgb;
   NL_att = dot(bufferSample.rgb, float3(0.3576, 0.7152, 0.1192));
   specular = max(bufferSample.a / NL_att, 0.00001f);
}


#include "shaders/common/torque.hlsl"

// Features:
// Vert Position
// Diffuse Vertex Color
// Base Texture
// Diffuse Color
// Deferred RT Lighting
// Reflect Cube
// Visibility
// Fog
// HDR Output
// Translucent
// Forward Shaded Material

struct VertData
{
   float3 position        : POSITION;
   float3 normal          : NORMAL;
   float3 T               : TANGENT;
   float4 diffuse         : COLOR;
   float2 texCoord        : TEXCOORD0;
};


struct ConnectData
{
   float4 hpos            : POSITION;
   float4 vertColor       : COLOR;
   float2 out_texCoord    : TEXCOORD0;
   float3 wsNormal        : TEXCOORD1;
   float3 outWsPosition   : TEXCOORD2;
   float3 reflectVec      : TEXCOORD3;
};


//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------
ConnectData main( VertData IN,
                  uniform float4x4 modelview       : register(C0),
                  uniform float4x4 objTrans        : register(C4),
                  uniform float3   eyePosWorld     : register(C8)
)
{
   ConnectData OUT;

   // Vert Position
   OUT.hpos = mul(modelview, float4(IN.position.xyz,1));
   
   // Diffuse Vertex Color
   OUT.vertColor = IN.diffuse;
   
   // Base Texture
   OUT.out_texCoord = (float2)IN.texCoord;
   
   // Diffuse Color
   
   // Deferred RT Lighting
   OUT.wsNormal = mul( objTrans, float4( normalize( IN.normal ), 0.0 ) ).xyz;
   OUT.outWsPosition = mul( objTrans, float4( IN.position.xyz, 1 ) ).xyz;
   
   // Reflect Cube
   float3 cubeVertPos = mul((float3x3)objTrans, IN.position).xyz;
   float3 cubeNormal = normalize( mul(objTrans, normalize(IN.normal)).xyz );
   float3 cubePos = float3( objTrans[0][3], objTrans[1][3], objTrans[2][3] );
   float3 eyeToVert = cubeVertPos - ( eyePosWorld - cubePos );
   OUT.reflectVec = reflect(eyeToVert, cubeNormal);
   
   // Visibility
   
   // Fog
   
   // HDR Output
   
   // Translucent
   
   // Forward Shaded Material
   
   return OUT;
}
