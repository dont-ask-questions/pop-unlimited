function showFriendedAnim(login)
{
   container = com.poptropica.models.PopModel.getInstance().navbarMC.topAnimContainer;
   var _loc2_ = container.attachMovie("friendedStarGraphic","friendedStarGraphic" + container.getNextHighestDepth(),container.getNextHighestDepth());
   var _loc3_ = new flash.geom.Point(Users[login].char._x,Users[login].char._y - 100);
   Users[login].char._parent.localToGlobal(_loc3_);
   _loc2_._parent.globalToLocal(_loc3_);
   _loc2_._x = _loc3_.x;
   _loc2_._y = _loc3_.y - 10;
   _loc2_._alpha = 0;
   _loc2_._xscale = _loc2_._yscale = 50;
   com.greensock.TweenMax.to(_loc2_,0.12,{_alpha:100,onComplete:fadeFriendStar,onCompleteParams:[_loc2_],onCompleteScope:this});
   trace("[frame7.as] friendedStar:" + _loc2_ + " pt:" + _loc3_ + "    PopModel.getInstance().navbarMC:" + com.poptropica.models.PopModel.getInstance().navbarMC);
}
function fadeFriendStar(mc)
{
   com.greensock.TweenMax.to(mc,1.5,{delay:0.05,_y:mc._y - 100,_alpha:0,_xscale:100,_yscale:100,ease:com.greensock.easing.Linear.easeNone});
}
function userIsFriend(login)
{
   var _loc1_ = 0;
   while(_loc1_ < Friends.length)
   {
      if(Friends[_loc1_] == login)
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function Connect()
{
   var _loc2_ = camera.scene.char.avatar.loadLogin();
   var _loc5_ = camera.scene.char.avatar.getLook().toString();
   var _loc6_ = camera.scene.char.avatar.loadName();
   var _loc3_ = camera.scene.mmoRoomName;
   if(camera.scene.PartyRoom)
   {
      _loc3_ = _loc3_.substr(1,4);
   }
   trace("[frame7.as] Connect Room: " + _loc3_ + " Login: " + _loc2_ + " Look: " + _loc5_ + " Char Name: " + _loc6_);
   var _loc4_ = getUserInfo();
   trace("[frame7.as] USER INFO ranking: " + _loc4_.ranking + " points: " + _loc4_.points);
   server.connect("rtmp://" + _root.camera.scene.char.avatar.FunBrain_so.data.MMOprefix + "/game/",_loc3_,_loc2_,_loc5_,Math.round(camera.scene.startX),Math.round(camera.scene.startY),_loc6_,_loc4_);
   Users[_loc2_] = {char:camera.scene.char,login:_loc2_,look:_loc5_};
   Users[_loc2_].char.Loaded = true;
   Users[_loc2_].char.charName = _loc6_;
   Users[_loc2_].char.userInfo = _loc4_;
}
function getNextUserDepth()
{
   do
   {
      nextUserDepth++;
   }
   while(camera.scene.getInstanceAtDepth(nextUserDepth));
   
   return nextUserDepth;
}
function addUser(login, look, X, Y, stat, charName, userInfo)
{
   if(Users[login])
   {
      return undefined;
   }
   trace("[frame7.as] Adding user Login: " + login + " Look: " + look + " X: " + X + " Y: " + Y + " STATUS: " + stat + " CHARNAME: " + charName);
   var _loc4_ = look.split("/")[0];
   var _loc3_ = camera.scene.attachMovie("_char","char" + ++nextUserNum,getNextUserDepth(),{_x:X,_y:2000});
   Users[login] = {char:_loc3_,login:login,look:_loc4_,loader:new MovieClipLoader()};
   camera.scene.createEmptyMovieClip("initMC" + nextUserNum,camera.scene.getNextHighestDepth());
   camera.scene["initMC" + nextUserNum].onEnterFrame = function()
   {
      if(Users[login].char.loadingFinished)
      {
         Users[login].char.createMultiPlayer(Users[login].look);
         Users[login].char.login = login;
         Users[login].char.charName = charName;
         Users[login].char.userInfo = userInfo;
         Users[login].char.avatar.gotoAndStop(2);
         Users[login].char.gotoAndStop("start");
         Users[login].char._x = X;
         Users[login].char._y = Y;
         Users[login].char.Loaded = true;
         Users[login].char.stat = stat;
         if(stat != "none")
         {
            if(stat != "busy")
            {
               if(stat == "sudoku" || stat == "hoopshot" || stat == "skydive" || stat == "paintwar" || stat == "quizgame" || stat == "dotgame" || stat == "balloongame" || stat == "boggle" || stat == "kidcatcher" || stat == "hex")
               {
                  if(firstPlayer != undefined)
                  {
                     if(Users[firstPlayer].char._x < X)
                     {
                        Users[firstPlayer].char._xscale *= -1;
                        Users[firstPlayer].char._x -= 30;
                     }
                     else
                     {
                        Users[login].char._xscale *= -1;
                        Users[login].char._x -= 30;
                     }
                     _root.hideSay(Users[login].char);
                     _root.hideSay(Users[firstPlayer].char);
                     _root.showBattle(Users[login].char,Users[firstPlayer].char,stat);
                     Users[login].char.stat = stat;
                     Users[firstPlayer].char.stat = stat;
                     firstPlayer = null;
                  }
                  else
                  {
                     firstPlayer = login;
                  }
               }
            }
         }
         removeMovieClip(this);
      }
   };
   Users[login].loader.loadClip("char.swf",Users[login].char);
}
function removeUser(login)
{
   _root.hideSay(Users[login].char);
   Users[login].char.removeMovieClip();
   delete Users[login];
   var _loc3_ = camera.scene.char.avatar.loadLogin();
   if(_loc3_ == login)
   {
      multiplayer.MultiUserObjectManager.reset();
   }
}
function createRoomName(login1, login2)
{
   if(login1 < login2)
   {
      return login1 + "vs" + login2;
   }
   return login2 + "vs" + login1;
}
function getUserInfo()
{
   totWins = 0;
   totLosses = 0;
   scores = 0;
   var _loc5_ = 0;
   while(_loc5_ < _root.MMOGames.length)
   {
      var _loc2_ = _root.camera.scene.char.avatar.FunBrain_so.data[_root.MMOGames[_loc5_] + "Wins"];
      var _loc3_ = _root.camera.scene.char.avatar.FunBrain_so.data[_root.MMOGames[_loc5_] + "Losses"];
      if(_loc2_ != undefined || _loc3_ != undefined)
      {
         _loc2_ = _loc2_ != undefined ? parseInt(_loc2_) : 0;
         _loc3_ = _loc3_ != undefined ? parseInt(_loc3_) : 0;
         switch(_root.MMOGames[_loc5_])
         {
            case "skydive":
               _loc2_ *= 1;
               _loc3_ *= 1;
               break;
            case "hoopshot":
               _loc2_ *= 2;
               _loc3_ *= 2;
               break;
            case "sudoku":
               _loc2_ *= 3;
               _loc3_ *= 3;
               break;
            case "paintwar":
               _loc2_ *= 2;
               _loc3_ *= 2;
               break;
            case "quizgame":
               _loc2_ *= 2;
               _loc3_ *= 2;
               break;
            case "dotgame":
               _loc2_ *= 2;
               _loc3_ *= 2;
               break;
            case "balloongame":
               _loc2_ *= 2;
               _loc3_ *= 2;
               break;
            case "boggle":
               _loc2_ *= 2;
               _loc3_ *= 2;
               break;
            case "kidcatcher":
               _loc2_ *= 1;
               _loc3_ *= 1;
               break;
            case "hex":
               _loc2_ *= 2;
               _loc3_ *= 2;
         }
         if(_root.MMOGames[_loc5_] == "sudoku")
         {
            scores += 100 * _loc2_;
         }
         else
         {
            scores += 10 * _loc2_;
         }
         I;
         totWins += _loc2_;
         totLosses += _loc3_;
      }
      _loc5_ = _loc5_ + 1;
   }
   var _loc7_ = totWins + totLosses;
   var _loc8_ = Math.ceil(100 * (totWins + 8 / (_loc7_ + 1)) / (_loc7_ + 40 / (_loc7_ + 1))) / 100;
   if(isNaN(_loc8_))
   {
      _loc8_ = 0;
   }
   var _loc4_ = new Object();
   _loc4_.ranking = Math.round(_loc8_ * 100);
   _loc4_.points = scores;
   var _loc6_ = SharedObject.getLocal("Char","/");
   _loc4_.countryCode = _loc6_.data.countryCode;
   _loc4_.stateCode = _loc6_.data.stateCode;
   _loc4_.tribe = _loc6_.data.userData.Tribe;
   for(_loc5_ in _loc4_)
   {
      trace("[frame7.as]       getUserInfo. userInfo." + _loc5_ + " = " + _loc4_[_loc5_]);
   }
   return _loc4_;
}
logWWW("***gameplay frame 7");
Users = new Array();
Friends = new Array();
var _not_registered_popup;
var savePopupShown;
nextUserNum = 1;
nextUserDepth = 100;
server = new NetConnection();
server.addUser = function(login, look, X, Y, pState, charName, userInfo)
{
   trace("[frame7.as] ADD user with Login: " + login + " Look: " + look + " coords(" + X + ":" + Y + ")" + " STATE: " + pState + " CHARNAME: " + charName);
   if(!X)
   {
      X = camera.scene.startX;
   }
   if(!Y)
   {
      Y = camera.scene.startY;
   }
   addUser(login,look,X,Y,pState,charName,userInfo);
   for(var _loc2_ in userInfo)
   {
      trace("[frame7.as] [frame7.as]   " + _loc2_ + ": " + userInfo[_loc2_]);
   }
};
server.removeUser = function(login)
{
   trace("[frame7.as] remove user " + login);
   _root.hideSay(Users[login].char);
   removeUser(login);
};
server.moveTo = function(login, X, Y)
{
   if(!Users[login].char.Loaded)
   {
      return undefined;
   }
   if(Users[login].char.invitePlayer != undefined)
   {
      _root.hideSay(Users[Users[login].char.invitePlayer].char);
   }
   if(login == camera.scene.char.avatar.loadLogin())
   {
      _root.hideMenu();
      _root.hideChat();
   }
   if(!Users[login].char.trackingClip)
   {
      Users[login].char.clickTarget(X,Y);
   }
   if(com.poptropica.models.PopModelConst.avatar.loadLogin() == "commonRoomTest")
   {
      showFriendedAnim(login);
   }
};
server.emotion = function(login, emotion)
{
   var _loc5_ = emotion.slice(1,emotion.length - 1);
   var _loc3_ = _loc5_.split(", ");
   if(Users[login].char.invitePlayer != undefined)
   {
      _root.hideSay(Users[Users[login].char.invitePlayer].char);
   }
   if(Users[login].char.Loaded && Users[login].char.avatar.avatarReady)
   {
      if(emotion == "specialAction")
      {
         Users[login].char.avatar.item.action();
         Users[login].char.avatar.head.action();
         Users[login].char.avatar.pack.action();
         Users[login].char.avatar.body.action();
         Users[login].char.avatar.hair.action();
      }
      else if(_loc3_[0] == "multiUserObjectAction")
      {
         var _loc6_ = _loc3_[1];
         var _loc7_ = _loc3_.slice(2);
         multiplayer.MultiUserObjectManager[_loc6_].apply(null,_loc7_);
      }
      else
      {
         Users[login].char.action(emotion);
      }
   }
};
server.say = function(login, phrase, quest_id)
{
   trace("[frame7.as] Say LOGIN: " + login + " PHRASE: " + phrase + " QUEST_ID: " + quest_id);
   Users[login].char.stat = "none";
   if(Users[login].char.invitePlayer != undefined)
   {
      _root.hideSay(Users[Users[login].char.invitePlayer].char);
   }
   _root.showSay(Users[login].char,phrase);
   if(quest_id > -1)
   {
      if(answers_arr[quest_id])
      {
         trace("grabbing local answer: " + answers_arr[quest_id]);
         _root.showSay(Users[login].char,answers_arr[quest_id]);
      }
      else
      {
         _root.camera.scene.char.targetPlayer = _root.camera.scene.char;
         _root.showChat(_root.camera.scene.char);
         _root.loadAnswers(quest_id);
      }
   }
   else if(quest_id == -2)
   {
   }
};
server.actUser = function(login, target, action)
{
   trace("[frame7.as] actUser LOGIN: " + login + " TARGET: " + target + " ACTION: " + action);
   if(action == "friended")
   {
      trace("[frame7.as] actUser action:friended. login:" + login + " friendLogin:" + target + " PopModelConst.avatar.loadLogin():" + com.poptropica.models.PopModelConst.avatar.loadLogin());
      Friends.push(target);
      if(target == com.poptropica.models.PopModelConst.avatar.loadLogin())
      {
         if(Users[target].char.Loaded && Users[target].char.avatar.avatarReady)
         {
            trace("[frame7.as] found the friend to change. Users[login].char.avatar:" + Users[login].char.avatar);
            showFriendedAnim(target);
         }
      }
      var _loc8_ = com.poptropica.models.PopModel.getInstance().isRegistered;
      if(!_loc8_ && !savePopupShown)
      {
         var _loc7_ = _root.showMenuPopUp("unRegFriendReqPopup");
         _not_registered_popup = new com.poptropica.views.home.welcomeBack.SaveGamePopup(_loc7_);
         savePopupShown = true;
      }
      return undefined;
   }
   if(login == camera.scene.char.avatar.loadLogin())
   {
      Users[login].char.actionMMO = action;
   }
   if(Users[login].char.invitePlayer != undefined)
   {
      _root.hideSay(Users[Users[login].char.invitePlayer].char);
   }
   _root.hideSay(Users[login].char);
   Users[login].char.targetHor = true;
   Users[login].char.targetVer = true;
   Users[login].char.tracking = true;
   if(action == "comeup")
   {
      Users[login].char.stat = "none";
      Users[login].char.charState = "stand";
      Users[login].char.targetPlayer = Users[target].char;
      Users[login].char.targetPlayer.engaged = false;
   }
   else if(action == "npcact")
   {
      var _loc3_ = Users[login].char;
      var _loc5_ = camera.scene[target];
      _root.hideSay(_loc5_);
      _root.hideSay(_loc3_.targetPlayer);
      _root.hideSay(_loc3_);
      if(_loc3_.charState == "action")
      {
         _loc3_.avatar.gotoAndPlay("stand");
         _loc3_.charState = "stand";
      }
      _loc3_.targetHor = true;
      _loc3_.targetVer = true;
      _loc3_.tracking = true;
      _loc3_.trackingClip = false;
      _loc5_.targeted = true;
      _loc3_.targetPlayer = _loc5_;
   }
};
server.changeInfo = function(sender, userInfo)
{
   trace("[frame7.as] changeInfo SENDER: " + sender);
   for(var _loc2_ in userInfo)
   {
      trace("[frame7.as]     [" + _loc2_ + "]: " + userInfo[_loc2_]);
   }
   if(sender != userInfo.login)
   {
      Users[userInfo.login] = Users[sender];
   }
   Users[sender].char.userInfo = userInfo;
};
server.request = function(sender, what)
{
};
server.changeLook = function(sender, look)
{
   trace("[frame7.as] changeLook SENDER: " + sender + " LOOK: " + look);
   if(sender != camera.scene.char.avatar.loadLogin())
   {
      Users[sender].char.avatar.setLook(look.split(","));
      Users[sender].char.avatar.setParts();
      Users[sender].char.action("pop");
   }
};
server.sendData = function(sender, sentData)
{
   trace("[frame7.as] sendData SENDER: " + sender + " SENTDATA: " + sentData);
};
server.battleInvite = function(login, target, game)
{
   trace("[frame7.as] battleInvite LOGIN: " + login + " TARGET: " + target + " GAME: " + game);
   _root.showSay(Users[login].char,"Do you want to play\nhead-to-head " + _root.MMOGamesNames[game] + "?");
   Users[target].char.invitePlayer = login;
   trace("[frame7.as] invite " + Users[target].char.invitePlayer);
   if(target == camera.scene.char.avatar.loadLogin())
   {
      camera.scene.char.targetPlayer = Users[login].char;
      _root.showChat(camera.scene.char);
      _root.invited(_root.MMOGames[game]);
   }
};
server.battleStart = function(login, target, game)
{
   trace("[frame7.as] battlePlay LOGIN: " + login + " TARGET: " + target + " GAME: " + game);
   Users[login].char.avatar.gotoAndPlay("stand");
   Users[target].char.avatar.gotoAndPlay("stand");
   _root.hideSay(Users[login].char);
   _root.hideSay(Users[target].char);
   _root.showBattle(Users[login].char,Users[target].char,game);
   Users[login].char.stat = game;
   Users[target].char.stat = game;
   var _loc8_ = camera.scene.char.avatar.loadLogin();
   if(login == _loc8_ || target == _loc8_)
   {
      _root.game = game + ".swf";
      _root.gameRoom = createRoomName(login,target);
      _root.popup("gameLoader.swf",true);
      var _loc2_ = 0;
      while(_loc2_ < _root.MMOGames.length)
      {
         if(_root.MMOGames[_loc2_] == game)
         {
            gameNum = _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc7_ = com.poptropica.models.PopModel.getInstance();
      var _loc6_ = !_loc7_.isActiveMember() ? "N" : "Y";
      login = _loc7_.poptropica_user.login;
      GameName = _root.MMOGamesNames[gameNum] + " Battle";
      EventToTrack = "Loaded";
      loadVariablesNum("/brain/track.php?cluster=" + _root.ClusterName + "&scene=" + _root.SceneName + "&game=" + GameName + "&event=" + EventToTrack + "&grade=" + _root.CharacterGrade + "&gender=" + _root.CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000) + "&member=" + _loc6_ + "&login=" + login,0);
   }
};
server.battleStop = function(login, target)
{
   trace("[frame7.as] battleStop LOGIN: " + login + " TARGET: " + target);
   Users[login].char.stat = "none";
   Users[target].char.stat = "none";
   _root.hideSay(Users[login].char);
   _root.hideSay(Users[target].char);
};
server.changeStatus = function(login, stat)
{
   trace("[frame7.as] CHANGE STATUS LOGIN: " + login + " STATUS: " + stat);
   if(Users[login].char.stat == stat)
   {
      return undefined;
   }
   if(stat == "thinking")
   {
      Users[login].char.action("think");
   }
   Users[login].char.stat = stat;
};
server.onStatus = function(info)
{
   trace(info.code);
   if(info.code == "NetConnection.Connect.Success")
   {
      _root.play();
   }
};
nextFrame();
