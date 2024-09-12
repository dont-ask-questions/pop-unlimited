class com.poptropica.models.proxy.ProxyObject extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _sender;
   var _loader;
   var _data;
   var _callBackFunction;
   var _errorMessage;
   function ProxyObject()
   {
      super();
      var _loc3_ = SharedObject.getLocal("Char","/");
      this._sender.login = _loc3_.data.login;
      this._sender.pass_hash = _loc3_.data.password;
      this._sender.dbid = _loc3_.data.dbid;
   }
   function onDataLoaded(pSuccess)
   {
      trace("[ProxyObject] onDataLoaded:" + pSuccess + "  " + this._loader.toString());
      if(pSuccess)
      {
         this._data = this._loader;
         this._callBackFunction(this._data);
      }
      else
      {
         com.poptropica.util.Debug.trace(this._errorMessage,com.poptropica.util.Debug.WARNING);
      }
   }
   function set callback(callback)
   {
      this._callBackFunction = callback;
   }
}
