class com.greensock.plugins.RoundPropsPlugin extends com.greensock.plugins.TweenPlugin
{
   var propName;
   var overwriteProps;
   var round;
   static var API = 1;
   function RoundPropsPlugin()
   {
      super();
      this.propName = "roundProps";
      this.overwriteProps = [];
      this.round = true;
   }
   function add(object, propName, start, change)
   {
      this.addTween(object,propName,start,start + change,propName);
      this.overwriteProps[this.overwriteProps.length] = propName;
   }
}
