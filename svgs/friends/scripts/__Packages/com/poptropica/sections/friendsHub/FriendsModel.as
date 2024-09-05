class com.poptropica.sections.friendsHub.FriendsModel extends Object
{
   var _hasTribeSelected;
   var _currentUserAvatarName;
   var _currentUserLogin;
   var _isQuiltOpen;
   var _initialQuidgetToOpen;
   var _initialUserLogin;
   var _islandNames;
   static var _instance;
   function FriendsModel()
   {
      super();
      mx.events.EventDispatcher.initialize(this);
   }
   static function getInstance()
   {
      if(com.poptropica.sections.friendsHub.FriendsModel._instance == undefined)
      {
         com.poptropica.sections.friendsHub.FriendsModel._instance = new com.poptropica.sections.friendsHub.FriendsModel();
      }
      return com.poptropica.sections.friendsHub.FriendsModel._instance;
   }
   function dispatchEvent()
   {
   }
   function addEventListener(pEventType, callingObj)
   {
   }
   function removeEventListener(pEventType, callingObj)
   {
   }
   function get hasTribeSelected()
   {
      return this._hasTribeSelected;
   }
   function set hasTribeSelected(s)
   {
      this._hasTribeSelected = s;
   }
   function get currentUserAvatarName()
   {
      return this._currentUserAvatarName;
   }
   function set currentUserAvatarName(s)
   {
      this._currentUserAvatarName = s;
   }
   function get currentUserLogin()
   {
      return this._currentUserLogin;
   }
   function set currentUserLogin(s)
   {
      this._currentUserLogin = s;
   }
   function get isCurrentUserSelf()
   {
      return this._currentUserLogin == com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.login;
   }
   function get identityString1stPerson()
   {
      var _loc2_ = !this.isCurrentUserSelf ? this.currentUserAvatarName : "I";
      return _loc2_;
   }
   function get identityString2ndPerson()
   {
      var _loc2_ = !this.isCurrentUserSelf ? this.currentUserAvatarName : "You";
      return _loc2_;
   }
   function get serverCallPrefix()
   {
      var _loc2_ = "";
      if(this.isLocalSwf())
      {
         _loc2_ = "http://proof.poptropica.com";
      }
      else
      {
         _loc2_ = com.poptropica.models.PopModelConst.prefix;
      }
      return _loc2_;
   }
   function isLocalSwf()
   {
      return _root._url.indexOf("file://") != -1;
   }
   function dispatchNumFriendsChanged()
   {
      trace("[FriendsModel] dispatchNumFriendsChanged()");
      this.dispatchEvent({type:"numFriendsChanged"});
   }
   function dispatchPopQuizAdded()
   {
      this.dispatchEvent({type:"popQuizAdded"});
   }
   function dispatchCommonRoomFriendAdded(friendBtn)
   {
      trace("[FriendsModel] friendBtn:" + friendBtn);
      this.dispatchEvent({type:"commonRoomFriendAdded",btn:friendBtn});
   }
   function dispatchNumFriendsLoaded(n)
   {
      this.dispatchEvent({type:"numFriendsLoaded",count:n});
   }
   function dispatchPlayerLookChanged()
   {
      this.dispatchEvent({type:"playerLookChanged"});
   }
   function dispatchPlayerTribeChanged()
   {
      this.dispatchEvent({type:"playerTribeChanged"});
   }
   function populateLoadVarsBase(postVars)
   {
      postVars.login = com.poptropica.models.PopModelConst.avatar.loadLogin();
      postVars.pass_hash = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.password;
      postVars.logged_in = !com.poptropica.models.PopModelConst.avatar.isRegistred() ? 0 : 1;
      postVars.dbid = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.dbid;
      if(_root._url.indexOf("file:/") != -1)
      {
         postVars.login = "pizmogames";
         postVars.pass_hash = "95ebc3c7b3b9f1d2c40fec14415d3cb8";
         postVars.logged_in = 1;
         postVars.dbid = 1;
      }
   }
   function get isQuiltOpen()
   {
      return this._isQuiltOpen;
   }
   function set isQuiltOpen(b)
   {
      this._isQuiltOpen = b;
   }
   function set initialQuidgetToOpen(s)
   {
      this._initialQuidgetToOpen = s;
   }
   function get initialQuidgetToOpen()
   {
      return this._initialQuidgetToOpen;
   }
   function set initialUserLogin(s)
   {
      this._initialUserLogin = s;
   }
   function get initialUserLogin()
   {
      return this._initialUserLogin;
   }
   function set islandNames(a)
   {
      this._islandNames = a;
   }
   function get islandNames()
   {
      return this._islandNames;
   }
}
