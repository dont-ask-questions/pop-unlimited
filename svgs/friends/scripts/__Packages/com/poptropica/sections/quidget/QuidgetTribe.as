class com.poptropica.sections.quidget.QuidgetTribe extends com.poptropica.sections.quidget.QuidgetBase
{
   var _newTribeNum;
   var _tribes;
   var _glowFilter;
   var _tribeNum;
   var _tribeId;
   var _asset;
   var _popup;
   var _toolTip;
   var _tribeNumChanged = false;
   var _tribeSelected = false;
   var DELAY_AFTER_CHOICE_MADE = 0.03;
   var X_SPACING = 130;
   var Y_SPACING = 93;
   var NUM_COLUMNS = 4;
   function QuidgetTribe()
   {
      super();
      trace("[QuidgetTribe] Constructor");
      this._newTribeNum = -1;
      this._tribes = [];
      this._tribes[0] = {id:4001,full_name:"Flying Squid",room_name:"FlyingSquid"};
      this._tribes[1] = {id:4002,full_name:"Wildfire",room_name:"Wildfire"};
      this._tribes[2] = {id:4003,full_name:"Yellowjackets",room_name:"Yellowjackets"};
      this._tribes[3] = {id:4004,full_name:"Pathfinders",room_name:"Pathfinders"};
      this._tribes[4] = {id:4005,full_name:"Black Flags",room_name:"BlackFlags"};
      this._tribes[5] = {id:4006,full_name:"Nightcrawlers",room_name:"Nightcrawlers"};
      this._tribes[6] = {id:4007,full_name:"Seraphim",room_name:"Seraphim"};
      this._tribes[7] = {id:4008,full_name:"Nanobots",room_name:"Nanobots"};
      this.loadQuidgetSwf();
      this._glowFilter = new flash.filters.GlowFilter(16776960,30,5,5,5,5);
   }
   function init(d)
   {
      trace("[QuidgetTribe] d.id:" + d.id + ", tribes:" + this._tribes);
      var _loc2_ = 0;
      while(_loc2_ < this._tribes.length)
      {
         if(Number(d.id) == this._tribes[_loc2_].id)
         {
            this._tribeNum = _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      this._tribeId = d.id;
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetTribe] onPopQuizLoadInit. ");
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this.setEditable(true);
      }
      this.draw();
      this.dispatchLoadComplete();
   }
   function draw()
   {
      trace("[QuidgetTribe] draw. Tribenum: " + this._tribeId);
      if(this._asset.contentContainer.content.tribeQuidget != undefined)
      {
         this._asset.contentContainer.content.tribeQuidget.removeMovieClip();
      }
      this._asset.contentContainer.content.attachMovie("tribeIcon_" + this._tribeId,"tribeQuidget",this._asset.contentContainer.content.getNextHighestDept());
      this._tribeNumChanged = false;
      this.convertToBitmap();
   }
   function onAssetClick()
   {
      this.checkAsk();
   }
   function checkAsk()
   {
      trace("[QuidgetTribe] checkAsk()");
      trace(this._tribeNum);
      if(!this._tribeNum && this._tribeNum != 0)
      {
         this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("tribePopup",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/tribe_quidget_assets.swf");
         com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
      }
      else
      {
         this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("tribesCommon",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/tribe_quidget_assets.swf");
         com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onCommonRoomPopupReady));
      }
   }
   function onPopupReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      this._toolTip = new com.poptropica.sections.quidget.ToolTipMessageManager();
      this._toolTip.container = this._popup.toolTipContainer;
      var _loc4_ = undefined;
      var _loc6_ = undefined;
      var _loc7_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this._tribes.length)
      {
         _loc6_ = "btnEmoticon" + _loc3_;
         var _loc5_ = "tribeIcon_" + this._tribes[_loc3_].id;
         this._popup.btnContainer.attachMovie(_loc5_,_loc6_,this._popup.btnContainer.getNextHighestDepth());
         _loc4_ = this._popup.btnContainer[_loc6_];
         if(_loc4_ == undefined)
         {
            trace("ERROR XXXXXXXXXXXX:" + _loc5_ + " is undefined");
         }
         _loc4_._x = _loc3_ % this.NUM_COLUMNS * this.X_SPACING;
         _loc4_._y = Math.floor(_loc3_ / this.NUM_COLUMNS) * this.Y_SPACING;
         _loc4_.tribeNum = _loc3_;
         _loc4_.controller = this;
         _loc7_ = this._popup.btnContainer.attachMovie("tribeTextLabel","tf" + _loc3_,this._popup.btnContainer.getNextHighestDepth());
         _loc7_._x = _loc4_._x;
         _loc7_._y = _loc4_._y + 29;
         _loc3_ = _loc3_ + 1;
      }
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
      com.greensock.TweenMax.delayedCall(0.5,this.makeBtnsInteractive,null,this);
      var _loc8_ = SharedObject.getLocal("Char","/");
      trace("[QuidgetTribe] onPopupReady lso.tribe? :" + _loc8_.data.userData.Tribe);
   }
   function onCommonRoomPopupReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      this._popup.gotoAndStop(this._tribeNum + 1);
      this._popup.changeBtn.onRelease = com.poptropica.util.EventDelegate.create(this,this.showChangeTribePopup);
      this._popup.joinRoomBtn.onRelease = com.poptropica.util.EventDelegate.create(this,this.launchCommonRoom);
      this._popup.room_txt.text = "visit the " + this._tribes[this._tribeNum].room_name + " common room to battle, chat, and friend other members of your tribe.";
   }
   function showChangeTribePopup()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupSwitch));
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
   }
   function onPopupSwitch()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("tribePopup",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/tribe_quidget_assets.swf");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
   }
   function launchCommonRoom()
   {
      var _loc3_ = com.poptropica.models.PopModel.getInstance();
      var _loc9_ = new com.poptropica.controllers.PopController(_loc3_);
      var _loc6_ = _loc3_.camera.scene.char.avatar.FunBrain_so.data.partyRoom;
      var _loc7_ = !com.poptropica.models.PopModel.getInstance().isActiveMember() ? "NonMember" : "Member";
      var _loc8_ = this._tribes[this._tribeNum].full_name;
      var _loc5_ = com.poptropica.models.PopModelConst.island;
      if(_loc5_.indexOf("Common") != -1)
      {
         _loc5_ = _loc3_.camera.scene.char.avatar.FunBrain_so.data.lastIsland;
      }
      com.poptropica.controllers.PopController.getInstance().track("Tribes","Common Room",_loc7_,_loc8_,false,_loc5_,"Hub");
      var _loc4_ = false;
      var _loc2_ = 0;
      while(_loc2_ < this._tribes.length)
      {
         if(_loc3_.desc == this._tribes[_loc2_].room_name)
         {
            _loc4_ = true;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_.desc != "FriendsRoom" && !_loc6_ && !_loc4_)
      {
         _loc3_.camera.scene.char.avatar.FunBrain_so.data.lastRoom = _loc3_.desc;
         _loc3_.camera.scene.char.avatar.FunBrain_so.data.lastIsland = com.poptropica.models.PopModelConst.island;
         _loc3_.camera.scene.char.avatar.FunBrain_so.flush();
      }
      _loc3_.camera.scene.char.loadScene(this._tribes[this._tribeNum].room_name,null,null,"TribalCommon" + this._tribes[this._tribeNum].room_name);
   }
   function onPhpComplete()
   {
      trace("[QuidgetTribe] onPhpComplete");
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
   }
   function makeBtnsInteractive()
   {
      var _loc3_ = 0;
      while(_loc3_ < this._tribes.length)
      {
         var _loc4_ = "btnEmoticon" + _loc3_;
         var _loc2_ = this._popup.btnContainer[_loc4_];
         _loc2_.onRelease = com.poptropica.util.EventDelegate.create(this,this.onBtnRelease,_loc2_);
         _loc2_.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onBtnRollOver,_loc2_);
         _loc2_.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onBtnRollOut,_loc2_);
         _loc3_ = _loc3_ + 1;
      }
   }
   function onBtnRelease(btn)
   {
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().hasTribeSelected = true;
      if(this._tribeNum != btn.tribeNum)
      {
         if(!this._tribeNum)
         {
            this._tribeSelected = true;
         }
         this._tribeNum = btn.tribeNum;
         this._tribeId = this._tribes[this._tribeNum].id;
         this._tribeNumChanged = true;
         _root.camera.scene.char.avatar.setUserField("Tribe",this._tribeId);
         com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.data.userData.Tribe = this._tribeId;
         com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.flush();
         com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchPlayerTribeChanged();
         trace("[QuidgetTribe] _tribeId" + this._tribeId);
         trace("[QuidgetTribe] onPopupReady lso.tribe? :" + com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.data.userData.Tribe);
         com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
         _root.camera.scene.tribeChanged();
         var _loc3_ = !com.poptropica.models.PopModel.getInstance().isActiveMember() ? "NonMember" : "Member";
         var _loc4_ = this._tribes[this._tribeNum].full_name;
         com.poptropica.controllers.PopController.getInstance().track("Tribes","SelectedTribe",_loc3_,_loc4_,false,com.poptropica.models.PopModelConst.island,"Hub");
      }
      else
      {
         com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
      }
   }
   function onBtnRollOver(btn)
   {
      btn.filters = [this._glowFilter];
      var _loc3_ = this._tribes[btn.tribeNum].full_name;
      this._toolTip.setMessage(btn,_loc3_);
   }
   function onBtnRollOut(btn)
   {
      btn.filters = [];
      this._toolTip.objRollout(btn);
   }
   function onPopupClose(callingObj)
   {
      trace("[QuidgetTribe] onPopupClose.");
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      if(this._tribeNumChanged)
      {
         this.draw();
         com.poptropica.sections.friendsHub.Quilt.getInstance().clearCurrentUserCache();
      }
      if(!this._tribeSelected)
      {
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
      return "tribe";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      if(this._tribeId != -1)
      {
         _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " belongs to the " : " belong to the ";
         _loc2_ += this._tribes[this._tribeNum].full_name + " tribe.";
      }
      else if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         _loc2_ = "Click to select your tribe.";
      }
      else
      {
         _loc2_ += " has not selected a tribe yet.";
      }
      return _loc2_;
   }
}
