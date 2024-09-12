class com.poptropica.models.proxy.dailyPop.SneakPeeksProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _model;
   var _sender;
   function SneakPeeksProxy()
   {
      super();
      this._errorMessage = "SneakPeeksProxy::(), ERROR LOADING SNEAK PEEK PROXY";
   }
   function loadData(pCallBackFunction)
   {
      this._callBackFunction = pCallBackFunction;
      if(this._model.SNEAK_PEEKS_QUANTITY != null && this._model.SNEAK_PEEKS_QUANTITY != undefined)
      {
         this._sender.quantity = this._model.SNEAK_PEEKS_QUANTITY;
      }
      if(this._model.offsetSneakPeeks != null && this._model.offsetSneakPeeks != undefined)
      {
         this._sender.offset = this._model.offsetSneakPeeks;
      }
      super.doConnect("creatorClips/get_creator_clips.php");
   }
}
