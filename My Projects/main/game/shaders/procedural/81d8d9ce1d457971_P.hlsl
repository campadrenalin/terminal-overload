//*****************************************************************************
// Torque -- HLSL procedural shader
//*****************************************************************************

// Dependencies:
//------------------------------------------------------------------------------
// Autogenerated 'Light Buffer Conditioner [RGB]' Uncondition Method
//------------------------------------------------------------------------------
inline void autogenUncondition_bde4cbab(in float4 bufferSample, out float3 lightColor, out float NL_att, out float specular)
{
   lightColor = bufferSample.rgb;
   NL_att = dot(bufferSample.rgb, float3(0.3576, 0.7152, 0.1192));
   specular = max(bufferSample.a / NL_att, 0.00001f);
}


#include "shaders/common/lighting.hlsl"
#include "shaders/common/torque.hlsl"

// Features:
// Vert Position
// Texture Animation
// Base Texture
// Detail
// Diffuse Color
// Specular Map
// Bumpmap [Deferred]
// Deferred RT Lighting
// Pixel Specular [Deferred]
// Visibility
// Fog
// HDR Output
// Translucent
// DXTnm
// Forward Shaded Material

struct ConnectData
{
   float2 texCoord        : TEXCOORD0;
   float2 detCoord        : TEXCOORD1;
   float3x3 worldToTangent  : TEXCOORD2;
   float3 wsPosition      : TEXCOORD5;
};


struct Fragout
{
   float4 col : COLOR0;
};


//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------
Fragout main( ConnectData IN,
              uniform sampler2D diffuseMap      : register(S0),
              uniform sampler2D detailMap       : register(S1),
              uniform float4    diffuseMaterialColor : register(C0),
              uniform sampler2D specularMap     : register(S2),
              uniform sampler2D bumpMap         : register(S3),
              uniform float3    eyePosWorld     : register(C16),
              uniform float4    inLightPos[3] : register(C1),
              uniform float4    inLightInvRadiusSq : register(C4),
              uniform float4    inLightColor[4] : register(C5),
              uniform float4    inLightSpotDir[3] : register(C9),
              uniform float4    inLightSpotAngle : register(C12),
              uniform float4    inLightSpotFalloff : register(C13),
              uniform float     specularPower   : register(C14),
              uniform float4    ambient         : register(C17),
              uniform float     visibility      : register(C15),
              uniform float4    fogColor        : register(C18),
              uniform float3    fogData         : register(C19)
)
{
   Fragout OUT;

   // Vert Position
   
   // Texture Animation
   
   // Base Texture
   OUT.col = tex2D(diffuseMap, IN.texCoord);
   
   // Detail
   OUT.col += ( tex2D(detailMap, IN.detCoord) * 2.0 ) - 1.0;
   
   // Diffuse Color
   OUT.col *= diffuseMaterialColor;
   
   // Specular Map
   float4 specularColor = tex2D(specularMap, IN.texCoord);
   
   // Bumpmap [Deferred]
   float4 bumpNormal = float4( tex2D(bumpMap, IN.texCoord).ag * 2.0 - 1.0, 0.0, 0.0 ); // DXTnm
   bumpNormal.z = sqrt( 1.0 - dot( bumpNormal.xy, bumpNormal.xy ) ); // DXTnm
   float3 wsNormal = normalize( mul( bumpNormal.xyz, IN.worldToTangent ) );
   
   // Deferred RT Lighting
   float3 wsView = normalize( eyePosWorld - IN.wsPosition );
   float4 rtShading; float4 specular;
   compute4Lights( wsView, IN.wsPosition, wsNormal, float4( 1, 1, 1, 1 ),
      inLightPos, inLightInvRadiusSq, inLightColor, inLightSpotDir, inLightSpotAngle, inLightSpotFalloff, specularPower, specularColor,
      rtShading, specular );
   OUT.col *= float4( rtShading.rgb + ambient.rgb, 1 );
   
   // Pixel Specular [Deferred]
   OUT.col.rgb += ( specular * specularColor ).rgb;
   
   // Visibility
   OUT.col.a *= visibility;
   
   // Fog
   float fogAmount = saturate( computeSceneFog( eyePosWorld, IN.wsPosition, fogData.r, fogData.g, fogData.b ) );
   OUT.col.rgb = lerp( fogColor.rgb, OUT.col.rgb, fogAmount );
   
   // HDR Output
   OUT.col = hdrEncode( OUT.col );
   
   // Translucent
   
   // DXTnm
   
   // Forward Shaded Material
   

   return OUT;
}
