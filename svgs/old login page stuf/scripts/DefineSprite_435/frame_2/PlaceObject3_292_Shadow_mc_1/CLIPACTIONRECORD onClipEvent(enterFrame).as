onClipEvent(enterFrame){
   DistanceFromShadow = _parent.GlassBallBoyClip._y + 220;
   if(DistanceFromShadow < 27)
   {
      DistanceFromShadow = 27;
   }
   _xscale = DistanceFromShadow + 50;
   _yscale = DistanceFromShadow + 50;
}
