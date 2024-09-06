class com.poptropica.models.proxy.rating.UserRatingProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function UserRatingProxy()
   {
      super();
      this._errorMessage = "UserRatingProxy::(), ERROR LOADING USER ITEMS RATING";
   }
   function loadData(pCallBackFunction, pArrayOfIds)
   {
      this._callBackFunction = pCallBackFunction;
      var _loc3_ = 0;
      while(_loc3_ < pArrayOfIds.length)
      {
         this._sender["item_ids_array[" + _loc3_ + "]"] = pArrayOfIds[_loc3_];
         _loc3_ = _loc3_ + 1;
      }
      this._sender.login = this._model.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      super.doConnect("ratings/get_user_items_ratings.php");
   }
}
