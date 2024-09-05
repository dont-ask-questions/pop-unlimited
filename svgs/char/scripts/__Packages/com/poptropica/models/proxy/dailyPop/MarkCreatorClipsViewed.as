class com.poptropica.models.proxy.dailyPop.MarkCreatorClipsViewed extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function MarkCreatorClipsViewed()
   {
      super();
      this._errorMessage = "MarkCreatorClipsViewed::(), ERROR LOADING mark_clips_viewed.php STREAM";
   }
   function sendData(pCallBackFunction, pArrayOfIds)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.login = this._model.poptropica_user.login;
      this._sender.pass_hash = this._model.poptropica_user.password_hash;
      this._sender.dbid = this._model.db_id;
      var _loc3_ = 0;
      while(_loc3_ < pArrayOfIds.length)
      {
         this._sender["creator_clip_ids_array[" + _loc3_ + "]"] = pArrayOfIds[_loc3_];
         _loc3_ = _loc3_ + 1;
      }
      super.doConnect("creatorClips/mark_clips_viewed.php");
   }
}
