class com.poptropica.models.proxy.ComicStripsProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   function ComicStripsProxy()
   {
      super();
      this._errorMessage = "SneakPeeksProxy::(), ERROR LOADING COMIC STRIPS STREAM";
   }
   function loadData(pCallBackFunction, pId, pUserName, pDbId)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.comic_stream_id = pId;
      this._sender.username = pUserName;
      this._sender.db_id = pDbId;
      super.doConnect("comics/get_comic_strips.php");
   }
}
