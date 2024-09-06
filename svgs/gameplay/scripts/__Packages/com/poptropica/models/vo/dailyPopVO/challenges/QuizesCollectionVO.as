class com.poptropica.models.vo.dailyPopVO.challenges.QuizesCollectionVO
{
   var _typeID;
   var _arrayOfQuizes;
   var _arrayOfQuizesResult;
   var _quizesResultParser;
   var _quizesParser;
   function QuizesCollectionVO(pType)
   {
      this._typeID = pType;
      this._arrayOfQuizes = new Array();
      this._arrayOfQuizesResult = new Array();
   }
   function getQuizVoById(pId)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfQuizes.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeVO(this._arrayOfQuizes[_loc2_]);
         if(_loc3_.id == pId)
         {
            return _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function getQuizResultVoById(pId)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfQuizesResult.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(this._arrayOfQuizesResult[_loc2_]);
         if(_loc3_.id == pId)
         {
            return _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function reSaveQuizResult(res)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfQuizesResult.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(this._arrayOfQuizesResult[_loc2_]);
         if(_loc3_.id == res.id)
         {
            this._arrayOfQuizesResult[_loc2_] = res;
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function getQuizVoByIndex(pIndex)
   {
      return com.poptropica.models.vo.dailyPopVO.challenges.QuizeVO(this._arrayOfQuizes[pIndex]);
   }
   function getElements(pOffset, pQuantity)
   {
      var _loc3_ = new Array();
      var _loc4_ = pOffset + pQuantity;
      var _loc2_ = pOffset;
      while(_loc2_ < _loc4_)
      {
         if(!this._arrayOfQuizes[_loc2_])
         {
            return _loc3_;
         }
         _loc3_.push(this._arrayOfQuizes[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function isThisNumberOfElementsInCollection(pOffset, pQuantity)
   {
      com.poptropica.util.Debug.trace("QuizesCollectionVO :: isThisNumberOfElementsInCollection::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc5_ = com.poptropica.models.PopModel.getInstance().getChallengesVO().quizeTypesCollection.getQuizeTypeById(this.typeID);
      if(this.arrayOfQuizes.length >= _loc5_.totalCount && _loc5_.totalCount && this.arrayOfQuizes.length)
      {
         return true;
      }
      var _loc3_ = pOffset + pQuantity;
      var _loc2_ = pOffset;
      while(_loc2_ < _loc3_)
      {
         if(!this._arrayOfQuizes[_loc2_])
         {
            return false;
         }
         _loc2_ = _loc2_ + 1;
      }
      return true;
   }
   function setResultCollection(pData)
   {
      this._quizesResultParser = new com.poptropica.models.vo.dailyPopVO.challenges.QuizesResultCollectionVOParser(pData);
      var _loc2_ = 0;
      while(_loc2_ < this._quizesResultParser.arrayOfQuizesResult.length)
      {
         var _loc3_ = this._quizesResultParser.arrayOfQuizesResult[_loc2_];
         this.reSaveQuizResult(_loc3_);
         _loc2_ = _loc2_ + 1;
      }
      trace("QuizesCollectionVO::setResultCollection.length->" + this._arrayOfQuizesResult.length + "; type=" + this.typeID);
   }
   function setCollection(pData)
   {
      this._quizesParser = new com.poptropica.models.vo.dailyPopVO.challenges.QuizeCollectionVOParser(pData);
      this.addEmptyResultsForNewQuizes(this._quizesParser.arrayOfQuizes);
      this._arrayOfQuizes = this._arrayOfQuizes.concat(this._quizesParser.arrayOfQuizes);
      trace("QuizesCollectionVO::setCollection.length->" + this._arrayOfQuizes.length + " ; type= " + this.typeID);
   }
   function addEmptyResultsForNewQuizes(pArrayOfQuizes)
   {
      var _loc2_ = 0;
      while(_loc2_ < pArrayOfQuizes.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeVO(pArrayOfQuizes[_loc2_]);
         var _loc4_ = new com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(_loc3_.id,0,0,0);
         this._arrayOfQuizesResult.push(_loc4_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function get arrayOfQuizes()
   {
      return this._arrayOfQuizes;
   }
   function get arrayOfQuizesResult()
   {
      return this._arrayOfQuizesResult;
   }
   function get typeID()
   {
      return this._typeID;
   }
}
