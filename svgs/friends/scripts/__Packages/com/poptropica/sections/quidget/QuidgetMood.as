class com.poptropica.sections.quidget.QuidgetMood extends com.poptropica.sections.quidget.QuidgetBase
{
   var _newMoodNum;
   var _moodNum;
   var _asset;
   var _popup;
   var _phpResults;
   var _moodNumChanged = false;
   var _moods = ["happy","excited","goofy","starstruck","bored","sleepy","bashful","ill","angry","sad"];
   var DELAY_AFTER_CHOICE_MADE = 0.03;
   function QuidgetMood()
   {
      super();
      trace("[QuidgetMood] Constructor");
      this._newMoodNum = -1;
      this.loadQuidgetSwf();
   }
   function init(d)
   {
      this._moodNum = d.mood;
      if(this._moodNum == -1)
      {
         this._moodNum = 0;
      }
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetMood] onPopQuizLoadInit. ");
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this.setEditable(true);
      }
      this.draw();
      this.dispatchLoadComplete();
   }
   function draw()
   {
      trace("[QuidgetMood] draw. Moodnum: " + this._moodNum);
      if(this._asset.contentContainer.content.moodQuidget != undefined)
      {
         this._asset.contentContainer.content.moodQuidget.removeMovieClip();
      }
      this._asset.contentContainer.content.attachMovie(this._moods[this._moodNum] + "Quidget","moodQuidget",this._asset.contentContainer.content.getNextHighestDept());
      this._moodNumChanged = false;
      this.convertToBitmap();
   }
   function onAssetClick()
   {
      this.checkAsk();
   }
   function checkAsk()
   {
      trace("[QuidgetMood] checkAsk()");
      this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("moodPopup",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/mood_quidget_assets.swf");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
   }
   function onPopupReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      var _loc8_ = 70;
      var _loc7_ = 66;
      var _loc4_ = undefined;
      var _loc6_ = undefined;
      var _loc5_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this._moods.length)
      {
         _loc6_ = "btnEmoticon" + _loc3_;
         this._popup.btnContainer.attachMovie(this._moods[_loc3_] + "Emote",_loc6_,this._popup.btnContainer.getNextHighestDepth());
         _loc4_ = this._popup.btnContainer[_loc6_];
         if(_loc4_ == undefined)
         {
            trace("ERROR XXXXXXXXXXXX:" + this._moods[_loc3_] + " button undefined");
         }
         _loc4_._x = -30 + _loc3_ % 5 * _loc8_;
         _loc4_._y = Math.floor(_loc3_ / 5) * _loc7_;
         _loc4_.moodNum = _loc3_;
         _loc4_.controller = this;
         _loc5_ = this._popup.btnContainer.attachMovie("moodTextLabel","tf" + _loc3_,this._popup.btnContainer.getNextHighestDepth());
         _loc5_._x = _loc4_._x;
         _loc5_._y = _loc4_._y + 29;
         _loc5_.tf.text = this._moods[_loc3_];
         _loc3_ = _loc3_ + 1;
      }
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
      com.greensock.TweenMax.delayedCall(0.5,this.makeBtnsInteractive,null,this);
   }
   function makeBtnsInteractive()
   {
      var _loc3_ = 0;
      while(_loc3_ < this._moods.length)
      {
         var _loc4_ = "btnEmoticon" + _loc3_;
         var _loc2_ = this._popup.btnContainer[_loc4_];
         var _loc0_ = null;
         var _loc5_ = _loc2_.onRelease = Delegate.create(this,this.onBtnRelease);
         _loc5_.btn = _loc2_;
         _loc2_.onRollOver = this.onBtnRollOver;
         _loc2_.onRollOut = this.onBtnRollOut;
         _loc3_ = _loc3_ + 1;
      }
   }
   function onBtnRelease()
   {
      if(this._moodNum != arguments.caller.btn.moodNum)
      {
         this._moodNum = arguments.caller.btn.moodNum;
         this._moodNumChanged = true;
         var _loc3_ = new LoadVars();
         com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc3_);
         _loc3_.mood_id = this._moodNum;
         this._phpResults = new LoadVars();
         this._phpResults.onLoad = Delegate.create(this,this.onPhpComplete);
         var _loc4_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/set_user_mood.php";
         _loc3_.sendAndLoad(_loc4_,this._phpResults,"POST");
         this._popup.btnContainer._visible = false;
         this._popup.tfMsg.text = "Submitting...";
      }
      else
      {
         com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
      }
      com.poptropica.controllers.PopController.getInstance().track("Friends","QuidgetAnswered",this._moods[this._moodNum],"",false,"Hub","Mood");
   }
   function onPhpComplete()
   {
      trace("[QuidgetMood] onPhpComplete");
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
   }
   function onBtnRollOver()
   {
      var _loc2_ = new flash.filters.GlowFilter(16776960,30,5,5,5,5);
      this.filters = [_loc2_];
   }
   function onBtnRollOut()
   {
      this.filters = [];
   }
   function onPopupClose(callingObj)
   {
      trace("[QuidgetMood] onPopupClose.");
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      if(this._moodNumChanged)
      {
         this.draw();
         com.poptropica.sections.friendsHub.Quilt.getInstance().clearCurrentUserCache();
      }
      com.greensock.TweenMax.delayedCall(this.DELAY_AFTER_CHOICE_MADE,this.makeIconFlash,null,this);
   }
   function isAccomplishment()
   {
      return false;
   }
   function isPersonality()
   {
      return true;
   }
   function get name()
   {
      return "mood";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " feels " : " feel ";
      _loc2_ += this._moods[this._moodNum] + ".";
      return _loc2_;
   }
}
