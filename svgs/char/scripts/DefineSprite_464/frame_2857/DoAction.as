if(!item.savedEnterFrame)
{
   item.savedEnterFrame = item.onEnterFrame;
}
item.turnSpeed = -30;
item.onEnterFrame = function()
{
   this._rotation += this.turnSpeed;
   this.turnSpeed *= 0.7;
   this._x += (hand1._x + 20 - this._x) / 4;
   this._y += (hand1._y + 50 - this._y) / 4;
   if(!_parent.jumping)
   {
      this.onEnterFrame = this.savedEnterFrame;
   }
};
