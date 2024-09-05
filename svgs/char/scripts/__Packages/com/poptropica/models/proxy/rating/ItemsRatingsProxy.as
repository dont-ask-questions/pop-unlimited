class com.poptropica.models.proxy.rating.ItemsRatingsProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   function ItemsRatingsProxy()
   {
      super();
      this._errorMessage = "ItemsRatingsProxy::(), ERROR LOADING ITEMS RATING";
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
      super.doConnect("ratings/get_items_ratings.php");
   }
}
