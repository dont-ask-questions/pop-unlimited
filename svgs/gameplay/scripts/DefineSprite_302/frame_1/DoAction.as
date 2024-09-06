function showInfo(login, look, battleRanking)
{
   delete this.onEnterFrame;
   if(!_root.camera.scene.red5 || showedUser == login)
   {
      return undefined;
   }
   delete this.onRollOut;
   delete this.onRollOver;
   clearInterval(tribeInt);
   vRollover = false;
   tfState.text = "";
   rankingBar._visible = true;
   pointsBar._visible = false;
   showedUser = login;
   var _loc3_ = "";
   var _loc10_ = "";
   var _loc6_ = "";
   if(login == _root.camera.scene.char.avatar.loadLogin())
   {
      var _loc9_ = _root.getUserInfo();
      name.text = _root.camera.scene.char.avatar.loadName();
      pointsBar.points.text = _loc9_.points;
      rankingBar.ranking._width = rankingClipWidth * (_loc9_.ranking / 100);
      trace("[commonRoomUserInfo] current user.ranking:" + _loc9_.ranking);
      var _loc7_ = SharedObject.getLocal("Char","/");
      _loc3_ = _loc7_.data.countryCode;
      _loc10_ = _loc7_.data.stateCode;
      _loc6_ = _loc7_.data.userData.Tribe;
   }
   else
   {
      var _loc4_ = _root.Users[login].char;
      if(_loc4_ == undefined)
      {
         name.text = login;
         pointsBar._visible = false;
         if(battleRanking == undefined)
         {
            battleRanking = 100;
         }
         rankingBar.ranking._width = rankingClipWidth * (battleRanking / 100);
         _loc3_ = "-1";
      }
      else
      {
         name.text = _loc4_.charName;
         pointsBar.points.text = _loc4_.userInfo.points;
         rankingBar.ranking._width = rankingClipWidth * (_loc4_.userInfo.ranking / 100);
         _loc3_ = _loc4_.userInfo.countryCode;
         trace("[commonRoomUserInfo] other user.ranking:" + _loc4_.userInfo.ranking);
         trace("[commonRoomUserInfo] cc:" + _loc4_.userInfo.countryCode);
         _loc10_ = _loc4_.userInfo.stateCode;
         _loc6_ = _loc4_.userInfo.tribe;
      }
   }
   var _loc11_ = false;
   if(_loc3_ != "" && _loc3_ != undefined && _loc3_ != "-1")
   {
      _loc11_ = true;
      tRolloverCountry.text = _countryObj[_loc3_];
      loadFlag(_loc3_);
      if(_loc3_ == "US")
      {
         tfState.state = _loc10_;
      }
   }
   else
   {
      mcFlagContainer._visible = false;
      tRolloverCountry._visible = false;
      trace("[commonRoomUserInfo] no country code set yet: = " + _loc3_);
   }
   tRolloverTribe._visible = false;
   if(_loc6_)
   {
      _loc11_ = true;
      mcTribe._alpha = 0;
      mcTribe.gotoAndStop("tribe_" + _loc6_);
      var _loc5_ = undefined;
      switch(_loc6_)
      {
         case 4001:
            _loc5_ = "Flying Squid";
            break;
         case 4002:
            _loc5_ = "Wildfire";
            break;
         case 4003:
            _loc5_ = "Yellowjackets";
            break;
         case 4004:
            _loc5_ = "Pathfinders";
            break;
         case 4005:
            _loc5_ = "Black Flags";
            break;
         case 4006:
            _loc5_ = "Nightcrawlers";
            break;
         case 4007:
            _loc5_ = "Seraphim";
            break;
         case 4008:
            _loc5_ = "Nanobots";
      }
      tRolloverTribe.text = _loc5_;
      tribeInt = setInterval(this,"toggleTribeFlag",3000);
   }
   else
   {
      mcTribe._alpha = 0;
      tRolloverTribe._visible = false;
   }
   if(_loc11_)
   {
      tRolloverTribe._visible = true;
      tRolloverCountry._visible = true;
      tRolloverTribe._alpha = 0;
      tRolloverCountry._alpha = 0;
      this.onRollOver = function()
      {
         vRollover = true;
         if(mcTribe._alpha >= 50)
         {
            tRolloverTribe._alpha = 100;
            tRolloverCountry._alpha = 0;
         }
         else
         {
            tRolloverCountry._alpha = 100;
            tRolloverTribe._alpha = 0;
         }
      };
      this.onRollOut = function()
      {
         vRollover = false;
         tRolloverTribe._alpha = 0;
         tRolloverCountry._alpha = 0;
      };
   }
   if(!char_mc.loadingFinished)
   {
      var _loc13_ = new MovieClipLoader();
      _loc13_.loadClip("char.swf",char_mc);
      this.createEmptyMovieClip("loadCheck",1);
      loadCheck.onEnterFrame = function()
      {
         if(char_mc.loadingFinished)
         {
            delete this.onEnterFrame;
            char_mc.avatar.setLook(look.split(","));
            char_mc.avatar.nextFrame();
            delete char_mc.onRollOver;
            delete char_mc.onPress;
            delete char_mc.onRelease;
            instructions.onEnterFrame = function()
            {
               this._alpha -= fadeSpeed;
               if(this._alpha <= 0)
               {
                  this._alpha = 0;
                  delete this.onEnterFrame;
               }
            };
            removeMovieClip(loadCheck);
         }
      };
   }
   else
   {
      char_mc.avatar.setLook(look.split(","));
      char_mc.avatar.setParts();
      instructions.onEnterFrame = function()
      {
         this._alpha -= fadeSpeed;
         if(this._alpha <= 0)
         {
            this._alpha = 0;
            delete this.onEnterFrame;
         }
      };
   }
}
function onCountryCodeTxtLoaded(success)
{
   if(success)
   {
      _countryObj = {};
      var _loc4_ = unescape(_countryCodeLoadVars.cc);
      _loc4_ += "Puerto Rico|PR\n";
      _loc4_ += "Virgin Islands|VI\n";
      _loc4_ += "Cayman Islands|KY\n";
      _loc4_ += "Guam|GU\n";
      _loc4_ += "Bermuda|BM\n";
      _loc4_ += "Palestine|PS\n";
      _loc4_ += "Aruba|AW\n";
      _loc4_ += "Curacao|CW\n";
      _loc4_ += "South Sudan|SS";
      var _loc3_ = _loc4_.split("\n");
      var _loc2_ = _loc3_.length - 1;
      while(_loc2_ != -1)
      {
         var _loc1_ = _loc3_[_loc2_].split("|");
         if(_loc1_.length == 2)
         {
            _countryObj[_loc1_[1]] = _loc1_[0];
         }
         _loc2_ = _loc2_ - 1;
      }
   }
}
function loadFlag(cc)
{
   mcFlagContainer._visible = false;
   tRolloverCountry._visible = false;
   if(cc != undefined && cc != "" && cc != "-1")
   {
      var _loc2_ = new MovieClipLoader();
      var _loc4_ = "images/flags/" + cc.toLowerCase() + ".jpg";
      _loc2_.loadClip(_loc4_,mcFlagContainer);
      _loc2_.onLoadInit = Delegate.create(this,jpgLoadComplete);
   }
}
function jpgLoadComplete(target)
{
   trace("[commonRoomUserInfo] jpgLoadComplete.");
   mcFlagContainer.forceSmoothing = true;
   mcFlagContainer._visible = true;
}
function hideInfo()
{
   this.i = 0;
   this.onEnterFrame = function()
   {
      if(this.i++ > hideDelay * fps)
      {
         delete this.onEnterFrame;
         showedUser = "";
         instructions.onEnterFrame = function()
         {
            tRolloverCountry._visible = false;
            tRolloverTribe._visible = false;
            this._alpha += fadeSpeed;
            if(this._alpha > 100)
            {
               this._alpha = 100;
               delete this.onEnterFrame;
            }
         };
      }
   };
}
function switchBars()
{
   if(rankingBar._visible)
   {
      rankingBar._visible = false;
      pointsBar._visible = true;
   }
   else
   {
      rankingBar._visible = true;
      pointsBar._visible = false;
   }
}
function toggleTribeFlag()
{
   var _loc1_ = undefined;
   if(mcTribe._alpha == 0)
   {
      _loc1_ = 100;
      caurina.transitions.Tweener.addTween(tRolloverCountry,{_alpha:mcTribe._alpha,time:1,transition:"easeOutSine"});
      if(vRollover)
      {
         caurina.transitions.Tweener.addTween(tRolloverTribe,{_alpha:_loc1_,time:1,transition:"easeOutSine"});
      }
   }
   else
   {
      _loc1_ = 0;
      caurina.transitions.Tweener.addTween(tRolloverTribe,{_alpha:_loc1_,time:1,transition:"easeOutSine"});
      if(vRollover)
      {
         caurina.transitions.Tweener.addTween(tRolloverCountry,{_alpha:mcTribe._alpha,time:1,transition:"easeOutSine"});
      }
   }
   caurina.transitions.Tweener.addTween(mcTribe,{_alpha:_loc1_,time:1,transition:"easeOutSine"});
}
stop();
var showedUser = "";
var fadeSpeed = 10;
var switchTime = 2000;
var rankingClipWidth = 76;
var hideDelay = 2;
var fps = 31;
var tribeInt;
var _countryObj;
var _countryCodeLoadVars = new LoadVars();
var vRollover = false;
_countryCodeLoadVars.onLoad = Delegate.create(this,onCountryCodeTxtLoaded);
_countryCodeLoadVars.load(_root.getPrefix() + "/images/flags/flag-index.txt");
