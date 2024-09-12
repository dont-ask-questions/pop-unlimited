class com.poptropica.models.proxy.dailyPop.challenges.QuizeTypesProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   function QuizeTypesProxy()
   {
      super();
      this._errorMessage = "QuizeTypesProxy::(), ERROR LOADING CHALLENGES GET TYPES";
   }
   function loadData(pCallBackFunction)
   {
      this._callBackFunction = pCallBackFunction;
      super.doConnect("quizzes/get_quiz_types.php");
   }
}
