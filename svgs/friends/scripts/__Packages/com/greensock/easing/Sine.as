class com.greensock.easing.Sine
{
   static var _HALF_PI = 1.5707963267948966;
   function Sine()
   {
   }
   static function easeIn(t, b, c, d)
   {
      return (- c) * Math.cos(t / d * com.greensock.easing.Sine._HALF_PI) + c + b;
   }
   static function easeOut(t, b, c, d)
   {
      return c * Math.sin(t / d * com.greensock.easing.Sine._HALF_PI) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      return (- c) * 0.5 * (Math.cos(3.141592653589793 * t / d) - 1) + b;
   }
}
