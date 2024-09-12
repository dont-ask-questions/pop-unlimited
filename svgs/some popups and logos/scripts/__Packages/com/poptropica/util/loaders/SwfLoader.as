class com.poptropica.util.loaders.SwfLoader
{
   var _loadListener;
   var _loader;
   var _currentProgress;
   function SwfLoader()
   {
      mx.events.EventDispatcher.initialize(this);
   }
   function dispatchEvent(pEvent)
   {
   }
   function addEventListener(pEventType, pHandler)
   {
   }
   function removeEventListener(pEventType, pHandler)
   {
   }
   function load(pUrl, pTarget)
   {
      this._loadListener = new Object();
      this._loader = new MovieClipLoader();
      this._loadListener.onLoadComplete = com.poptropica.util.EventDelegate.create(this,this.onLoadComplete);
      this._loadListener.onLoadProgress = com.poptropica.util.EventDelegate.create(this,this.onLoadProgress);
      this._loadListener.onLoadInit = com.poptropica.util.EventDelegate.create(this,this.onLoadInit);
      this._loadListener.onLoadError = com.poptropica.util.EventDelegate.create(this,this.onLoadError);
      this._loader.addListener(this._loadListener);
      this._loader.loadClip(pUrl,pTarget);
   }
   function onLoadError(pTtarget, errorCode, httpStatus)
   {
      var _loc2_ = new com.poptropica.events.LoaderEvent(com.poptropica.events.LoaderEvent.LOAD_ERROR);
      this.dispatchEvent(_loc2_);
   }
   function onLoadInit(pTarger)
   {
      var _loc2_ = new com.poptropica.events.LoaderEvent(com.poptropica.events.LoaderEvent.LOAD_INIT);
      this.dispatchEvent(_loc2_);
      this.kill();
   }
   function onLoadProgress(pTarget, pBytesLoaded, pBytesTotal)
   {
      var _loc2_ = new com.poptropica.events.LoaderEvent(com.poptropica.events.LoaderEvent.LOAD_PROGRESS);
      this._currentProgress = pBytesLoaded / pBytesTotal;
      this.dispatchEvent(_loc2_);
   }
   function onLoadComplete(pTarger, pHttpStatus)
   {
      var _loc2_ = new com.poptropica.events.LoaderEvent(com.poptropica.events.LoaderEvent.LOAD_COMPLETE);
      this.dispatchEvent(_loc2_);
   }
   function kill()
   {
      delete this._loadListener.onLoadError;
      delete this._loadListener.onLoadComplete;
      delete this._loadListener;
      delete this._loader;
   }
   function get currentProgress()
   {
      return this._currentProgress;
   }
}
