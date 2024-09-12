class com.poptropica.models.vo.dailyPopVO.challenges.QuizeTypesCollectionVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _arrayOfQuizTypes;
   var _jsonObject;
   function QuizeTypesCollectionVO(pData)
   {
      super(pData);
   }
   function parseData()
   {
      this._arrayOfQuizTypes = new Array();
      for(var _loc3_ in this._jsonObject)
      {
         var _loc2_ = new com.poptropica.models.vo.dailyPopVO.challenges.QuizeTypeVO(_loc3_,this._jsonObject[_loc3_].quiz_type_name,this._jsonObject[_loc3_].quiz_type_thumbnail_path,this._jsonObject[_loc3_].quiz_engine_path,this._jsonObject[_loc3_].quizzes_of_type);
         trace("type id " + _loc2_.id + "; total=" + _loc2_.totalCount);
         this._arrayOfQuizTypes.push(_loc2_);
      }
   }
   function getQuizeTypeById(pId)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfQuizTypes.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeTypeVO(this._arrayOfQuizTypes[_loc2_]);
         if(_loc3_.id == pId)
         {
            return _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function get arrayOfQuizTypes()
   {
      return this._arrayOfQuizTypes;
   }
}
