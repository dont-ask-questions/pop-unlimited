class com.poptropica.models.proxy.dailyPop.GamesProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   function GamesProxy()
   {
      super();
      this._errorMessage = "GamesProxy::(), ERROR LOADING GAMES STREAM";
   }
   function loadData(pCallBackFunction, pPartnerId)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.partner_id = pPartnerId;
      super.doConnect("games/interface/get_games.php");
   }
}
