head.mouth.gotoAndStop(15);
follow(item,hand1,-4,-4,1.5,0.35);
item.savedEnterFrame = item.onEnterFrame;
item.speed = 0;
item.turn = 0;
item.accel = 2;
item.onEnterFrame = function()
{
   this.speed += this.accel;
   this.turn += this.speed;
   this._rotation = this.turn;
   this._x = hand1._x;
   this._y = hand1._y;
   if(this.turn > 305)
   {
      this.accel = 0;
      this.speed *= 0.72;
      if(this.speed < 0.15)
      {
         this.onEnterFrame = this.savedEnterFrame;
      }
   }
};
