if(_root.camera.scene.swings > walkSwings)
{
   runSwings = _root.camera.scene.swings;
   gotoAndStop("walkstartSwordSwish");
   play();
}
else
{
   stop();
   _parent.charState = null;
   item._visible = true;
   _root.camera.scene.ResetSword();
}
