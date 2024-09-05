class com.poptropica.sections.quidget.QuidgetPhotos extends com.poptropica.sections.quidget.QuidgetBase
{
   var _photosObj;
   var _numPhotos;
   var npc_banner;
   var npc_campaign;
   var _asset;
   var onEnterFrame;
   var content;
   static var _instance;
   var allPhotos = [];
   var npc_friend = false;
   function QuidgetPhotos()
   {
      super();
      trace("[QuidgetPhotos] Constructor");
      com.poptropica.sections.quidget.QuidgetPhotos._instance = this;
      this.loadQuidgetSwf();
   }
   function init(d)
   {
      this._photosObj = d;
      this._numPhotos = d.count;
      if(d.npc_friend == true)
      {
         this.npc_friend = true;
         this.allPhotos = d.photos;
         this.npc_banner = d.banner;
         this.npc_campaign = d.campaign_name;
      }
      _global.photoQuidgetLoaded = false;
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().addEventListener("playerTribeChanged",Delegate.create(this,this.onPlayerTribeChanged));
   }
   static function getInstance()
   {
      if(com.poptropica.sections.quidget.QuidgetPhotos._instance == undefined)
      {
         com.poptropica.sections.quidget.QuidgetPhotos._instance = new com.poptropica.sections.quidget.QuidgetPhotos();
      }
      return com.poptropica.sections.quidget.QuidgetPhotos._instance;
   }
   function onPlayerTribeChanged()
   {
      this.loadChar();
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetPhotos] onAssetLoadInit. ");
      this._asset.contentContainer.content.attachMovie("photoQuidgetAsset","quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      this.setEditable(true);
      this._asset.contentContainer.content.quidgetAsset.tf.text = this._numPhotos;
      this._asset.contentContainer.content.quidgetAsset.nophotos._visible = false;
      this._asset.contentContainer.content.quidgetAsset.pausedGame = true;
      this.getPhotoData();
      this.dispatchLoadComplete();
      this.loadChar();
   }
   function loadChar()
   {
      if(!this.npc_friend)
      {
         var _loc2_ = new MovieClipLoader();
         this._asset.contentContainer.content.quidgetAsset.char_photo_quidget._visible = false;
         _loc2_.loadClip("char.swf",this._asset.contentContainer.content.quidgetAsset.char_photo_quidget);
         this.onEnterFrame = this.waitLoad;
      }
   }
   function waitLoad()
   {
      if(this._asset.contentContainer.content.quidgetAsset.char_photo_quidget.loadingFinished)
      {
         delete this.onEnterFrame;
         var _loc2_ = this._asset.contentContainer.content.quidgetAsset.char_photo_quidget;
         var _loc3_ = com.poptropica.models.PopModel.getInstance();
         var _loc4_ = _loc3_.poptropica_user.login;
         if(_loc4_ != com.poptropica.sections.friendsHub.FriendsMarch.getInstance().selectedChar.userData[0])
         {
            var _loc5_ = com.poptropica.sections.friendsHub.FriendsMarch.getInstance().selectedChar.userData[3];
            _loc2_.avatar.setLook(_loc5_.split(","));
         }
         else
         {
            _loc2_.createBackPlayer();
         }
         _loc2_.avatar.nextFrame();
         delete _loc2_.avatar.head.onEnterFrame;
         delete _loc2_.avatar.body.onEnterFrame;
         delete _loc2_.avatar.head.eyes.pupils.onEnterFrame;
         delete _loc2_.avatar.head.eyes.pupils.pupil1.onEnterFrame;
         delete _loc2_.avatar.head.eyes.pupils.pupil2.onEnterFrame;
      }
   }
   function deleteEnterFrames(movieclip)
   {
      for(var _loc3_ in movieclip)
      {
         if(typeof movieclip[_loc3_] == "movieclip")
         {
            delete movieclip[_loc3_].onEnterFrame;
            this.deleteEnterFrames(movieclip[_loc3_]);
         }
      }
   }
   function getPhotoData()
   {
      if(this.npc_friend)
      {
         this.loadPhotoToStage();
      }
      else
      {
         this.allPhotos = [];
         var _this = this;
         var _loc5_ = new LoadVars();
         var receiver = new LoadVars();
         receiver.onLoad = function(success)
         {
            if(receiver.answer == "ok")
            {
               var _loc4_ = new asLib.JSON();
               var _loc2_ = _loc4_.parse(receiver.json);
               trace(receiver.json);
               trace("JSON: " + _loc2_.counts);
               for(var _loc3_ in _loc2_)
               {
                  if(_loc3_ != "counts")
                  {
                     var _loc1_ = {};
                     _loc1_.photo_id = _loc3_;
                     _loc1_.photoPath = _loc2_[_loc3_][0];
                     _loc1_.photoCaption = _loc2_[_loc3_][1];
                     _loc1_.photoLook = _loc2_[_loc3_][2];
                     _this.allPhotos.unshift(_loc1_);
                  }
               }
               _this.loadPhotoToStage();
            }
            else
            {
               trace("Error: " + receiver);
            }
         };
         var _loc8_ = com.poptropica.models.PopModel.getInstance();
         _loc5_.login = _loc8_.poptropica_user.login;
         _loc5_.pass_hash = _loc8_.poptropica_user.password_hash;
         _loc5_.dbid = parseInt(_loc8_.db_id);
         _loc5_.quantity = 1;
         _loc5_.offset = 0;
         var _loc6_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().currentUserLogin;
         if(_loc6_ != "undefined" && _loc6_ != _loc8_.poptropica_user.login)
         {
            var _loc9_ = _loc6_.substr(0,5);
            if(_loc9_ == "GUEST")
            {
               this._asset.contentContainer.content.quidgetAsset.char_photo_quidget._visible = true;
               this._asset.contentContainer.content.quidgetAsset.preloader._visible = false;
               _global.photoQuidgetLoaded = true;
               return undefined;
            }
            _loc5_.lookup_user = _loc6_;
         }
         if(_loc5_.login != undefined && _loc5_.login != "")
         {
            _loc5_.sendAndLoad(com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/photos/get_user_photos.php",receiver,"POST");
         }
      }
   }
   function loadPhotoToStage()
   {
      var _this = this;
      this._asset.contentContainer.content.quidgetAsset.tf.text = _this._numPhotos;
      this._asset.contentContainer.content.quidgetAsset.preloader._visible = false;
      if(this.allPhotos.length > 0)
      {
         var _loc5_ = new MovieClipLoader();
         var _loc4_ = new Object();
         _loc5_.loadClip(this.allPhotos[0].photoPath,this._asset.contentContainer.content.quidgetAsset.photoHolder);
         _loc4_.onLoadInit = function()
         {
            trace(":::::::" + _this._asset.contentContainer.content.quidgetAsset.photoHolder);
            var _loc3_ = _this._asset.contentContainer.content.quidgetAsset.photoHolder;
            if(_this.npc_friend)
            {
               _loc3_._x = 4;
               _loc3_._y = -6;
               _loc3_._xscale = 34;
               _loc3_._yscale = 34;
               _global.photoQuidgetLoaded = true;
            }
            else
            {
               _loc3_._xscale = 60;
               _loc3_._yscale = 60;
               _loc3_.SetCharacter(_this.allPhotos[0].photoLook);
               _this._asset.contentContainer.onEnterFrame = function()
               {
                  if(this.content.quidgetAsset.photoHolder.photoBMP)
                  {
                     delete this.onEnterFrame;
                     _global.photoQuidgetLoaded = true;
                  }
               };
            }
         };
         _loc5_.addListener(_loc4_);
      }
      else
      {
         this._asset.contentContainer.content.quidgetAsset.char_photo_quidget._visible = true;
         _global.photoQuidgetLoaded = true;
      }
   }
   function createRolloverIcons()
   {
   }
   function onAssetClick()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromSwf("photos/photoAlbum.swf",new flash.geom.Point(this._x + 60,this._y + 40),true,new flash.geom.Point(0,0));
   }
   function draw()
   {
      trace("[QuidgetPhotos] draw");
   }
   function isAccomplishment()
   {
      return true;
   }
   function isPersonality()
   {
      return false;
   }
   function get name()
   {
      return "photos";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " has " : " have ";
      _loc2_ += this._numPhotos + " photo" + (this._numPhotos != 1 ? "s." : ".");
      return _loc2_;
   }
   function updateQuidgetNum(num)
   {
      this._numPhotos = this._asset.contentContainer.content.quidgetAsset.tf.text = num;
   }
}
