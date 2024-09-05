steam.onEnterFrame = function()
{
   if(head.headSkin.red._alpha > 0)
   {
      head.headSkin.red._alpha -= 8;
      head.eyes.eyelids.red._alpha -= 8;
   }
};
