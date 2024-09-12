class com.poptropica.views.PointerView extends com.poptropica.mvc.AbstractView
{
   var _pointer_container_mc;
   var _pointer_mc;
   var _model;
   static var instance;
   var _clickWait = 0;
   function PointerView(m, c, pTarget, pDepth)
   {
      super(m,c);
      com.poptropica.util.Debug.trace("PointerView::() pTarget=" + pTarget + " pDepth=" + pDepth,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.views.PointerView.instance = this;
      this._pointer_container_mc = pTarget.createEmptyMovieClip("pointer_ctn_mc",pDepth);
      this.make();
   }
   static function getInstance()
   {
      return com.poptropica.views.PointerView.instance;
   }
   function update(o, pInfoObj)
   {
      com.poptropica.util.Debug.trace("PointerView::update()  pInfoObj._type=" + pInfoObj._type,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      switch(pInfoObj._type)
      {
         case com.poptropica.models.PopUpdateNotificationTypes.BUILD:
         case com.poptropica.models.PopUpdateNotificationTypes.GAMEPLAY_LOADED:
      }
   }
   function changePointerDisplay(pState)
   {
      this._pointer_mc.gotoAndStop(pState);
   }
   function get pointer_mc()
   {
      return this._pointer_mc;
   }
   function make()
   {
      com.poptropica.util.Debug.trace("PointerView::make() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      Mouse.hide();
      this._pointer_mc = this._pointer_container_mc.attachMovie("LibPointer","pointer_mc",1);
      this.ptOnEnterFrance();
      this._pointer_mc.onEnterFrame = com.poptropica.util.EventDelegate.create(this,this.ptOnEnterFrance);
   }
   function ptOnEnterFrance()
   {
      this._clickWait = this._clickWait + 1;
      this._pointer_mc._x = _xmouse;
      this._pointer_mc._y = _ymouse;
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc7_ = undefined;
      var _loc6_ = undefined;
      var _loc2_ = com.poptropica.models.PopModel(this._model).rt_mc.gameplay_container_mc.camera;
      var _loc3_ = Boolean(_loc2_ && _loc2_.scene.char.coordinates.x);
      if(_loc3_)
      {
         _loc5_ = this._pointer_mc._x - _loc2_.scene.char.coordinates.x;
         _loc4_ = this._pointer_mc._y - _loc2_.scene.char.coordinates.y;
         this.updateDirectionalBasedOnDistanceFromChar(_loc5_,_loc4_);
      }
   }
   function updateDirectionalBasedOnDistanceFromChar(delX, delY)
   {
      var _loc4_ = Math.atan((delY + 50) / delX) * 180 / 3.141592653589793;
      var _loc5_ = Math.sqrt(delX * delX + (delY + 65) * (delY + 65));
      if(delX >= 0)
      {
         _loc4_ += 180;
      }
      if(delX < 60 && delX > -60 && delY < -10 && delY > -120)
      {
         this._pointer_mc.directional.gotoAndStop("none");
         this._pointer_mc.directional._rotation = _loc4_;
      }
      else if(delY < -120)
      {
         this._pointer_mc.directional.gotoAndStop("up");
         this._pointer_mc.directional._rotation = _loc4_;
         this._pointer_mc.directional.base._xscale = 0 + _loc5_;
      }
      else if(delY > -10)
      {
         this._pointer_mc.directional.gotoAndStop("down");
         this._pointer_mc.directional._rotation = _loc4_;
      }
      else
      {
         this._pointer_mc.directional.gotoAndStop("side");
         if(delX >= 0)
         {
            this._pointer_mc.directional._rotation = 180;
         }
         else
         {
            this._pointer_mc.directional._rotation = 0;
         }
         this._pointer_mc.directional.base._xscale = 0 + _loc5_;
      }
      if(this._pointer_mc.directional.base._xscale > 700)
      {
         this._pointer_mc.directional.base._xscale = 700;
      }
   }
   function clear()
   {
      com.poptropica.util.Debug.trace("PointerView::clear()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._model.removeObserver(this);
   }
}
