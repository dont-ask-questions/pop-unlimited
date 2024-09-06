stop();
logWWW("***gameplay frame 2");
if(camera.scene.ad || camera.scene.home)
{
   navBar._visible = false;
}
navBar.wardrobeDim._visible = false;
camera.scene.pausedGame = false;
SceneName = camera.scene.roomName;
