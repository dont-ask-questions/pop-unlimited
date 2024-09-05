head.eyes.gotoAndStop("open");
if(itemFrame == "ninjaStaff")
{
   if(!item.savedEnterFrame)
   {
      item.savedEnterFrame = item.onEnterFrame;
   }
   _parent.ninjaBlocking = true;
   item.onEnterFrame = function()
   {
      this._rotation += 32;
      this._x = hand1._x;
      this._y = hand1._y;
      if(_parent.charState != "action")
      {
         _parent.ninjaBlocking = false;
         this.onEnterFrame = this.savedEnterFrame;
      }
   };
}
