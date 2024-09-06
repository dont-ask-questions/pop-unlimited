class com.poptropica.models.proxy.dailyPop.challenges.SetUserChallengeResultProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function SetUserChallengeResultProxy()
   {
      super();
      this._errorMessage = "SetUserChallengeResultProxy::(), ERROR LOADING SET USER CHALLENGES RESULT";
   }
   function loadData(pCallBackFunction, pChallangeId)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.username = this._model.poptropica_user.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.db_id = this._model.db_id;
      this._sender.item_id = pChallangeId;
      super.doConnect("challenges/set_user_challenge_result.php");
   }
}
