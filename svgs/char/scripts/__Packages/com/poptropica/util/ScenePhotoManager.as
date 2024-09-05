class com.poptropica.util.ScenePhotoManager
{
   var preloadedEventArr;
   var _x;
   var _y;
   var distance;
   var onEnterFrame;
   var photoID;
   var preRegPhotos;
   static var instance;
   var allScenePhotos = [];
   var numLoaded = 0;
   function ScenePhotoManager()
   {
      com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.GlowFilterPlugin]);
      com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.FramePlugin]);
      this.preloadedEventArr = [];
   }
   static function getInstance()
   {
      if(com.poptropica.util.ScenePhotoManager.instance == undefined)
      {
         com.poptropica.util.ScenePhotoManager.instance = new com.poptropica.util.ScenePhotoManager();
      }
      return com.poptropica.util.ScenePhotoManager.instance;
   }
   function loadScenePhotos(sceneID)
   {
      this.allScenePhotos = [];
      var _loc6_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            var _loc4_ = new JSON();
            var _loc1_ = _loc4_.parse(receiver.json);
            for(var _loc3_ in _loc1_)
            {
               com.poptropica.util.ScenePhotoManager.instance.allScenePhotos.push(_loc1_[_loc3_]);
               if(_loc1_[_loc3_].field_name == "trigger_location")
               {
                  var _loc2_ = _loc1_[_loc3_].field_data.split(",");
                  com.poptropica.util.ScenePhotoManager.instance.createPhotoByLocation(_loc2_[0],_loc2_[1],_loc2_[2],_loc1_[_loc3_].item_id);
               }
            }
            com.poptropica.util.ScenePhotoManager.instance.checkPreloadedEvents();
         }
      };
      if(sceneID != "undefined" && sceneID != null)
      {
         _loc6_.scene_id = sceneID;
         _loc6_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/photos/get_scene_photos.php",receiver,"POST");
      }
      var _loc4_ = SharedObject.getLocal("Char","/");
      trace("LSO PHOTOS: " + _loc4_.data.photos);
      if(!_loc4_.data.photos)
      {
         com.poptropica.util.ScenePhotoManager.instance.loadUserPhotos(_loc4_.data.login,_loc4_.data.password,_loc4_.data.dbid,com.poptropica.models.PopModelConst.island);
      }
   }
   function checkEventForPhoto(eventName)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.allScenePhotos.length)
      {
         if(eventName == this.allScenePhotos[_loc2_].field_data)
         {
            this.takePhoto(this.allScenePhotos[_loc2_].item_id);
         }
         _loc2_ = _loc2_ + 1;
      }
      this.preloadedEventArr.push(eventName);
   }
   function checkItemForPhoto(itemNum)
   {
      flash.external.ExternalInterface.call("console.log","Checking item for photo");
      var _loc2_ = 0;
      while(_loc2_ < this.allScenePhotos.length)
      {
         if(itemNum == this.allScenePhotos[_loc2_].field_data)
         {
            this.takePhoto(this.allScenePhotos[_loc2_].item_id);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function checkPreloadedEvents()
   {
      if(this.preloadedEventArr.length > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < this.allScenePhotos.length)
         {
            var _loc3_ = this.allScenePhotos[_loc2_].field_data;
            if(this.getArrayPos(this.preloadedEventArr,_loc3_) != null)
            {
               this.takePhoto(this.allScenePhotos[_loc2_].item_id);
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      this.preloadedEventArr = [];
      this.preloadedEventArr = null;
   }
   function createPhotoByLocation(xPos, yPos, distance, photo_id)
   {
      var _loc3_ = _root.scene.createEmptyMovieClip("photo_" + _root.scene.getNextHighestDepth(),_root.scene.getNextHighestDepth());
      _loc3_._x = xPos;
      _loc3_._y = yPos;
      _loc3_.distance = distance;
      _loc3_.photoID = photo_id;
      _loc3_.onEnterFrame = function()
      {
         var _loc4_ = _root.scene.char._x - this._x;
         var _loc3_ = _root.scene.char._y - this._y;
         var _loc5_ = Math.sqrt(_loc4_ * _loc4_ + _loc3_ * _loc3_);
         if(_loc5_ < this.distance)
         {
            delete this.onEnterFrame;
            com.poptropica.util.ScenePhotoManager.instance.takePhoto(this.photoID);
            removeMovieClip(this);
         }
      };
   }
   function takePhoto(photo_id)
   {
      var _loc5_ = com.poptropica.util.ScenePhotoManager.instance.checkLSOforPhoto(photo_id);
      flash.external.ExternalInterface.call("console.log","HAS PHOTO " + photo_id + "? " + _loc5_);
      var _loc4_ = com.poptropica.models.PopModel.getInstance();
      if(!_loc4_.isRegistered)
      {
         com.poptropica.util.ScenePhotoManager.instance.savePhotoToLSO(photo_id);
         com.poptropica.util.ScenePhotoManager.instance.playPhotoNotification();
      }
      else if(!_loc5_)
      {
         com.poptropica.util.ScenePhotoManager.instance.savePhotoToLSO(photo_id);
         var _loc2_ = new LoadVars();
         var receiver = new LoadVars();
         receiver.onLoad = function(success)
         {
            if(receiver.answer == "ok")
            {
               com.poptropica.util.ScenePhotoManager.instance.playPhotoNotification();
               com.poptropica.util.FeedItemManager.getInstance().saveFeedItem(12003);
            }
         };
         if(photo_id)
         {
            _loc4_ = com.poptropica.models.PopModel.getInstance();
            var _loc6_ = _root.scene.char.avatar.getLook();
            _loc2_.login = _loc4_.poptropica_user.login;
            _loc2_.pass_hash = _loc4_.poptropica_user.password_hash;
            _loc2_.dbid = parseInt(_loc4_.db_id);
            _loc2_.look = _loc6_;
            _loc2_.look_item_id = photo_id;
            _loc2_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/photos/take_photo.php",receiver,"POST");
         }
      }
      else
      {
         flash.external.ExternalInterface.call("console.log","You already have this photo!");
      }
   }
   function playPhotoNotification()
   {
      function cameraFlash()
      {
         com.greensock.TweenMax.to(model.navbarMC.photoNotification,0.5,{delay:0.8,_alpha:100,_xscale:100,_yscale:100,ease:com.greensock.easing.Back.easeOut});
         com.greensock.TweenMax.to(model.navbarMC.camera,0.4,{_rotation:0,ease:com.greensock.easing.Strong.easeOut});
         com.greensock.TweenMax.to(model.navbarMC.camera.flashclip,1,{frame:50,ease:com.greensock.easing.Strong.easeIn,onComplete:cameraBack});
      }
      function cameraBack()
      {
         com.greensock.TweenMax.to(model.navbarMC.photoNotification,0.4,{delay:2.2,_alpha:0,_xscale:0,_yscale:0,ease:com.greensock.easing.Back.easeIn});
         com.greensock.TweenMax.to(model.navbarMC.friendshubBtn,0.4,{delay:2.2,_x:167,_y:-1,_xscale:100,_yscale:100,ease:com.greensock.easing.Back.easeIn});
         com.greensock.TweenMax.to(model.navbarMC.camera,0.4,{delay:2.2,_x:190,_y:11,_alpha:0,_xscale:0,_yscale:0,_rotation:-8,ease:com.greensock.easing.Back.easeIn,onComplete:iconComplete});
         com.greensock.TweenMax.to(model.navbarMC.friendshubBtn,0.4,{delay:1.7,glowFilter:{color:13421619,alpha:1,blurX:10,blurY:10,strength:3,quality:3}});
      }
      function iconComplete()
      {
         com.greensock.TweenMax.to(model.navbarMC.friendshubBtn,0.4,{_xscale:106,_yscale:106,glowFilter:{color:13421619,alpha:1,blurX:10,blurY:10,strength:3,quality:3},onComplete:iconBack});
      }
      function iconBack()
      {
         com.greensock.TweenMax.to(model.navbarMC.friendshubBtn,0.4,{_xscale:100,_yscale:100,glowFilter:{alpha:0,blurX:0,blurY:0}});
      }
      var model = com.poptropica.models.PopModel.getInstance();
      com.greensock.TweenMax.to(model.navbarMC.friendshubBtn,0.4,{_x:175,_y:-7,_xscale:100,_yscale:100,ease:com.greensock.easing.Back.easeOut,onComplete:cameraFlash});
      com.greensock.TweenMax.to(model.navbarMC.camera,0.4,{_x:158,_y:36,_alpha:100,_xscale:100,_yscale:100,_rotation:-8,ease:com.greensock.easing.Back.easeOut});
   }
   function savePhotoToLSO(photo_id)
   {
      var _loc2_ = SharedObject.getLocal("Char","/");
      var _loc3_ = [];
      if(_loc2_.data.photos)
      {
         _loc3_ = _loc2_.data.photos.split(",");
      }
      if(this.getArrayPos(_loc3_,photo_id) == null)
      {
         _loc3_.push(photo_id);
         var _loc4_ = _loc3_.join(",");
         _loc2_.data.photos = _loc4_;
         _loc2_.flush();
      }
   }
   function checkLSOforPhoto(photo_id)
   {
      var _loc2_ = SharedObject.getLocal("Char","/");
      var _loc3_ = [];
      if(_loc2_.data.photos)
      {
         _loc3_ = _loc2_.data.photos.split(",");
      }
      if(this.getArrayPos(_loc3_,photo_id) != null)
      {
         return true;
      }
      return false;
   }
   function loadPreregPhotos()
   {
      var _loc2_ = SharedObject.getLocal("Char","/");
      if(_loc2_.data.photos)
      {
         this.preRegPhotos = _loc2_.data.photos.split(",");
         this.loadPhoto();
      }
   }
   function loadPhoto()
   {
      var _this = this;
      clearInterval(_this.my_int);
      var _loc3_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            _this.numLoaded = _this.numLoaded + 1;
            if(_this.numLoaded < _this.preRegPhotos.length)
            {
               _this.my_int = setInterval(_this,"loadPhoto",100);
            }
         }
      };
      var _loc4_ = SharedObject.getLocal("Char","/");
      var _loc6_ = com.poptropica.models.PopModel.getInstance();
      var _loc5_ = _root.scene.char.avatar.getLook();
      _loc3_.login = _loc4_.data.login;
      _loc3_.pass_hash = _loc4_.data.password;
      _loc3_.dbid = parseInt(_loc4_.data.dbid);
      _loc3_.look = _loc5_;
      _loc3_.look_item_id = _this.preRegPhotos[_this.numLoaded];
      if(_loc3_.look_item_id == undefined || _loc3_.look_item_id == "" || !_loc3_.look_item_id)
      {
         return undefined;
      }
      _loc3_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/photos/take_photo.php",receiver,"POST");
   }
   function loadUserPhotos(login, pass, dbid, island)
   {
      var _loc8_ = com.poptropica.models.PopModel.getInstance();
      var _loc4_ = _loc8_.poptropica_user.login;
      var _loc5_ = _loc4_.substr(0,5);
      if(_loc5_ == "GUEST")
      {
         return undefined;
      }
      var lso = SharedObject.getLocal("Char","/");
      var photoArr = [];
      var _loc1_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            var _loc3_ = new JSON();
            var _loc1_ = _loc3_.parse(receiver.json);
            for(var _loc2_ in _loc1_)
            {
               if(_loc2_ != "counts")
               {
                  photoArr.push(_loc2_);
               }
            }
            var _loc4_ = photoArr.join(",");
            lso.data.photos = _loc4_;
            lso.flush();
         }
         else
         {
            trace("Error: " + receiver);
         }
      };
      _loc1_.login = login;
      _loc1_.pass_hash = pass;
      _loc1_.dbid = dbid;
      _loc1_.quantity = 10;
      _loc1_.offset = 0;
      _loc1_.island = island;
      if(_loc1_.login != undefined && _loc1_.login != "")
      {
         _loc1_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/photos/get_user_photos.php",receiver,"POST");
      }
   }
   function updateIslandPhotos(photoArr)
   {
      trace("adding photos to LSO");
      var _loc1_ = SharedObject.getLocal("Char","/");
      var _loc2_ = photoArr.join(",");
      _loc1_.data.photos = _loc2_;
      _loc1_.flush();
      trace(_loc2_);
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
