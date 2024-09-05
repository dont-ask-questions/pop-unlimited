class com.poptropica.components.ScrollBarPop
{
   var _pos;
   var _dir;
   var _timeBetweenChanges;
   var _delta;
   var _leverPickedUp;
   var _mc;
   var _mcLever;
   var _btnUp;
   var _btnDown;
   var _mcBacking;
   var _lastChangeTime;
   var BASE_CHANGE_TIME = 500;
   function ScrollBarPop()
   {
      mx.events.EventDispatcher.initialize(this);
      trace("[ScrollBarPop] Constructor");
      this._pos = 0;
      this._dir = 0;
      this._timeBetweenChanges = this.BASE_CHANGE_TIME;
      this._delta = 10;
      this._leverPickedUp = false;
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
   function set asset(pAsset)
   {
      trace("[ScrollBarPop] set asset: " + pAsset);
      this._mc = pAsset;
      this._mcLever = this._mc.mcLever;
      this._btnUp = this._mc.btnUp;
      this._btnDown = this._mc.btnDown;
      this._mcBacking = this._mc.mcBacking;
      this._btnUp.onPress = Delegate.create(this,this.onBtnUpPress);
      this._btnUp.onRelease = this._btnUp.onReleaseOutside = Delegate.create(this,this.onBtnUpRelease);
      this._btnDown.onPress = Delegate.create(this,this.onBtnDownPress);
      this._btnDown.onRelease = this._btnDown.onReleaseOutside = Delegate.create(this,this.onBtnDownRelease);
      this._mcBacking.onPress = Delegate.create(this,this.onBackingPress);
      this._mcLever.onPress = Delegate.create(this,this.onLeverPress);
      this._mcLever.onRelease = this._mcLever.onReleaseOutside = Delegate.create(this,this.onLeverRelease);
      trace("_mcLever?" + this._mcLever);
      this._mc.onEnterFrame = Delegate.create(this,this.step);
      this.draw();
   }
   function step()
   {
      if(this._leverPickedUp)
      {
         var _loc2_ = this.getRelMouseY();
         _loc2_ = Math.max(_loc2_,this._btnUp._y);
         _loc2_ = Math.min(_loc2_,this._btnDown._y - 15);
         this._mcLever._y = _loc2_;
         this.setPos((_loc2_ - this._btnUp._y) / (this._btnDown._y - 15 - this._btnUp._y) * 100,true);
      }
      else if(this._dir != 0)
      {
         this.changePos(this._dir,true);
      }
   }
   function draw()
   {
      var _loc2_ = this._btnUp._y + this._pos / 100 * (this._btnDown._y - 30);
      this._mcLever._y = _loc2_;
   }
   function onBtnUpPress()
   {
      this.changePos(-1);
      this._dir = -1;
   }
   function onBtnUpRelease()
   {
      this._dir = 0;
      this._timeBetweenChanges = this.BASE_CHANGE_TIME;
   }
   function onBtnDownPress()
   {
      this.changePos(1);
      this._dir = 1;
   }
   function onBtnDownRelease()
   {
      this._dir = 0;
      this._timeBetweenChanges = this.BASE_CHANGE_TIME;
   }
   function onLeverPress()
   {
      this._leverPickedUp = true;
   }
   function onLeverRelease()
   {
      this._leverPickedUp = false;
   }
   function set height(n)
   {
      this._mcBacking._height = n;
      this._btnDown._y = this._mcBacking._height - 15;
      this.draw();
   }
   function getRelMouseY()
   {
      var _loc3_ = new flash.geom.Point(_root._xmouse,_root._ymouse);
      this._mc.globalToLocal(_loc3_);
      return _loc3_.y;
   }
   function onBackingPress()
   {
      if(this.getRelMouseY() > this._mcLever._y)
      {
         this.changePos(1);
      }
      else
      {
         this.changePos(-1);
      }
   }
   function changePos(dir, timeLimit)
   {
      var _loc2_ = true;
      if(timeLimit)
      {
         _loc2_ = false;
         if(this._lastChangeTime == undefined || getTimer() - this._lastChangeTime > this._timeBetweenChanges)
         {
            _loc2_ = true;
            this._timeBetweenChanges = Math.max(this._timeBetweenChanges - 175,0);
         }
      }
      if(_loc2_)
      {
         this.setPos(this._pos + dir * this._delta,true);
         this._lastChangeTime = getTimer();
      }
   }
   function setPos(n, dispatch)
   {
      this._pos = Math.min(n,100);
      this._pos = Math.max(0,this._pos);
      this.draw();
      if(dispatch)
      {
         this.dispatchEvent({type:"change",pos:this._pos});
      }
   }
   function set visible(b)
   {
      this._mc._visible = b;
   }
   function set x(n)
   {
      this._mc._x = n;
   }
   function set delta(n)
   {
      this._delta = n;
   }
   function onItemPress(pItem)
   {
   }
}
