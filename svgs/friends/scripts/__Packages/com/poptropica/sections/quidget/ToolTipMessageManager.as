class com.poptropica.sections.quidget.ToolTipMessageManager extends Object
{
   var _container;
   var _msg;
   var _objOver;
   var _str;
   var _offset;
   static var _instance;
   var DELAY_BEFORE_SHOW_MESSAGE = 0.5;
   function ToolTipMessageManager()
   {
      super();
      trace("[ToolTipMessageManager] constructor");
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
      if(com.poptropica.sections.quidget.ToolTipMessageManager._instance == undefined)
      {
         com.poptropica.sections.quidget.ToolTipMessageManager._instance = new com.poptropica.sections.quidget.ToolTipMessageManager();
         mx.events.EventDispatcher.initialize(com.poptropica.sections.quidget.ToolTipMessageManager._instance);
      }
      return com.poptropica.sections.quidget.ToolTipMessageManager._instance;
   }
   function set container(mc)
   {
      this._container = mc;
      this._msg = this._container.attachMovie("toolTipMessageAsset","ToolTipMessage",this._container.getNextHighestDepth());
      this._msg.onEnterFrame = Delegate.create(this,this.update);
      this._msg._visible = false;
   }
   function update()
   {
      if(this._msg._visible)
      {
         if(this._objOver)
         {
            this.updateLoc();
         }
      }
   }
   function setMessage(o, str, offset)
   {
      this._msg._visible = false;
      this._objOver = o;
      this._str = str;
      this._offset = offset;
      if(this._offset == undefined)
      {
         this._offset = new flash.geom.Point(55,-5);
      }
      com.greensock.TweenMax.killDelayedCallsTo(this.draw);
      com.greensock.TweenMax.delayedCall(this.DELAY_BEFORE_SHOW_MESSAGE,this.draw,[this._objOver],this);
   }
   function updateLoc()
   {
      var _loc2_ = new flash.geom.Point(0,0);
      this._objOver.localToGlobal(_loc2_);
      this._container.globalToLocal(_loc2_);
      this._msg._x = _loc2_.x + this._offset.x;
      this._msg._y = _loc2_.y + this._offset.y;
   }
   function draw(_prevObj)
   {
      if(!this._container._visible)
      {
         return undefined;
      }
      if(this._objOver == _prevObj)
      {
         this._msg._visible = true;
         var _loc2_ = this._msg.tf;
         _loc2_.text = this._str;
         _loc2_._y = - _loc2_.textHeight - 10;
         this._msg.mcBubble._height = _loc2_.textHeight + 10;
         this._msg.mcBubble._width = _loc2_.textWidth + 25;
         this.updateLoc();
         com.greensock.TweenMax.to(this._msg,0.3,{_alpha:100});
      }
   }
   function clear()
   {
      this._msg._visible = false;
      this._objOver = null;
   }
   function objRollout(o)
   {
      if(this._objOver == o)
      {
         this._msg._visible = false;
         this._objOver = undefined;
      }
   }
   function kill(mc)
   {
   }
   function enable()
   {
      this._container._visible = true;
   }
   function disable()
   {
      this.clear();
      this._container._visible = false;
   }
}
