class com.poptropica.models.proxy.badges.AlbumPageProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _sender;
   var _model;
   var _errorMessage;
   var _callBackFunction;
   function AlbumPageProxy()
   {
      super();
      this._sender.login = this._model.login;
      this._sender.pass_hash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      this._errorMessage = "AlbumPageProxy::(), ERROR LOADING";
   }
   function loadData(callBackFunction, albumId, setOffset, nSets)
   {
      this._callBackFunction = callBackFunction;
      this._sender.album_id = albumId;
      this._sender.set_offset = setOffset;
      this._sender.n_sets = nSets;
      super.doConnect("badges/get_album_page.php");
   }
}
