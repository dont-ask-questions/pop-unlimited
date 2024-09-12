class com.poptropica.models.proxy.dailyPop.challenges.ChallengeOfTheDayProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   function ChallengeOfTheDayProxy()
   {
      super();
      this._errorMessage = "ChallengeOfTheDayProxy::(), ERROR LOADING CHALLENGES GET QUIZES";
   }
   function loadData(pCallBackFunction)
   {
      this._callBackFunction = pCallBackFunction;
      super.doConnect("challenges/get_challenge.php");
   }
}
