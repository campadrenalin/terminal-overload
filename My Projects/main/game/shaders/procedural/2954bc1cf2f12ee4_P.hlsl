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
// Base Texture
// Specular Map
// Bumpmap [Deferred]
// Deferred RT Lighting
// Pixel Specular [Deferred]
// Visibility
// HDR Output
// DXTnm
// Hardware Instancing

struct ConnectData
{
   float2 texCoord        : TEXCOORD0;
   float4 screenspacePos  : TEXCOORD1;
   float visibility      : TEXCOORD2;
   float2 vpos            : VPOS;
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
              uniform sampler2D specularMap     : register(S1),
              uniform float4    rtParams2       : register(C1),
              uniform sampler2D lightInfoBuffer : register(S2),
              uniform float     specularPower   : register(C0)
)
{
   Fragout OUT;

   // Vert Position
   
   // Base Texture
   OUT.col = tex2D(diffuseMap, IN.texCoord);
   
   // Specular Map
   float4 specularColor = tex2D(specularMap, IN.texCoord);
   
   // Bumpmap [Deferred]
   
   // Deferred RT Lighting
   float2 uvScene = IN.screenspacePos.xy / IN.screenspacePos.w;
   uvScene = ( uvScene + 1.0 ) / 2.0;
   uvScene.y = 1.0 - uvScene.y;
   uvScene = ( uvScene * rtParams2.zw ) + rtParams2.xy;
   float3 d_lightcolor;
   float d_NL_Att;
   float d_specular;
   lightinfoUncondition(tex2D(lightInfoBuffer, uvScene), d_lightcolor, d_NL_Att, d_specular);
   OUT.col *= float4(d_lightcolor, 1.0);
   
   // Pixel Specular [Deferred]
   float specular = pow( d_specular, ceil(specularPower / AL_ConstantSpecularPower)) * d_NL_Att;
   OUT.col += float4( specularColor.rgb, 0 ) * specular;
   
   // Visibility
   fizzle( IN.vpos, IN.visibility );
   
   // HDR Output
   OUT.col = hdrEncode( OUT.col );
   
   // DXTnm
   
   // Hardware Instancing
   

   return OUT;
}
