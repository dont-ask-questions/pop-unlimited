class ActivityTimer
{
   var mScope;
   var mContainer;
   var mLSO;
   var mEvents;
   var mValidScenes;
   var mTimerInterval;
   var mInitialTime = 0;
   var mInactivityTime = 0;
   var mTotalInactivity = 0;
   var mTimerStarted = false;
   var mInactivityTimeLimit = 5000;
   var mTotalEventDisplays = 0;
   var mShowTimerDisplays = false;
   var UPDATE_TIME = 1000;
   function ActivityTimer(scope)
   {
      _root.logWWW("ActivityTimer :: _root.desc:" + _root.desc);
      if(_root.desc != "GlobalAS3Embassy")
      {
         this.mScope = scope;
         this.mContainer = this.mScope.createEmptyMovieClip("timerClip",this.mScope.getNextHighestDepth());
         this.mLSO = SharedObject.getLocal("ActivityTimer","/");
         this.mEvents = new Array();
         this.mValidScenes = new Array();
         if(utils.Utils.isNull(this.mLSO.data.eventData) || utils.Utils.isNull(this.mLSO.data.totalTime))
         {
            this.clearData();
         }
         else if(!utils.Utils.isNull(this.mLSO.data.eventData))
         {
            this.setEventData(this.mLSO.data.eventData);
            if(!utils.Utils.isNull(this.mLSO.data.validScenes))
            {
               this.mValidScenes = this.mLSO.data.validScenes;
            }
            this.start(Number(this.mLSO.data.totalTime));
         }
      }
   }
   function showDebug(showNow)
   {
      this.showTimerDisplays(showNow);
   }
   function clearData()
   {
      if(this.mTimerStarted)
      {
         this.end();
      }
      this.mLSO.clear();
   }
   function destroy()
   {
      this.showTimerDisplays(false);
      this.mContainer = null;
      this.mScope = null;
      this.mEvents = null;
   }
   function addScene(scene)
   {
      if(!utils.ArrayUtils.searchArray(scene,this.mValidScenes))
      {
         trace("ActivityTimer : adding scene to timer scope : " + scene);
         this.mValidScenes.push(scene);
         this.saveTimerData();
      }
      else
      {
         trace("ActivityTimer : " + scene + " already exists in timer scope.");
      }
   }
   function setEventData(eventData)
   {
      this.mEvents = eventData.slice();
      trace("ActivityTimer : " + this.mEvents.length + " event(s) recovered.");
      for(var _loc2_ in this.mEvents)
      {
         trace("ActivityTimer ***Event " + _loc2_ + "***\nActivityTimer begin : " + this.mEvents[_loc2_].event.begin + "\nActivityTimer end : " + this.mEvents[_loc2_].event.end + "\nActivityTimer start : " + this.mEvents[_loc2_].start + "\nActivityTimer kill : " + this.mEvents[_loc2_].event.kill);
      }
      var _loc3_ = this.getActiveEvents();
      if(this.mShowTimerDisplays && _loc3_.length > 0)
      {
         this.showTimerDisplays(false);
         this.showTimerDisplays(true);
      }
   }
   function saveTimerData()
   {
      this.mLSO.data.eventData = this.getEventData();
      this.mLSO.data.totalTime = this.getTime();
      if(this.mValidScenes.length > 0)
      {
         this.mLSO.data.validScenes = this.mValidScenes;
      }
      this.mLSO.flush();
   }
   function getEventData()
   {
      var _loc5_ = new Array();
      var _loc3_ = undefined;
      var _loc4_ = 0;
      while(_loc4_ < this.mEvents.length)
      {
         _loc3_ = this.mEvents[_loc4_];
         var _loc2_ = new Object();
         _loc2_.event = new Object();
         _loc2_.event.begin = _loc3_.event.begin;
         _loc2_.event.end = _loc3_.event.end;
         _loc2_.event.kill = _loc3_.event.kill;
         _loc2_.started = _loc3_.started;
         _loc2_.start = _loc3_.start;
         _loc2_.campaign = _loc3_.campaign;
         _loc2_.choice = _loc3_.choice;
         _loc2_.persist = _loc3_.persist;
         _loc2_.onlyTrackOnComplete = _loc3_.onlyTrackOnComplete;
         _loc5_.push(_loc2_);
         _loc4_ = _loc4_ + 1;
      }
      return _loc5_;
   }
   function start(initialTime)
   {
      if(!this.mTimerStarted)
      {
         this.mTimerStarted = true;
         if(initialTime != undefined)
         {
            this.mInitialTime = initialTime;
         }
         this.mTimerInterval = _global.setInterval(Delegate.create(this,this.update),this.UPDATE_TIME);
         trace("ActivityTimer : init time : " + this.mInitialTime + " mTotalTime : " + (this.mInitialTime + getTimer()) + " getTimer() : " + getTimer());
      }
   }
   function end()
   {
      this.mInitialTime = 0;
      this.mTimerStarted = false;
      _global.clearInterval(this.mTimerInterval);
      trace("ActivityTimer : end");
   }
   function update()
   {
      if(this.mTimerStarted)
      {
         if(this.mShowTimerDisplays)
         {
            this.updateTimerDisplays();
         }
         this.saveTimerData();
      }
      else
      {
         this.end();
      }
   }
   function getTime()
   {
      return this.mInitialTime + getTimer() - this.mTotalInactivity;
   }
   function getTotalTime()
   {
      return this.mInitialTime + getTimer();
   }
   function getTotalInactivity()
   {
      return this.mTotalInactivity;
   }
   function resetInactivityTime()
   {
      this.mInactivityTime = getTimer();
   }
   function checkInactivityTime()
   {
      return getTimer() - this.mInactivityTime;
   }
   function addEvent(campaign, choice, begin, end, kill, persist, onlyTrackOnComplete)
   {
      if(end == undefined)
      {
         end = null;
      }
      if(kill == undefined)
      {
         kill = null;
      }
      if(persist == undefined)
      {
         persist = false;
      }
      if(onlyTrackOnComplete == undefined)
      {
         onlyTrackOnComplete = false;
      }
      var _loc3_ = this.createEventObject(campaign,choice,begin,end,kill,persist,onlyTrackOnComplete);
      if(!this.checkForEvent(_loc3_))
      {
         trace("ActivityTimer :: Adding new event : \nActivityTimer :: begin : " + begin + "\nActivityTimer :: end : " + end);
         this.mEvents.push(_loc3_);
      }
      else
      {
         trace("ActivityTimer :: Event already exists : \nbegin : " + begin + "\nend : " + end);
      }
      this.saveTimerData();
   }
   function getActiveEvents()
   {
      var _loc3_ = undefined;
      var _loc4_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this.mEvents.length)
      {
         _loc3_ = this.mEvents[_loc2_];
         if(_loc3_.started)
         {
            _loc4_.push(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function checkForEvent(eventData)
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.mEvents.length)
      {
         _loc3_ = this.mEvents[_loc2_];
         if(this.checkEquality(eventData,_loc3_))
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function removeEvent(eventData)
   {
      var _loc3_ = undefined;
      var _loc4_ = this.mEvents.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.mEvents[_loc2_];
         if(this.checkEquality(eventData,_loc3_))
         {
            this.mEvents.splice(_loc2_,1);
            trace("ActivityTimer :: Event Removed : \nActivityTimer :: begin : " + _loc3_.event.begin.toString() + "\nActivityTimer :: end : " + _loc3_.event.end.toString());
            trace("ActivityTimer :: Events Remaining : " + this.mEvents.length);
         }
         _loc2_ = _loc2_ + 1;
      }
      this.saveTimerData();
   }
   function checkEquality(event1, event2)
   {
      if(utils.Utils.isNull(event1.event.end) && utils.Utils.isNull(event2.event.end))
      {
         return this.checkEventMatch(event1.event.begin,event2.event.begin);
      }
      return this.checkEventMatch(event1.event.begin,event2.event.begin) && this.checkEventMatch(event1.event.end,event2.event.end);
   }
   function checkEvent(event)
   {
      var _loc2_ = undefined;
      var _loc5_ = this.mEvents.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         _loc2_ = this.mEvents[_loc3_];
         if(this.checkEventMatch(_loc2_.event.begin,event))
         {
            trace("ActivityTimer :: event match begin : \nActivityTimer :: event : begin : " + _loc2_.event.begin + "\nActivityTimer :: end : " + _loc2_.event.end);
            if(!_loc2_.started)
            {
               this.eventStarted(_loc2_);
            }
         }
         else if(this.checkEventMatch(_loc2_.event.end,event))
         {
            trace("ActivityTimer :: event match end : \nActivityTimer :: event : begin : " + _loc2_.event.begin + "\nActivityTimer :: end : " + _loc2_.event.end);
            if(_loc2_.started)
            {
               this.eventComplete(_loc2_);
            }
         }
         this.checkEventKills(event);
         _loc3_ = _loc3_ + 1;
      }
   }
   function checkEventMatch(event1, event2)
   {
      if(!utils.Utils.isNull(event1) && !utils.Utils.isNull(event2))
      {
         if(typeof event1 == "string" && typeof event2 == "object")
         {
            return this.searchArray(event1,event2);
         }
         if(typeof event2 == "string" && typeof event1 == "object")
         {
            return this.searchArray(event2,event1);
         }
         if(event1.toString() == event2.toString())
         {
            return true;
         }
         return false;
      }
      return false;
   }
   function checkScene(scene)
   {
      if(!utils.Utils.isNull(scene) && this.mValidScenes.length > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < this.mValidScenes.length)
         {
            if(scene.indexOf(this.mValidScenes[_loc2_]) > -1)
            {
               return undefined;
            }
            _loc2_ = _loc2_ + 1;
         }
         trace("ActivityTimer : Scene outside timer scope Loaded : \'" + scene + "\'.  Killing all events.");
         this.killAllEvents();
      }
   }
   function killAllEvents()
   {
      var _loc5_ = undefined;
      var _loc3_ = this.mEvents.slice();
      var _loc4_ = _loc3_.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         this.eventKill(_loc3_[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function showTimerDisplays(showNow)
   {
      if(showNow == undefined)
      {
         showNow = true;
      }
      this.mShowTimerDisplays = showNow;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.mEvents.length)
      {
         _loc3_ = this.mEvents[_loc2_];
         this.showTimerDisplay(_loc3_,showNow);
         _loc2_ = _loc2_ + 1;
      }
   }
   function checkEventKills(event)
   {
      var _loc3_ = undefined;
      var _loc4_ = this.mEvents.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.mEvents[_loc2_];
         if(this.checkEventMatch(_loc3_.event.kill,event))
         {
            this.eventKill(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function showTimerDisplay(eventData, showNow)
   {
      if(showNow == undefined)
      {
         showNow = true;
      }
      if(showNow && !eventData.timerDisplay && eventData.started)
      {
         this.mTotalEventDisplays = this.mTotalEventDisplays + 1;
         var _loc5_ = this.mContainer.getNextHighestDepth();
         var _loc3_ = this.mContainer.attachMovie("timerDisplay","timerDisplay" + _loc5_,_loc5_,{_y:55 * this.mTotalEventDisplays});
         _loc3_.label0.text = eventData.event.begin;
         _loc3_.label1.text = eventData.event.end;
         eventData.timerDisplay = _loc3_;
      }
      else if(!showNow && eventData.timerDisplay)
      {
         eventData.timerDisplay.removeMovieClip();
         eventData.timerDisplay = null;
         if(this.mTotalEventDisplays > 0)
         {
            this.mTotalEventDisplays = this.mTotalEventDisplays - 1;
         }
      }
      trace("ActivityTimer :: showTimerDisplay : " + eventData.timerDisplay);
   }
   function updateTimerDisplays()
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.mEvents.length)
      {
         _loc3_ = this.mEvents[_loc2_];
         if(_loc3_.timerDisplay)
         {
            _loc3_.timerDisplay.label2.text = Math.floor(Number(this.getTime() - _loc3_.start) / 1000);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function createEventObject(campaign, choice, begin, end, kill, persist, onlyTrackOnComplete)
   {
      var _loc1_ = new Object();
      _loc1_.event = new Object();
      _loc1_.event.begin = begin;
      _loc1_.event.end = end;
      _loc1_.event.kill = kill;
      _loc1_.started = false;
      _loc1_.start = 0;
      _loc1_.campaign = campaign;
      _loc1_.choice = choice;
      _loc1_.persist = persist;
      _loc1_.onlyTrackOnComplete = onlyTrackOnComplete;
      return _loc1_;
   }
   function eventStarted(eventData)
   {
      eventData.started = true;
      eventData.start = this.getTime();
      if(this.mShowTimerDisplays)
      {
         this.showTimerDisplay(eventData,true);
      }
      this.saveTimerData();
      this.start();
      trace("ActivityTimer :: Event Started : " + eventData.event.begin);
   }
   function eventComplete(eventData)
   {
      eventData.started = false;
      eventData.end = this.getTime();
      this.track(eventData);
      if(eventData.persist)
      {
         this.saveTimerData();
      }
      else
      {
         this.removeEvent(eventData);
      }
      if(this.mEvents.length < 1)
      {
         this.end();
         this.clearData();
      }
      trace("ActivityTimer :: Event Complete : " + eventData.event.end + "\nActivityTimer :: total time : " + (eventData.end - eventData.start));
   }
   function eventKill(eventData)
   {
      eventData.started = false;
      if(this.mShowTimerDisplays)
      {
         this.showTimerDisplay(eventData,false);
      }
      if(eventData.onlyTrackOnComplete)
      {
         this.removeEvent(eventData);
      }
      else
      {
         this.eventComplete(eventData);
      }
      trace("ActivityTimer :: Event Killed : " + eventData.event.end + "\n total time : " + (eventData.end - eventData.start));
   }
   function track(eventData)
   {
      var _loc3_ = Math.floor((eventData.end - eventData.start) / 1000);
      this.mScope.trackActivityTime(_loc3_,eventData.campaign,eventData.choice);
   }
   function searchArray(element, array)
   {
      trace("searching array : element : " + element + " array : " + array);
      var _loc1_ = 0;
      while(_loc1_ < array.length)
      {
         if(array[_loc1_] == element)
         {
            return true;
         }
         _loc1_ = _loc1_ + 1;
      }
      return false;
   }
   function getRandomNumber(minVal, maxVal, round)
   {
      var _loc1_ = minVal + Math.random() * (maxVal - minVal);
      if(round != undefined)
      {
         if(round == "round")
         {
            _loc1_ = Math.round(_loc1_);
         }
         else if(round == "ciel")
         {
            _loc1_ = Math.ceil(_loc1_);
         }
         else if(round == "floor")
         {
            _loc1_ = Math.floor(_loc1_);
         }
      }
      return _loc1_;
   }
}
