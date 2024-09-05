class com.poptropica.models.vo.dailyPopVO.ChallengesVO
{
   var _challengeOfTheDayResult;
   var _quizeTypesCollection;
   var _quizesCollectionHolder;
   var _challengeOfTheDay;
   function ChallengesVO()
   {
   }
   function setUserChallengesResultData(pData)
   {
      this._challengeOfTheDayResult = new com.poptropica.models.vo.dailyPopVO.challenges.UserChallengesResultVO(pData);
   }
   function setQuizeTypesCollectionData(pData)
   {
      this._quizeTypesCollection = new com.poptropica.models.vo.dailyPopVO.challenges.QuizeTypesCollectionVO(pData);
      this._quizesCollectionHolder = new com.poptropica.models.vo.dailyPopVO.challenges.QuizesCollectionHolder(this._quizeTypesCollection.arrayOfQuizTypes);
   }
   function setChallengeOfTheDayData(pData)
   {
      this._challengeOfTheDay = new com.poptropica.models.vo.dailyPopVO.challenges.ChallengeOfTheDayVO(pData);
   }
   function get quizeTypesCollection()
   {
      return this._quizeTypesCollection;
   }
   function get challengeOfTheDay()
   {
      return this._challengeOfTheDay;
   }
   function get quizesCollectionHolder()
   {
      return this._quizesCollectionHolder;
   }
   function get challengeOfTheDayResult()
   {
      return this._challengeOfTheDayResult;
   }
}
