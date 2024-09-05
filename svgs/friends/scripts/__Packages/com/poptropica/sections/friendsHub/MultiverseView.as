class com.poptropica.sections.friendsHub.MultiverseView
{
   var _popModel;
   var _popController;
   var _container;
   var _asset;
   var status;
   var room_type;
   var prefix;
   function MultiverseView(pTarget)
   {
      mx.events.EventDispatcher.initialize(this);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = new com.poptropica.controllers.PopController(this._popModel);
      this._container = pTarget;
      trace("[MultiverseView] _container:" + this._container);
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = {};
      _loc2_.addListener(_loc3_);
      _loc3_.onLoadInit = Delegate.create(this,this.onAssetLoaded);
      _loc2_.loadClip("framework/sections/friends_hub/multiverse.swf",this._container.container);
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
      this._asset.bg.onRelease = function()
      {
      };
      var _this = this._asset;
      var _loc2_ = new Object();
      _loc2_.onKeyDown = function()
      {
         if(Key.getCode() == 13)
         {
            _this.btnJoin.onRelease();
            _this.btnJoin.onRelease();
         }
      };
      Key.addListener(_loc2_);
      var sender = new LoadVars();
      var receiver = new LoadVars();
      var _loc5_ = this._popModel.avatar.checkItem(3024);
      if(_loc5_)
      {
         this._asset.nonPurchasedInfo._visible = false;
      }
      else
      {
         this._asset.purchased._visible = false;
      }
      this._asset.bg.onRollOver = com.poptropica.util.EventDelegate.create(this._popController,this._popController.setPointerDisplay,"arrow");
      this._asset.btnJoin.onRollOver = com.poptropica.util.EventDelegate.create(this._popController,this._popController.setPointerDisplay,"click");
      this._asset.btnJoin.onRelease = function()
      {
         trace("TEXT:" + _this.Iname.text);
         if(_this.Iname.text == "")
         {
            _this.out.text = "Please enter a room code.";
            return undefined;
         }
         if(_this.Iname.text.toUpperCase() == com.poptropica.models.PopModelConst.gameplayMC.navBar.roomName.roomNameTxt.text)
         {
            _this.out.text = "You are already in this room.";
            return undefined;
         }
         if(com.poptropica.models.PopModelConst.gameplayMC.takeClick._visible)
         {
            return undefined;
         }
         _this.out.text = "";
         com.poptropica.models.PopModelConst.gameplayMC.takeClick._visible = true;
         this._popController.setPointerDisplay("loading");
         receiver.onLoad = function()
         {
            if(this.status == "exists")
            {
               var _loc2_ = this.room_type.toString();
               var _loc3_ = SharedObject.getLocal("Char","/");
               _loc3_.data.MMOprefix = this.prefix;
               com.poptropica.models.PopModelConst.gameplayMC.trackCampaign("","MultiverseEvent","RoomJoined",_loc2_);
               com.poptropica.models.PopModelConst.gameplayMC.visitPartyRoom(sender.room_name,_loc2_);
               return undefined;
            }
            if(this.status == "notexists")
            {
               _this.out.text = "There are no rooms matching your entry.";
            }
            else if(this.status == "full")
            {
               _this.out.text = "Sorry, this room is currently full.";
            }
            else
            {
               _this.out.text = "An error while connecting to the server occurred. Try again later.";
            }
            com.poptropica.models.PopModelConst.gameplayMC.takeClick._visible = false;
            this._popController.setPointerDisplay("click");
         };
         sender.room_name = _this.Iname.text.toUpperCase();
         sender.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/MMOcheckPrivateRoom.php",receiver,"POST");
      };
      _this.Iname.onChanged = function()
      {
         _this.out.text = "";
      };
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
