// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

singleton Material(DECAL_WpnRaptorProjectile)
{

   vertColor[0] = true;
   translucent = true;
   translucentBlendOp = "LerpAlpha";
   translucentZWrite = "0";
   mapTo = "rBlast";
   diffuseColor[0] = "0 1 0.929412 1";
   diffuseMap[0] = "content/xa/torque3d/3.0/decals/rBlast.png";
   glow[0] = "0";
   emissive[0] = "0";
   castShadows = "0";
   materialTag0 = "Miscellaneous";
   animFlags[0] = "0x00000000";
   scrollDir[0] = "1 1";
   scrollSpeed[0] = "0";
   showFootprints = "0";
};

singleton Material(xa_notc_core_mis_notc_dm1_skybox)
{
   mapTo = "unmapped_mat";
   materialTag0 = "Skies";
   cubemap = "xa_notc_core_skies_skybox1";
};

new CubemapData(xxx2)
{
   cubeFace[0] = "content/tmp/night-skyboxes/night-skyboxes/PondNight/2.jpg";
   cubeFace[1] = "content/tmp/night-skyboxes/night-skyboxes/PondNight/1.jpg";
   cubeFace[2] = "content/tmp/night-skyboxes/night-skyboxes/PondNight/3.jpg";
   cubeFace[3] = "content/tmp/night-skyboxes/night-skyboxes/PondNight/posx.jpg";
   cubeFace[4] = "content/tmp/night-skyboxes/night-skyboxes/PondNight/6.jpg";
   cubeFace[5] = "content/tmp/night-skyboxes/night-skyboxes/PondNight/7.jpg";
};

new CubemapData(xa_notc_core_skies_skybox1)
{
   cubeFace[0] = "content/xa/notc/core/skies/skybox1/right.png";
   cubeFace[1] = "content/xa/notc/core/skies/skybox1/left.png";
   cubeFace[2] = "content/xa/notc/core/skies/skybox1/back.png";
   cubeFace[3] = "content/xa/notc/core/skies/skybox1/front.png";
   cubeFace[4] = "content/xa/notc/core/skies/skybox1/top.png";
   cubeFace[5] = "content/xa/notc/core/skies/skybox1/top.png";
};

