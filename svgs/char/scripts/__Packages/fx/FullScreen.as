class fx.FullScreen
{
   static var mClips = new Array();
   static var mShakeStates = [10,-10];
   static var mShakeState = 0;
   static var mShakeTime = 0.2;
   static var mContainer = null;
   function FullScreen()
   {
   }
   static function colorScreen(scope, color, alpha, id)
   {
      if(id == undefined)
      {
         id = 0;
      }
      if(fx.FullScreen.mContainer == null)
      {
         fx.FullScreen.mContainer = scope.createEmptyMovieClip("overlays",scope.getNextHighestDepth());
      }
      var _loc3_ = fx.FullScreen.mContainer.getNextHighestDepth();
      var _loc2_ = fx.FullScreen.mContainer.createEmptyMovieClip("overlay" + _loc3_,_loc3_);
      _loc2_.beginFill(color,alpha);
      _loc2_.moveTo(scope._x,scope._y);
      _loc2_.lineTo(scope._width,scope._y);
      _loc2_.lineTo(scope._width,scope._height);
      _loc2_.lineTo(scope._x,scope._height);
      fx.FullScreen.mClips[id] = _loc2_;
   }
   static function clear(id)
   {
      if(id != undefined)
      {
         if(fx.FullScreen.mClips[id])
         {
            fx.FullScreen.mClips[id].removeMovieClip();
            fx.FullScreen.mClips[id] = null;
         }
      }
      else
      {
         fx.FullScreen.mContainer.removeMovieClip();
         fx.FullScreen.mClips = new Array();
         fx.FullScreen.mContainer = null;
      }
   }
   static function fadeColorScreen(fadeIn, fadeTime, fadeDelay, id, scope, color, alpha)
   {
      var _loc1_ = undefined;
      if(id == undefined)
      {
         id = 0;
      }
      if(scope != undefined)
      {
         fx.FullScreen.colorScreen(scope,color,alpha,id);
      }
      _loc1_ = fx.FullScreen.mClips[id];
      if(fadeDelay == 0)
      {
         fadeDelay = 0;
      }
      if(fadeIn == undefined)
      {
         fadeIn = true;
      }
      if(fadeTime == undefined)
      {
         fadeTime = 0.2;
      }
      var _loc2_ = undefined;
      if(fadeIn)
      {
         _loc1_._alpha = 0;
         _loc2_ = 100;
         caurina.transitions.Tweener.addTween(_loc1_,{_alpha:_loc2_,delay:fadeDelay,time:fadeTime,transition:"linear"});
      }
      else
      {
         _loc1_._alpha = 100;
         _loc2_ = 0;
         caurina.transitions.Tweener.addTween(_loc1_,{_alpha:_loc2_,delay:fadeDelay,time:fadeTime,transition:"linear",onComplete:mx.utils.Delegate.create(fx.FullScreen,fx.FullScreen.clear),onCompleteParams:[id]});
      }
   }
   static function shake(shakeNow, scope, shakePoints, shakeTime, onlyOnce)
   {
      if(shakeNow == undefined)
      {
         shakeNow = true;
      }
      if(shakeTime != undefined)
      {
         fx.FullScreen.mShakeTime = shakeTime;
      }
      if(shakePoints != undefined)
      {
         fx.FullScreen.mShakeStates = shakePoints;
      }
      if(shakeNow)
      {
         var _loc2_ = fx.FullScreen.mShakeStates[fx.FullScreen.mShakeState];
         fx.FullScreen.mShakeState = fx.FullScreen.mShakeState + 1;
         if(fx.FullScreen.mShakeState == fx.FullScreen.mShakeStates.length)
         {
            fx.FullScreen.mShakeState = 0;
         }
         if(onlyOnce)
         {
            var _loc9_ = 0;
            for(var _loc5_ in shakePoints)
            {
               _loc2_ = shakePoints[_loc5_];
               caurina.transitions.Tweener.addTween(scope,{_y:scope._y + _loc2_,delay:_loc9_,time:fx.FullScreen.mShakeTime,transition:"linear"});
               _loc9_ += shakeTime;
            }
            caurina.transitions.Tweener.addTween(scope,{_y:0,time:fx.FullScreen.mShakeTime,delay:_loc9_,transition:"linear"});
         }
         else
         {
            caurina.transitions.Tweener.addTween(scope,{_y:scope._y + _loc2_,time:fx.FullScreen.mShakeTime,transition:"linear",onComplete:mx.utils.Delegate.create(fx.FullScreen,fx.FullScreen.shake),onCompleteParams:[true,scope]});
         }
      }
      else
      {
         scope._y = 0;
         caurina.transitions.Tweener.removeTweens(scope);
      }
   }
}
