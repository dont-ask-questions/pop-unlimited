class com.greensock.easing.Strong
{
   function Strong()
   {
   }
   static function easeIn(t, b, c, d)
   {
      return c * (t /= d) * t * t * t * t + b;
   }
   static function easeOut(t, b, c, d)
   {
      return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      if((t /= d * 0.5) < 1)
      {
         return c * 0.5 * t * t * t * t * t + b;
      }
      return c * 0.5 * ((t -= 2) * t * t * t * t + 2) + b;
   }
}
