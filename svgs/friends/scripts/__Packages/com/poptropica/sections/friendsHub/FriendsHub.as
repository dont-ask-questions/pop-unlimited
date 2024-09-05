class com.poptropica.sections.friendsHub.FriendsHub extends com.poptropica.sections.AbstractSection
{
   var _asset;
   var _popModel;
   var _popController;
   var _not_registered_popup;
   var _quilt;
   var _friendsMarch;
   var _adContainerOrigY;
   var _multiverseView;
   var _tribesView;
   var adCmsLoadVar;
   static var _instance;
   var VERSION = "v1.0r45";
   var _currentTribe = "";
   function FriendsHub(pTarget)
   {
      super(pTarget);
      com.poptropica.util.Debug.trace("FriendsHub constructor::() " + pTarget,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      mx.events.EventDispatcher.initialize(this);
      this._asset = pTarget;
      if(this._asset.tfVersion != undefined)
      {
         this._asset.tfVersion.text = this.VERSION;
      }
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = new com.poptropica.controllers.PopController(this._popModel);
      trace("Once upon a time, PopModelConst.prefix would be overwritten here.");
      com.poptropica.models.PopModel.getInstance().isTestMode = false;
      var _loc5_ = com.poptropica.models.PopModel.getInstance().isRegistered;
      trace("[FriendsHub] PopModel.getInstance.isRegistered:" + com.poptropica.models.PopModel.getInstance().isRegistered);
      trace("_root._url.contains:" + _root._url);
      if(_loc5_ || _root._url.indexOf("file://") != -1)
      {
         this.init();
      }
      else
      {
         var _loc4_ = this._asset.mcTop.attachMovie("mcNotRegisteredPopup","save_popup",1,{_x:0,_y:40});
         trace("[FriendsHub]           mc:" + _loc4_);
         this._not_registered_popup = new com.poptropica.views.home.welcomeBack.SaveGamePopup(_loc4_);
         com.poptropica.controllers.PopController.getInstance().setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
      }
      trace("[FriendsHub] PopModelConst.gameplayMC.island:" + com.poptropica.models.PopModelConst.gameplayMC.island);
      com.poptropica.sections.friendsHub.FriendsHub._instance = this;
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
      if(com.poptropica.sections.friendsHub.FriendsHub._instance == undefined)
      {
         com.poptropica.sections.friendsHub.FriendsHub._instance = new com.poptropica.sections.friendsHub.FriendsHub();
      }
      return com.poptropica.sections.friendsHub.FriendsHub._instance;
   }
   function init()
   {
      com.poptropica.sections.friendsHub.FriendsViewCounter.incrementCounter("hub");
      var _loc2_ = new LoadVars();
      _loc2_.login = com.poptropica.models.PopModelConst.avatar.loadLogin();
      _loc2_.pass_hash = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.password;
      _loc2_.logged_in = !com.poptropica.models.PopModelConst.avatar.isRegistred() ? 0 : 1;
      _loc2_.dbID = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.dbid;
      this._quilt = com.poptropica.sections.friendsHub.Quilt.getInstance();
      this._quilt.init(this._asset.mcQuilt);
      this._quilt.addEventListener("close",Delegate.create(this,this.onQuiltClosed));
      com.poptropica.sections.quidget.PopupManager.getInstance().container = this._asset.mcPopupContainer;
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("open",Delegate.create(this,this.onPopupOpen));
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("close",Delegate.create(com.poptropica.sections.quidget.ToolTipMessageManager.getInstance(),com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().enable));
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().container = this._asset.mcToolTipContainer;
      this._friendsMarch = com.poptropica.sections.friendsHub.FriendsMarch.getInstance();
      this._friendsMarch.cleanUp();
      this._friendsMarch.asset = this._asset.mcFriendsMarch;
      this._friendsMarch.init();
      this._friendsMarch.tfUsername = this._asset.mcQuilt.tfUsername;
      this._adContainerOrigY = this._asset.adContainer._y;
      this._asset.btnFriends.onRelease = Delegate.create(this,this.onFriendsTabClick);
      this._asset.btnTribes.onRelease = Delegate.create(this,this.onTribesTabClick);
      this.checkTribeSelected();
      this._asset.btnMultiverse.onRelease = Delegate.create(this,this.onMultiverseTabClick);
      this._multiverseView = new com.poptropica.sections.friendsHub.MultiverseView(this._asset.mcMultiverse);
      this._multiverseView.visible = false;
      this._tribesView = new com.poptropica.sections.friendsHub.TribesView(this._asset.mcTribes);
      this._tribesView.visible = false;
      this.setFriendsAndMultiverseBtns();
      trace("[FriendsHub] FriendsModel.getInstance().initialQuidgetToOpen:" + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialQuidgetToOpen);
      trace("[FriendsHub] FriendsModel.getInstance().initialUserLogin:" + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin);
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialQuidgetToOpen != undefined)
      {
         this._quilt.setOpen();
         this._friendsMarch.selectUser();
         com.poptropica.controllers.PopController.getInstance().setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
      }
      else if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin != undefined)
      {
         this._quilt.setOpen();
         com.poptropica.controllers.PopController.getInstance().setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
      }
      else
      {
         this.revertToOpenUserQuilt();
      }
   }
   function onPopupOpen()
   {
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().disable();
   }
   function onFriendsTabClick()
   {
      trace("[FriendsHub] onFriendsTabClick:");
      this._multiverseView.visible = false;
      this._tribesView.visible = false;
      this._friendsMarch.visible = true;
      this._quilt.visible = true;
      this.setFriendsAndMultiverseBtns();
      this._asset.adContainer.onRelease = Delegate.create(this,this.onAdClick);
   }
   function onTribesTabClick()
   {
      trace("[FriendsHub] onTribesTabClick:");
      var _loc2_ = !com.poptropica.models.PopModel.getInstance().isActiveMember() ? "NonMember" : "Member";
      var _loc3_ = this._currentTribe;
      com.poptropica.controllers.PopController.getInstance().track("Tribes","TribeClicked",_loc2_,_loc3_,false,com.poptropica.models.PopModelConst.island,"Hub");
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().hasTribeSelected)
      {
         this._multiverseView.visible = false;
         this._tribesView.init();
         this._tribesView.visible = true;
         this._friendsMarch.visible = false;
         this._quilt.visible = false;
         this.setFriendsAndMultiverseBtns();
      }
      else
      {
         this.onFriendsTabClick();
         this._quilt.openQuidgetByName("tribe");
      }
   }
   function onMultiverseTabClick()
   {
      this._multiverseView.visible = true;
      this._tribesView.visible = false;
      this._friendsMarch.visible = false;
      this._quilt.visible = false;
      this.setFriendsAndMultiverseBtns();
      delete this._asset.adContainer.onRelease;
      com.poptropica.controllers.PopController.getInstance().track("Friends","MultiverseClicked","","",false,"Hub");
   }
   function setFriendsAndMultiverseBtns()
   {
      if(this._multiverseView.visible)
      {
         this._asset.btnFriends.gotoAndStop(1);
         this._asset.btnTribes.gotoAndStop(1);
         this._asset.btnMultiverse.gotoAndStop(2);
         com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._asset.btnMultiverse);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnTribes,1);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnFriends,2);
      }
      else if(this._tribesView.visible)
      {
         this._asset.btnFriends.gotoAndStop(1);
         this._asset.btnTribes.gotoAndStop(2);
         this._asset.btnMultiverse.gotoAndStop(1);
         com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._asset.btnTribes);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnFriends,1);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnMultiverse,1);
      }
      else
      {
         this._asset.btnFriends.gotoAndStop(2);
         this._asset.btnMultiverse.gotoAndStop(1);
         this._asset.btnTribes.gotoAndStop(1);
         com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._asset.btnFriends);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnMultiverse,1);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnTribes,1);
      }
   }
   function onQuiltClosed()
   {
      this._friendsMarch.clearSelected();
      this._quilt.clearLastLoaded();
   }
   function xLoadBigAdCms()
   {
      trace("[FriendsHub] xLoadBigAdCms");
      com.poptropica.sections.friendsHub.FriendsViewCounter.incrementCounter("hub");
      this.adCmsLoadVar = new LoadVars();
      this.adCmsLoadVar.onLoad = Delegate.create(this,this.onAdCmsLoaded);
      var _loc2_ = new LoadVars();
      _loc2_.type = "Friend Hub";
      var _loc5_ = com.poptropica.models.PopModel.getInstance().poptropica_user;
      _loc2_.age = _loc5_.age;
      _loc2_.gender = _loc5_.gender;
      var _loc4_ = com.poptropica.models.PopModelConst.gameplayMC.island;
      if(_loc4_.indexOf("Common") != -1)
      {
         _loc4_ = com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.data.lastIsland;
      }
      _loc2_.island = _loc4_;
      _loc2_.v = 2;
      _loc2_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/get_campaign_list.php",this.adCmsLoadVar,"POST");
      trace("[FriendsHub] ------------get_campaign_list.php:");
      for(var _loc3_ in _loc2_)
      {
         trace("            " + _loc3_ + ":" + _loc2_[_loc3_]);
      }
   }
   function onAdCmsLoaded(success)
   {
      trace("[FriendsHub] onAdCmsLoaded success:" + success + "  campaign_name:" + this.adCmsLoadVar.campaign_name);
      var _loc2_ = success;
      if(this.adCmsLoadVar.campaign_name == "" || this.adCmsLoadVar.campaign_name == undefined)
      {
         _loc2_ = false;
      }
      if(_loc2_)
      {
         this.loadAdAsset(this.adCmsLoadVar.campaign_file1);
      }
      else
      {
         this.revertToOpenUserQuilt();
      }
   }
   function loadAdAsset(url)
   {
      var _loc3_ = new MovieClipLoader();
      var _loc2_ = {};
      _loc3_.addListener(_loc2_);
      _loc2_.onLoadInit = Delegate.create(this,this.onAdAssetLoadInit);
      _loc2_.onLoadError = Delegate.create(this,this.onAdAssetLoadError);
      _loc3_.addListener(_loc2_);
      _loc3_.loadClip(url,this._asset.adContainer);
      this._asset.adContainer._visible = true;
      this._asset.adContainer._y = this._adContainerOrigY;
   }
   function onAdAssetLoadInit()
   {
      com.poptropica.controllers.PopController.getInstance().setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
      this._asset.adContainer.onRelease = Delegate.create(this,this.onAdClick);
      com.poptropica.controllers.PopController.getInstance().track(this.adCmsLoadVar.campaign_name,"Impression","RaggedAd","",false,"Hub");
   }
   function onAdAssetLoadError()
   {
      this.revertToOpenUserQuilt();
   }
   function revertToOpenUserQuilt()
   {
      com.poptropica.controllers.PopController.getInstance().setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
      this._quilt.noBigAd();
      this._quilt.setOpen();
      this._friendsMarch.selectUser();
   }
   function onAdClick()
   {
      getURL(this.adCmsLoadVar.click_through_URL,"blank");
      com.poptropica.controllers.PopController.getInstance().track(this.adCmsLoadVar.campaign_name,"ClickToSponsor","RaggedAd","",false,"Hub");
   }
   function onAdOkClick()
   {
   }
   function get controller()
   {
      return this._popController;
   }
   function get model()
   {
      return this._popModel;
   }
   function checkTribeSelected()
   {
      var _this = this;
      var _loc3_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         var _loc1_ = [];
         _loc1_[4001] = {id:4001,full_name:"Flying Squid",room_name:"FlyingSquid"};
         _loc1_[4002] = {id:4002,full_name:"Wildfire",room_name:"Wildfire"};
         _loc1_[4003] = {id:4003,full_name:"Yellowjackets",room_name:"Yellowjackets"};
         _loc1_[4004] = {id:4004,full_name:"Pathfinders",room_name:"Pathfinders"};
         _loc1_[4005] = {id:4005,full_name:"Black Flags",room_name:"BlackFlags"};
         _loc1_[4006] = {id:4006,full_name:"Nightcrawlers",room_name:"Nightcrawlers"};
         _loc1_[4007] = {id:4007,full_name:"Seraphim",room_name:"Seraphim"};
         _loc1_[4008] = {id:4008,full_name:"Nanobots",room_name:"Nanobots"};
         if(receiver.answer == "ok")
         {
            if(receiver.tribe_id)
            {
               com.poptropica.sections.friendsHub.FriendsModel.getInstance().hasTribeSelected = true;
               _this._currentTribe = _loc1_[receiver.tribe_id].full_name;
            }
            else
            {
               com.poptropica.sections.friendsHub.FriendsModel.getInstance().hasTribeSelected = false;
               _this._currentTribe = "no tribe";
            }
         }
         else
         {
            flash.external.ExternalInterface.call("dbug",receiver);
         }
      };
      _loc3_.login = this._popModel.poptropica_user.login;
      _loc3_.pass_hash = this._popModel.poptropica_user.password_hash;
      _loc3_.dbid = parseInt(this._popModel.db_id);
      _loc3_.lookup_user = this._popModel.poptropica_user.login;
      _loc3_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/get_user_tribe.php",receiver,"POST");
   }
}
