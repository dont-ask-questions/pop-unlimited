class com.poptropica.models.proxy.badges.BadgeSetProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _sender;
   var _model;
   var _errorMessage;
   var _callBackFunction;
   function BadgeSetProxy()
   {
      super();
      this._sender.login = this._model.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      this._errorMessage = "BadgeSetProxy::(), ERROR LOADING";
   }
   function loadData(callBackFunction, badgeSetId)
   {
      this._callBackFunction = callBackFunction;
      this._sender.badge_set_id = badgeSetId;
      super.doConnect("badges/get_badge_set.php");
   }
}
