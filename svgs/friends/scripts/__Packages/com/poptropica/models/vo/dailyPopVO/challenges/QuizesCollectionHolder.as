class com.poptropica.models.vo.dailyPopVO.challenges.QuizesCollectionHolder
{
   var _arrayOfQuizesCollections;
   function QuizesCollectionHolder(pArrayOfTypes)
   {
      this._arrayOfQuizesCollections = new Array();
      var _loc2_ = 0;
      while(_loc2_ < pArrayOfTypes.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeTypeVO(pArrayOfTypes[_loc2_]).id;
         this._arrayOfQuizesCollections.push(new com.poptropica.models.vo.dailyPopVO.challenges.QuizesCollectionVO(_loc3_));
         _loc2_ = _loc2_ + 1;
      }
   }
   function getQuizeCollectionByType(pType)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfQuizesCollections.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizesCollectionVO(this._arrayOfQuizesCollections[_loc2_]);
         if(_loc3_.typeID == pType)
         {
            return _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
}
