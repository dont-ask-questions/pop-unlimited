head.mouth.gotoAndStop(15);
follow(item,hand1,-4,-4,1.5,0.35);
item.savedRotation = item._rotation;
item.savedEnterFrame = item.onEnterFrame;
item.speed = 0;
item.turn = 0;
item.accel = 2;
item.onEnterFrame = function()
{
   this._rotation += (50 - this._rotation) / 8;
   this._x = hand1._x;
   this._y = hand1._y;
};
