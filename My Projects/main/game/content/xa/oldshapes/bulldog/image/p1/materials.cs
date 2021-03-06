// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

singleton Material(Bulldog_ScopeScreen_Base)
{
   mapTo = "Bulldog_ScopeScreen_Base";
   diffuseMap[0] = "content/xa/oldshapes/bulldog/image/p1/Bulldog_D.dds";
   specular[0] = "1 1 1 1";
   specularPower[0] = "10";
   translucentBlendOp = "None";
   glow[0] = "1";
   emissive[0] = "1";
   diffuseColor[0] = "1 0.0705882 0 1";
   animFlags[0] = "0x00000008";
   scrollDir[0] = "1 1";
   scrollSpeed[0] = "0.118";
   rotSpeed[0] = "0.588";
   waveFreq[0] = "8.281";
   waveAmp[0] = "1";
   materialTag0 = "Miscellaneous";
};

singleton Material(Bulldog_Base)
{
   mapTo = "Bulldog_Base";
   diffuseMap[0] = "content/xa/oldshapes/bulldog/image/p1/Bulldog_D.dds";
   normalMap[0] = "content/xa/oldshapes/bulldog/image/p1/Bulldog_N.dds";
   specularMap[0] = "content/xa/oldshapes/bulldog/image/p1/Bulldog_S.dds";
   specular[0] = "1 1 1 1";
   specularPower[0] = "1";
   translucentBlendOp = "None";
   useAnisotropic[0] = "0";
   diffuseColor[0] = "0.996078 0.992157 0.992157 1";
   diffuseColor[1] = "0.992157 0.992157 0.992157 0";
   glow[0] = "0";
   emissive[0] = "0";
   materialTag0 = "Miscellaneous";
   pixelSpecular[0] = "1";
};

singleton Material(Bulldog_MuzzleFlash_Base)
{
   mapTo = "Bulldog_MuzzleFlash_Base";
   diffuseMap[0] = "content/xa/oldshapes/bulldog/image/p1/Bulldog_MuzzleFlash.dds";
   specular[0] = "0.9 0.9 0.9 1";
   specularPower[0] = "1";
   translucentBlendOp = "Add";
   useAnisotropic[0] = "0";
   diffuseColor[0] = "0.15 0.15 0.15 1";
   diffuseColor[1] = "1 1 1 1";
   glow[0] = "1";
   emissive[0] = "1";
   doubleSided = "1";
   animFlags[0] = "0x00000005";
   scrollDir[0] = "-0.15 -0.15";
   rotSpeed[0] = "0.25";
   rotPivotOffset[0] = "-0.5 -0.5";
   waveFreq[0] = "5.313";
   waveAmp[0] = "0.016";
   castShadows = "0";
   translucent = "1";
};

singleton Material(Bulldog_MuzzleFlash_Base)
{
   mapTo = "Bulldog_MuzzleFlash_Base";
   diffuseMap[0] = "Bulldog_MuzzleFlash.dds";
   diffuseColor[0] = "0.15 0.15 0.15 1";
   specular[0] = "0.9 0.9 0.9 1";
   specularPower[0] = "10";
   translucent = "1";
   glow[0] = "1";
   emissive[0] = "1";
   doubleSided = "1";
   translucentBlendOp = "Add";
   animFlags[0] = "0x00000005";
   scrollDir[0] = "-0.15 -0.15";
   rotSpeed[0] = "0.25";
   rotPivotOffset[0] = "-0.5 -0.5";
   waveFreq[0] = "5.313";
   waveAmp[0] = "0.016";
   castShadows = "0";
};
