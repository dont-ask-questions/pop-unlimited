class com.greensock.plugins.EndArrayPlugin extends com.greensock.plugins.TweenPlugin
{
   var propName;
   var overwriteProps;
   var _info;
   var _a;
   var round;
   static var API = 1;
   function EndArrayPlugin()
   {
      super();
      this.propName = "endArray";
      this.overwriteProps = ["endArray"];
      this._info = [];
   }
   function onInitTween(target, value, tween)
   {
      if(!(target instanceof Array) || !(value instanceof Array))
      {
         return false;
      }
      this.init([target][0],[value][0]);
      return true;
   }
   function init(start, end)
   {
      this._a = start;
      var _loc2_ = end.length;
      while(_loc2_--)
      {
         if(start[_loc2_] != end[_loc2_] && start[_loc2_] != undefined)
         {
            this._info[this._info.length] = new com.greensock.plugins.helpers.ArrayTweenInfo(_loc2_,this._a[_loc2_],end[_loc2_] - this._a[_loc2_]);
         }
      }
   }
   function set changeFactor(n)
   {
      var _loc3_ = this._info.length;
      var _loc2_ = undefined;
      if(this.round)
      {
         while(_loc3_--)
         {
            _loc2_ = this._info[_loc3_];
            this._a[_loc2_.index] = Math.round(_loc2_.start + _loc2_.change * n);
         }
      }
      else
      {
         while(_loc3_--)
         {
            _loc2_ = this._info[_loc3_];
            this._a[_loc2_.index] = _loc2_.start + _loc2_.change * n;
         }
      }
   }
}
