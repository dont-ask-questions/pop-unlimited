stop();
this.onEnterFrame = function()
{
   if(this.hitTest(_parent.char.hit))
   {
      _parent.char.flying = true;
      _parent.char.avatar.packFrame = 7;
      _parent.char.avatar.setParts();
      delete this.onEnterFrame;
      nextFrame();
   }
};
