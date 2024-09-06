function dispatchEvent()
{
}
function addEventListener()
{
}
function removeEventListener()
{
}
function init()
{
   stop();
   mcSaveGameDialog._visible = false;
   EventDispatcher.initialize(this);
   clipHeight = 10;
   btn1.onPress = function()
   {
      checkMoveToNPC();
      _root.showChat(_root.camera.scene.char);
      _root.loadChat();
      eventToTrack = "ChatClicked";
      var _loc4_ = com.poptropica.models.PopModel.getInstance();
      var _loc3_ = !_loc4_.isActiveMember() ? "N" : "Y";
      var _loc2_ = _loc4_.poptropica_user.login;
      loadVariablesNum("/brain/track.php?cluster=" + _root.ClusterName + "&scene=" + _root.SceneName + "&event=" + eventToTrack + "&grade=" + _root.CharacterGrade + "&gender=" + _root.CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000) + "&member=" + _loc3_ + "&login=" + _loc2_,0);
   };
   btn1.onRollOver = _root.useArrow;
   btn2.onPress = function()
   {
      checkMoveToNPC();
      _root.showGameMenu(_root.camera.scene.char.targetPlayer);
      var _loc4_ = com.poptropica.models.PopModel.getInstance();
      var _loc3_ = !_loc4_.isActiveMember() ? "N" : "Y";
      var _loc2_ = _loc4_.poptropica_user.login;
      eventToTrack = "BattleClicked";
      loadVariablesNum("/brain/track.php?cluster=" + _root.ClusterName + "&scene=" + _root.SceneName + "&event=" + eventToTrack + "&grade=" + _root.CharacterGrade + "&gender=" + _root.CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000) + "&member=" + _loc3_ + "&login=" + _loc2_,0);
   };
   btn2.onRollOver = _root.useArrow;
   btn3.onRelease = Delegate.create(this,onBtnFriendRelease);
   btn3.onRollOver = _root.useArrow;
}
function animateIn()
{
   i = 1;
   while(i <= 3)
   {
      btn = this["btn" + i];
      btn.startY = btn._y;
      btn._y += 40;
      btn._alpha = 0;
      btn._xscale = btn._yscale = 0;
      btn._rotation = Math.random() * 360 - 180;
      btn.onEnterFrame = function()
      {
         this._alpha += (100 - this._alpha) / 2;
         this._xscale = this._yscale += (100 - this._xscale) / 2;
         this._rotation += (- this._rotation) / 2;
         this._y += (this.startY - this._y) / 2;
      };
      i++;
   }
   btn3.tf.text = "FRIEND";
}
function onBtnFriendRelease()
{
   checkMoveToNPC();
   var _loc3_ = com.poptropica.models.PopModel.getInstance().isRegistered;
   if(_loc3_)
   {
      addFriend();
   }
   else
   {
      var _loc2_ = _root.showMenuPopUp("mcNotRegisteredPopup");
      _not_registered_popup = new com.poptropica.views.home.welcomeBack.SaveGamePopup(_loc2_);
   }
}
function addFriend()
{
   btn3.tf.text = "ADDING...";
   _phpResults = new LoadVars();
   var _loc3_ = new LoadVars();
   com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc3_);
   if(_root.char.targetPlayer.npc)
   {
      _friendLogin = _root.char.targetPlayer.npcName;
      var _loc5_ = _root.char.targetPlayer;
      com.poptropica.controllers.PopController.getInstance().track(_loc5_.campaignName,"FriendClick",_loc5_.npcName,"",true,_root.island,_root.desc);
      _loc3_.favorite = 2;
   }
   else
   {
      _friendLogin = _root.char.targetPlayer.login;
      _loc3_.favorite = 0;
   }
   _loc3_.friend_login = _friendLogin;
   _loc3_.method = 0;
   _phpResults.onLoad = Delegate.create(this,onAddFriendPhpComplete);
   var _loc9_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/friends/add_friend.php";
   _loc3_.sendAndLoad(_loc9_,_phpResults,"POST");
   trace("[commonRoomUserMenu] ------------------/friends/add_friend.php-----------------------");
   for(var _loc4_ in _loc3_)
   {
      trace("[commonRoomUserMenu]        " + _loc4_ + ": " + _loc3_[_loc4_]);
   }
   var _loc8_ = com.poptropica.models.PopModel.getInstance();
   var _loc7_ = !_loc8_.isActiveMember() ? "N" : "Y";
   var _loc6_ = _loc8_.poptropica_user.login;
   eventToTrack = "FriendClicked";
   loadVariablesNum("/brain/track.php?cluster=" + _root.ClusterName + "&scene=" + _root.SceneName + "&event=" + eventToTrack + "&grade=" + _root.CharacterGrade + "&gender=" + _root.CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000) + "&member=" + _loc7_ + "&login=" + _loc6_,0);
}
function onAddFriendPhpComplete(success)
{
   trace("onAddFriendPhpComplete. success:" + success);
   var _loc3_ = "";
   if(success)
   {
      switch(_phpResults.answer)
      {
         case "item-already-there":
            _loc3_ = "ALREADY A FRIEND";
            break;
         case "ok":
      }
   }
   else
   {
      _loc3_ = "Communication error. Please try later.";
   }
   if(_loc3_ != "")
   {
      trace("[commonRoomUserMenu] errorString:" + _loc3_);
      _popup = _root.showMenuPopUp("generalPopupNoTitle");
      _popup.tfBody.text = "You are already friends with that user.";
      _popup.btnOk.onRelease = Delegate.create(this,onAddFriendErrorOkClick);
      _root.Friends.push(_root.camera.scene.char.targetPlayer.login);
   }
   else
   {
      friendAddSuccess();
   }
}
function onAddFriendErrorOkClick()
{
   _popup.removeMovieClip();
   _visible = false;
}
function friendAddSuccess()
{
   _visible = false;
   com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchCommonRoomFriendAdded(btn3);
   com.poptropica.controllers.PopController.getInstance().track("Friends","AddFriend","","CommonRoom");
   trace("[commonRoomUserMenu] ]]]]]]]]]]],friend login:" + _friendLogin + "  PopModelConst.avatar.loadLogin():" + com.poptropica.models.PopModelConst.avatar.loadLogin());
   _root.server.call("actUser",null,_friendLogin,"friended");
}
function xxxxxxNotInUse()
{
   var _loc3_ = com.poptropica.models.PopModel.getInstance().navbarMC.friendshubBtn;
   var _loc5_ = new flash.geom.Point(_loc3_._x + 20,_loc3_._y + 20);
   _loc3_._parent.localToGlobal(_loc5_);
   var _loc4_ = _quizObj.getSolutionIcon();
   _loc4_._parent.globalToLocal(_loc5_);
   TweenMax.to(_loc4_,0.3,{delay:0.9,_x:_loc5_.x - 10,_y:_loc5_.y - 15,_xscale:20,_yscale:20,onComplete:onAnimateToNavBarComplete,onCompleteScope:this,onCompleteParams:[_loc4_]});
   _loc3_ = com.poptropica.models.PopModel.getInstance().navbarMC.friendshubBtn;
   _loc5_ = new flash.geom.Point(_loc3_._x + 20,_loc3_._y + 20);
   _loc3_._parent.localToGlobal(_loc5_);
   _addFriendIcon = _parent.topAnimContainer.attachMovie("addFriendCommonRoomIcon","addFriendCommonRoomIcon",_parent.topAnimContainer.getNextHighestDepth());
   _addFriendIcon._parent.globalToLocal(_loc5_);
   _addFriendIcon._xscale = 4000;
   _addFriendIcon._yscale = 4000;
   trace("[commonRoomUserMenu] _addFriendIcon:" + _addFriendIcon + "  topAnimContainer:" + _parent.topAnimContainer);
   var _loc15_ = new flash.display.BitmapData(75,70,true,16777215);
   var _loc6_ = new flash.geom.Matrix();
   _loc6_.scale(0.6,0.6);
}
function onAnimateToNavBarComplete(icon)
{
   trace("[commonRoomUserMenu] onAnimateToNavBarComplete. icon:" + icon);
   com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchNumFriendsChanged();
   com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchCommonRoomFriendAdded();
   _addFriendIcon.removeMovieClip();
}
function checkMoveToNPC()
{
   if(_root.camera.scene.red5)
   {
      if(Math.abs(_root.camera.scene.char._x - _root.camera.scene.char.targetPlayer._x) > 120)
      {
         if(_root.server)
         {
            _root.responding = false;
            _root.server.call("actUser",null,_root.camera.scene.char.targetPlayer.login,"comeup");
            _root.camera.scene.char.disableMMOMenu = true;
         }
      }
   }
}
var _addFriendIcon;
var _phpResults;
var _not_registered_popup;
var _popup;
var _friendLogin;
init();
