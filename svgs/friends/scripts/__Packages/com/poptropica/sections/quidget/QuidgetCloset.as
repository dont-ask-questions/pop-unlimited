class com.poptropica.sections.quidget.QuidgetCloset extends com.poptropica.sections.quidget.QuidgetBase
{
   var _numLooks;
   var npc_looks;
   var npc_banner;
   var npc_campaign;
   var _asset;
   var onEnterFrame;
   var lookString;
   static var _instance;
   var npc_friend = false;
   function QuidgetCloset()
   {
      super();
      trace("[QuidgetCloset] Constructor");
      com.poptropica.sections.quidget.QuidgetCloset._instance = this;
      this.loadQuidgetSwf();
   }
   function init(d)
   {
      this._numLooks = d.numLooks;
      if(d.npc_friend)
      {
         this.npc_friend = true;
         this.npc_looks = d.looks;
         this.npc_banner = d.banner;
         this.npc_campaign = d.campaign_name;
      }
      if(this._numLooks == undefined)
      {
         this._numLooks = 0;
      }
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().addEventListener("playerTribeChanged",Delegate.create(this,this.onPlayerTribeChanged));
   }
   static function getInstance()
   {
      if(com.poptropica.sections.quidget.QuidgetCloset._instance == undefined)
      {
         com.poptropica.sections.quidget.QuidgetCloset._instance = new com.poptropica.sections.quidget.QuidgetCloset();
      }
      return com.poptropica.sections.quidget.QuidgetCloset._instance;
   }
   function onPlayerTribeChanged()
   {
      this.loadCharForIcon();
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetCloset] onPopQuizLoadInit. ");
      this._asset.contentContainer.content.attachMovie("photoQuidgetAsset","quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      this.setEditable(true);
      this._asset.contentContainer.content.quidgetAsset.tf.text = "";
      this._asset.contentContainer.content.quidgetAsset.char_closet_quidget._alpha = 0;
      this._asset.contentContainer.content.quidgetAsset.pausedGame = true;
      this.loadCharForIcon();
      this.dispatchLoadComplete();
   }
   function loadCharForIcon()
   {
      var _loc2_ = new MovieClipLoader();
      _loc2_.loadClip("char.swf",this._asset.contentContainer.content.quidgetAsset.char_closet_quidget);
      this.onEnterFrame = this.waitLoad;
   }
   function waitLoad()
   {
      if(this._asset.contentContainer.content.quidgetAsset.char_closet_quidget.loadingFinished)
      {
         delete this.onEnterFrame;
         this.getLatestSavedLook();
      }
   }
   function getLatestSavedLook()
   {
      trace("GET LATEST LOOK");
      var _this = this;
      var _loc10_ = _asset.contentContainer.content.quidgetAsset;
      if(this.npc_friend)
      {
         this.lookString = this.npc_looks[0];
         this.loadCharacter();
      }
      else
      {
         var _loc3_ = new LoadVars();
         var receiver = new LoadVars();
         receiver.onLoad = function(success)
         {
            trace(receiver);
            if(receiver.answer == "ok")
            {
               var _loc4_ = new asLib.JSON();
               var _loc1_ = _loc4_.parse(receiver.json);
               var _loc2_ = 0;
               for(var _loc3_ in _loc1_)
               {
                  _this.lookString = _loc1_[_loc3_][0];
                  _loc2_ = _loc2_ + 1;
               }
               _this._numLooks = _loc2_;
               _this.loadCharacter();
            }
            else
            {
               flash.external.ExternalInterface.call("dbug",receiver);
            }
         };
         var _loc7_ = com.poptropica.models.PopModel.getInstance();
         _loc3_.login = _loc7_.poptropica_user.login;
         _loc3_.pass_hash = _loc7_.poptropica_user.password_hash;
         _loc3_.dbid = parseInt(_loc7_.db_id);
         _loc3_.look_types_array = 5020;
         _loc3_.quantity = 30;
         _loc3_.offset = 0;
         var _loc5_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().currentUserLogin;
         if(_loc5_ != "undefined" && _loc5_ != _loc7_.poptropica_user.login)
         {
            var _loc8_ = _loc5_.substr(0,5);
            if(_loc8_ == "GUEST")
            {
               this._numLooks = 0;
               this.loadCharacter();
               return undefined;
            }
            _loc3_.lookup_user = _loc5_;
         }
         _loc3_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/lookCloset/get_look_closet.php",receiver,"POST");
      }
   }
   function loadCharacter()
   {
      var _loc2_ = this._asset.contentContainer.content.quidgetAsset.char_closet_quidget;
      this._asset.contentContainer.content.quidgetAsset.preloader._visible = false;
      this._asset.contentContainer.content.quidgetAsset.tf.text = this._numLooks;
      _loc2_._yscale = 90;
      if(this._numLooks > 0)
      {
         var _loc3_ = this.lookString.split(",");
         _loc3_[5] = "27";
         _loc2_.avatar.setLook(_loc3_);
         _loc2_.avatar.setParts();
         _loc2_.avatar.nextFrame();
      }
      else
      {
         var _loc4_ = com.poptropica.models.PopModel.getInstance();
         var _loc5_ = _loc4_.poptropica_user.login;
         if(_loc5_ != com.poptropica.sections.friendsHub.FriendsMarch.getInstance().selectedChar.userData[0])
         {
            var _loc6_ = com.poptropica.sections.friendsHub.FriendsMarch.getInstance().selectedChar.userData[3];
            _loc2_.avatar.setLook(_loc6_.split(","));
         }
         else
         {
            _loc2_.createBackPlayer();
         }
         _loc2_.avatar.eyesFrame = "mannequin";
         _loc2_.avatar.head.mouth._visible = false;
         _loc2_.avatar.head.headSkin.gotoAndStop(2);
         _loc2_.avatar.nextFrame();
      }
      _loc2_.avatar.eyesFrame = "mannequin";
      _loc2_.avatar.head.mouth._visible = false;
      _loc2_.avatar.head.headSkin.gotoAndStop(2);
      delete _loc2_.avatar.head.eyes.pupils.onEnterFrame;
      delete _loc2_.avatar.head.eyes.pupils.pupil1.onEnterFrame;
      delete _loc2_.avatar.head.eyes.pupils.pupil2.onEnterFrame;
      _loc2_._alpha = 100;
   }
   function createRolloverIcons()
   {
   }
   function onAssetClick()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
      com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromSwf("lookCloset/costumeCloset.swf",new flash.geom.Point(this._x + 60,this._y + 40),true,new flash.geom.Point(0,0));
   }
   function draw()
   {
      trace("[QuidgetCloset] draw");
   }
   function onPopupClose(callingObj)
   {
      trace("[QuidgetCloset] onPopupClose.");
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      com.greensock.TweenMax.delayedCall(0.6,this.makeIconFlash,null,this);
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
      return "closet";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " has " : " have ";
      _loc2_ += String(this._numLooks);
      _loc2_ += this._numLooks != 1 ? " outfits." : " outfit.";
      return _loc2_;
   }
   function updateQuidgetNum(num)
   {
      this._numLooks = this._asset.contentContainer.content.quidgetAsset.tf.text = num;
   }
}
