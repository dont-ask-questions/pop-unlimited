if(_root.camera.scene.swings > runSwings)
{
   runSwings = _root.camera.scene.swings;
   gotoAndStop("runstartSwordSwish");
   play();
}
else
{
   stop();
   _parent.charState = null;
   item._visible = true;
   _root.camera.scene.ResetSword();
}
