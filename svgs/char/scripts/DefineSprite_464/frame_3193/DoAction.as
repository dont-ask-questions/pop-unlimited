resetFace();
head.eyes.gotoAndStop("squint");
head.eyes.pupils.gotoAndStop(1);
createEmptyMovieClip("headRotater",getNextHighestDepth());
headRotater.onEnterFrame = function()
{
   if(headRotationClip)
   {
      head._rotation = hair._rotation += (-30 - head._rotation) / 4;
   }
   else
   {
      head._rotation = hair._rotation = 0;
      this.removeMovieClip();
   }
};
