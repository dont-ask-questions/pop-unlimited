function returnToGameHandler(pCounter)
{
   trace("GetAdCommand : return to game");
   popupClip2.removeMovieClip();
   unPauseGame(true);
}
function leaveGameHandler(pCounter)
{
   trace("leaveGameHandler : pCounter : " + pCounter);
   pauseGame(true);
   updateLatestGameplayBitmap();
}
logWWW("***gameplay frame 26");
trace("GetAdCommand : frame 26");
stop();
if(camera.scene.home)
{
   camera.scene.nextFrame();
}
if(camera.scene.vendorCartHolder)
{
   camera.scene.vendorCartHolder._visible = false;
}
if(camera.scene.char.avatar.FunBrain_so.data.enteringNewIsland)
{
   logWWW("LSOWarningManager : using gameplay startup path.");
   sendSceneVisit();
   if(!camera.scene.char.avatar.FunBrain_so.data.doingLogin)
   {
      camera.scene.char.avatar.FunBrain_so.data.enteringNewIsland = false;
   }
   else
   {
      camera.scene.char.avatar.FunBrain_so.data.doingLogin = false;
   }
   _popModel.startup_path = "gameplay";
}
sceneIsVisible = true;
camera.scene.init2();
if(island != "Home")
{
   if(camera.scene.useScalePan == true)
   {
      if(char._x < camera.scene.leftLimit)
      {
         char._x = camera.scene.leftLimit;
      }
      else if(char._x * camera.scene.scaleFactor > camera.scene.rightLimit)
      {
         char._x = camera.scene.rightLimit * camera.scene.scaleFactor;
      }
   }
   else if(char._x < camera.scene.leftLimit)
   {
      char._x = camera.scene.leftLimit;
   }
   else if(char._x > camera.scene.rightLimit)
   {
      char._x = camera.scene.rightLimit;
   }
}
var scenePhotoManager = com.poptropica.util.ScenePhotoManager.getInstance();
scenePhotoManager.loadScenePhotos(camera.scene.roomNo);
if(gotomap)
{
   logWWW("go to the map!");
   popup("travelmap.swf",false);
}
