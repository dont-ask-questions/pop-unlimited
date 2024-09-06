class com.greensock.plugins.GlowFilterPlugin extends com.greensock.plugins.FilterPlugin
{
   var propName;
   var overwriteProps;
   var _target;
   var _type;
   static var API = 1;
   static var _propNames = ["color","alpha","blurX","blurY","strength","quality","inner","knockout"];
   function GlowFilterPlugin()
   {
      super();
      this.propName = "glowFilter";
      this.overwriteProps = ["glowFilter"];
   }
   function onInitTween(target, value, tween)
   {
      this._target = target;
      this._type = flash.filters.GlowFilter;
      this.initFilter(value,new flash.filters.GlowFilter(16777215,0,0,0,value.strength || 1,value.quality || 2,value.inner,value.knockout),com.greensock.plugins.GlowFilterPlugin._propNames);
      return true;
   }
}
