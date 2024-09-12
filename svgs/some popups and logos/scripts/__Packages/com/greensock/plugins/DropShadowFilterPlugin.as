class com.greensock.plugins.DropShadowFilterPlugin extends com.greensock.plugins.FilterPlugin
{
   var propName;
   var overwriteProps;
   var _target;
   var _type;
   static var API = 1;
   static var _propNames = ["distance","angle","color","alpha","blurX","blurY","strength","quality","inner","knockout","hideObject"];
   function DropShadowFilterPlugin()
   {
      super();
      this.propName = "dropShadowFilter";
      this.overwriteProps = ["dropShadowFilter"];
   }
   function onInitTween(target, value, tween)
   {
      this._target = target;
      this._type = flash.filters.DropShadowFilter;
      this.initFilter(value,new flash.filters.DropShadowFilter(0,45,0,0,0,0,1,value.quality || 2,value.inner,value.knockout,value.hideObject),com.greensock.plugins.DropShadowFilterPlugin._propNames);
      return true;
   }
}
