class com.poptropica.models.proxy.dailyPop.GetCreatorClipsProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   function GetCreatorClipsProxy()
   {
      super();
      this._errorMessage = "GetCreatorClipsProxy::(), ERROR LOADING Creator CLIPS PROXY";
   }
   function loadData(pCallBackFunction)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.mode = "Sprint 2";
      super.doConnect("creatorClips/get_creator_clips.php");
   }
}
