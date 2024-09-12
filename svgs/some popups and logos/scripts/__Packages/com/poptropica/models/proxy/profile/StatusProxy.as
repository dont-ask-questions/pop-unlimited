class com.poptropica.models.proxy.profile.StatusProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _sender;
   var _model;
   var _errorMessage;
   var _callBackFunction;
   function StatusProxy()
   {
      super();
      this._sender.login = this._model.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      this._errorMessage = "StatusProxy::(), ERROR LOADING";
   }
   function sendData(callBackFunction, messageId)
   {
      this._callBackFunction = callBackFunction;
      this._sender.msgid = messageId;
      super.doConnect("profile/set_status.php");
   }
   function loadData(callBackFunction)
   {
      this._callBackFunction = callBackFunction;
      super.doConnect("profile/get_status.php");
   }
}
