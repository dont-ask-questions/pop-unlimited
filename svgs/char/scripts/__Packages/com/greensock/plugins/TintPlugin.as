class com.greensock.plugins.TintPlugin extends com.greensock.plugins.TweenPlugin
{
   var propName;
   var overwriteProps;
   var _ignoreAlpha;
   var _color;
   var _ct;
   var _tweens;
   static var API = 1;
   function TintPlugin()
   {
      super();
      this.propName = "tint";
      this.overwriteProps = ["tint"];
   }
   function onInitTween(target, value, tween)
   {
      if(typeof target != "movieclip" && !(target instanceof TextField))
      {
         return false;
      }
      var _loc2_ = tween.vars._alpha == undefined ? (tween.vars.autoAlpha == undefined ? target._alpha : tween.vars.autoAlpha) : tween.vars._alpha;
      var _loc4_ = Number(value);
      var _loc6_ = !(value == null || tween.vars.removeTint == true) ? {rb:_loc4_ >> 16,gb:_loc4_ >> 8 & 0xFF,bb:_loc4_ & 0xFF,ra:0,ga:0,ba:0,aa:_loc2_} : {rb:0,gb:0,bb:0,ab:0,ra:_loc2_,ga:_loc2_,ba:_loc2_,aa:_loc2_};
      this._ignoreAlpha = true;
      this.init(target,_loc6_);
      return true;
   }
   function init(target, end)
   {
      this._color = new Color(target);
      this._ct = this._color.getTransform();
      var _loc5_ = undefined;
      var _loc2_ = undefined;
      for(_loc2_ in end)
      {
         if(this._ct[_loc2_] != end[_loc2_])
         {
            this._tweens[this._tweens.length] = new com.greensock.core.PropTween(this._ct,_loc2_,this._ct[_loc2_],end[_loc2_] - this._ct[_loc2_],"tint",false);
         }
      }
   }
   function set changeFactor(n)
   {
      var _loc3_ = this._tweens.length;
      var _loc2_ = undefined;
      while(_loc3_--)
      {
         _loc2_ = this._tweens[_loc3_];
         _loc2_.target[_loc2_.property] = _loc2_.start + _loc2_.change * n;
      }
      if(this._ignoreAlpha)
      {
         var _loc5_ = this._color.getTransform();
         this._ct.aa = _loc5_.aa;
         this._ct.ab = _loc5_.ab;
      }
      this._color.setTransform(this._ct);
   }
}
