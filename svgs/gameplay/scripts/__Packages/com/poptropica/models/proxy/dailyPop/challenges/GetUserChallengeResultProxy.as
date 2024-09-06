class com.poptropica.models.proxy.dailyPop.challenges.GetUserChallengeResultProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function GetUserChallengeResultProxy()
   {
      super();
      this._errorMessage = "GetUserChallengeResult::(), ERROR LOADING GET USER CHALLENGES RESULT";
   }
   function loadData(pCallBackFunction, pChallangeId)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.username = this._model.poptropica_user.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.db_id = this._model.db_id;
      this._sender["challenge_ids_array[0]"] = pChallangeId;
      super.doConnect("challenges/get_user_challenge_result.php");
   }
}
