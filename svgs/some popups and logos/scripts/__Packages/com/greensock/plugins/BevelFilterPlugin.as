class com.greensock.plugins.BevelFilterPlugin extends com.greensock.plugins.FilterPlugin
{
   var propName;
   var overwriteProps;
   var _target;
   var _type;
   static var API = 1;
   static var _propNames = ["distance","angle","highlightColor","highlightAlpha","shadowColor","shadowAlpha","blurX","blurY","strength","quality"];
   function BevelFilterPlugin()
   {
      super();
      this.propName = "bevelFilter";
      this.overwriteProps = ["bevelFilter"];
   }
   function onInitTween(target, value, tween)
   {
      this._target = target;
      this._type = flash.filters.BevelFilter;
      this.initFilter(value,new flash.filters.BevelFilter(0,0,16777215,0.5,0,0.5,2,2,0,value.quality || 2),com.greensock.plugins.BevelFilterPlugin._propNames);
      return true;
   }
}
