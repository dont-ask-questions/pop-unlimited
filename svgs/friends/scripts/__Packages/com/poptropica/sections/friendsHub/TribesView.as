class com.poptropica.sections.friendsHub.TribesView
{
   var _glowFilter;
   var _popModel;
   var _popController;
   var _container;
   var _tribes;
   var _asset;
   var _tribeNum;
   var buttonsMade;
   var X_SPACING = 130;
   var Y_SPACING = 93;
   var NUM_COLUMNS = 4;
   function TribesView(pTarget)
   {
      this._glowFilter = new flash.filters.GlowFilter(16776960,30,5,5,5,5);
      mx.events.EventDispatcher.initialize(this);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = new com.poptropica.controllers.PopController(this._popModel);
      this._container = pTarget;
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = {};
      _loc2_.addListener(_loc3_);
      _loc3_.onLoadInit = Delegate.create(this,this.onAssetLoaded);
      _loc2_.loadClip("framework/sections/friends_hub/tribes.swf",this._container.container);
      this._tribes = [];
      this._tribes[0] = {id:4001,full_name:"Flying Squid",room_name:"FlyingSquid"};
      this._tribes[1] = {id:4002,full_name:"Wildfire",room_name:"Wildfire"};
      this._tribes[2] = {id:4003,full_name:"Yellowjackets",room_name:"Yellowjackets"};
      this._tribes[3] = {id:4004,full_name:"Pathfinders",room_name:"Pathfinders"};
      this._tribes[4] = {id:4005,full_name:"Black Flags",room_name:"BlackFlags"};
      this._tribes[5] = {id:4006,full_name:"Nightcrawlers",room_name:"Nightcrawlers"};
      this._tribes[6] = {id:4007,full_name:"Seraphim",room_name:"Seraphim"};
      this._tribes[7] = {id:4008,full_name:"Nanobots",room_name:"Nanobots"};
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
   function onAssetLoaded(mc)
   {
      this._asset = mc;
      this.init();
   }
   function init()
   {
      this.getTribe();
   }
   function getTribe()
   {
      var _this = this;
      var _loc2_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            _this.loadTribeGraphic(receiver.tribe_id);
         }
         else
         {
            flash.external.ExternalInterface.call("dbug",receiver);
         }
      };
      _loc2_.login = this._popModel.poptropica_user.login;
      _loc2_.pass_hash = this._popModel.poptropica_user.password_hash;
      _loc2_.dbid = parseInt(this._popModel.db_id);
      _loc2_.lookup_user = this._popModel.poptropica_user.login;
      _loc2_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/get_user_tribe.php",receiver,"POST");
   }
   function loadTribeGraphic(tribeID)
   {
      if(tribeID)
      {
         var _loc2_ = 0;
         while(_loc2_ < this._tribes.length)
         {
            if(Number(tribeID) == this._tribes[_loc2_].id)
            {
               this._tribeNum = _loc2_;
            }
            _loc2_ = _loc2_ + 1;
         }
         this._asset.gotoAndStop(this._tribeNum + 1);
         this._asset.joinRoomBtn.onRelease = com.poptropica.util.EventDelegate.create(this,this.launchCommonRoom);
      }
      else
      {
         this._asset.gotoAndStop(9);
      }
   }
   function launchCommonRoom()
   {
      var _loc6_ = !com.poptropica.models.PopModel.getInstance().isActiveMember() ? "NonMember" : "Member";
      var _loc7_ = this._tribes[this._tribeNum].full_name;
      com.poptropica.controllers.PopController.getInstance().track("Tribes","Common Room",_loc6_,_loc7_,false,com.poptropica.models.PopModelConst.island,"TribePage");
      var _loc3_ = com.poptropica.models.PopModel.getInstance();
      var _loc8_ = new com.poptropica.controllers.PopController(_loc3_);
      var _loc5_ = _loc3_.camera.scene.char.avatar.FunBrain_so.data.partyRoom;
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
      if(_loc3_.desc != "FriendsRoom" && !_loc5_ && !_loc4_)
      {
         _loc3_.camera.scene.char.avatar.FunBrain_so.data.lastRoom = _loc3_.desc;
         _loc3_.camera.scene.char.avatar.FunBrain_so.data.lastIsland = com.poptropica.models.PopModelConst.island;
         _loc3_.camera.scene.char.avatar.FunBrain_so.flush();
      }
      _loc3_.camera.scene.char.loadScene(this._tribes[this._tribeNum].room_name,null,null,"TribalCommon" + this._tribes[this._tribeNum].room_name);
   }
   function makeButtons()
   {
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc6_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this._tribes.length)
      {
         _loc5_ = "btnEmoticon" + _loc2_;
         var _loc4_ = "tribeIcon_" + this._tribes[_loc2_].id;
         this._asset.attachMovie(_loc4_,_loc5_,this._asset.getNextHighestDepth());
         _loc3_ = this._asset[_loc5_];
         if(_loc3_ == undefined)
         {
            trace("ERROR XXXXXXXXXXXX:" + _loc4_ + " is undefined");
         }
         _loc3_._x = 150 + _loc2_ % this.NUM_COLUMNS * this.X_SPACING;
         _loc3_._y = 250 + Math.floor(_loc2_ / this.NUM_COLUMNS) * this.Y_SPACING;
         _loc3_.tribeNum = _loc2_;
         _loc3_.controller = this;
         _loc2_ = _loc2_ + 1;
      }
      this.buttonsMade = true;
      com.greensock.TweenMax.delayedCall(0.5,this.makeBtnsInteractive,null,this);
   }
   function makeBtnsInteractive()
   {
      var _loc3_ = 0;
      while(_loc3_ < this._tribes.length)
      {
         var _loc4_ = "btnEmoticon" + _loc3_;
         var _loc2_ = this._asset[_loc4_];
         _loc2_.onRelease = com.poptropica.util.EventDelegate.create(this,this.onBtnRelease,_loc2_);
         _loc2_.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onBtnRollOver,_loc2_);
         _loc2_.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onBtnRollOut,_loc2_);
         _loc3_ = _loc3_ + 1;
      }
   }
   function removeButtons()
   {
      var _loc3_ = 0;
      while(_loc3_ < this._tribes.length)
      {
         var _loc4_ = "btnEmoticon" + _loc3_;
         var _loc2_ = this._asset[_loc4_];
         _loc2_.onRelease = null;
         _loc2_.onRollOver = null;
         _loc2_.onRollOut = null;
         _loc2_._visible = false;
         _loc3_ = _loc3_ + 1;
      }
   }
   function onBtnRollOver(btn)
   {
      btn.filters = [this._glowFilter];
   }
   function onBtnRollOut(btn)
   {
      btn.filters = [];
   }
   function onBtnRelease(btn)
   {
      this._tribeNum = btn.tribeNum;
      var _loc4_ = this._tribes[this._tribeNum].id;
      _root.camera.scene.char.avatar.setUserField("Tribe",_loc4_);
      com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.data.userData.Tribe = _loc4_;
      com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.flush();
      _root.camera.scene.tribeChanged();
      var _loc5_ = !com.poptropica.models.PopModel.getInstance().isActiveMember() ? "NonMember" : "Member";
      var _loc6_ = this._tribes[this._tribeNum].full_name;
      var _loc3_ = com.poptropica.models.PopModelConst.island;
      if(_loc3_.indexOf("Common") != -1)
      {
         _loc3_ = com.poptropica.models.PopModel.getInstance().camera.scene.char.avatar.FunBrain_so.data.lastIsland;
      }
      com.poptropica.controllers.PopController.getInstance().track("Tribes","SelectedTribe",_loc5_,_loc6_,_loc3_,"Hub");
      this.loadTribeGraphic(_loc4_);
      this.removeButtons();
   }
   function set visible(b)
   {
      this._container._visible = b;
   }
   function get visible()
   {
      return this._container._visible;
   }
}
