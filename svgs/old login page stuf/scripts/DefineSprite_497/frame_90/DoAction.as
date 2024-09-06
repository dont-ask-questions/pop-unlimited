var i = 0;
while(i < totalBalls)
{
   this["gbc_mc" + i].removeMovieClip();
   i++;
}
var i = 0;
while(i < totalBalls)
{
   this["shdw_mc" + i].removeMovieClip();
   i++;
}
blimp.onEnterFrame = function()
{
   this.velX = (390 - this._x) / 12;
   this.velY = (260 - this._y) / 12;
   if(this.velX > 4)
   {
      this.velX = 4;
   }
   if(this.velY > 3)
   {
      this.velY = 3;
   }
   this._x += this.velX;
   this._y += this.velY;
   blimpClick._x = this._x;
   blimpClick._y = this._y;
   blimpHit._x = this._x;
   blimpHit._y = this._y;
   if(Math.abs(this.delY) < 0.1 && Math.abs(this.delY) < 0.1)
   {
      delete this.onEnterFrame;
   }
};
