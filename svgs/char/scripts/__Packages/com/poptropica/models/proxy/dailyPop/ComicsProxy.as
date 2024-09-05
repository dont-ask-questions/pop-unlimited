class com.poptropica.models.proxy.dailyPop.ComicsProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   function ComicsProxy()
   {
      super();
      this._errorMessage = "ComicsProxy::(), ERROR LOADING COMICS STREAM";
   }
   function loadData(pCallBackFunction)
   {
      this._callBackFunction = pCallBackFunction;
      super.doConnect("comics/get_comic_streams.php");
   }
}
