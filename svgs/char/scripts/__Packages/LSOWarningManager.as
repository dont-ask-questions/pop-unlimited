class LSOWarningManager
{
   var mBaseScope;
   var mScope;
   var _width;
   var _height;
   var mLSO;
   var mDialog;
   static var instance;
   var mFlushCallback = null;
   var WARNING_DETAILS_ASSET = "popups/lso/details.swf";
   var WARNING_ASSET = "popups/lso/warning.swf";
   function LSOWarningManager(baseScope, scope, width, height)
   {
      this.mBaseScope = baseScope;
      this.mScope = scope;
      if(width == undefined)
      {
         this._width = Stage.width;
      }
      else
      {
         this._width = width;
      }
      if(height == undefined)
      {
         this._height = Stage.height;
      }
      else
      {
         this._height = height;
      }
      this.init();
   }
   static function getInstance(baseScope, scope)
   {
      if(LSOWarningManager.instance == undefined)
      {
         LSOWarningManager.instance = new LSOWarningManager(baseScope,scope);
      }
      return LSOWarningManager.instance;
   }
   function init()
   {
      this.mLSO = SharedObject.getLocal("Char","/");
      this.mLSO.onStatus = Delegate.create(this,this.lsoFlushEvent);
   }
   function lsoFlushEvent(result)
   {
      trace("LSOWarningManager :: Result of LSO storage request!! : " + result.code + " mFlushCallback : " + this.mFlushCallback);
      switch(result.code)
      {
         case "SharedObject.Flush.Failed":
            this.showErrorDialog(false);
            break;
         case "SharedObject.Flush.Success":
            this.removeDialog();
            if(this.mFlushCallback != null)
            {
               this.mFlushCallback();
               this.mFlushCallback = null;
            }
      }
   }
   function get lso()
   {
      if(this.mLSO == undefined)
      {
         this.init();
      }
      return this.mLSO;
   }
   function flush(size, callback)
   {
      if(size == undefined)
      {
         size = 0;
      }
      if(callback)
      {
         this.mFlushCallback = callback;
      }
      var _loc2_ = this.mLSO.flush(size);
      switch(_loc2_)
      {
         case "pending":
            trace("LSOWarningManager :: flush is pending, waiting on user interaction.");
            this.showErrorDialog(_loc2_);
            break;
         case true:
            trace("LSOWarningManager :: flush was successful. Requested storage space approved.");
            break;
         case false:
            trace("LSOWarningManager :: flush failed. User denied request for additional storage.");
            this.showErrorDialog(_loc2_);
      }
      return _loc2_;
   }
   function showErrorDialog(flushResult)
   {
      trace("LSOWarningManager :: showErrorDialog " + flushResult);
      this.mBaseScope.trackCampaign("LoginError","Size Warning at Login : " + flushResult);
      var _loc2_ = this.WARNING_ASSET;
      if(flushResult == false)
      {
         _loc2_ = this.WARNING_DETAILS_ASSET;
      }
      if(this.mDialog)
      {
         this.mDialog.removeMovieClip();
      }
      this.mDialog = this.mScope.createEmptyMovieClip("lsoWarning",this.mScope.getNextHighestDepth());
      var _loc4_ = new MovieClipLoader();
      var _loc3_ = new Object();
      _loc3_.onLoadInit = Delegate.create(this,this.dialogLoaded);
      _loc4_.addListener(_loc3_);
      _loc4_.loadClip(_loc2_,this.mDialog);
   }
   function dialogLoaded(target)
   {
      com.poptropica.models.PopModelConst.gameplayMC.takeClick._visible = false;
      var _loc2_ = this._width - this.mDialog._width;
      var _loc3_ = this._height - this.mDialog._height;
      this.mDialog._x = _loc2_ * 0.5;
      this.mDialog._y = _loc3_ * 0.5;
      this.mDialog.okButton.onRelease = Delegate.create(this,this.removeDialog);
      trace("LSOWarningManager :: dialog loaded : " + this.mDialog);
   }
   function removeDialog()
   {
      trace("LSOWarningManager :: removing dialog " + this.mDialog + " : " + this.mScope + " : " + this.mBaseScope);
      this.mDialog._alpha = 10;
      this.mDialog.removeMovieClip();
   }
}
