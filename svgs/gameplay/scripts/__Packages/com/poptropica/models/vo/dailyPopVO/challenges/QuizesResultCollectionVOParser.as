class com.poptropica.models.vo.dailyPopVO.challenges.QuizesResultCollectionVOParser extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _arrayOfQuizesResult;
   var _jsonObject;
   function QuizesResultCollectionVOParser(pData)
   {
      super(pData);
   }
   function parseData()
   {
      this._arrayOfQuizesResult = new Array();
      for(var _loc2_ in this._jsonObject)
      {
         this._arrayOfQuizesResult.push(new com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(_loc2_,this._jsonObject[_loc2_].quiz_score,this._jsonObject[_loc2_].quiz_result,this._jsonObject[_loc2_].quiz_time));
      }
   }
   function get arrayOfQuizesResult()
   {
      return this._arrayOfQuizesResult;
   }
}
