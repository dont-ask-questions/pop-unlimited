function resetMoveReady()
{
   gMultiplayerRoomMoveReady = true;
}
logWWW("***gameplay frame 9");
play();
var gCharList = new Array();
for(var p in camera.scene)
{
   if(camera.scene[p].isPlayer || camera.scene[p].isObject)
   {
      camera.scene[p].nextFrame();
      if(camera.scene[p].isPlayer)
      {
         _root.gCharList.push(camera.scene[p]);
      }
   }
}
clearInterval(errorTimer);
if(!camera.scene.ad && !camera.scene.home)
{
   saveSceneVisit();
}
var gMultiplayerRoomMoveReady = true;
var MOVE_TIMEOUT = 330;
camera.scene.bg.onPress = function()
{
   turnOffWardrobe();
   if(camera.scene.common)
   {
      pointer.gotoAndStop("target");
   }
   else
   {
      pointer.gotoAndStop("directional");
   }
   if(camera.scene.common)
   {
      if(true)
      {
         if(false)
         {
            camera.scene.cancelExit = true;
            if(server)
            {
               server.call("moveTo",null,Math.round(camera.scene._xmouse),Math.round(camera.scene._ymouse));
               server.call("changeStatus",null,"none");
            }
         }
         else
         {
            camera.scene.char.clickTarget(camera.scene._xmouse,camera.scene._ymouse);
         }
      }
   }
   else
   {
      camera.scene.useTargetControl = false;
   }
   pointer.directional._alpha = 100;
   pointer.target._alpha = 100;
   camera.scene.char.mouseFollow = true;
   camera.scene.char.targetPlayer.engaged = false;
   camera.scene.char.targetPlayer.targeted = false;
   hideMenu();
   hideChat();
   hideSay(camera.scene.char);
};
camera.scene.bg.onRollOver = function()
{
   if(useWardrobe)
   {
      pointer.gotoAndStop("arrow");
   }
   else if(camera.scene.common)
   {
      pointer.gotoAndStop("target");
   }
   else
   {
      pointer.gotoAndStop("directional");
   }
};
onMouseDown = function()
{
   Mouse.hide();
};
onMouseUp = function()
{
   pointer.directional._alpha = 50;
   pointer.target._alpha = 50;
   camera.scene.char.mouseFollow = false;
};
if(desc != "Home")
{
   trackEvent("Loaded");
}
