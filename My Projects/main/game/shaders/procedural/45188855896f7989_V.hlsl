//*****************************************************************************
// Torque -- HLSL procedural shader
//*****************************************************************************

// Dependencies:
#include "shaders/common/torque.hlsl"

// Features:
// Vert Position
// Detail
// Diffuse Color
// Bumpmap [Deferred]
// Visibility
// Translucent
// DXTnm
// Forward Shaded Material

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
   float2 detCoord        : TEXCOORD0;
   float2 out_texCoord    : TEXCOORD1;
   float3x3 outWorldToTangent : TEXCOORD2;
};


//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------
ConnectData main( VertData IN,
                  uniform float4x4 modelview       : register(C0),
                  uniform float2   detailScale     : register(C8),
                  uniform float4x4 worldToObj      : register(C4)
)
{
   ConnectData OUT;

   // Vert Position
   OUT.hpos = mul(modelview, float4(IN.position.xyz,1));
   
   // Detail
   OUT.detCoord = IN.texCoord * detailScale;
   
   // Diffuse Color
   
   // Bumpmap [Deferred]
   OUT.out_texCoord = (float2)IN.texCoord;
   float3x3 objToTangentSpace;
   objToTangentSpace[0] = IN.T;
   objToTangentSpace[1] = cross( IN.T, normalize(IN.normal) ) * IN.tangentW;
   objToTangentSpace[2] = normalize(IN.normal);
   float3x3 worldToTangent = mul( objToTangentSpace, (float3x3)worldToObj );
   OUT.outWorldToTangent = worldToTangent;
   
   // Visibility
   
   // Translucent
   
   // DXTnm
   
   // Forward Shaded Material
   
   return OUT;
}
