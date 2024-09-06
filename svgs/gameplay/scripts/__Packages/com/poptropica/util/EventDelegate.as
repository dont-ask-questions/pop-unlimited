class com.poptropica.util.EventDelegate
{
   function EventDelegate()
   {
   }
   static function create(scope, method)
   {
      var params = arguments.splice(2,arguments.length - 2);
      var _loc2_ = function()
      {
         method.apply(scope,arguments.concat(params));
      };
      return _loc2_;
   }
}
