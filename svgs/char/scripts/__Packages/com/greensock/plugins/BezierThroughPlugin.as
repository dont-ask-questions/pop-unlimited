class com.greensock.plugins.BezierThroughPlugin extends com.greensock.plugins.BezierPlugin
{
   var propName;
   static var API = 1;
   function BezierThroughPlugin()
   {
      super();
      this.propName = "bezierThrough";
   }
   function onInitTween(target, value, tween)
   {
      if(!(value instanceof Array))
      {
         return false;
      }
      this.init(tween,[value][0],true);
      return true;
   }
}
