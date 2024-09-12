class com.poptropica.models.vo.dailyPopVO.challenges.QuizeCollectionVOParser extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _arrayOfQuizes;
   var _jsonObject;
   function QuizeCollectionVOParser(pData)
   {
      super(pData);
   }
   function parseData()
   {
      this._arrayOfQuizes = new Array();
      for(var _loc2_ in this._jsonObject)
      {
         this._arrayOfQuizes.push(new com.poptropica.models.vo.dailyPopVO.challenges.QuizeVO(_loc2_,this._jsonObject[_loc2_].quiz_type_id,this._jsonObject[_loc2_].quiz_xml_path));
      }
   }
   function get arrayOfQuizes()
   {
      return this._arrayOfQuizes;
   }
}
