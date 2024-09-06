class com.poptropica.models.vo.dailyPopVO.challenges.UserChallengesResultVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _userChallengeResult;
   var _jsonObject;
   function UserChallengesResultVO(pData)
   {
      super(pData);
   }
   function getUserChallengeResultByChallengeId(pId)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._userChallengeResult.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(this._userChallengeResult[_loc2_]);
         if(pId == _loc3_.id)
         {
            return _loc3_.quizResult;
         }
         _loc2_ = _loc2_ + 1;
      }
      com.poptropica.util.Debug.trace("UserChallengesResultVO:: getUserChallengeResultById -> id=" + pId + "; NOT FOUND!!!",com.poptropica.util.Debug.WARNING);
      return undefined;
   }
   function setUserChallengeResultByChallengeId(pId)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._userChallengeResult.length)
      {
         var _loc3_ = com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(this._userChallengeResult[_loc2_]);
         if(pId == _loc3_.id)
         {
            this._userChallengeResult[_loc2_] = new com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(pId,0,1,undefined);
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      com.poptropica.util.Debug.trace("UserChallengesResultVO:: setUserChallengeResultByChallengeId -> id=" + pId + "; NOT FOUND!!!",com.poptropica.util.Debug.WARNING);
   }
   function parseData()
   {
      this._userChallengeResult = new Array();
      for(var _loc2_ in this._jsonObject)
      {
         this._userChallengeResult.push(new com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO(_loc2_,0,Number(this._jsonObject[_loc2_].user_challenge_result),undefined));
      }
   }
}
