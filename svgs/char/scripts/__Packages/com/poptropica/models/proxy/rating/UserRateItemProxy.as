class com.poptropica.models.proxy.rating.UserRateItemProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function UserRateItemProxy()
   {
      super();
      this._errorMessage = "UserRateItemProxy::(), ERROR SENDING USER ITEM RATE";
   }
   function loadData(pCallBackFunction, pItemId, pItemRating)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.login = this._model.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      this._sender.item_id = pItemId;
      this._sender.user_item_rating = pItemRating;
      super.doConnect("ratings/rate_item.php");
   }
}
