var flags = 0;
onEnterFrame = function()
{
   if(!undershirt._visible && (flags & 1) === 0)
   {
      flags++;
      undershirt._alpha = 0;
   }
   if(!underpants._visible && !(flags & 2) === 0)
   {
      flags += 2;
      underpants._alpha = 0;
   }
   if(flags === 3)
   {
      delete this.flags;
      delete this.onEnterFrame;
   }
};
