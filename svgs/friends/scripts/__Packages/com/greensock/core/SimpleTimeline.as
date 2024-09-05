class com.greensock.core.SimpleTimeline extends com.greensock.core.TweenCore
{
   var _firstChild;
   var _lastChild;
   var cachedTotalTime;
   var cachedTime;
   function SimpleTimeline(vars)
   {
      super(0,vars);
   }
   function addChild(tween)
   {
      if(!tween.cachedOrphan && tween.timeline != undefined)
      {
         tween.timeline.remove(tween,true);
      }
      tween.timeline = this;
      if(tween.gc)
      {
         tween.setEnabled(true,true);
      }
      if(this._firstChild)
      {
         this._firstChild.prevNode = tween;
      }
      tween.nextNode = this._firstChild;
      this._firstChild = tween;
      tween.prevNode = undefined;
      tween.cachedOrphan = false;
   }
   function remove(tween, skipDisable)
   {
      if(tween.cachedOrphan)
      {
         return undefined;
      }
      if(skipDisable != true)
      {
         tween.setEnabled(false,true);
      }
      if(tween.nextNode)
      {
         tween.nextNode.prevNode = tween.prevNode;
      }
      else if(this._lastChild == tween)
      {
         this._lastChild = tween.prevNode;
      }
      if(tween.prevNode)
      {
         tween.prevNode.nextNode = tween.nextNode;
      }
      else if(this._firstChild == tween)
      {
         this._firstChild = tween.nextNode;
      }
      tween.cachedOrphan = true;
   }
   function renderTime(time, suppressEvents, force)
   {
      var _loc2_ = this._firstChild;
      var _loc4_ = undefined;
      var _loc5_ = undefined;
      this.cachedTotalTime = time;
      this.cachedTime = time;
      while(_loc2_)
      {
         _loc5_ = _loc2_.nextNode;
         if(_loc2_.active || time >= _loc2_.cachedStartTime && !_loc2_.cachedPaused && !_loc2_.gc)
         {
            if(!_loc2_.cachedReversed)
            {
               _loc2_.renderTime((time - _loc2_.cachedStartTime) * _loc2_.cachedTimeScale,suppressEvents,false);
            }
            else
            {
               _loc4_ = !_loc2_.cacheIsDirty ? _loc2_.cachedTotalDuration : _loc2_.totalDuration;
               _loc2_.renderTime(_loc4_ - (time - _loc2_.cachedStartTime) * _loc2_.cachedTimeScale,suppressEvents,false);
            }
         }
         _loc2_ = _loc5_;
      }
   }
   function get rawTime()
   {
      return this.cachedTotalTime;
   }
}
