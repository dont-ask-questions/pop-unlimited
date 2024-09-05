class com.poptropica.sections.quidget.PopupManager extends Object
{
   var _container;
   var _clickCatcher;
   var _popup;
   var _className;
   var _startLoc;
   var _fullScreen;
   var _adjustment;
   static var _instance;
   function PopupManager()
   {
      super();
   }
   function dispatchEvent()
   {
   }
   function addEventListener()
   {
   }
   function removeEventListener()
   {
   }
   static function getInstance()
   {
      if(com.poptropica.sections.quidget.PopupManager._instance == undefined)
      {
         com.poptropica.sections.quidget.PopupManager._instance = new com.poptropica.sections.quidget.PopupManager();
         mx.events.EventDispatcher.initialize(com.poptropica.sections.quidget.PopupManager._instance);
      }
      return com.poptropica.sections.quidget.PopupManager._instance;
   }
   function set container(mc)
   {
      this._container = mc;
      this._container.attachMovie("popupGrey","clickCatcher",this._container.getNextHighestDepth());
      this._clickCatcher = this._container.clickCatcher;
      this._clickCatcher._visible = false;
   }
   function drawGeneralPopup(className, titleStr, bodyStr)
   {
      this.drawPopupFromClass(className);
      this._popup.tfTitle.text = titleStr;
      this._popup.tfBody.text = bodyStr;
      this._popup.btnOk.onRelease = Delegate.create(this,this.closePopup);
      return this._popup;
   }
   function drawPopupFromClass(className, startLoc, assetUrl)
   {
      trace("[PopupManager] drawPopupFromClass:" + className + " container:" + this._container + ", assetUrl:" + assetUrl);
      if(startLoc == undefined)
      {
         startLoc = new flash.geom.Point(400,220);
      }
      this._className = className;
      if(this._container.popupContainer != undefined)
      {
         this._container.popupContainer.removeMovieClip();
      }
      this._container.createEmptyMovieClip("popupContainer",this._container.getNextHighestDepth());
      this._startLoc = startLoc;
      trace("[PopupManager] startLoc:" + this._startLoc);
      var _loc4_ = undefined;
      if(assetUrl == undefined)
      {
         _loc4_ = this.createPopupFromClass(className);
         this.animatePopupOpen(false);
      }
      else
      {
         var _loc2_ = new MovieClipLoader();
         var _loc3_ = {};
         _loc2_.addListener(_loc3_);
         _loc3_.onLoadInit = Delegate.create(this,this.onPopupAssetWithClassLoaded);
         _loc2_.loadClip(assetUrl,this._container.popupContainer);
      }
      this.dispatchEvent({type:"open"});
      return _loc4_;
   }
   function drawPopupFromSwf(swfUrl, startLoc, fullScreen, adjustment)
   {
      trace("[PopupManager] drawPopupFromSwf");
      this._fullScreen = fullScreen;
      this._adjustment = adjustment;
      if(this._container.popupContainer != undefined)
      {
         this._container.popupContainer.removeMovieClip();
      }
      this._container.createEmptyMovieClip("popupContainer",this._container.getNextHighestDepth());
      this._startLoc = startLoc;
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = {};
      _loc2_.addListener(_loc3_);
      _loc3_.onLoadInit = Delegate.create(this,this.onPopupSwfLoaded);
      _loc2_.loadClip(swfUrl,this._container.popupContainer);
      this.dispatchEvent({type:"open"});
      return this._container.popupContainer;
   }
   function reshowPopup(mc)
   {
      this._popup = mc;
      this.animatePopupOpen(false);
   }
   function isPopupOpen()
   {
      return this._popup != undefined;
   }
   function onPopupAssetWithClassLoaded()
   {
      trace("[PopupManager] onPopupAssetWithClassLoaded");
      this.createPopupFromClass();
      this.animatePopupOpen(false);
   }
   function onPopupSwfLoaded()
   {
      trace("[PopupManager] onPopupSwfLoaded");
      this._popup = this._container.popupContainer;
      this.popupInitCommon();
      this.animatePopupOpen(this._fullScreen);
   }
   function popupInitCommon()
   {
      if(this._popup == undefined)
      {
         trace("================= ERROR CREATING POPUP :" + this._className + " ===============");
      }
      else
      {
         this._popup.dispatchEvent = function()
         {
         };
         this._popup.addEventListener = function()
         {
         };
         this._popup.removeEventListener = function()
         {
         };
         mx.events.EventDispatcher.initialize(this._popup);
         this._popup.bg.onRelease = function()
         {
         };
         this._popup.addEventListener("close",Delegate.create(this,this.closePopup));
      }
   }
   function createPopupFromClass()
   {
      trace("[PopupManager] create:" + this._className + " container:" + this._container);
      this._container.popupContainer.attachMovie(this._className,this._className,this._container.popupContainer.getNextHighestDepth());
      this._popup = this._container.popupContainer[this._className];
      this.popupInitCommon();
      return this._popup;
   }
   function animatePopupOpen(fullScreen)
   {
      trace("[PopupManager] animatePopupOpen. fullScreen:" + fullScreen);
      var _loc4_ = 0;
      var _loc3_ = 0;
      var _loc2_ = undefined;
      var _loc6_ = undefined;
      if(fullScreen)
      {
         _loc2_ = this._adjustment.x;
         _loc6_ = this._adjustment.y;
         _loc4_ = this._startLoc.x - 60;
         _loc3_ = this._startLoc.y - 40;
         this._popup._xscale = 15;
         this._popup._yscale = 15;
      }
      else
      {
         _loc4_ = this._startLoc.x;
         _loc3_ = this._startLoc.y;
         _loc2_ = Math.max(this._startLoc.x,this._popup._width / 2 + 20);
         _loc2_ = Math.min(_loc2_,805 - this._popup._width / 2 - 20);
         var _loc5_ = undefined;
         if(this._popup.bg != undefined)
         {
            _loc5_ = this._popup.bg._height;
         }
         else
         {
            _loc5_ = this._popup._height;
         }
         var _loc7_ = 570 - _loc5_ / 2 - 30;
         _loc6_ = Math.min(this._startLoc.y,_loc7_);
         this._popup._xscale = 1;
         this._popup._yscale = 1;
      }
      this._popup._x = _loc4_;
      this._popup._y = _loc3_;
      this._popup.btnClose.onRelease = Delegate.create(this,this.onCloseBtnClick);
      com.greensock.TweenMax.to(this._popup,1.9,{_x:_loc2_,_y:_loc6_,_xscale:100,_yscale:100,ease:com.greensock.easing.Elastic.easeOut,easeParams:[0.8,1]});
      if(this._popup.mcDialogBg != undefined)
      {
         this._popup.mcDialogBg.onRelease = function()
         {
         };
      }
      this._clickCatcher._visible = true;
      this._clickCatcher.onRollOver = function()
      {
      };
      this._clickCatcher.onRelease = Delegate.create(this,this.closePopup);
      this._clickCatcher._alpha = 20;
      this.dispatchEvent({type:"popupReady",popup:this._popup});
   }
   function nextScaleOpenTween(popup, tweenIndex)
   {
      if(tweenIndex < 4)
      {
         var _loc3_ = [110,95,102,100];
         var _loc2_ = _loc3_[tweenIndex];
         com.greensock.TweenMax.to(popup,0.5 / (1 + tweenIndex * 2),{_xscale:_loc2_,_yscale:_loc2_,onComplete:com.poptropica.sections.quidget.PopupManager.getInstance().nextScaleOpenTween,onCompleteParams:[popup,tweenIndex + 1],ease:com.greensock.easing.Sine.easeOut});
      }
   }
   function onCloseBtnClick()
   {
      trace("[PopupManager] onCloseBtnClick");
      this.closePopup();
   }
   function closePopup()
   {
      if(this._popup != undefined)
      {
         trace("[PopupManager] closePopup() _popup:" + this._popup);
         this.dispatchEvent({type:"close"});
         com.greensock.TweenMax.to(this._popup,0.3,{_xscale:1,_yscale:1,_x:this._startLoc.x,_y:this._startLoc.y,ease:com.greensock.easing.Back.easeIn,onComplete:this.onCloseComplete,onCompleteParams:[this,this._popup]});
         this._popup = undefined;
         com.greensock.TweenMax.to(this._clickCatcher,0.01,{delay:0.3,_alpha:0,ease:com.greensock.easing.Sine.easeInOut});
         delete this._clickCatcher.onRollOver;
         delete this._clickCatcher.onRelease;
      }
   }
   function onCloseComplete(pThis, mc)
   {
      pThis.dispatchEvent({type:"closeComplete"});
      mc.removeMovieClip();
      this._popup = undefined;
   }
   function get backing()
   {
      return this._clickCatcher;
   }
}
