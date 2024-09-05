class com.greensock.plugins.ColorTransformPlugin extends com.greensock.plugins.TintPlugin
{
   var propName;
   static var API = 1;
   function ColorTransformPlugin()
   {
      super();
      this.propName = "colorTransform";
   }
   function onInitTween(target, value, tween)
   {
      if(typeof target != "movieclip" && !(target instanceof TextField))
      {
         return false;
      }
      var _loc7_ = new Color(target);
      var _loc2_ = _loc7_.getTransform();
      if(value.redMultiplier != undefined)
      {
         _loc2_.ra = value.redMultiplier * 100;
      }
      if(value.greenMultiplier != undefined)
      {
         _loc2_.ga = value.greenMultiplier * 100;
      }
      if(value.blueMultiplier != undefined)
      {
         _loc2_.ba = value.blueMultiplier * 100;
      }
      if(value.alphaMultiplier != undefined)
      {
         _loc2_.aa = value.alphaMultiplier * 100;
      }
      if(value.redOffset != undefined)
      {
         _loc2_.rb = value.redOffset;
      }
      if(value.greenOffset != undefined)
      {
         _loc2_.gb = value.greenOffset;
      }
      if(value.blueOffset != undefined)
      {
         _loc2_.bb = value.blueOffset;
      }
      if(value.alphaOffset != undefined)
      {
         _loc2_.ab = value.alphaOffset;
      }
      if(!isNaN(value.tint) || !isNaN(value.color))
      {
         var _loc4_ = !!isNaN(value.tint) ? value.color : value.tint;
         if(_loc4_ != null)
         {
            _loc2_.rb = Number(_loc4_) >> 16;
            _loc2_.gb = Number(_loc4_) >> 8 & 0xFF;
            _loc2_.bb = Number(_loc4_) & 0xFF;
            _loc2_.ra = 0;
            _loc2_.ga = 0;
            _loc2_.ba = 0;
         }
      }
      if(!isNaN(value.tintAmount))
      {
         var _loc5_ = value.tintAmount / (1 - (_loc2_.ra + _loc2_.ga + _loc2_.ba) / 300);
         _loc2_.rb *= _loc5_;
         _loc2_.gb *= _loc5_;
         _loc2_.bb *= _loc5_;
         _loc2_.ra = _loc2_.ga = _loc2_.ba = (1 - value.tintAmount) * 100;
      }
      else if(!isNaN(value.exposure))
      {
         _loc2_.rb = _loc2_.gb = _loc2_.bb = 255 * (value.exposure - 1);
         _loc2_.ra = _loc2_.ga = _loc2_.ba = 100;
      }
      else if(!isNaN(value.brightness))
      {
         _loc2_.rb = _loc2_.gb = _loc2_.bb = Math.max(0,(value.brightness - 1) * 255);
         _loc2_.ra = _loc2_.ga = _loc2_.ba = (1 - Math.abs(value.brightness - 1)) * 100;
      }
      if(tween.vars._alpha != undefined && value.alphaMultiplier == undefined)
      {
         _loc2_.aa = tween.vars._alpha;
         tween.killVars({alpha:1});
      }
      this.init(target,_loc2_);
      return true;
   }
}
