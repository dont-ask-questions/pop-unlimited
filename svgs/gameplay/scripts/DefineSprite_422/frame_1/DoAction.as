wardrobeSelect._visible = false;
grappleHit._visible = false;
grappleHit.onRollOver = function()
{
   _parent.pointer.gotoAndStop("target");
};
grappleHit.onPress = function()
{
   this._visible = false;
   _parent.camera.scene.char.grappleShoot();
};
photoNotification._visible = false;
