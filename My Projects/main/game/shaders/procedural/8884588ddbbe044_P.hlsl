//*****************************************************************************
// Torque -- HLSL procedural shader
//*****************************************************************************

// Dependencies:
#include "shaders/common/torque.hlsl"

// Features:
// Vert Position
// Texture Animation
// Diffuse Color
// Visibility
// Translucent
// Forward Shaded Material

struct ConnectData
{
};


struct Fragout
{
   float4 col : COLOR0;
};


//-----------------------------------------------------------------------------
// Main
//-----------------------------------------------------------------------------
Fragout main( ConnectData IN,
              uniform float4    diffuseMaterialColor : register(C0),
              uniform float     visibility      : register(C1)
)
{
   Fragout OUT;

   // Vert Position
   
   // Texture Animation
   
   // Diffuse Color
   OUT.col = diffuseMaterialColor;
   
   // Visibility
   OUT.col.a *= visibility;
   
   // Translucent
   
   // Forward Shaded Material
   

   return OUT;
}
