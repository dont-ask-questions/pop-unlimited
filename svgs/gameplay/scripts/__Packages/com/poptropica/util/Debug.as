class com.poptropica.util.Debug
{
   static var instance;
   var _severity_level = 2;
   static var FATAL_ERROR = 1;
   static var WARNING = 2;
   static var STANDARD_MESSAGE = 3;
   static var VERBOSE_MESSAGE = 4;
   function Debug()
   {
   }
   static function getInstance()
   {
      if(com.poptropica.util.Debug.instance == undefined)
      {
         com.poptropica.util.Debug.instance = new com.poptropica.util.Debug();
      }
      return com.poptropica.util.Debug.instance;
   }
   static function examineContents(obj, depth)
   {
      if(depth == undefined)
      {
         trace("Debug::trace()");
      }
      for(var _loc3_ in obj)
      {
         if(obj[_loc3_] instanceof Array || obj[_loc3_] instanceof Object)
         {
            trace(depth + _loc3_ + ": ");
            com.poptropica.util.Debug.examineContents(obj[_loc3_],depth + "\t");
         }
         else if(obj[_loc3_])
         {
            trace(depth + _loc3_ + ": " + obj[_loc3_].valueOf());
         }
      }
   }
   function set severity_level(s)
   {
      com.poptropica.util.Debug.trace("Debug.as::set severity_level() s=" + s,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._severity_level = s;
   }
   function get severity_level()
   {
      return this._severity_level;
   }
   static function trace(output, severity)
   {
      com.poptropica.util.Debug.getInstance().localTrace(output,severity);
   }
   function localTrace(output, severity)
   {
      if(severity == undefined)
      {
         severity = com.poptropica.util.Debug.VERBOSE_MESSAGE;
      }
      this._severity_level = 999;
      if(this._severity_level >= severity)
      {
         trace(output);
      }
   }
}
