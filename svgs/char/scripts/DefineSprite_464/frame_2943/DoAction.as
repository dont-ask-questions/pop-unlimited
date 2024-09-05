if(_root.camera.scene.keyDown == true)
{
   gotoAndStop("superSlash");
   play();
}
else if(_root.camera.scene.swings < 2)
{
   stop();
   _parent.charState = null;
   item._visible = true;
   _root.camera.scene.ResetSword();
}
else
{
   head.mouth.gotoAndStop("angry");
}
