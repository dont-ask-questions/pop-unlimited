class com.poptropica.util.ComicViewerUtil
{
   function ComicViewerUtil()
   {
   }
   static function parseComicViewerVoData(pData, pComicTitle, pId)
   {
      var _loc3_ = new com.poptropica.models.vo.ComicViewerVO(pComicTitle,pId);
      var _loc5_ = new JSON();
      try
      {
         var _loc2_ = _loc5_.parse(com.poptropica.util.DailyPopUtils.filterJson(pData));
      }
      catch(ex)
      {
         com.poptropica.util.Debug.trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
      }
      for(var _loc4_ in _loc2_)
      {
         var _loc1_ = new com.poptropica.models.vo.ComicStripVO(_loc4_,_loc2_[_loc4_]);
         _loc3_.listComicStrip.unshift(_loc1_);
      }
      return _loc3_;
   }
}
