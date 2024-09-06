this.onRelease = function()
{
   _parent.useTargetControl = true;
   _parent.char.clickTarget(this._x,this._y);
   this.onEnterFrame = function()
   {
      _parent.char.clickTarget(this._x,this._y);
      if(Math.abs(_parent.char._x - this._x) < 200)
      {
         _parent.char.maxSpeed += (_parent.char.walkMaxSpeed - _parent.char.maxSpeed) / 4;
      }
      else
      {
         _parent.char.maxSpeed = _parent.char.runMaxSpeed;
      }
      if(Math.abs(this._x - _parent.char._x) < 40 && Math.abs(this._y - _parent.char._y) < 40 && _parent.char.speed == 0 && _parent.char.vSpeed == 0)
      {
         _root.popup("travelmap.swf",false);
         delete this.onEnterFrame;
         _parent.googleMap();
      }
      if(_parent.useTargetControl == false || _parent.char.targetX != this._x || _parent.char.targetY != this._y)
      {
         delete this.onEnterFrame;
      }
   };
};
this.onRollOver = function()
{
   if(angle == 360)
   {
      _root.pointer.gotoAndStop("exit3D");
   }
   else
   {
      _root.pointer.gotoAndStop("exit");
      _root.pointer.exit._rotation = angle;
      _root.pointer.exit._xscale = scale;
   }
   _root.pointer.labelFld.text = labelText;
};
