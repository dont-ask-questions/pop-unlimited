class com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _model;
   var _loader;
   var _sender;
   var _method;
   var _data;
   var _callBackFunction;
   var _errorMessage;
   static var POST = "POST";
   static var GET = "GET";
   function ProxyBase()
   {
      this._model = com.poptropica.models.PopModel.getInstance();
      this._loader = new LoadVars();
      this._sender = new LoadVars();
      this._method = com.poptropica.models.proxy.supportClasses.ProxyBase.POST;
   }
   function get data()
   {
      return this._data;
   }
   function doConnect(pUrl)
   {
      var _loc2_ = !this._model.isTestMode ? com.poptropica.models.PopModel.getInstance().prefix + "/" + pUrl : "test_data/" + pUrl;
      _loc2_ = com.poptropica.models.PopModel.getInstance().prefix + "/" + pUrl;
      trace("[ProxyBase] doConnect url: " + _loc2_);
      this._loader.onLoad = com.poptropica.util.EventDelegate.create(this,this.onDataLoaded);
      this._sender.sendAndLoad(_loc2_,this._loader,this._method);
   }
   function onDataLoaded(pSuccess)
   {
      trace("[ProxyBase] onDataLoaded:" + pSuccess + "  " + this._loader.toString());
      if(pSuccess)
      {
         this._data = this._loader.toString();
         this._callBackFunction(this._data);
      }
      else
      {
         com.poptropica.util.Debug.trace(this._errorMessage,com.poptropica.util.Debug.WARNING);
      }
   }
}
