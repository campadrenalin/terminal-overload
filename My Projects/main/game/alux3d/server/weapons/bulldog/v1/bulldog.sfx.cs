// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

datablock SFXProfile(WpnBulldogFireSound)
{
   filename = "content/xa/cat5/p.1/sounds/cat5/gunshot2";
   description = AudioClose3D;
   preload = true;
};

datablock SFXProfile(WpnBulldogPumpSound)
{
	filename = "content/xa/cat5/p.1/sounds/cat5/pumpgun1.wav";
   description = AudioClose3D;
   preload = true;
};

datablock SFXProfile(WpnBulldogDryFireSound)
{
   filename = "content/xa/rotc/p.5.4/sounds/rotc/weaponEmpty";
   description = AudioClose3D;
   preload = true;
};

datablock SFXProfile(WpnBulldogReloadSound)
{
   filename = "content/xa/torque3d/3.0/sound/weapons/wpn_lurker_reload";
   description = AudioClose3D;
   preload = true;
};

datablock SFXProfile(WpnBulldogIdleSound)
{
   filename = "content/xa/torque3d/3.0/sound/weapons/wpn_lurker_idle";
   description = AudioClose3D;
   preload = true;
};

datablock SFXProfile(WpnBulldogSwitchinSound)
{
   filename = "content/xa/torque3d/3.0/sound/weapons/wpn_lurker_switchin";
   description = AudioClose3D;
   preload = true;
};

datablock SFXProfile(WpnBulldogGrenadeFireSound)
{
   filename = "content/xa/torque3d/3.0/sound/weapons/wpn_lurker_grenadelaunch";
   description = AudioClose3D;
   preload = true;
};

datablock SFXPlayList(WpnBulldogFireSoundList)
{
   // Use a looped description so the list playback will loop.
   description = AudioClose3D;

   track[ 0 ] = WpnBulldogFireSound;
};


