//*****************************************************************************
// Torque -- HLSL procedural shader
//*****************************************************************************

// Dependencies:
#include "shaders/common/torque.hlsl"

// Features:
// Vert Position
// Base Texture
// Reflect Cube
// Visibility
// Translucent ZWrite

struct VertData
{
   float3 position        : POSITION;
   float tangentW        : TEXCOORD3;
   float3 normal          : NORMAL;
   float3 T               : TANGENT;
   float2 texCoord        : TEXCOORD0;
};


struct ConnectData
{
   float4 hpos            : POSITION;
   float2 out_texCoord    : TEXCOORD0;
   float3 reflectVec      : TEXCOORD1;
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
   
   // Base Texture
   OUT.out_texCoord = (float2)IN.texCoord;
   
   // Reflect Cube
   float3 cubeVertPos = mul((float3x3)objTrans, IN.position).xyz;
   float3 cubeNormal = normalize( mul(objTrans, normalize(IN.normal)).xyz );
   float3 cubePos = float3( objTrans[0][3], objTrans[1][3], objTrans[2][3] );
   float3 eyeToVert = cubeVertPos - ( eyePosWorld - cubePos );
   OUT.reflectVec = reflect(eyeToVert, cubeNormal);
   
   // Visibility
   
   // Translucent ZWrite
   
   return OUT;
}
