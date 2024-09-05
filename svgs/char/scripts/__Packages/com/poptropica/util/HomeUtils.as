class com.poptropica.util.HomeUtils
{
   function HomeUtils()
   {
   }
   static function parsePromoCodeSubmitData(pData)
   {
      com.poptropica.util.Debug.trace("parsePromoCodeSubmitData::parsePromoCodeSubmitData() pData=" + pData,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc1_ = new LoadVars();
      var _loc4_ = undefined;
      try
      {
         _loc1_.decode(pData);
      }
      catch(ex)
      {
         com.poptropica.util.Debug.trace(ex.name + ":" + ex.message + ":" + ex.at + ":" + ex.text);
      }
      var _loc3_ = !Boolean(_loc1_.answer == "ok") ? _loc1_.answer : "";
      var _loc2_ = !(Number(_loc1_.credits) == NaN || _loc1_.credits == undefined) ? Number(_loc1_.credits) : 0;
      _loc4_ = new com.poptropica.models.vo.PromoCodeResponseVO(Boolean(_loc1_.answer == "ok"),_loc3_,_loc1_.error,_loc2_,_loc1_.items.split(","),_loc1_.itemCategories.split(","));
      return _loc4_;
   }
}
