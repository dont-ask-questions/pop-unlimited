class com.poptropica.util.PopUtils
{
   function PopUtils()
   {
   }
   static function isURLLive(pURL)
   {
      com.poptropica.util.Debug.trace("PopUtils::isURLLive() pURL=" + pURL,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      return pURL.indexOf("http") == 0;
   }
   static function makeURLInsecure(pURL)
   {
      com.poptropica.util.Debug.trace("PopUtils::makeURLInsecure() pURL=" + pURL,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      return pURL.split("https").join("http");
   }
   static function getFlashPrefixFromLocalConnection()
   {
      com.poptropica.util.Debug.trace("PopUtils::getFlashPrefixFromLocalConnection()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new LocalConnection();
      var _loc1_ = _loc2_.domain();
      if(_loc1_ == "localhost" || _loc1_ == "feta.fen.com")
      {
         return "";
      }
      return "http://" + _loc1_ + "/";
   }
}
