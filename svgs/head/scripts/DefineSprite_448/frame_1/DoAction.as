onEnterFrame = function()
{
   rad = Math.atan((_parent._ymouse - this._y) / (_parent._xmouse - this._x));
   degrees = 180 * rad / 3.141592653589793;
   if(_parent._xmouse - this._x >= 0)
   {
      rad += 3.141592653589793;
      degrees += 180;
   }
   this._rotation = degrees;
};
