if(!item.active_obj.fire())
{
   item.savedEnterFrame = item.onEnterFrame;
   item.vy = -40;
   item.ay = 3;
   item.onEnterFrame = function()
   {
      this.vy += this.ay;
      this._y += this.vy;
      this._rotation += 10;
      if(this.vy > 0 && this._y >= hand1._y)
      {
         this.onEnterFrame = this.savedEnterFrame;
      }
   };
}
