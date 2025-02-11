function setDress(dressClip, curDressRotation, curMinXscale, curMaxXscale, curMinYscale, curMaxYscale)
{
   if(this._visible)
   {
      dressRotation = curDressRotation;
      minXscale = curMinXscale;
      maxXscale = curMaxXscale;
      minYscale = curMinYscale;
      maxYscale = curMaxYscale;
      avatar.leg1._visible = false;
      avatar.leg2._visible = false;
      dressClip.onEnterFrame = dressMove;
   }
}
function dressMove()
{
   x1 = Math.abs(avatar.foot1._x - avatar.foot2._x) * 0.36;
   x2 = Math.abs(avatar.foot2._x - avatar.foot1._x) * 0.36;
   xAverage = Math.max(x1,x2);
   newXscale = xAverage / xAverageStart * 100;
   if(newXscale < maxXscale && newXscale > minXscale)
   {
      this._xscale = newXscale;
   }
   else if(newXscale >= maxXscale)
   {
      this._xscale = maxXscale;
   }
   else if(newXscale <= minXscale)
   {
      this._xscale = minXscale;
   }
   else
   {
      this._xscale = newXscale;
   }
   y1 = Math.abs(avatar.foot1._y - avatar.leg1._y) * 0.36;
   y2 = Math.abs(avatar.foot2._y - avatar.leg2._y) * 0.36;
   yAverage = Math.max(y1,y2);
   newYscale = yAverage / yAverageStart * 100;
   if(newYscale < maxYscale && newYscale > minYscale)
   {
      this._yscale = newYscale;
   }
   else if(newYscale >= maxYscale)
   {
      this._yscale = maxYscale;
   }
   else if(newYscale <= minYscale)
   {
      this._yscale = minYscale;
   }
   else
   {
      this._yscale = newYscale;
   }
   if(_parent._yscale > 100 && this._yscale > maxYscale - (_parent._yscale - 100))
   {
      this._yscale = maxYscale - (_parent._yscale - 100);
   }
   if(char.speed == 0)
   {
      this._rotation = 0;
   }
   else
   {
      this._rotation = - Math.abs(char.speed * dressRotation);
   }
}
stop();
avatar = _parent._parent;
char = _parent._parent._parent;
x1Start = Math.abs(avatar.foot1._x - avatar.foot2._x) * 0.36;
x2Start = Math.abs(avatar.foot2._x - avatar.foot1._x) * 0.36;
xAverageStart = Math.max(x1Start,x2Start);
y1Start = Math.abs(avatar.foot1._y - avatar.leg1._y) * 0.36;
y2Start = Math.abs(avatar.foot2._y - avatar.leg2._y) * 0.36;
yAverageStart = Math.max(y1Start,y2Start);
dressRotation = 0;
minXscale = 0;
maxXscale = 100;
minYscale = 0;
maxYscale = 0;
