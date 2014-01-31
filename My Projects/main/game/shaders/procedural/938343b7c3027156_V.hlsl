//*****************************************************************************
// Torque -- HLSL procedural shader
//*****************************************************************************

// Dependencies:
#include "shaders/common/torque.hlsl"

// Features:
// Vert Position
// Texture Animation
// Base Texture
// Detail
// Bumpmap [Deferred]
// Visibility
// Fog
// HDR Output
// Translucent
// Hardware Instancing
// DXTnm
// Forward Shaded Material

struct VertData
{
   float3 position        : POSITION;
   float tangentW        : TEXCOORD3;
   float3 normal          : NORMAL;
   float3 T               : TANGENT;
   float4 texCoord        : TEXCOORD0;
   float4 inst_objectTrans[4] : TEXCOORD4;
   float inst_visibility : TEXCOORD8;
};


struct ConnectData
{
   float4 hpos            : POSITION;
   float2 out_texCoord    : TEXCOORD0;
   float2 detCoord        : TEXCOORD1;
   float3x3 outWorldToTangent : TEXCOORD2;
   float visibility      : TEXCOORD5;
   float3 outWsPosition   : TEXCOORD6;
};


//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------
ConnectData main( VertData IN,
                  uniform float4x4 viewProj        : register(C1),
                  uniform float4x4 texMat          : register(C5),
                  uniform float2   detailScale     : register(C0)
)
{
   ConnectData OUT;

   // Vert Position
   float4x4 objTrans = { // Instancing!
      IN.inst_objectTrans[0],
      IN.inst_objectTrans[1],
      IN.inst_objectTrans[2],
      IN.inst_objectTrans[3] };
   float4x4 modelview = mul( viewProj, objTrans ); // Instancing!
   OUT.hpos = mul(modelview, float4(IN.position.xyz,1));
   
   // Texture Animation
   
   // Base Texture
   OUT.out_texCoord = (float2)mul(texMat, IN.texCoord);
   
   // Detail
   OUT.detCoord = mul(texMat, IN.texCoord) * detailScale;
   
   // Bumpmap [Deferred]
   float3x3 objToTangentSpace;
   objToTangentSpace[0] = IN.T;
   objToTangentSpace[1] = cross( IN.T, normalize(IN.normal) ) * IN.tangentW;
   objToTangentSpace[2] = normalize(IN.normal);
   float3x3 worldToObj = transpose( (float3x3)objTrans ); // Instancing!
   float3x3 worldToTangent = mul( objToTangentSpace, (float3x3)worldToObj );
   OUT.outWorldToTangent = worldToTangent;
   
   // Visibility
   OUT.visibility = IN.inst_visibility; // Instancing!
   
   // Fog
   OUT.outWsPosition = mul( objTrans, float4( IN.position.xyz, 1 ) ).xyz;
   
   // HDR Output
   
   // Translucent
   
   // Hardware Instancing
   
   // DXTnm
   
   // Forward Shaded Material
   
   return OUT;
}
