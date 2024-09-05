class com.poptropica.sections.quidget.QuidgetBase extends MovieClip
{
   var debugFlag;
   var _objId;
   var _active;
   var _rect;
   var _asset;
   var _animatingFromArr;
   var _animArr;
   var _animArrIndex;
   var _targetX;
   var _accelY;
   var _isEditable = false;
   var _isLoaded = false;
   var _isMouseOver = false;
   function QuidgetBase()
   {
      super();
      this.debugFlag = false;
      this._objId = random(9999);
      this._active = false;
      mx.events.EventDispatcher.initialize(this);
      this._rect = new flash.geom.Rectangle(0,0,120,81);
      this.createQuidgetContainer();
      this._asset.onEnterFrame = Delegate.create(this,this.step);
      this._animatingFromArr = false;
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
   function init()
   {
   }
   function isAccomplishment()
   {
      return false;
   }
   function isPersonality()
   {
      return false;
   }
   function createQuidgetContainer()
   {
      this._asset = this.attachMovie("quidgetContainer","asset",1000);
      this._asset.rolloverIconsContainer._visible = false;
   }
   function loadQuidgetSwf(swfName)
   {
      var _loc3_ = new MovieClipLoader();
      var _loc2_ = {};
      _loc3_.addListener(_loc2_);
      _loc2_.onLoadInit = Delegate.create(this,this.onAssetLoadInit);
      if(swfName == undefined)
      {
         swfName = this.name + "_quidget_assets.swf";
      }
      _loc3_.loadClip("framework/assets/quidgets/" + swfName,this._asset.contentContainer.content);
   }
   function onAssetLoadInit()
   {
   }
   function step()
   {
      if(this._active)
      {
         var _loc2_ = this._rect.contains(this._asset._xmouse,this._asset._ymouse);
         if(this._isMouseOver != _loc2_)
         {
            this._isMouseOver = _loc2_;
            if(this._isMouseOver)
            {
               this.onButtonRollOver();
            }
            else
            {
               this.onButtonRollout();
            }
         }
      }
      if(this._animatingFromArr)
      {
         var _loc3_ = this._animArr[this._animArrIndex];
         this._x = _loc3_.x;
         this._y = _loc3_.y;
         if(this._animArrIndex >= this._animArr.length)
         {
            this._animatingFromArr = false;
         }
         else
         {
            this._animArrIndex = this._animArrIndex + 1;
         }
      }
   }
   function dispatchLoadComplete()
   {
      this._isLoaded = true;
      this.dispatchEvent({type:"loadComplete",quidget:this});
      this.convertToBitmap();
   }
   function createRolloverIcons()
   {
      var _loc2_ = this.createRolloverIcon("pencilIcon");
      _loc2_._x = 94;
      _loc2_._y = 6;
      _loc2_.onRelease = Delegate.create(this,this.onAssetClick);
   }
   function createRolloverIcon(s)
   {
      var _loc2_ = this._asset.rolloverIconsContainer.getNextHighestDepth();
      var _loc3_ = this._asset.rolloverIconsContainer.attachMovie(s,"icon" + _loc2_,_loc2_);
      return _loc3_;
   }
   function onButtonRollOver()
   {
      if(com.poptropica.sections.quidget.PopupManager.getInstance().isPopupOpen())
      {
         return undefined;
      }
      if(this._isEditable)
      {
         var _loc2_ = new flash.filters.GlowFilter(16776960,30,5,5,5,5);
         this._asset.filters = [_loc2_];
         this._asset.rolloverIconsContainer._visible = true;
         com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
      }
      if(this._visible && this._active)
      {
         this.dispatchEvent({type:"rollOver",quidget:this});
      }
   }
   function onButtonRollout()
   {
      this._asset.rolloverIconsContainer._visible = false;
      this._asset.filters = [];
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
      this.dispatchEvent({type:"rollOut",quidget:this});
   }
   function setEditable(b, hideIcons)
   {
      trace("[QuidgetBase] setEditable:" + b + "  hideIcons:" + hideIcons);
      this._isEditable = b;
      if(b)
      {
         if(hideIcons != true)
         {
            this.createRolloverIcons();
         }
         this._asset.contentContainer.onRelease = Delegate.create(this,this.onAssetClick);
      }
      else
      {
         delete this._asset.contentContainer.onRelease;
         this._asset.filters = [];
         this._asset.rolloverIconsContainer._visible = false;
      }
   }
   function onAssetClick()
   {
   }
   function get asset()
   {
      return this._asset;
   }
   function convertToBitmap()
   {
      if(this.name != "photos" && this.name != "closet")
      {
         var _loc2_ = new flash.display.BitmapData(160,82,true,0);
         _loc2_.draw(this._asset.contentContainer.content);
         this._asset.contentContainer.bitmapContainer.attachBitmap(_loc2_,0,false,true);
         this._asset.contentContainer.content._visible = false;
      }
   }
   function showConfirmDeletePopup()
   {
   }
   function makeIconFlash(color)
   {
      if(isNaN(color))
      {
         color = 16777113;
      }
      com.greensock.TweenMax.to(this._asset,0.1,{onComplete:this.clearIconFlash,onCompleteParams:[this],colorTransform:{tint:color,tintAmount:0.7}});
   }
   function clearIconFlash(scope)
   {
      var _loc1_ = scope._asset;
      com.greensock.TweenMax.to(_loc1_,1,{colorTransform:{tint:16777113,tintAmount:0}});
   }
   function get name()
   {
      return "should be overridden";
   }
   function get rolloverString()
   {
      return "rollover text to be added...";
   }
   function get isLoaded()
   {
      return this._isLoaded;
   }
   function set active(b)
   {
      this._active = b;
   }
   function get active()
   {
      return this._active;
   }
   function set targetX(n)
   {
      this._targetX = n;
   }
   function get targetX()
   {
      return this._targetX;
   }
   function set accelY(n)
   {
      this._accelY = n;
   }
   function get accelY()
   {
      return this._accelY;
   }
   function setAnim(a)
   {
      this._animArr = a;
   }
   function startAnim()
   {
      this._animArrIndex = 0;
      this._animatingFromArr = true;
   }
   function stopAnim()
   {
      this._animatingFromArr = false;
   }
}
