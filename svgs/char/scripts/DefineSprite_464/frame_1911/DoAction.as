item.onEnterFrame = function()
{
   this._rotation += (this.savedRotation - this._rotation) / 4;
   this._x = hand1._x;
   this._y = hand1._y;
};
