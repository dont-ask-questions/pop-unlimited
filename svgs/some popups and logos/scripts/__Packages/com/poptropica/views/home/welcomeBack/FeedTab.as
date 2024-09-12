class com.poptropica.views.home.welcomeBack.FeedTab extends com.poptropica.components.tab.TabBase
{
   var allFeedItems;
   var _asset;
   var onEnterFrame;
   static var __instance;
   var currentItem = 0;
   var feedDataArr = [];
   var loaded = false;
   function FeedTab(mc)
   {
      super(mc);
      mx.events.EventDispatcher.initialize(this);
      this.allFeedItems = [];
      com.poptropica.views.home.welcomeBack.FeedTab.__instance = this;
      this._asset.btnPrev.onPress = com.poptropica.views.home.welcomeBack.FeedTab.__instance.prevFeedItem;
      this._asset.btnNext.onPress = com.poptropica.views.home.welcomeBack.FeedTab.__instance.nextFeedItem;
      var _loc3_ = new MovieClipLoader();
      _loc3_.loadClip("char.swf",this._asset.feed_char);
      this._asset.feed_char._alpha = 0;
      this.onEnterFrame = this.waitLoad;
   }
   static function getInstance()
   {
      if(com.poptropica.views.home.welcomeBack.FeedTab.__instance == undefined)
      {
         com.poptropica.views.home.welcomeBack.FeedTab.__instance = new com.poptropica.views.home.welcomeBack.FeedTab();
      }
      return com.poptropica.views.home.welcomeBack.FeedTab.__instance;
   }
   function init()
   {
      trace("[FeedTab] init. _asset:" + this._asset);
      this.feedDataArr = [];
   }
   function show()
   {
      this._asset._visible = true;
      if(!this.loaded)
      {
         com.poptropica.views.home.welcomeBack.FeedTab.__instance.getFeedData();
      }
      this.loaded = true;
      this.dispatchEvent({type:"INITIALIZED",target:this});
   }
   function waitLoad()
   {
      if(this._asset.feed_char.loadingFinished)
      {
         this._asset.feed_char._alpha = 0;
         this._asset.feed_char._xscale = -110;
         this._asset.feed_char._yscale = 110;
         delete this.onEnterFrame;
      }
   }
   function getFeedData()
   {
      var _loc5_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            var _loc7_ = new asLib.JSON();
            var _loc2_ = _loc7_.parse(receiver.json);
            trace("FEED: " + receiver.json);
            flash.external.ExternalInterface.call("dbug","FEED: " + receiver.json);
            for(var _loc5_ in _loc2_)
            {
               var _loc1_ = {};
               _loc1_.name = com.poptropica.views.home.welcomeBack.FeedTab.__instance.scrubName(_loc2_[_loc5_].avatar_name);
               _loc1_.path = _loc2_[_loc5_].path;
               _loc1_.caption = _loc2_[_loc5_].caption;
               _loc1_.look = _loc2_[_loc5_].look;
               _loc1_.login = _loc2_[_loc5_].login;
               com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.unshift(_loc1_);
            }
            flash.external.ExternalInterface.call("dbug","NumFeedItems: " + com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.length);
            var _loc6_ = com.poptropica.models.PopModel.getInstance();
            if(com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.length < 10)
            {
               var _loc3_ = {};
               _loc3_.name = "default";
               _loc3_.path = "feed/quidgets/default1.swf";
               _loc3_.caption = "NEW: Find out how\nto make friends!";
               _loc3_.look = _loc6_.avatar.getLook();
               _loc3_.login = _loc6_.poptropica_user.login;
               com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.push(_loc3_);
            }
            if(com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.length < 10)
            {
               var _loc4_ = {};
               _loc4_.name = "default";
               _loc4_.path = "feed/quidgets/default2.swf";
               _loc4_.caption = "NEW: See the\nFriends trailer!";
               _loc4_.look = _loc6_.avatar.getLook();
               _loc4_.login = _loc6_.poptropica_user.login;
               com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.push(_loc4_);
            }
            com.poptropica.views.home.welcomeBack.FeedTab.__instance.my_int = setInterval(com.poptropica.views.home.welcomeBack.FeedTab.__instance,"loadFeedItem",300);
         }
         else
         {
            com.poptropica.views.home.welcomeBack.FeedTab.__instance.showFeedDisabled();
         }
      };
      var _loc7_ = com.poptropica.models.PopModel.getInstance();
      _loc5_.login = _loc7_.poptropica_user.login;
      _loc5_.pass_hash = _loc7_.poptropica_user.password_hash;
      _loc5_.dbid = parseInt(_loc7_.db_id);
      _loc5_.quantity = 10;
      _loc5_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/feed/get_feed.php",receiver,"POST");
   }
   function scrubName(name)
   {
      var _loc2_ = name.split(" ");
      _loc2_.length <= 2 ? null : (_loc2_[1] = _loc2_[1] + " " + _loc2_[2]);
      var _loc3_ = _loc2_[0];
      var _loc4_ = _loc2_[1];
      var _loc5_ = this._asset.feed_char.avatar.FirstName;
      var _loc9_ = this._asset.feed_char.avatar.LastName;
      var _loc8_ = this._asset.feed_char.avatar.FirstNameCustom;
      var _loc6_ = this._asset.feed_char.avatar.LastNameCustom;
      if(com.poptropica.views.home.welcomeBack.FeedTab.__instance.getArrayPos(_loc5_,_loc3_) == null && com.poptropica.views.home.welcomeBack.FeedTab.__instance.getArrayPos(_loc8_,_loc3_) == null)
      {
         return "Poptropican";
      }
      if(com.poptropica.views.home.welcomeBack.FeedTab.__instance.getArrayPos(_loc9_,_loc4_) == null && com.poptropica.views.home.welcomeBack.FeedTab.__instance.getArrayPos(_loc6_,_loc4_) == null)
      {
         return "Poptropican";
      }
      var _loc7_ = _loc2_.join(" ");
      return _loc7_;
   }
   function loadFeedItem(num, dir)
   {
      clearInterval(com.poptropica.views.home.welcomeBack.FeedTab.__instance.my_int);
      !!num ? null : (num = 0);
      trace("Load feed num " + num);
      this.allFeedItems[num].name != "default" ? (this._asset.captionClip._y = 104) : (this._asset.captionClip._y = 87);
      this._asset.quidgetLoader._alpha = this._asset.nameClip._alpha = this._asset.captionClip._alpha = 20;
      this._asset.quidgetLoader._x = dir != "right" ? 205 : 135;
      this._asset.nameClip._x = this._asset.captionClip._x = dir != "right" ? 165 : 95;
      this.allFeedItems[num].name != "default" ? (this._asset.nameClip.name_txt.text = this.allFeedItems[num].name) : (this._asset.nameClip.name_txt.text = "");
      this._asset.captionClip.caption_txt.text = "";
      this._asset.feed_char._alpha = 0;
      this._asset.feed_char._xscale = -110;
      this._asset.feed_char._yscale = 110;
      var _loc5_ = com.poptropica.models.PopModel.getInstance();
      var _loc9_ = _loc5_.poptropica_user.login;
      if(this.allFeedItems[num].login == _loc9_)
      {
         var _loc8_ = com.poptropica.models.PopModelConst.avatar.getLook();
         this._asset.feed_char.avatar.setLook(_loc8_.split(","));
      }
      else
      {
         this._asset.feed_char.avatar.setLook(this.allFeedItems[num].look.split(","));
      }
      this._asset.feed_char.avatar.setParts();
      this._asset.feed_char.avatar.nextFrame();
      this._asset.quidgetHolder.unloadMovie("holder");
      var _loc7_ = new MovieClipLoader();
      var _loc4_ = new Object();
      var targ = this._asset;
      var _this = this;
      var _loc3_ = this.allFeedItems[num].path;
      var _loc6_ = _loc3_.substr(_loc3_.lastIndexOf("/") + 1);
      var _loc2_ = _loc6_.substr(0,_loc6_.indexOf("."));
      if(_loc5_.isActiveMember())
      {
         com.poptropica.controllers.PopController.getInstance().track("Friends","FeedItemViewed","Member",_loc2_,false,"WelcomeBack",null);
      }
      else
      {
         com.poptropica.controllers.PopController.getInstance().track("Friends","FeedItemViewed","NonMember",_loc2_,false,"WelcomeBack",null);
      }
      _loc7_.loadClip(this.allFeedItems[num].path,this._asset.quidgetLoader.holder);
      _loc4_.onLoadInit = function()
      {
         targ.quidgetLoader.holder.mc.init(_this.allFeedItems[num]);
      };
      _loc7_.addListener(_loc4_);
      caurina.transitions.Tweener.addTween(this._asset.feed_char,{_alpha:100,time:0.5,transition:"easeOut"});
      caurina.transitions.Tweener.addTween(this._asset.quidgetLoader,{_x:170,_alpha:100,time:0.5,transition:"easeOutBack"});
      caurina.transitions.Tweener.addTween(this._asset.nameClip,{_x:135,_alpha:100,time:0.5,delay:0.2,transition:"easeOutBack"});
      caurina.transitions.Tweener.addTween(this._asset.captionClip,{_x:135,_alpha:100,time:0.5,delay:0.4,transition:"easeOutBack"});
      num != 0 ? (this._asset.btnPrev._visible = true) : (this._asset.btnPrev._visible = false);
      num != this.allFeedItems.length - 1 ? (this._asset.btnNext._visible = true) : (this._asset.btnNext._visible = false);
   }
   function prevFeedItem()
   {
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem--;
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.loadFeedItem(com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem,"right");
   }
   function nextFeedItem()
   {
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem = com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem + 1;
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.loadFeedItem(com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem,"left");
   }
   function showFeedDisabled()
   {
      this._asset.btnPrev._visible = false;
      this._asset.btnNext._visible = false;
      this._asset.captionClip._x = 80;
      this._asset.captionClip._y = 40;
      this._asset.feed_char._visible = false;
      this._asset.captionClip.caption_txt.text = "Recent Activity not available. \nPlease check back later.";
   }
   function removeFeedItem()
   {
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.allFeedItems.splice(com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem,1);
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.feedDataArr.splice(com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem,1);
      com.poptropica.views.home.welcomeBack.FeedTab.__instance.loadFeedItem(com.poptropica.views.home.welcomeBack.FeedTab.__instance.currentItem,"left");
   }
   function getArrayPos(arr, item)
   {
      var _loc1_ = 0;
      while(_loc1_ < arr.length)
      {
         if(arr[_loc1_] == item)
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
}
