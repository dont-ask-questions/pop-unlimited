stop();
onEnterFrame = function()
{
   rad1 = Math.atan((_ymouse - pupil1._y) / (_xmouse - pupil1._x));
   degrees1 = 180 * rad1 / 3.141592653589793;
   if(_xmouse - pupil1._x >= 0)
   {
      rad1 += 3.141592653589793;
      degrees1 += 180;
   }
   pupil1._rotation = degrees1;
   rad2 = Math.atan((_ymouse - pupil2._y) / (_xmouse - pupil2._x));
   degrees2 = 180 * rad2 / 3.141592653589793;
   if(_xmouse - pupil2._x >= 0)
   {
      degrees2 += 180;
   }
   pupil2._rotation = degrees2;
   if(_parent._currentframe == 1 || _parent._currentframe == 2)
   {
      _parent.eyelids._y = pupil1._y - 10 * Math.sin(rad1) - 65;
      _parent._parent.eyelashes._y = pupil1._y - 10 * Math.sin(rad1) - 32;
      if(Math.sin(rad1) > 0)
      {
         _parent.eyelids._rotation = -4 * Math.sin(rad1);
      }
      else
      {
         _parent.eyelids._rotation = 0;
      }
   }
   else
   {
      _parent._parent.eyelashes._y = -32;
   }
};
