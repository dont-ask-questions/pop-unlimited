class com.greensock.plugins.ShortRotationPlugin extends com.greensock.plugins.TweenPlugin
{
   var propName;
   var overwriteProps;
   static var API = 1;
   function ShortRotationPlugin()
   {
      super();
      this.propName = "shortRotation";
      this.overwriteProps = [];
   }
   function onInitTween(target, value, tween)
   {
      if(typeof value == "number")
      {
         return false;
      }
      for(var _loc4_ in value)
      {
         this.initRotation(target,_loc4_,target[_loc4_],typeof value[_loc4_] != "number" ? target[_loc4_] + Number(value[_loc4_]) : Number(value[_loc4_]));
      }
      return true;
   }
   function initRotation(target, propName, start, end)
   {
      var _loc2_ = (end - start) % 360;
      if(_loc2_ != _loc2_ % 180)
      {
         _loc2_ = _loc2_ >= 0 ? _loc2_ - 360 : _loc2_ + 360;
      }
      this.addTween(target,propName,start,start + _loc2_,propName);
      this.overwriteProps[this.overwriteProps.length] = propName;
   }
}
