if(_root.camera.scene.swings < 1)
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
