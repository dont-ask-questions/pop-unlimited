class com.poptropica.util.DailyPopUtils
{
   function DailyPopUtils()
   {
   }
   static function filterJson(pStr)
   {
      var _loc2_ = "";
      var _loc3_ = "json=";
      var _loc4_ = "answer=ok";
      pStr = unescape(pStr);
      if(pStr.indexOf(_loc4_) != -1)
      {
         _loc2_ = pStr.substring(pStr.indexOf(_loc3_) + _loc3_.length,pStr.length);
      }
      else
      {
         trace("DailyPopUtils()::filterJson() NOT CORRECT ANSWER FROM SERVER " + pStr);
      }
      return _loc2_;
   }
   static function parseDailyPopComicData(pData)
   {
      var _loc3_ = new Array();
      var _loc5_ = new JSON();
      try
      {
         var _loc1_ = _loc5_.parse(com.poptropica.util.DailyPopUtils.filterJson(pData));
      }
      catch(ex)
      {
         com.poptropica.util.Debug.trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
      }
      for(var _loc4_ in _loc1_)
      {
         var _loc2_ = new com.poptropica.models.vo.dailyPopVO.ComicVO(_loc4_,_loc1_[_loc4_].comic_stream_name,_loc1_[_loc4_].comic_stream_thumbnail_path);
         _loc3_.unshift(_loc2_);
      }
      return _loc3_;
   }
   static function parseDailyPopGamesData(pData)
   {
      var _loc3_ = new Array();
      var _loc5_ = new JSON();
      try
      {
         var _loc1_ = _loc5_.parse(com.poptropica.util.DailyPopUtils.filterJson(pData));
      }
      catch(ex)
      {
         com.poptropica.util.Debug.trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
      }
      for(var _loc4_ in _loc1_)
      {
         var _loc2_ = new com.poptropica.models.vo.dailyPopVO.GameVO(_loc1_[_loc4_].game_id,_loc1_[_loc4_].title,_loc1_[_loc4_].game_thumbnail_path,_loc1_[_loc4_].game_swf_path,_loc1_[_loc4_].gamecode,_loc1_[_loc4_].partner,Number(_loc1_[_loc4_].width),Number(_loc1_[_loc4_].height));
         _loc3_.unshift(_loc2_);
      }
      return _loc3_;
   }
   static function parseSneakPeeksData(pData)
   {
      var _loc3_ = new Array();
      var _loc5_ = new JSON();
      try
      {
         var _loc1_ = _loc5_.parse(com.poptropica.util.DailyPopUtils.filterJson(pData));
      }
      catch(ex)
      {
         com.poptropica.util.Debug.trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
      }
      for(var _loc4_ in _loc1_)
      {
         var _loc2_ = new com.poptropica.models.vo.dailyPopVO.SneakPeeksVO(_loc4_,_loc1_[_loc4_].creator_id,_loc1_[_loc4_].creator_clip_type_id,_loc1_[_loc4_].creator_clip_xml_path);
         _loc3_.unshift(_loc2_);
      }
      return _loc3_;
   }
}
