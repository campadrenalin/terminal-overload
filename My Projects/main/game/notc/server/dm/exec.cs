// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

function executeDeathmatchServerScripts()
{
   exec("notc/server/base/exec.cs");
   
   exec("notc/server/forms/standardcat/exec.cs");
   
   exec("notc/server/items/ballast/exec.cs");
   exec("notc/server/items/etherboard/exec.cs");

   exec("notc/server/weapons/smg1/v1/exec.cs");
   exec("notc/server/weapons/mgl1/v1/exec.cs");
   exec("notc/server/weapons/sg1/v1/exec.cs");
   exec("notc/server/weapons/sr1/v1/exec.cs");
   exec("notc/server/weapons/mg1/v1/exec.cs");
   exec("notc/server/weapons/ml1/v1/exec.cs");

   exec("./dm.cs");
   exec("./gameCoreDM.cs");
   exec("./health.cs");
}

executeDeathmatchServerScripts();

