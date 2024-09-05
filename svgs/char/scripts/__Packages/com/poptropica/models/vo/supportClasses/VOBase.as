class com.poptropica.models.vo.supportClasses.VOBase
{
   var _jsonObject;
   function VOBase(serverResult)
   {
      var _loc2_ = this.filterJson(serverResult);
      if(!_loc2_)
      {
         return;
      }
      var _loc3_ = new JSON();
      try
      {
         this._jsonObject = _loc3_.parse(unescape(_loc2_));
         this.parseData();
      }
      catch(ex)
      {
         com.poptropica.util.Debug.trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
      }
   }
   function filterJson(pStr)
   {
      var _loc2_ = null;
      var _loc3_ = "json=";
      var _loc4_ = "answer=ok";
      pStr = unescape(pStr);
      if(pStr.indexOf(_loc4_) != -1)
      {
         _loc2_ = pStr.substring(pStr.indexOf(_loc3_) + _loc3_.length,pStr.length);
      }
      else
      {
         com.poptropica.util.Debug.trace("VOBase()::filterJson() NOT CORRECT ANSWER FROM SERVER. Answer: " + pStr,com.poptropica.util.Debug.WARNING);
      }
      return _loc2_;
   }
   function parseData()
   {
      com.poptropica.util.Debug.trace("This method is to be overriden!",com.poptropica.util.Debug.WARNING);
   }
}
