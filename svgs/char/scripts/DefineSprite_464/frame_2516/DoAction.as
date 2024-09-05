head.mouth.gotoAndStop(15);
follow(item,hand1,-4,-4,1.5,0.35);
item.savedEnterFrame = item.onEnterFrame;
item.speed = -22;
item.turn = 0;
item.accel = 0;
item.onEnterFrame = function()
{
   this.speed += this.accel;
   if(this.speed > 50)
   {
      this.speed = 50;
   }
   this.turn += this.speed;
   this._rotation = this.turn;
   this._x = hand1._x;
   this._y = hand1._y;
   if(Math.abs(this.turn) > 2000)
   {
      this.onEnterFrame = this.savedEnterFrame;
   }
};
