class com.greensock.TweenMax extends com.greensock.TweenLite
{
   var _cyclesComplete;
   var yoyo;
   var vars;
   var _repeat;
   var _repeatDelay;
   var cacheIsDirty;
   var target;
   var cachedTimeScale;
   var cachedPT1;
   var _hasPlugins;
   var propTweenLookup;
   var ratio;
   var timeline;
   var cachedStartTime;
   var gc;
   var initted;
   var cachedTime;
   var cachedDuration;
   var cachedTotalDuration;
   var cachedTotalTime;
   var _rawPrevTime;
   var active;
   var cachedReversed;
   var cachedPaused;
   var _ease;
   var _hasUpdate;
   var _pauseTime;
   static var version = 11.37;
   static var _activatedPlugins = com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.AutoAlphaPlugin,com.greensock.plugins.EndArrayPlugin,com.greensock.plugins.FramePlugin,com.greensock.plugins.RemoveTintPlugin,com.greensock.plugins.TintPlugin,com.greensock.plugins.VisiblePlugin,com.greensock.plugins.VolumePlugin,com.greensock.plugins.BevelFilterPlugin,com.greensock.plugins.BezierPlugin,com.greensock.plugins.BezierThroughPlugin,com.greensock.plugins.BlurFilterPlugin,com.greensock.plugins.ColorMatrixFilterPlugin,com.greensock.plugins.ColorTransformPlugin,com.greensock.plugins.DropShadowFilterPlugin,com.greensock.plugins.FrameLabelPlugin,com.greensock.plugins.GlowFilterPlugin,com.greensock.plugins.HexColorsPlugin,com.greensock.plugins.RoundPropsPlugin,com.greensock.plugins.ShortRotationPlugin,{}]);
   static var _overwriteMode = !com.greensock.OverwriteManager.enabled ? com.greensock.OverwriteManager.init(2) : com.greensock.OverwriteManager.mode;
   static var killTweensOf = com.greensock.TweenLite.killTweensOf;
   static var killDelayedCallsTo = com.greensock.TweenLite.killTweensOf;
   function TweenMax(target, duration, vars)
   {
      super(target,duration,vars);
      if(com.greensock.TweenLite.version < 11.2)
      {
         trace("TweenMax warning: Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
      }
      this._cyclesComplete = 0;
      this.yoyo = Boolean(this.vars.yoyo);
      this._repeat = this.vars.repeat || 0;
      this._repeatDelay = this.vars.repeatDelay || 0;
      this.cacheIsDirty = true;
      if(this.vars.timeScale != undefined && !(this.target instanceof com.greensock.core.TweenCore))
      {
         this.cachedTimeScale = this.vars.timeScale;
      }
   }
   function init()
   {
      if(this.vars.startAt)
      {
         this.vars.startAt.overwrite = 0;
         this.vars.startAt.immediateRender = true;
         var _loc10_ = new com.greensock.TweenMax(this.target,0,this.vars.startAt);
      }
      super.init();
      if(this.vars.roundProps && com.greensock.TweenLite.plugins.roundProps)
      {
         var _loc11_ = undefined;
         var _loc4_ = undefined;
         var _loc6_ = undefined;
         var _loc9_ = this.vars.roundProps;
         var _loc5_ = undefined;
         var _loc7_ = undefined;
         var _loc3_ = undefined;
         var _loc8_ = _loc9_.length;
         while((_loc8_ = _loc8_ - 1) > -1)
         {
            _loc4_ = _loc9_[_loc8_];
            _loc3_ = this.cachedPT1;
            while(_loc3_)
            {
               if(_loc3_.name == _loc4_)
               {
                  if(_loc3_.isPlugin)
                  {
                     _loc3_.target.round = true;
                  }
                  else
                  {
                     if(_loc5_ == undefined)
                     {
                        _loc5_ = new com.greensock.TweenLite.plugins.roundProps();
                        _loc5_.add(_loc3_.target,_loc4_,_loc3_.start,_loc3_.change);
                        this._hasPlugins = true;
                        this.cachedPT1 = _loc7_ = this.insertPropTween(_loc5_,"changeFactor",0,1,"_MULTIPLE_",true,this.cachedPT1);
                     }
                     else
                     {
                        _loc5_.add(_loc3_.target,_loc4_,_loc3_.start,_loc3_.change);
                     }
                     this.removePropTween(_loc3_);
                     this.propTweenLookup[_loc4_] = _loc7_;
                  }
               }
               else if(_loc3_.isPlugin && _loc3_.name == "_MULTIPLE_" && !_loc3_.target.round)
               {
                  _loc6_ = " " + _loc3_.target.overwriteProps.join(" ") + " ";
                  if(_loc6_.indexOf(" " + _loc4_ + " ") != -1)
                  {
                     _loc3_.target.round = true;
                  }
               }
               _loc3_ = _loc3_.nextNode;
            }
         }
      }
   }
   function insertPropTween(target, property, start, end, name, isPlugin, nextNode)
   {
      var _loc3_ = new com.greensock.core.PropTween(target,property,start,typeof end != "number" ? Number(end) : Number(end) - start,name,isPlugin,nextNode);
      if(isPlugin && name == "_MULTIPLE_")
      {
         var _loc2_ = target.overwriteProps.length;
         while((_loc2_ = _loc2_ - 1) > -1)
         {
            this.propTweenLookup[target.overwriteProps[_loc2_]] = _loc3_;
         }
      }
      else
      {
         this.propTweenLookup[name] = _loc3_;
      }
      return _loc3_;
   }
   function removePropTween(propTween)
   {
      if(propTween.nextNode)
      {
         propTween.nextNode.prevNode = propTween.prevNode;
      }
      if(propTween.prevNode)
      {
         propTween.prevNode.nextNode = propTween.nextNode;
      }
      else if(this.cachedPT1 == propTween)
      {
         this.cachedPT1 = propTween.nextNode;
      }
      if(propTween.isPlugin && propTween.target.onDisable)
      {
         propTween.target.onDisable();
         if(propTween.target.activeDisable)
         {
            return true;
         }
      }
      return false;
   }
   function invalidate()
   {
      this.yoyo = Boolean(this.vars.yoyo);
      this._repeat = this.vars.repeat || 0;
      this._repeatDelay = this.vars.repeatDelay || 0;
      this.setDirtyCache(true);
      super.invalidate();
   }
   function updateTo(vars, resetDuration)
   {
      var _loc8_ = this.ratio;
      if(resetDuration && this.timeline != undefined && this.cachedStartTime < this.timeline.cachedTime)
      {
         this.cachedStartTime = this.timeline.cachedTime;
         this.setDirtyCache(false);
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else
         {
            this.timeline.addChild(this);
         }
      }
      for(var _loc6_ in vars)
      {
         this.vars[_loc6_] = vars[_loc6_];
      }
      if(this.initted)
      {
         this.initted = false;
         if(!resetDuration)
         {
            this.init();
            if(!resetDuration && this.cachedTime > 0 && this.cachedTime < this.cachedDuration)
            {
               var _loc5_ = 1 / (1 - _loc8_);
               var _loc2_ = this.cachedPT1;
               var _loc3_ = undefined;
               while(_loc2_)
               {
                  _loc3_ = _loc2_.start + _loc2_.change;
                  _loc2_.change *= _loc5_;
                  _loc2_.start = _loc3_ - _loc2_.change;
                  _loc2_ = _loc2_.nextNode;
               }
            }
         }
      }
   }
   function setDestination(property, value, adjustStartValues)
   {
      var _loc2_ = {};
      _loc2_[property] = value;
      this.updateTo(_loc2_,Boolean(adjustStartValues != false));
   }
   function killProperties(names)
   {
      var _loc3_ = {};
      var _loc2_ = names.length;
      while((_loc2_ = _loc2_ - 1) > -1)
      {
         _loc3_[names[_loc2_]] = true;
      }
      this.killVars(_loc3_);
   }
   function renderTime(time, suppressEvents, force)
   {
      var _loc9_ = !this.cacheIsDirty ? this.cachedTotalDuration : this.totalDuration;
      var _loc7_ = this.cachedTime;
      var _loc5_ = undefined;
      var _loc10_ = undefined;
      var _loc6_ = undefined;
      if(time >= _loc9_)
      {
         this.cachedTotalTime = _loc9_;
         this.cachedTime = this.cachedDuration;
         this.ratio = 1;
         _loc5_ = true;
         if(this.cachedDuration == 0)
         {
            if((time == 0 || this._rawPrevTime < 0) && this._rawPrevTime != time)
            {
               force = true;
            }
            this._rawPrevTime = time;
         }
      }
      else if(time <= 0)
      {
         if(time < 0)
         {
            this.active = false;
            if(this.cachedDuration == 0)
            {
               if(this._rawPrevTime > 0)
               {
                  force = true;
                  _loc5_ = true;
               }
               this._rawPrevTime = time;
            }
         }
         this.cachedTotalTime = this.cachedTime = this.ratio = 0;
         if(this.cachedReversed && _loc7_ != 0)
         {
            _loc5_ = true;
         }
      }
      else
      {
         this.cachedTotalTime = this.cachedTime = time;
         _loc6_ = true;
      }
      if(this._repeat != 0)
      {
         var _loc4_ = this.cachedDuration + this._repeatDelay;
         if(_loc5_)
         {
            if(this.yoyo && this._repeat % 2)
            {
               this.cachedTime = this.ratio = 0;
            }
         }
         else if(time > 0)
         {
            var _loc12_ = this._cyclesComplete;
            this._cyclesComplete = Math.floor(this.cachedTotalTime / _loc4_);
            if(this._cyclesComplete == this.cachedTotalTime / _loc4_)
            {
               this._cyclesComplete = this._cyclesComplete - 1;
            }
            if(_loc12_ != this._cyclesComplete)
            {
               _loc10_ = true;
            }
            this.cachedTime = (this.cachedTotalTime / _loc4_ - this._cyclesComplete) * _loc4_;
            if(this.yoyo && this._cyclesComplete % 2)
            {
               this.cachedTime = this.cachedDuration - this.cachedTime;
            }
            else if(this.cachedTime >= this.cachedDuration)
            {
               this.cachedTime = this.cachedDuration;
               this.ratio = 1;
               _loc6_ = false;
            }
            if(this.cachedTime <= 0)
            {
               this.cachedTime = this.ratio = 0;
               _loc6_ = false;
            }
         }
      }
      if(_loc7_ == this.cachedTime && !force)
      {
         return undefined;
      }
      if(!this.initted)
      {
         this.init();
      }
      if(!this.active && !this.cachedPaused)
      {
         this.active = true;
      }
      if(_loc6_)
      {
         this.ratio = this._ease(this.cachedTime,0,1,this.cachedDuration);
      }
      if(_loc7_ == 0 && this.vars.onStart && this.cachedTotalTime != 0 && !suppressEvents)
      {
         this.vars.onStart.apply(this.vars.onStartScope,this.vars.onStartParams);
      }
      var _loc2_ = this.cachedPT1;
      while(_loc2_)
      {
         _loc2_.target[_loc2_.property] = _loc2_.start + this.ratio * _loc2_.change;
         _loc2_ = _loc2_.nextNode;
      }
      if(this._hasUpdate && !suppressEvents)
      {
         this.vars.onUpdate.apply(this.vars.onUpdateScope,this.vars.onUpdateParams);
      }
      if(_loc5_)
      {
         if(this._hasPlugins && this.cachedPT1)
         {
            com.greensock.TweenLite.onPluginEvent("onComplete",this);
         }
         this.complete(true,suppressEvents);
      }
      else if(_loc10_ && !suppressEvents)
      {
         if(this.vars.onRepeat)
         {
            this.vars.onRepeat.apply(this.vars.onRepeatScope,this.vars.onRepeatParams);
         }
      }
   }
   static function to(target, duration, vars)
   {
      return new com.greensock.TweenMax(target,duration,vars);
   }
   static function from(target, duration, vars)
   {
      vars.runBackwards = true;
      if(vars.immediateRender != false)
      {
         vars.immediateRender = true;
      }
      return new com.greensock.TweenMax(target,duration,vars);
   }
   static function fromTo(target, duration, fromVars, toVars)
   {
      toVars.startAt = fromVars;
      if(fromVars.immediateRender)
      {
         toVars.immediateRender = true;
      }
      return new com.greensock.TweenMax(target,duration,toVars);
   }
   static function allTo(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
   {
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      var _loc1_ = undefined;
      if(stagger == undefined)
      {
         stagger = 0;
      }
      var _loc8_ = targets.length;
      var _loc5_ = [];
      var _loc6_ = vars.delay || 0;
      var onCompleteProxy = vars.onComplete;
      var onCompleteParamsProxy = vars.onCompleteParams;
      var onCompleteScopeProxy = vars.onCompleteScope;
      var _loc9_ = !(stagger <= 0 || stagger == undefined) ? _loc8_ - 1 : 0;
      _loc3_ = 0;
      while(_loc3_ < _loc8_)
      {
         _loc2_ = {};
         for(_loc1_ in vars)
         {
            _loc2_[_loc1_] = vars[_loc1_];
         }
         _loc2_.delay = _loc6_;
         if(_loc3_ == _loc9_ && onCompleteAll != undefined)
         {
            _loc2_.onComplete = function()
            {
               if(onCompleteProxy != undefined)
               {
                  onCompleteProxy.apply(onCompleteScopeProxy,onCompleteParamsProxy);
               }
               onCompleteAll.apply(onCompleteAllScope,onCompleteAllParams);
            };
         }
         _loc5_[_loc5_.length] = new com.greensock.TweenMax(targets[_loc3_],duration,_loc2_);
         _loc6_ += stagger;
         _loc3_ = _loc3_ + 1;
      }
      return _loc5_;
   }
   static function allFrom(targets, duration, vars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
   {
      vars.runBackwards = true;
      if(vars.immediateRender != false)
      {
         vars.immediateRender = true;
      }
      return com.greensock.TweenMax.allTo(targets,duration,vars,stagger,onCompleteAll,onCompleteAllParams,onCompleteAllScope);
   }
   static function allFromTo(targets, duration, fromVars, toVars, stagger, onCompleteAll, onCompleteAllParams, onCompleteAllScope)
   {
      toVars.startAt = fromVars;
      if(fromVars.immediateRender)
      {
         toVars.immediateRender = true;
      }
      return com.greensock.TweenMax.allTo(targets,duration,toVars,stagger,onCompleteAll,onCompleteAllParams,onCompleteAllScope);
   }
   static function delayedCall(delay, onComplete, onCompleteParams, onCompleteScope, useFrames)
   {
      return new com.greensock.TweenMax(onComplete,0,{delay:delay,onComplete:onComplete,onCompleteParams:onCompleteParams,onCompleteScope:onCompleteScope,immediateRender:false,useFrames:useFrames,overwrite:0});
   }
   static function getTweensOf(target)
   {
      var _loc2_ = com.greensock.TweenLite.masterList[target].tweens;
      var _loc3_ = [];
      if(_loc2_)
      {
         var _loc1_ = _loc2_.length;
         while((_loc1_ = _loc1_ - 1) > -1)
         {
            if(!_loc2_[_loc1_].gc)
            {
               _loc3_[_loc3_.length] = _loc2_[_loc1_];
            }
         }
      }
      return _loc3_;
   }
   static function isTweening(target)
   {
      var _loc3_ = com.greensock.TweenMax.getTweensOf(target);
      var _loc2_ = _loc3_.length;
      var _loc1_ = undefined;
      while((_loc2_ = _loc2_ - 1) > -1)
      {
         _loc1_ = _loc3_[_loc2_];
         if(_loc1_.active || _loc1_.cachedStartTime == _loc1_.timeline.cachedTime && _loc1_.timeline.active)
         {
            return true;
         }
      }
      return false;
   }
   static function getAllTweens()
   {
      var _loc5_ = com.greensock.TweenLite.masterList;
      var _loc4_ = 0;
      var _loc3_ = [];
      var _loc2_ = undefined;
      var _loc1_ = undefined;
      for(var _loc6_ in _loc5_)
      {
         _loc2_ = _loc5_[_loc6_].tweens;
         _loc1_ = _loc2_.length;
         while((_loc1_ = _loc1_ - 1) > -1)
         {
            if(!_loc2_[_loc1_].gc)
            {
               _loc3_[_loc4_++] = _loc2_[_loc1_];
            }
         }
      }
      return _loc3_;
   }
   static function killAll(complete, tweens, delayedCalls)
   {
      if(tweens == undefined)
      {
         tweens = true;
      }
      if(delayedCalls == undefined)
      {
         delayedCalls = true;
      }
      var _loc2_ = com.greensock.TweenMax.getAllTweens();
      var _loc3_ = undefined;
      var _loc1_ = _loc2_.length;
      while((_loc1_ = _loc1_ - 1) > -1)
      {
         _loc3_ = _loc2_[_loc1_].target == _loc2_[_loc1_].vars.onComplete;
         if(_loc3_ == delayedCalls || _loc3_ != tweens)
         {
            if(complete == true)
            {
               _loc2_[_loc1_].complete(false,false);
            }
            else
            {
               _loc2_[_loc1_].setEnabled(false,false);
            }
         }
      }
   }
   static function killChildTweensOf(parent, complete)
   {
      var _loc3_ = com.greensock.TweenMax.getAllTweens();
      var _loc4_ = undefined;
      var _loc1_ = undefined;
      var _loc2_ = _loc3_.length;
      while((_loc2_ = _loc2_ - 1) > -1)
      {
         _loc4_ = _loc3_[_loc2_].target;
         if(_loc4_ instanceof MovieClip)
         {
            _loc1_ = _loc4_._parent;
            while(_loc1_)
            {
               if(_loc1_ == parent)
               {
                  if(complete == true)
                  {
                     _loc3_[_loc2_].complete(false,false);
                  }
                  else
                  {
                     _loc3_[_loc2_].setEnabled(false,false);
                  }
               }
               _loc1_ = _loc1_._parent;
            }
         }
      }
   }
   static function pauseAll(tweens, delayedCalls)
   {
      com.greensock.TweenMax.changePause(true,tweens,delayedCalls);
   }
   static function resumeAll(tweens, delayedCalls)
   {
      com.greensock.TweenMax.changePause(false,tweens,delayedCalls);
   }
   static function changePause(pause, tweens, delayedCalls)
   {
      if(tweens == undefined)
      {
         tweens = true;
      }
      if(delayedCalls == undefined)
      {
         delayedCalls = true;
      }
      var _loc2_ = com.greensock.TweenMax.getAllTweens();
      var _loc3_ = undefined;
      var _loc1_ = _loc2_.length;
      while((_loc1_ = _loc1_ - 1) > -1)
      {
         _loc3_ = Boolean(_loc2_[_loc1_].target == _loc2_[_loc1_].vars.onComplete);
         if(_loc3_ == delayedCalls || _loc3_ != tweens)
         {
            _loc2_[_loc1_].paused = pause;
         }
      }
   }
   function get currentProgress()
   {
      return this.cachedTime / this.duration;
   }
   function set currentProgress(n)
   {
      if(this._cyclesComplete == 0)
      {
         this.setTotalTime(this.duration * n,false);
      }
      else
      {
         this.setTotalTime(this.duration * n + this._cyclesComplete * this.cachedDuration,false);
      }
   }
   function get totalProgress()
   {
      return this.cachedTotalTime / this.totalDuration;
   }
   function set totalProgress(n)
   {
      this.setTotalTime(this.totalDuration * n,false);
   }
   function get currentTime()
   {
      return this.cachedTime;
   }
   function set currentTime(n)
   {
      if(this._cyclesComplete != 0)
      {
         if(this.yoyo && this._cyclesComplete % 2 == 1)
         {
            n = this.duration - n + this._cyclesComplete * (this.cachedDuration + this._repeatDelay);
         }
         else
         {
            n += this._cyclesComplete * (this.duration + this._repeatDelay);
         }
      }
      this.setTotalTime(n,false);
   }
   function get totalDuration()
   {
      if(this.cacheIsDirty)
      {
         this.cachedTotalDuration = this._repeat != -1 ? this.cachedDuration * (this._repeat + 1) + this._repeatDelay * this._repeat : 999999999999;
         this.cacheIsDirty = false;
      }
      return this.cachedTotalDuration;
   }
   function set totalDuration(n)
   {
      if(this._repeat == -1)
      {
         return;
      }
      this.duration = (n - this._repeat * this._repeatDelay) / (this._repeat + 1);
   }
   function get timeScale()
   {
      return this.cachedTimeScale;
   }
   function set timeScale(n)
   {
      if(n == 0)
      {
         n = 0.0001;
      }
      var _loc3_ = !(this._pauseTime || this._pauseTime == 0) ? this.timeline.cachedTotalTime : this._pauseTime;
      this.cachedStartTime = _loc3_ - (_loc3_ - this.cachedStartTime) * this.cachedTimeScale / n;
      this.cachedTimeScale = n;
      this.setDirtyCache(false);
   }
   function get repeat()
   {
      return this._repeat;
   }
   function set repeat(n)
   {
      this._repeat = n;
      this.setDirtyCache(true);
   }
   function get repeatDelay()
   {
      return this._repeatDelay;
   }
   function set repeatDelay(n)
   {
      this._repeatDelay = n;
      this.setDirtyCache(true);
   }
   static function get globalTimeScale()
   {
      return com.greensock.TweenLite.rootTimeline != undefined ? com.greensock.TweenLite.rootTimeline.cachedTimeScale : 1;
   }
   static function set globalTimeScale(n)
   {
      if(n == 0)
      {
         n = 0.0001;
      }
      if(com.greensock.TweenLite.rootTimeline == undefined)
      {
         com.greensock.TweenLite.to({},0,{});
      }
      var _loc1_ = com.greensock.TweenLite.rootTimeline;
      var _loc2_ = getTimer() * 0.001;
      _loc1_.cachedStartTime = _loc2_ - (_loc2_ - _loc1_.cachedStartTime) * _loc1_.cachedTimeScale / n;
      _loc1_ = com.greensock.TweenLite.rootFramesTimeline;
      _loc2_ = com.greensock.TweenLite.rootFrame;
      _loc1_.cachedStartTime = _loc2_ - (_loc2_ - _loc1_.cachedStartTime) * _loc1_.cachedTimeScale / n;
      com.greensock.TweenLite.rootFramesTimeline.cachedTimeScale = com.greensock.TweenLite.rootTimeline.cachedTimeScale = n;
   }
}
