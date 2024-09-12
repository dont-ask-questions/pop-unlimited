class com.poptropica.models.proxy.dailyPop.challenges.GetQuizesProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   function GetQuizesProxy()
   {
      super();
      this._errorMessage = "GetQuizesProxy::(), ERROR LOADING GET QUIZES";
   }
   function loadData(pCallBackFunction, pQuantity, pOffset, pType, pChallengeQuizId)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.quantity = pQuantity;
      this._sender.offset = pOffset;
      this._sender.quiz_type = pType;
      if(pChallengeQuizId)
      {
         this._sender.challenge_quiz_id = pChallengeQuizId;
      }
      super.doConnect("quizzes/get_quizzes.php");
   }
}
