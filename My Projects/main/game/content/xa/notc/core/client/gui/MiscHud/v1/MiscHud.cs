// Copyright information can be found in the file named COPYING
// located in the root directory of this distribution.

package MiscHud
{
   function clientCmdGameStart(%seq)
   {
      Parent::clientCmdGameStart(%seq);
      HudGameTimer.visible = false;
   }
   
   function clientCmdGameTimer(%timeLeft)
   {
      HudGameTimer.setTimeLeft(%timeLeft);
   }
   
   function clientCmdSetFovDelta(%dt)
   {
      setFovDelta(%dt);
   }

   function clientCmdViewSetHud(%hud, %teamId)
   {
      %valid = false;
      if(%hud $= "LightHud")
         %valid = true;
      if(%hud $= "SoldierHud")
         %valid = true;

      if(!%valid)
         return;

      %hud.zTeamId = %teamId;
      $PlayGui = %hud;
      Canvas.setContent($PlayGui);
   }

   function clientCmdViewSetIris(%sizeX, %dtX, %sizeY, %dtY)
   {
      if(%sizeX !$= "")
         Iris.sizeX = %sizeX;
      if(%dtX !$= "")
         Iris.setDeltaX(%dtX);
      if(%sizeY !$= "")
         Iris.sizeY = %sizeY;
      if(%dtY !$= "")
         Iris.setDeltaY(%dtY);
   }
   
   function clientCmdLeftPrint(%text)
   {
      if(%text $= "")
         leftPrintText.setText("");
      else
         leftPrintText.setText(leftPrintText.getText() @ %text);
   }

   //---------------------------------------------------------------------------

   function refreshBottomTextCtrl()
   {
      BottomPrintText.position = "0 0";
   }

   function refreshCenterTextCtrl()
   {
      CenterPrintText.position = "0 0";
   }

   //---------------------------------------------------------------------------

   function HudGameTimer::setTimeLeft(%this, %timeLeft)
   {
      %this.zTimeLeft = %timeLeft;
      %this.updateThread();
      %this.visible = true;
   }

   function HudGameTimer::updateThread(%this)
   {
      if(%this.zUpdateThread !$= "")
      {
         cancel(%this.zUpdateThread);
         %this.zUpdateThread = "";
      }

      %this.text = mFloatLength(%this.zTimeLeft, 1);
      %this.zTimeLeft -= 0.1;

      if(%this.zTimeLeft < 0)
         %this.zTimeLeft = 0;
      else
         %this.zUpdateThread = %this.schedule(100, "updateThread");
   }

   //---------------------------------------------------------------------------

   function Iris::setDeltaX(%this, %dt)
   {
      %this.zSizeDeltaX = %dt;
      %this.animationThread();
   }

   function Iris::setDeltaY(%this, %dt)
   {
      %this.zSizeDeltaY = %dt;
      %this.animationThread();
   }

   function Iris::animationThread(%this)
   {
      if(%this.zAnimationThread !$= "")
      {
         cancel(%this.zAnimationThread);
         %this.zAnimationThread = "";
      }

      %this.sizeX += %this.zSizeDeltaX;
      %this.sizeY += %this.zSizeDeltaY;

      //$CAPostFx::cubeDistortionFactor = %this.size/10;
      %r = getWord($CAPostFx::colorDistortionFactor, 0);
      %g = getWord($CAPostFx::colorDistortionFactor, 1);
      %b = getWord($CAPostFx::colorDistortionFactor, 2);
      %r += %this.zSizeDelta/50;
      %g -= %this.zSizeDelta/50;
      %b += %this.zSizeDelta/100;
      //$CAPostFx::colorDistortionFactor = %r SPC %g SPC %b;

      if(%this.size <= 0)
         %this.size = 0;
      //else if(%this.size >= 1)
      //   %this.size = 1;
      else
         %this.zAnimationThread = %this.schedule(32, "animationThread");
   }

   //---------------------------------------------------------------------------

   function setFovDelta(%dt)
   {
      $fovDelta = %dt;
      fovDeltaThread();
   }

   function fovDeltaThread(%this)
   {
      if($fovDeltaThread !$= "")
      {
         cancel($fovDeltaThread);
         $fovDeltaThread = "";
      }

      if($fovDelta == 0)
         return;

      %newFov = ServerConnection.getControlCameraFov() + $fovDelta;
      setFov(%newFov);

      if(%newFov < 1 || %newFov > 179)
         return;

      $fovDeltaThread = schedule(32, ServerConnection, "fovDeltaThread");
   }
   
   //---------------------------------------------------------------------------
};

activatePackage(MiscHud);


