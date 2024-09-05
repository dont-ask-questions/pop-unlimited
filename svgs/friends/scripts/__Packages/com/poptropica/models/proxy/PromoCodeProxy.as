class com.poptropica.models.proxy.PromoCodeProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _sender;
   var _model;
   var _errorMessage;
   var _callBackFunction;
   function PromoCodeProxy()
   {
      super();
      this._sender.login = this._model.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      this._errorMessage = "PromoCodeProxy::(), ERROR LOADING PROMO CODE";
   }
   function loadData(pCallBackFunction, pPromoCode)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.promo_code = pPromoCode;
      super.doConnect("use-promo-code.php");
   }
}
