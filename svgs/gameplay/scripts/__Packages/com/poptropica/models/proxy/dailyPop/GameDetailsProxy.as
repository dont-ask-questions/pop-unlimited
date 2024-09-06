class com.poptropica.models.proxy.dailyPop.GameDetailsProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _model;
   var _sender;
   function GameDetailsProxy()
   {
      super();
      this._errorMessage = "GameDetailsProxy::(), ERROR LOADING GAME DETAILS";
   }
   function loadData(pCallBackFunction, pGameId)
   {
      this._callBackFunction = pCallBackFunction;
      if(this._model.login)
      {
         this._sender.username = this._model.login;
      }
      if(this._model.db_id)
      {
         this._sender.dbid = this._model.db_id;
      }
      if(this._model.password_hash)
      {
         this._sender.passhash = this._model.password_hash;
      }
      this._sender.gameid = pGameId;
      super.doConnect("games/interface/get_highscores.php");
   }
}
