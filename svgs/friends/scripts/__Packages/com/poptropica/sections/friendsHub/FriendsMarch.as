class com.poptropica.sections.friendsHub.FriendsMarch
{
   var _objId;
   var _json;
   var _friendNotFoundCount;
   var _lso;
   var _sortOrder;
   var _scrollUntilFriendFound;
   var _usernamesToAddArr;
   var _phpCallStack;
   var _phpCallInProgress;
   var _slider;
   var _selectedFilter;
   var _hilitedFilter;
   var _numFriends;
   var _asset;
   var _scrollPaused;
   var _dropDown;
   var _keyListener;
   var _addFriendPopup;
   var _userChar;
   var _usernameToAdd;
   var _phpScript;
   var _phpResults;
   var _phpCompleteFn;
   var _selectedCharLogin;
   var _friendClipArr;
   var _sliderOrigX;
   var _arrowLeft;
   var _arrowRight;
   var _orientation;
   var _waitClip;
   var mc;
   var controller;
   var _minX;
   var _tfUserName;
   var _deleteFriendConfirmPopup;
   var _curSpeed;
   static var __instance;
   static var instance;
   static var SCROLL_ACTIVE_RECT;
   static var MAX_X;
   static var FRIEND_CENTER_PT;
   static var NPC_FRIEND_PREFIX = "npc:";
   var _friendsDataArr = [];
   var _getFriendsPhpInProgress = false;
   var _firstVisibleFriendIndex = 0;
   var _offset = 0;
   static var STAND = 0;
   static var LEFT = 1;
   static var RIGHT = -1;
   static var ITEM_SPACE = 90;
   static var ITEM_SCALE = 100;
   static var MAX_VIS = 8;
   static var MAX_AVATARS = 15;
   static var SCROLL_SPEED = 20;
   static var MIN_SPEED = 0.4;
   static var MIN_SCROLL = 40;
   static var MID_X = 450;
   static var FRIENDS_TO_LOAD_PER_CALL = 15;
   function FriendsMarch()
   {
      this._objId = random(9999);
      trace("[FriendsMarch " + this._objId + "] constructor");
      com.poptropica.sections.friendsHub.FriendsMarch.__instance = this;
      mx.events.EventDispatcher.initialize(this);
      this._json = new asLib.JSON();
      this._friendNotFoundCount = 0;
      this._lso = SharedObject.getLocal("Char","/");
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
      if(com.poptropica.sections.friendsHub.FriendsMarch.instance == undefined)
      {
         com.poptropica.sections.friendsHub.FriendsMarch.instance = new com.poptropica.sections.friendsHub.FriendsMarch();
      }
      return com.poptropica.sections.friendsHub.FriendsMarch.instance;
   }
   function init()
   {
      trace("[FriendsMarch " + this._objId + "] init() ");
      trace("[FriendsMarch] !!!!! FriendsModel.getInstance().initialUserLogin:" + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin);
      this._sortOrder = "activity";
      this._scrollUntilFriendFound = false;
      this._offset = 0;
      this._usernamesToAddArr = [];
      this._phpCallStack = [];
      this._phpCallInProgress = false;
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("open",Delegate.create(this,this.setScrollingPauseTrue));
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("close",Delegate.create(this,this.setScrollingPauseFalse));
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("close",Delegate.create(this,this.onPopupClose));
      com.poptropica.sections.friendsHub.Quilt.getInstance().addEventListener("close",Delegate.create(this,this.onQuiltClosed));
      com.poptropica.sections.friendsHub.FriendsMarch.SCROLL_ACTIVE_RECT = new flash.geom.Rectangle(0,43,762,150);
      com.poptropica.sections.friendsHub.FriendsMarch.MAX_X = this._slider._x;
      com.poptropica.sections.friendsHub.FriendsMarch.FRIEND_CENTER_PT = new flash.geom.Point(430,115);
      this._selectedFilter = new flash.filters.GlowFilter(5614335,30,5,5,5,5);
      this._hilitedFilter = new flash.filters.GlowFilter(16776960,0.8,4,4,4,4);
      this.clearSelected();
      this.resetSlider();
      if(this._lso.data.numFriends == undefined)
      {
         this.addPhpCallToStack("get_friend_count");
      }
      else
      {
         this._numFriends = this._lso.data.numFriends;
         this.addPhpCallToStack("get_friends_list");
      }
      this.loadUserChar();
      this._asset.friendSpotlight._visible = false;
      this._asset.userSpotlight._visible = false;
      this._scrollPaused = false;
      this._asset.btnAdd.onRelease = Delegate.create(this,this.onBtnAddFriendClick);
      this.setBtnRollovers(this._asset.btnAdd);
      this._asset.mcCover.onRelease = function()
      {
      };
      this.setBtnActive(this._asset.btnDelete,false);
      this.setBtnActive(this._asset.btnCostumizer,false);
      this._dropDown = new com.poptropica.components.dropDown.DropDownMenu();
      this._dropDown.setDropDownMC(this._asset.mcDropDown);
      this._dropDown.addEventListener("itemSelected",Delegate.create(this,this.onDropdownSelected));
      var _loc2_ = [];
      _loc2_.push({label:"NEWEST",val:"friending"});
      _loc2_.push({label:"MOST ACTIVE",val:"activity"});
      var _loc3_ = {friending:"NEWEST",activity:"MOST ACTIVE",tribe:"MY TRIBE"};
      this._dropDown.initialLabel = _loc3_[this._sortOrder];
      this._dropDown.setData(_loc2_);
      this._keyListener = new Object();
      this._keyListener.onKeyDown = Delegate.create(this,this.onKeydown);
      Key.addListener(this._keyListener);
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().addEventListener("playerTribeChanged",Delegate.create(this,this.onPlayerTribeChanged));
   }
   function onPlayerTribeChanged()
   {
      this.loadUserChar();
   }
   function onDropdownSelected(a)
   {
      trace("[FriendsMarch " + this._objId + "]onDropDownMenuItemSelected. value:" + a.selectedItem.val);
      this._sortOrder = a.selectedItem.val;
      this.reloadFriends();
   }
   function onQuiltClosed()
   {
   }
   function onBtnAddFriendClick()
   {
      if(!this._addFriendPopup)
      {
         this._addFriendPopup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("addFriendPopup",com.poptropica.sections.friendsHub.FriendsMarch.FRIEND_CENTER_PT);
         this.setupAddFriendPopup();
      }
      else
      {
         com.poptropica.sections.quidget.PopupManager.getInstance().reshowPopup(this._addFriendPopup);
      }
   }
   function set visible(b)
   {
      this._asset._visible = b;
   }
   function onPopupClose()
   {
      this._addFriendPopup = undefined;
   }
   function loadUserChar()
   {
      var _loc2_ = new MovieClipLoader();
      _loc2_.loadClip("char.swf",this._userChar.mcChar.charContainer);
      this._userChar.mcChar.onEnterFrame = Delegate.create(this,this.checkUserCharLoaded);
   }
   function checkUserCharLoaded()
   {
      if(this._userChar.mcChar.charContainer.loadingFinished)
      {
         delete this._userChar.mcChar.onEnterFrame;
         this.drawUser();
      }
   }
   function drawUser()
   {
      this._userChar._xscale = - com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SCALE;
      this._userChar._yscale = com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SCALE;
      this._userChar.mcChar.charContainer.createBackPlayer();
      this._userChar.mcChar.charContainer.avatar.nextFrame();
      this._userChar.mcChar.charContainer.avatar.setParts();
      this._userChar.mcBtn.mc = this._userChar;
      this.setRolloverCallbacks(this._userChar.mcBtn);
      this._userChar.mcBtn.onRelease = Delegate.create(this,this.onUserClick);
   }
   function setupAddFriendPopup()
   {
      this._addFriendPopup.btnOk.onRelease = Delegate.create(this,this.onAddOkClick);
      this._addFriendPopup.btnFindFriends.onRelease = Delegate.create(this,this.onFindFriendsClick);
      this._asset.loadingIcon._visible = false;
      var _loc2_ = this._addFriendPopup.tfUserNameEntry;
      _loc2_.onSetFocus = Delegate.create(this,this.onAddFriendTfClick);
      this._addFriendPopup.tfMsg.text = "";
   }
   function onAddFriendTfClick()
   {
      trace("[FriendsMarch] onAddFriendTfClick");
      if(this._addFriendPopup.tfUserNameEntry.text == "username")
      {
         this._addFriendPopup.tfUserNameEntry.text = "";
      }
   }
   function onKeydown()
   {
      if(Key.getCode() == 13)
      {
         var _loc2_ = Selection.getFocus();
         if(this._addFriendPopup != undefined && _loc2_.indexOf("tfUserName") != -1)
         {
            this.onAddOkClick();
         }
      }
   }
   function getNextUserNameToAdd()
   {
      this._usernameToAdd = "";
      if(this._usernamesToAddArr.length > 0)
      {
         if(this._usernameToAdd != this._usernamesToAddArr[0])
         {
            this._usernameToAdd = this._usernamesToAddArr[0];
            this._usernamesToAddArr.splice(0,1);
         }
         else
         {
            this._usernamesToAddArr = [];
         }
      }
      trace("[FriendsMarch] getNextUserNameToAdd:" + this._usernameToAdd);
   }
   function onAddOkClick()
   {
      var _loc2_ = this._addFriendPopup.tfUserNameEntry.text;
      _loc2_ = _loc2_.split("!@#$%^&")[0];
      this._usernamesToAddArr.push(_loc2_);
      this._addFriendPopup.tfUserNameEntry.text = "";
      trace("[FriendsMarch] **************onAddOkClick _usernamesToAddArr:" + this._usernamesToAddArr);
      this.getNextUserNameToAdd();
      if(this._usernameToAdd != "" && this._usernameToAdd != undefined)
      {
         if(this._usernameToAdd.split(" ").length > 1)
         {
            this._addFriendPopup.tfMsg.text = "Can\'t find " + this._usernameToAdd + ". Please try again.";
            this._addFriendPopup.mcHelpMsg.gotoAndPlay("open");
         }
         else
         {
            this.addFriend();
         }
      }
   }
   function addFriend()
   {
      trace("[FriendsMarch] addFriend()");
      this._addFriendPopup.btnOk._alpha = 30;
      this._addFriendPopup.tfMsg.text = "adding " + this._usernameToAdd + "...";
      var _loc2_ = 1;
      if(this._usernameToAdd.substr(0,4) == com.poptropica.sections.friendsHub.FriendsMarch.NPC_FRIEND_PREFIX)
      {
         _loc2_ = 2;
      }
      this.addPhpCallToStack("add_friend",{favorite:_loc2_,completeFn:this.onAddFriendPhpComplete});
   }
   function onCostumizerClick()
   {
      trace("[FriendsMarch " + this._objId + "] onCostumizerClick");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupCostumizerReady));
      _root.modelLook = this.selectedChar.userData[3].split(",");
      com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromSwf("popups/wardrobe.swf",new flash.geom.Point(400,this._asset._y + 40),true,new flash.geom.Point(90,0));
      this._asset.btnCostumizer.tfLoading.text = "...";
      this.setBtnActive(this._asset.btnCostumizer,false);
   }
   function onPopupCostumizerReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      var _loc3_ = e.popup;
      _loc3_.bg._visible = false;
      _loc3_.context = "friendsHub";
      _loc3_.addEventListener("playerLookChanged",Delegate.create(this,this.onPlayerLookChanged));
      this.setBtnActive(this._asset.btnCostumizer,true,this.onCostumizerClick);
      this._asset.btnCostumizer.tfLoading.text = "";
   }
   function onPlayerLookChanged(e)
   {
      trace("[FriendsMarch " + this._objId + "] onPlayerLookChange look:" + e.look);
      this._userChar.mcChar.charContainer.avatar.setLook(e.look);
      this._userChar.mcChar.charContainer.avatar.setParts();
   }
   function onFriendPopupErrorOkClick()
   {
      this._addFriendPopup.gotoAndPlay(1);
      this._addFriendPopup.onEnterFrame = Delegate.create(this,this.onCheckFriendPopupReachedFirstFrame);
   }
   function onCheckFriendPopupReachedFirstFrame()
   {
      this._addFriendPopup.tfMsg.text = "";
      delete this._addFriendPopup.onEnterFrame;
      this._addFriendPopup.btnOk.onRelease = Delegate.create(this,this.onAddOkClick);
   }
   function addPhpCallToStack(s, pVars)
   {
      trace("[FriendsMarch] addPhpCallToStack");
      this._phpCallStack.push({script:s,vars:pVars});
      if(!this._phpCallInProgress)
      {
         this.checkNextPhpCall();
      }
   }
   function loadPhp(s, pVars)
   {
      trace("[FriendsMarch " + this._objId + "] -----------------loadphp:" + s);
      this._phpScript = s;
      this._phpResults = new LoadVars();
      this._phpCallInProgress = true;
      var _loc3_ = new LoadVars();
      _loc3_.login = com.poptropica.models.PopModelConst.avatar.loadLogin();
      _loc3_.pass_hash = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.password;
      _loc3_.logged_in = !com.poptropica.models.PopModelConst.avatar.isRegistred() ? 0 : 1;
      _loc3_.dbid = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.dbid;
      var _loc5_ = undefined;
      switch(this._phpScript)
      {
         case "remove_friend":
            _loc5_ = "friends";
            _loc3_.friend_login = this.selectedChar.userData[0];
            _loc3_.method = 1;
            this._phpCompleteFn = this.onRemoveFriendPhpComplete;
            break;
         case "add_friend":
            _loc5_ = "friends";
            _loc3_.friend_login = this._usernameToAdd;
            _loc3_.favorite = pVars.favorite;
            _loc3_.method = 1;
            this._phpCompleteFn = pVars.completeFn;
            break;
         case "get_friends_list":
            _loc5_ = "friends";
            _loc3_.limit = com.poptropica.sections.friendsHub.FriendsMarch.FRIENDS_TO_LOAD_PER_CALL;
            _loc3_.offset = this._offset;
            _loc3_.order = this._sortOrder;
            if(this._offset == 0)
            {
               this._phpCompleteFn = this.onGetFriendsListPhpCompleteInitial;
            }
            else
            {
               this._phpCompleteFn = this.onGetFriendsListPhpComplete;
            }
            this._asset.friendSpotlight._x = -1000;
            this._getFriendsPhpInProgress = true;
            break;
         case "get_friend_count":
            _loc5_ = "friends";
            this._phpCompleteFn = this.onGetFriendCountPhpComplete;
      }
      if(_root._url.indexOf("file:/") != -1)
      {
         _loc3_.login = "pizmogames";
         _loc3_.pass_hash = "95ebc3c7b3b9f1d2c40fec14415d3cb8";
         _loc3_.logged_in = 1;
         _loc3_.dbid = 1;
      }
      this._phpResults.onLoad = Delegate.create(this,this.onPhpCallComplete);
      var _loc6_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/" + _loc5_ + "/" + this._phpScript + ".php";
      _loc3_.sendAndLoad(_loc6_,this._phpResults,"POST");
      trace("[FriendsMarch " + this._objId + "]----- " + _loc6_ + " -----------");
      for(var _loc4_ in _loc3_)
      {
         trace("[FriendsMarch " + this._objId + "] postVars." + _loc4_ + " = " + _loc3_[_loc4_]);
      }
   }
   function onPhpCallComplete(success)
   {
      this._phpCallInProgress = false;
      this._phpCompleteFn(success);
      this.checkNextPhpCall();
   }
   function checkNextPhpCall()
   {
      if(this._phpCallStack.length > 0)
      {
         var _loc2_ = this._phpCallStack.splice(0,1)[0];
         this.loadPhp(_loc2_.script,_loc2_.vars);
      }
   }
   function onRemoveFriendPhpComplete(success)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
      if(success)
      {
         this._numFriends = this._numFriends - 1;
         this._lso.data.numFriends = this._numFriends;
         this._lso.data.flush();
         this.reloadFriends();
      }
   }
   function reloadFriends()
   {
      trace("[FriendsMarch] reloadFriends");
      this.cleanUp();
      this.addPhpCallToStack("get_friends_list");
      this._scrollPaused = true;
      this._asset.loadingIcon._visible = true;
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isQuiltOpen && !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this.selectChar(this._userChar);
      }
      else
      {
         this.clearSelected();
      }
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchNumFriendsChanged();
   }
   function clearSelected()
   {
      this.clearSelectedCharHilite();
      this._selectedCharLogin = undefined;
      this.updateFriendSpotlight();
      this.updateUserSpotlight();
   }
   function onAddFriendPhpComplete(success)
   {
      trace("[FriendsMarch " + this._objId + "] onAddFriendPhpComplete  \n   -----------> success:" + success);
      for(var _loc3_ in this._phpResults)
      {
         trace(_loc3_ + "[FriendsMarch]  " + _loc3_ + " = " + this._phpResults[_loc3_]);
      }
      var _loc2_ = "";
      if(success)
      {
         if(this._phpResults.answer == "ok")
         {
            this._numFriends = this._numFriends + 1;
            this._lso.data.numFriends = this._numFriends;
            this._lso.flush();
         }
         trace("[FriendsMarch] _usernamesToAddArr:" + this._usernamesToAddArr);
         if(this._usernamesToAddArr.length == 0)
         {
            switch(this._phpResults.answer)
            {
               case "item-already-there":
                  _loc2_ = this._usernameToAdd + " is already a friend.";
                  break;
               case "ok":
                  com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
                  this.cleanUp();
                  this._scrollPaused = true;
                  this._asset.loadingIcon._visible = true;
                  com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchNumFriendsChanged();
                  if(this._sortOrder != "friending")
                  {
                     this._dropDown.setItemByValue("friending",true);
                  }
                  this.addPhpCallToStack("get_friends_list");
                  break;
               case "no-such-friend-login":
                  _loc2_ = "Can\'t find " + this._usernameToAdd + ". Please try again.";
                  this._friendNotFoundCount = this._friendNotFoundCount + 1;
                  if(this._friendNotFoundCount >= 2)
                  {
                     this._addFriendPopup.mcHelpMsg.gotoAndPlay("open");
                  }
                  break;
               case "cannot-friend-yourself":
                  _loc2_ = "That\'s you! You can\'t friend yourself :)";
            }
         }
      }
      else
      {
         _loc2_ = "Communication error. Please try later.";
      }
      if(_loc2_ != "")
      {
         this._addFriendPopup.tfMsg.text = _loc2_;
         this._addFriendPopup.btnOk._alpha = 100;
      }
      this.getNextUserNameToAdd();
      if(this._usernameToAdd != "" && this._usernameToAdd != undefined)
      {
         this.addFriend();
      }
      else
      {
         trace("[FriendsMarch] no more friends to add");
      }
   }
   function onCheckFriendPopupReachedErrorFrame()
   {
      delete this._addFriendPopup.onEnterFrame;
      this._addFriendPopup.btnOkError.onRelease = Delegate.create(this,this.onFriendPopupErrorOkClick);
   }
   function onGetFriendCountPhpComplete()
   {
      trace("[FriendsMarch] onGetFriendCountPhpComplete");
      this._numFriends = this._phpResults.n_friends;
      this._lso.data.numFriends = this._phpResults.n_friends;
      this._lso.flush();
      this.addPhpCallToStack("get_friends_list");
   }
   function onGetFriendsListPhpCompleteInitial(success)
   {
      trace("[FriendsMarch] onGetFriendsListPhpCompleteInitial");
      if(success)
      {
         this.loadFriendChars();
      }
      this.onGetFriendsListPhpComplete(success);
   }
   function onGetFriendsListPhpComplete(success)
   {
      trace("[FriendsMarch " + this._objId + "] onGetFriendsListPhpComplete. success:" + success);
      this._getFriendsPhpInProgress = false;
      this._scrollPaused = false;
      var _loc6_ = "";
      if(this._phpResults.answer == undefined)
      {
         return undefined;
      }
      for(var _loc7_ in this._phpResults.json)
      {
         trace("[FriendsMarch. " + this._objId + "]  phpResults.     " + _loc7_ + ":" + this._phpResults.json[_loc7_]);
      }
      if(success)
      {
         var _loc0_ = null;
         if((_loc0_ = this._phpResults.answer) !== "ok")
         {
            _loc6_ = "The friend features are not available. Please check back later.";
         }
         else
         {
            var _loc3_ = [];
            var _loc4_ = this._json.parse(this._phpResults.json);
            trace("[FriendsMarch] _phpResults.json:" + this._phpResults.json);
            for(_loc7_ in _loc4_)
            {
               _loc3_[_loc7_] = _loc4_[_loc7_];
            }
            var _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               this._friendsDataArr[_loc2_ + this._offset] = _loc3_[_loc2_];
               _loc2_ = _loc2_ + 1;
            }
            if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin != undefined)
            {
               var _loc5_ = -1;
               _loc2_ = 0;
               while(_loc2_ < this._friendsDataArr.length)
               {
                  if(this._friendsDataArr[_loc2_][0] == com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin)
                  {
                     _loc5_ = _loc2_;
                  }
                  _loc2_ = _loc2_ + 1;
               }
               trace("posFound:" + _loc5_ + "  FriendsModel.getInstance().initialUserLogin:" + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin);
               if(_loc5_ != -1 && _loc5_ >= 7)
               {
                  this._scrollUntilFriendFound = true;
               }
               trace("[FriendsMarch] posFound:" + _loc5_ + " username:" + this._friendsDataArr[0][0]);
            }
            _loc2_ = 0;
            while(_loc2_ < this._friendClipArr.length)
            {
               this.setFriendLook(this._friendClipArr[_loc2_]);
               _loc2_ = _loc2_ + 1;
            }
            this.removeLoadingScreen();
         }
      }
      else
      {
         _loc6_ = "There was a problem loading friends. Please try again later.";
      }
      if(_loc6_ != "")
      {
         trace("[FriendsMarch] error found:" + _loc6_);
         this._asset.mcTopMsg._visible = true;
         this._asset.mcTopMsg.tf.text = _loc6_;
         this._asset.loadingBlocker._visible = true;
      }
   }
   function set asset(mc)
   {
      this._asset = mc;
      this._asset.userSpotlight._visible = false;
      this._userChar = this._asset.userChar;
      this._slider = mc.slider;
      this._sliderOrigX = this._slider._x;
      this._arrowLeft = mc.arrowLeft;
      this._arrowRight = mc.arrowRight;
      this._asset.mcFindFriendsMsg.btn.onRelease = Delegate.create(this,this.onFindFriendsClick);
      var _loc2_ = [];
      _loc2_.push(com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.login);
      _loc2_.push(com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.firstName + " " + com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.lastName);
      this._userChar.userData = _loc2_;
      this._asset.mcTopMsg._visible = false;
   }
   function onFindFriendsClick()
   {
      var _loc1_ = com.poptropica.models.PopModel.getInstance();
      var _loc4_ = new com.poptropica.controllers.PopController(_loc1_);
      var _loc3_ = _loc1_.camera.scene.char.avatar.FunBrain_so.data.partyRoom;
      if(_loc1_.desc != "FriendsRoom" && !_loc3_)
      {
         _loc1_.camera.scene.char.avatar.FunBrain_so.data.lastRoom = _loc1_.desc;
         _loc1_.camera.scene.char.avatar.FunBrain_so.data.lastIsland = com.poptropica.models.PopModelConst.island;
         _loc1_.camera.scene.char.avatar.FunBrain_so.flush();
      }
      _loc1_.camera.scene.char.loadScene("FriendsRoom",1003,778,"Friends");
      var _loc2_ = !_loc1_.isActiveMember() ? "NonMember" : "Member";
      com.poptropica.controllers.PopController.getInstance().track("Friends","FindFriend",_loc2_,"",false,"Hub");
   }
   function get asset()
   {
      return this._asset;
   }
   function setScrollingPauseFalse()
   {
      this._scrollPaused = false;
   }
   function setScrollingPauseTrue()
   {
      this._scrollPaused = true;
   }
   function loadFriendChars()
   {
      trace("[FriendsMarch " + this._objId + "] loadFriendChars() numFriends:" + this._numFriends + "\nthis.asset:" + this.asset);
      var _loc5_ = new MovieClipLoader();
      if(this._numFriends == 0)
      {
         this.onBtnAddFriendClick();
      }
      else
      {
         this._asset.numClip.label_txt.text = this._numFriends;
         this._friendClipArr = new Array();
         this._orientation = com.poptropica.sections.friendsHub.FriendsMarch.STAND;
         var _loc2_ = undefined;
         var _loc4_ = Math.min(com.poptropica.sections.friendsHub.FriendsMarch.MAX_AVATARS,this._numFriends);
         var _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this._slider.attachMovie("friendContainer","c" + _loc3_,_loc3_);
            _loc2_._x = com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE * _loc3_;
            _loc2_._y = 96;
            _loc2_._xscale = _loc2_._yscale = com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SCALE;
            _loc5_.loadClip("char.swf",_loc2_.mcChar.charContainer);
            _loc2_.mcStar.gotoAndStop(1);
            _loc2_.mcStar._visible = false;
            _loc2_.mcStar.mcLoading._visible = false;
            _loc2_.mcStar.onRelease = com.poptropica.util.EventDelegate.create(this,this.onStarClick,_loc2_);
            _loc2_.mcStar.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onBtnRollover,_loc2_.mcStar);
            _loc2_.mcStar.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onBtnRollout,_loc2_.mcStar);
            this._friendClipArr[_loc3_] = _loc2_;
            _loc3_ = _loc3_ + 1;
         }
      }
      this.waitLoads();
   }
   function onStarClick(mc)
   {
      mc.mcStar.gotoAndStop(3 - mc.mcStar._currentframe);
      this._usernameToAdd = mc.userData[0];
      this.addPhpCallToStack("add_friend",{favorite:Number(mc.mcStar._currentframe == 2),completeFn:this.onAddFriendPhpComplete});
   }
   function onBtnRollover(mc)
   {
      mc.filters = [this._hilitedFilter];
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
   }
   function onBtnRollout(mc)
   {
      mc.filters = [];
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function waitLoads()
   {
      trace("[FriendsMarch " + this._objId + "] waitLoads");
      this._waitClip = com.poptropica.sections.friendsHub.FriendsMarch.getInstance().asset.createEmptyMovieClip("waiter",com.poptropica.sections.friendsHub.FriendsMarch.getInstance().asset.getNextHighestDepth());
      trace("_WaitClip: " + this._waitClip);
      this._waitClip.onEnterFrame = Delegate.create(com.poptropica.sections.friendsHub.FriendsMarch.getInstance(),this.onWaitStep);
   }
   function onWaitStep()
   {
      var _loc4_ = 0;
      var _loc2_ = 0;
      while(_loc2_ < this._friendClipArr.length)
      {
         if(this._friendClipArr[_loc2_].mcChar.charContainer.loadingFinished)
         {
            this._friendClipArr[_loc2_].mcChar._visible = true;
            this._friendClipArr[_loc2_].mcStar._visible = true;
            _loc4_ = _loc4_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc4_ >= this._friendClipArr.length)
      {
         this._waitClip.removeMovieClip();
         this.initFriendChars();
         var _loc3_ = undefined;
         if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin != undefined)
         {
            if(this._userChar.userData[0] == com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin)
            {
               _loc3_ = this._userChar;
            }
            _loc2_ = 0;
            while(_loc2_ < this._friendClipArr.length)
            {
               if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin == this._friendClipArr[_loc2_].userData[0])
               {
                  _loc3_ = this._friendClipArr[_loc2_];
               }
               _loc2_ = _loc2_ + 1;
            }
            if(_loc3_ != undefined)
            {
               this.selectChar(_loc3_);
               trace("[FriendsMarch] found the initial user :" + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin);
            }
            else
            {
               trace("[FriendsMarch] error! Could not find initialUserLogin:" + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin);
            }
         }
      }
   }
   function initFriendChars()
   {
      trace("[FriendsMarch " + this._objId + "] initFriendChars ");
      var mc;
      var _loc2_ = 0;
      while(_loc2_ < com.poptropica.sections.friendsHub.FriendsMarch.MAX_AVATARS)
      {
         mc = this._friendClipArr[_loc2_];
         mc._x = com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE * _loc2_;
         mc.ind = _loc2_;
         mc.tfIndex.text = mc.ind;
         mc.mcChar.charContainer.charState = "stand";
         this.setFriendLook(mc);
         mc.mcChar.charContainer.avatar.nextFrame();
         delete mc.btn.onRelease;
         mc.mcBtn.controller = this;
         mc.mcBtn.mc = mc;
         mc.mcBtn.onRelease = function()
         {
            this.controller.onFriendClick(this.mc);
         };
         this.setRolloverCallbacks(mc.mcBtn);
         _loc2_ = _loc2_ + 1;
      }
      this.drawArrows();
      com.greensock.TweenMax.delayedCall(0.002,this.removeLoadingScreen,null,this);
   }
   function drawArrows()
   {
      if(this._numFriends <= 6)
      {
         this._arrowLeft._visible = this._arrowRight._visible = false;
      }
      else
      {
         this._arrowLeft._visible = this._arrowRight._visible = true;
         this._minX = com.poptropica.sections.friendsHub.FriendsMarch.MAX_X + (com.poptropica.sections.friendsHub.FriendsMarch.MAX_VIS - this._numFriends) * com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE - 130;
         this._asset.onEnterFrame = Delegate.create(this,this.step);
         trace("[FriendsMarch] _minX:" + this._minX + "_numFriends:" + this._numFriends);
      }
   }
   function setRolloverCallbacks(mc)
   {
      mc.onRollOver = function()
      {
         com.poptropica.sections.friendsHub.FriendsMarch.__instance.onCharRollover(this.mc);
      };
      mc.onRollOut = function()
      {
         com.poptropica.sections.friendsHub.FriendsMarch.__instance.onCharRollout(this.mc);
      };
   }
   function step()
   {
      if(com.poptropica.sections.friendsHub.FriendsMarch.SCROLL_ACTIVE_RECT.contains(this._asset._xmouse,this._asset._ymouse) && !this._scrollPaused && this._numFriends > 6 || this._scrollUntilFriendFound)
      {
         this.checkScroll();
      }
      else
      {
         this.stopWalks();
      }
      if(this._scrollUntilFriendFound)
      {
         var _loc3_ = 0;
         while(_loc3_ < this._friendClipArr.length)
         {
            var _loc2_ = this._friendClipArr[_loc3_];
            if(_loc2_.userData[0] == com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin)
            {
               if(utils.ArrayUtils.getIndex(_loc2_,this._friendClipArr) < 6)
               {
                  trace("(mc.userData[0] == FriendsModel.getInstance().initialUserLogin:" + _loc2_.userData[0] + "," + com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin);
                  trace("mc.ind:" + _loc2_.ind + " array.indexOf:" + utils.ArrayUtils.getIndex(_loc2_,this._friendClipArr));
                  this._scrollUntilFriendFound = false;
                  com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin = undefined;
               }
            }
            _loc3_ = _loc3_ + 1;
         }
      }
      this.updateFriendSpotlight();
      this._asset.tfDebug.text = this._firstVisibleFriendIndex;
   }
   function updateFriendSpotlight()
   {
      if(this.selectedChar != undefined)
      {
         var _loc2_ = new flash.geom.Point(this.selectedChar._x,this.selectedChar._y);
         this.selectedChar._parent.localToGlobal(_loc2_);
         this._asset.globalToLocal(_loc2_);
         this._asset.friendSpotlight._x = _loc2_.x - 46;
      }
      else
      {
         this._asset.friendSpotlight._x = -9999;
      }
   }
   function updateUserSpotlight()
   {
      var _loc2_ = this._selectedCharLogin == this._userChar.userData[0];
      if(this._selectedCharLogin == undefined)
      {
         _loc2_ = false;
      }
      this._asset.userSpotlight._visible = _loc2_;
   }
   function removeLoadingScreen()
   {
      trace("[FriendsMarch " + this._objId + "] removeLoadingScreen. _asset.loadingBlocker:" + this._asset.loadingBlocker);
      this._asset.loadingBlocker._visible = false;
      this._asset.loadingIcon._visible = false;
   }
   function onUserClick()
   {
      trace("[FriendsMarch " + this._objId + "] onUserClick");
      if(this._selectedCharLogin != this._userChar)
      {
         this.selectChar(this._userChar);
      }
   }
   function selectUser()
   {
      this.selectChar(this._userChar);
   }
   function selectChar(char)
   {
      trace("[FriendsMarch " + this._objId + "] selectChar:" + char + "   old selected char:" + this.selectedChar.userData[0] + "   selectedCharLogin:" + this._selectedCharLogin);
      if(this.selectedChar != undefined)
      {
         this.clearSelectedCharHilite();
      }
      if(char != undefined)
      {
         char.mcChar.filters = [];
      }
      this._selectedCharLogin = char.userData[0];
      var _loc4_ = {type:"userSelected",login:this._selectedCharLogin};
      this.dispatchEvent(_loc4_);
      com.poptropica.sections.friendsHub.Quilt.getInstance().loadUser(_loc4_);
      char.mcChar.filters = [this._selectedFilter];
      var _loc3_ = char != this._userChar;
      this.setBtnActive(this._asset.btnDelete,_loc3_,this.onDeleteClick);
      this.setBtnActive(this._asset.btnCostumizer,_loc3_,this.onCostumizerClick);
      if(char.userData[1] == "undefined undefined")
      {
         if(char.userData[0].indexOf("GUEST;") >= 0)
         {
            char.userData[1] = "Guest Poptropican";
         }
         else
         {
            char.userData[1] = "Poptropican";
         }
      }
      else
      {
         char.userData[1] = this.scrubName(char.userData[1]);
      }
      this._tfUserName.text = char.userData[1];
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().currentUserLogin = char.userData[0];
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().currentUserAvatarName = char.userData[1];
      this.updateUserSpotlight();
      this._asset.friendSpotlight._visible = char != this._userChar;
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().clear();
   }
   function scrubName(name)
   {
      var _loc1_ = name.split(" ");
      var _loc2_ = _loc1_[0];
      var _loc3_ = _loc1_[1];
      var _loc4_ = com.poptropica.models.PopModelConst.avatar.FirstName;
      var _loc8_ = com.poptropica.models.PopModelConst.avatar.LastName;
      var _loc7_ = com.poptropica.models.PopModelConst.avatar.FirstNameCustom;
      var _loc5_ = com.poptropica.models.PopModelConst.avatar.LastNameCustom;
      if(!utils.ArrayUtils.searchArray(_loc2_,_loc4_) && !utils.ArrayUtils.searchArray(_loc2_,_loc7_))
      {
         return "Poptropican";
      }
      if(!utils.ArrayUtils.searchArray(_loc3_,_loc8_) && !utils.ArrayUtils.searchArray(_loc3_,_loc5_))
      {
         return "Poptropican";
      }
      var _loc6_ = _loc1_.join(" ");
      return _loc6_;
   }
   function setBtnActive(btn, b, fn)
   {
      if(b)
      {
         btn._alpha = 100;
         btn.onRelease = Delegate.create(this,fn);
         this.setBtnRollovers(btn);
      }
      else
      {
         btn._alpha = 50;
         delete btn.onRelease;
         this.clearBtnRollovers(btn);
      }
   }
   function setBtnRollovers(mc)
   {
      mc.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onBtnRollover,mc);
      mc.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onBtnRollout,mc);
   }
   function clearBtnRollovers(mc)
   {
      mc.onRollOver = function()
      {
      };
      mc.onRollOut = function()
      {
      };
   }
   function hiliteChar(char)
   {
      char.mcChar.filters = [this._hilitedFilter];
   }
   function unHiliteChar(char)
   {
      if(char.userData[0] != this._selectedCharLogin)
      {
         char.mcChar.filters = [];
      }
   }
   function onCharRollover(char)
   {
      if(char.userData[0] != "undefined undefined")
      {
         char.userData[1] = this.scrubName(char.userData[1]);
      }
      if(this._selectedCharLogin != char.userData[0])
      {
         this.hiliteChar(char);
      }
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
      var _loc3_ = undefined;
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isQuiltOpen)
      {
         _loc3_ = char.userData[1];
      }
      else if(char == this._userChar)
      {
         _loc3_ = "Click to view your profile.";
      }
      else
      {
         _loc3_ = "Click to view " + char.userData[1] + "\'s profile.";
      }
      trace("[FriendsMarch] rolling over user: " + char.userData[0] + " " + char.userData[1]);
      if(_loc3_ != undefined)
      {
         com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().setMessage(char,_loc3_,new flash.geom.Point(-10,-130));
      }
   }
   function onCharRollout(char)
   {
      if(this._selectedCharLogin != char.userData[0])
      {
         this.unHiliteChar(char);
      }
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().objRollout(char);
   }
   function onFriendClick(char)
   {
      this.selectChar(char);
      this._scrollPaused = true;
      com.greensock.TweenMax.delayedCall(2,this.setScrollingPauseFalse,null,this);
      this.updateFriendSpotlight();
   }
   function clearSelectedCharHilite()
   {
      this.selectedChar.mcChar.filters = [];
   }
   function onDeleteClick()
   {
      this._deleteFriendConfirmPopup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("friendDeleteConfirmPopup",com.poptropica.sections.friendsHub.FriendsMarch.FRIEND_CENTER_PT);
      this._deleteFriendConfirmPopup.btnYes.onRelease = Delegate.create(this,this.onFriendDeleteConfirm);
      this._deleteFriendConfirmPopup.btnNo.onRelease = Delegate.create(com.poptropica.sections.quidget.PopupManager.getInstance(),com.poptropica.sections.quidget.PopupManager.getInstance().closePopup);
   }
   function onFriendDeleteConfirm()
   {
      this._deleteFriendConfirmPopup.gotoAndStop(2);
      this.addPhpCallToStack("remove_friend");
   }
   function checkScroll()
   {
      var _loc3_ = com.poptropica.sections.friendsHub.FriendsMarch.MID_X - this._asset._parent._xmouse;
      if(this._scrollUntilFriendFound)
      {
         _loc3_ = -600;
      }
      var _loc2_ = _loc3_ / com.poptropica.sections.friendsHub.FriendsMarch.MID_X;
      this._curSpeed = _loc2_ * com.poptropica.sections.friendsHub.FriendsMarch.SCROLL_SPEED;
      if(this._curSpeed > 0)
      {
         this._arrowLeft._alpha = 100;
         this._arrowRight._alpha = 100 - _loc2_ * 100;
      }
      else
      {
         this._arrowRight._alpha = 100;
         this._arrowLeft._alpha = 100 + _loc2_ * 100;
      }
      this._curSpeed *= 0.9;
      if(Math.abs(this._curSpeed) < 0.4)
      {
         this._curSpeed = 0;
      }
      if(Math.abs(_loc3_) <= com.poptropica.sections.friendsHub.FriendsMarch.MIN_SCROLL || Math.abs(this._curSpeed) <= com.poptropica.sections.friendsHub.FriendsMarch.MIN_SPEED)
      {
         this._curSpeed = 0;
         if(this._orientation != com.poptropica.sections.friendsHub.FriendsMarch.STAND)
         {
            this.stopWalks();
         }
      }
      else if(this._curSpeed > 0)
      {
         this._slider._x += this._curSpeed;
         if(this._slider._x >= com.poptropica.sections.friendsHub.FriendsMarch.MAX_X)
         {
            this._slider._x = com.poptropica.sections.friendsHub.FriendsMarch.MAX_X;
            if(this._orientation != com.poptropica.sections.friendsHub.FriendsMarch.STAND)
            {
               this.stopWalks();
            }
         }
         else
         {
            if(this._orientation != com.poptropica.sections.friendsHub.FriendsMarch.RIGHT)
            {
               this._orientation = com.poptropica.sections.friendsHub.FriendsMarch.RIGHT;
               this.doWalks();
               this.flipScales();
            }
            var _loc4_ = this._friendClipArr[this._friendClipArr.length - 1];
            if(_loc4_._x + this._slider._x > com.poptropica.sections.friendsHub.FriendsMarch.MAX_X + 8 * com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE)
            {
               this.moveCharToBack(_loc4_);
            }
         }
      }
      else
      {
         this._slider._x += this._curSpeed;
         if(this._slider._x <= this._minX)
         {
            this._slider._x = this._minX;
            if(this._orientation != com.poptropica.sections.friendsHub.FriendsMarch.STAND)
            {
               this.stopWalks();
            }
         }
         else
         {
            if(this._orientation != com.poptropica.sections.friendsHub.FriendsMarch.LEFT)
            {
               this._orientation = com.poptropica.sections.friendsHub.FriendsMarch.LEFT;
               this.doWalks();
               this.flipScales();
            }
            _loc4_ = this._friendClipArr[0];
            if(_loc4_._x + this._slider._x < com.poptropica.sections.friendsHub.FriendsMarch.MAX_X - 2 * com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE)
            {
               this.moveCharToFront(_loc4_);
            }
         }
      }
   }
   function doWalks()
   {
      var _loc5_ = this._friendClipArr.length;
      var _loc2_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < _loc5_)
      {
         _loc2_ = this._friendClipArr[_loc3_].mcChar.charContainer.avatar;
         if(_loc2_._currentframe != 1)
         {
            _loc2_.gotoAndPlay("walk");
            var _loc4_ = _loc2_._currentframe + 8 * _loc3_ % 4;
            _loc2_.gotoAndPlay(_loc4_);
            _loc2_.walk(_loc2_.foot1,_loc2_.leg1);
            _loc2_.walk(_loc2_.foot2,_loc2_.leg2);
            _loc2_.swing(_loc2_.hand1,_loc2_.arm1);
            _loc2_.swing(_loc2_.hand2,_loc2_.arm2);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function stopWalks()
   {
      this._orientation = com.poptropica.sections.friendsHub.FriendsMarch.STAND;
      var _loc4_ = this._friendClipArr.length;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this._friendClipArr[_loc2_].mcChar.charContainer.avatar;
         if(_loc3_._currentframe != 1)
         {
            _loc3_.gotoAndPlay("stand");
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function moveCharToBack(mc)
   {
      if(this._firstVisibleFriendIndex == 0)
      {
         return undefined;
      }
      this._firstVisibleFriendIndex = this._firstVisibleFriendIndex - 1;
      mc._x = this._firstVisibleFriendIndex * com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE;
      this._friendClipArr.unshift(this._friendClipArr.pop());
      mc.ind = this._firstVisibleFriendIndex;
      mc.tfIndex.text = mc.ind;
      this.setFriendLook(mc);
   }
   function moveCharToFront(mc)
   {
      if(this._firstVisibleFriendIndex + this._friendClipArr.length == this._numFriends)
      {
         return undefined;
      }
      this._friendClipArr.push(this._friendClipArr.shift());
      mc.ind = this._firstVisibleFriendIndex + com.poptropica.sections.friendsHub.FriendsMarch.MAX_AVATARS;
      mc.tfIndex.text = mc.ind;
      mc._x = mc.ind * com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SPACE;
      this._firstVisibleFriendIndex = this._firstVisibleFriendIndex + 1;
      if(this._firstVisibleFriendIndex + com.poptropica.sections.friendsHub.FriendsMarch.MAX_AVATARS > this._friendsDataArr.length && this._friendsDataArr.length < this._numFriends)
      {
         if(!this._getFriendsPhpInProgress)
         {
            this._offset += com.poptropica.sections.friendsHub.FriendsMarch.FRIENDS_TO_LOAD_PER_CALL;
            this.addPhpCallToStack("get_friends_list");
         }
      }
      this.setFriendLook(mc);
   }
   function setFriendLook(mc)
   {
      var _loc4_ = this._friendsDataArr[mc.ind];
      if(_loc4_ != undefined)
      {
         mc.mcChar.charContainer.avatar.setLook(_loc4_[3].split(","));
         mc.onEnterFrame = com.poptropica.util.EventDelegate.create(this,this.removeSpecialAbilities,mc);
         mc.mcChar.charContainer.avatar.setParts();
         mc.mcStar._visible = true;
         var _loc7_ = Number(_loc4_[2]) + 1;
         mc.mcStar.gotoAndStop(_loc7_);
         if(_loc7_ == 3)
         {
            mc.mcStar.onRelease = null;
            mc.mcStar.onRollOver = null;
            mc.mcStar.onRollOut = null;
            delete mc.mcStar.onRelease;
            delete mc.mcStar.onRollOver;
            delete mc.mcStar.onRollOut;
            mc.mcStar._visible = false;
            var _loc3_ = mc.mcChar.charContainer.avatar;
            var _loc6_ = _loc4_[0];
            var _loc5_ = _loc6_.substr(_loc6_.indexOf(":") + 1);
            if(_loc5_ != undefined)
            {
               _loc3_.npcName = _loc5_;
               _loc3_.npcxml = new XML();
               _loc3_.npcxml.ignoreWhite = true;
               _loc3_.npcxml.load("framework/npcfriends/xml/" + _loc5_ + "Setup.xml");
               _loc3_.npcxml.onData = Delegate.create(this,this.gotNPCXML,_loc3_);
            }
         }
         mc.userData = this._friendsDataArr[mc.ind];
         mc.mcChar._visible = true;
         mc.mcLoading._visible = false;
      }
      else
      {
         trace("[FriendsMarch] oops. char data is undefined for mc.ind=" + mc.ind);
         mc.mcStar._visible = false;
         mc.mcChar._visible = false;
         mc.mcLoading._visible = false;
      }
   }
   function gotNPCXML(data, avatar)
   {
      if(data)
      {
         avatar.npcxml.parseXML(data);
         var _loc2_ = avatar.npcxml.firstChild.firstChild;
         while(_loc2_ != null)
         {
            if(String(_loc2_.nodeName) == "logo" && String(_loc2_.firstChild.nodeValue) == "true")
            {
               var _loc3_ = avatar.createEmptyMovieClip("logo",avatar.getNextHighestDepth());
               _loc3_._y = 115;
               _loc3_._xscale = 10000 / avatar._yscale;
               _loc3_._yscale = 10000 / avatar._yscale;
               var _loc5_ = new MovieClipLoader();
               var _loc4_ = "framework/npcfriends/quidgets/" + avatar.npcName + "/" + avatar.npcName + "_logo.swf";
               trace("NPC friend: logoClip: " + _loc4_);
               _loc5_.loadClip(_loc4_,_loc3_);
               return undefined;
            }
            _loc2_ = _loc2_.nextSibling;
         }
      }
      else
      {
         trace("error loading NPC friend xml");
      }
   }
   function onSetFriendLookDelayComplete(mc)
   {
      mc.mcChar._visible = true;
      mc.mcLoading._visible = false;
   }
   function removeSpecialAbilities(mc)
   {
      delete mc.onEnterFrame;
      mc.mcChar.charContainer.avatar.removeAllSpecialAbilities();
      mc.mcChar._visible = true;
      mc.mcLoading._visible = false;
   }
   function flipScales()
   {
      var _loc5_ = this._friendClipArr.length;
      var _loc6_ = this._orientation * com.poptropica.sections.friendsHub.FriendsMarch.ITEM_SCALE;
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         var _loc3_ = this._friendClipArr[_loc2_];
         _loc3_._xscale = _loc6_;
         var _loc4_ = _loc3_.mcChar.charContainer.avatar;
         _loc4_.logo._xscale = this._orientation * 10000 / _loc4_._yscale;
         _loc2_ = _loc2_ + 1;
      }
   }
   function getArrayPos(arr, item)
   {
      var _loc1_ = 0;
      while(_loc1_ < arr.length)
      {
         if(arr[_loc1_] === item)
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
   function get selectedChar()
   {
      var _loc3_ = undefined;
      var _loc4_ = this._friendClipArr.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         if(this._friendClipArr[_loc2_].userData[0] == this._selectedCharLogin)
         {
            _loc3_ = this._friendClipArr[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      if(this._userChar.userData[0] == this._selectedCharLogin)
      {
         _loc3_ = this._userChar;
      }
      return _loc3_;
   }
   function cleanUp()
   {
      trace("[FriendsMarch] cleanUp()");
      var _loc3_ = this._friendClipArr.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this._friendClipArr[_loc2_].removeMovieClip();
         _loc2_ = _loc2_ + 1;
      }
      this._friendClipArr = [];
      this._friendsDataArr = [];
      this.resetSlider();
      this._firstVisibleFriendIndex = 0;
      this._offset = 0;
      delete this._asset.onEnterFrame;
      this._scrollUntilFriendFound = false;
   }
   function resetSlider()
   {
      this._slider._x = this._sliderOrigX;
      this._slider._y = 100;
   }
   function set tfUsername(tf)
   {
      this._tfUserName = tf;
   }
   function makeUserCurrentByLogin(login)
   {
   }
}
