stop();
onEnterFrame = function()
{
   pupil1._rotation = pupil2._rotation = 0;
   if(_parent._currentframe == 1 || _parent._currentframe == 2)
   {
      _parent.eyelids._y = pupil1._y - 65;
      _parent._parent.eyelashes._y = pupil1._y - 32;
      _parent.eyelids._rotation = 0;
   }
   else
   {
      _parent._parent.eyelashes._y = -32;
   }
};
