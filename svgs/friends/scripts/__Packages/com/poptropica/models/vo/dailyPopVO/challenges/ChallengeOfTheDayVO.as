class com.poptropica.models.vo.dailyPopVO.challenges.ChallengeOfTheDayVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _jsonObject;
   var _id;
   var _chTypeID;
   var _chQuizID;
   var _chQuizName;
   function ChallengeOfTheDayVO(pServerResult)
   {
      super(pServerResult);
   }
   function parseData()
   {
      for(var _loc2_ in this._jsonObject)
      {
         this._id = _loc2_;
         this._chTypeID = this._jsonObject[_loc2_].challenge_type_id;
         this._chQuizID = this._jsonObject[_loc2_].challenge_quiz_id;
         this._chQuizName = this._jsonObject[_loc2_].challenge_quiz_name;
      }
   }
   function get id()
   {
      return this._id;
   }
   function get chTypeID()
   {
      return this._chTypeID;
   }
   function get chQuizID()
   {
      return this._chQuizID;
   }
   function get chQuizName()
   {
      return this._chQuizName;
   }
}
