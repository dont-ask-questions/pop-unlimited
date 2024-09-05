class com.greensock.core.TweenCore
{
   var vars;
   var cachedDuration;
   var cachedTotalDuration;
   var _delay;
   var cachedTimeScale;
   var active;
   var cachedTotalTime;
   var cachedTime;
   var data;
   var gc;
   var initted;
   var cacheIsDirty;
   var cachedPaused;
   var cachedReversed;
   var _rawPrevTime;
   var cachedStartTime;
   var timeline;
   var cachedOrphan;
   var _pauseTime;
   static var _classInitted;
   static var version = 1.382;
   function TweenCore(duration, vars)
   {
      this.vars = vars || {};
      this.cachedDuration = this.cachedTotalDuration = duration || 0;
      this._delay = Number(this.vars.delay) || 0;
      this.cachedTimeScale = this.vars.timeScale || 1;
      this.active = Boolean(duration == 0 && this._delay == 0 && this.vars.immediateRender != false);
      this.cachedTotalTime = this.cachedTime = 0;
      this.data = this.vars.data;
      this.gc = this.initted = this.cacheIsDirty = this.cachedPaused = this.cachedReversed = false;
      this._rawPrevTime = -1;
      if(!com.greensock.core.TweenCore._classInitted)
      {
         if(!(com.greensock.TweenLite.rootFrame == undefined && com.greensock.TweenLite.initClass != undefined))
         {
            return;
         }
         com.greensock.TweenLite.initClass();
         com.greensock.core.TweenCore._classInitted = true;
      }
      var _loc2_ = !(this.vars.timeline instanceof com.greensock.core.SimpleTimeline) ? (this.vars.useFrames != true ? com.greensock.TweenLite.rootTimeline : com.greensock.TweenLite.rootFramesTimeline) : this.vars.timeline;
      this.cachedStartTime = _loc2_.cachedTotalTime + this._delay;
      _loc2_.addChild(this);
      if(this.vars.reversed)
      {
         this.cachedReversed = true;
      }
      if(this.vars.paused)
      {
         this.paused = true;
      }
   }
   function play()
   {
      this.reversed = false;
      this.paused = false;
   }
   function pause()
   {
      this.paused = true;
   }
   function resume()
   {
      this.paused = false;
   }
   function restart(includeDelay, suppressEvents)
   {
      this.reversed = false;
      this.paused = false;
      this.setTotalTime(!includeDelay ? 0 : - this._delay,Boolean(suppressEvents != false));
   }
   function reverse(forceResume)
   {
      this.reversed = true;
      if(forceResume != false)
      {
         this.paused = false;
      }
      else if(this.gc)
      {
         this.setEnabled(true,false);
      }
   }
   function renderTime(time, suppressEvents, force)
   {
   }
   function complete(skipRender, suppressEvents)
   {
      if(!skipRender)
      {
         this.renderTime(this.totalDuration,suppressEvents,false);
         return undefined;
      }
      if(this.timeline.autoRemoveChildren)
      {
         this.setEnabled(false,false);
      }
      else
      {
         this.active = false;
      }
      if(!suppressEvents)
      {
         if(this.vars.onComplete && this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed)
         {
            this.vars.onComplete.apply(this.vars.onCompleteScope,this.vars.onCompleteParams);
         }
         else if(this.cachedReversed && this.cachedTotalTime == 0 && this.vars.onReverseComplete)
         {
            this.vars.onReverseComplete.apply(this.vars.onReverseCompleteScope,this.vars.onReverseCompleteParams);
         }
      }
   }
   function invalidate()
   {
   }
   function setEnabled(enabled, ignoreTimeline)
   {
      this.gc = !enabled;
      if(enabled)
      {
         this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
         if(ignoreTimeline != true && this.cachedOrphan)
         {
            this.timeline.addChild(this);
         }
      }
      else
      {
         this.active = false;
         if(ignoreTimeline != true)
         {
            this.timeline.remove(this,true);
         }
      }
      return false;
   }
   function kill()
   {
      this.setEnabled(false,false);
   }
   function setDirtyCache(includeSelf)
   {
      var _loc2_ = includeSelf == false ? this.timeline : this;
      while(_loc2_)
      {
         _loc2_.cacheIsDirty = true;
         _loc2_ = _loc2_.timeline;
      }
   }
   function setTotalTime(time, suppressEvents)
   {
      if(this.timeline)
      {
         var _loc3_ = !(this._pauseTime || this._pauseTime == 0) ? this.timeline.cachedTotalTime : this._pauseTime;
         if(this.cachedReversed)
         {
            var _loc4_ = !this.cacheIsDirty ? this.cachedTotalDuration : this.totalDuration;
            this.cachedStartTime = _loc3_ - (_loc4_ - time) / this.cachedTimeScale;
         }
         else
         {
            this.cachedStartTime = _loc3_ - time / this.cachedTimeScale;
         }
         if(!this.timeline.cacheIsDirty)
         {
            this.setDirtyCache(false);
         }
         if(this.cachedTotalTime != time)
         {
            this.renderTime(time,suppressEvents,false);
         }
      }
   }
   function get delay()
   {
      return this._delay;
   }
   function set delay(n)
   {
      this.startTime += n - this._delay;
      this._delay = n;
   }
   function get duration()
   {
      return this.cachedDuration;
   }
   function set duration(n)
   {
      this.cachedDuration = this.cachedTotalDuration = n;
      this.setDirtyCache(false);
   }
   function get totalDuration()
   {
      return this.cachedTotalDuration;
   }
   function set totalDuration(n)
   {
      this.duration = n;
   }
   function get currentTime()
   {
      return this.cachedTime;
   }
   function set currentTime(n)
   {
      this.setTotalTime(n,false);
   }
   function get totalTime()
   {
      return this.cachedTotalTime;
   }
   function set totalTime(n)
   {
      this.setTotalTime(n,false);
   }
   function get startTime()
   {
      return this.cachedStartTime;
   }
   function set startTime(n)
   {
      var _loc2_ = Boolean(this.timeline != undefined && (n != this.cachedStartTime || this.gc));
      this.cachedStartTime = n;
      if(_loc2_)
      {
         this.timeline.addChild(this);
      }
   }
   function get reversed()
   {
      return this.cachedReversed;
   }
   function set reversed(b)
   {
      if(b != this.cachedReversed)
      {
         this.cachedReversed = b;
         this.setTotalTime(this.cachedTotalTime,true);
      }
   }
   function get paused()
   {
      return this.cachedPaused;
   }
   function set paused(b)
   {
      if(b != this.cachedPaused && this.timeline)
      {
         if(b)
         {
            this._pauseTime = this.timeline.rawTime;
         }
         else
         {
            this.cachedStartTime += this.timeline.rawTime - this._pauseTime;
            this._pauseTime = NaN;
            this.setDirtyCache(false);
         }
         this.cachedPaused = b;
         this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
      }
      if(!b && this.gc)
      {
         this.setTotalTime(this.cachedTotalTime,false);
         this.setEnabled(true,false);
      }
   }
}
