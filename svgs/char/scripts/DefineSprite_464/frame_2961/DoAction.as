if(_root.camera.scene.swings < 4)
{
   stop();
   item._visible = true;
   _root.camera.scene.ResetSword();
}
else
{
   head.mouth.gotoAndStop("angry");
}
