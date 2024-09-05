class com.poptropica.sections.friendsHub.Quilt
{
   var _objId;
   var _json;
   var _allQuidgetData;
   var _allQuidgetNumQuidgets;
   var _asset;
   var _buildAnim;
   var _quidgetContainer;
   var _dropDown;
   var _isVisible;
   var _currentUserLogin;
   var _quidgetArr;
   var _pageNum;
   var _lastLoadedLogin;
   var _fnAfterPageOfQuidgetsReady;
   var _popModel;
   var _quizReviewInput;
   var _state;
   var _postVars;
   var _phpResults;
   var _pageNumMax;
   static var _instance;
   static var NPC_FRIEND_PREFIX = "npc:";
   var _active = true;
   var _filterStr = "all";
   var X_BASE = 17;
   var X_SPACING = 130;
   var Y_BASE = 262;
   var Y_SPACING = 90;
   var NUM_COLS = 6;
   var NUM_ROWS = 3;
   var _pageChangeDir = 0;
   var _campaigns = {};
   var CLOSED_Y = 660;
   function Quilt()
   {
      this._objId = random(10000);
      trace("[Quilt " + this._objId + "]constructor::()");
      mx.events.EventDispatcher.initialize(this);
      this._json = new asLib.JSON();
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
      if(com.poptropica.sections.friendsHub.Quilt._instance == undefined)
      {
         com.poptropica.sections.friendsHub.Quilt._instance = new com.poptropica.sections.friendsHub.Quilt();
      }
      return com.poptropica.sections.friendsHub.Quilt._instance;
   }
   function init(asset)
   {
      trace("[Quilt " + this._objId + "]init::()");
      this._allQuidgetData = {};
      this._allQuidgetNumQuidgets = {};
      this._asset = asset;
      this._asset.mcTopMsg._visible = false;
      this.clearLastLoaded();
      this.clearQuidgets();
      _global.photoQuidgetLoaded = false;
      this._asset.mcBg.onRelease = function()
      {
      };
      this._buildAnim = "none";
      this._quidgetContainer = this._asset.quidgetContainer;
      this._asset.btnPrev.onRelease = Delegate.create(this,this.onPrevClick);
      this._asset.btnNext.onRelease = Delegate.create(this,this.onNextClick);
      this._asset.btnClose.onRelease = Delegate.create(this,this.onCloseQuiltClick);
      this._dropDown = new com.poptropica.components.dropDown.DropDownMenu();
      this._dropDown.setDropDownMC(this._asset.mcDropDown);
      this._dropDown.active = false;
      this._dropDown.addEventListener("itemSelected",Delegate.create(this,this.onQuiltDropdownSelected));
      this._dropDown.addEventListener("open",Delegate.create(this,this.onDropDownOpen));
      this._dropDown.addEventListener("close",Delegate.create(this,this.onDropDownClose));
      var _loc3_ = [];
      _loc3_.push({label:"ACCOMPLISHMENTS",val:"accomplishment"});
      _loc3_.push({label:"PERSONALITY",val:"personality"});
      _loc3_.push({label:"ALL",val:"all"});
      this._dropDown.initialLabel = "ALL";
      this._dropDown.setData(_loc3_);
      this._filterStr = "all";
      this._isVisible = true;
      this._asset._y = this.CLOSED_Y;
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().isQuiltOpen = false;
      this._isVisible = false;
      this._asset.mcNextLoadingMsg._visible = false;
   }
   function onDropDownOpen()
   {
      trace("[Quilt " + this._objId + "]---------onDropDownOpen-----");
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().disable();
   }
   function onDropDownClose()
   {
      trace("[Quilt " + this._objId + "]---------onDropDownClose-----");
      com.greensock.TweenMax.delayedCall(0.3,this.onDelayAfterDropDownClose,null,this);
   }
   function onDelayAfterDropDownClose()
   {
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().enable();
   }
   function initNewUser()
   {
      this.fnStopNPCFriendTimer();
      if(this._allQuidgetData[this._currentUserLogin] == undefined)
      {
         this._allQuidgetData[this._currentUserLogin] = [];
      }
      this._quidgetArr = [];
      this._pageNum = 0;
      this._pageChangeDir = 0;
      this._lastLoadedLogin = undefined;
   }
   function checkGetQuidgetData()
   {
      var _loc2_ = (this._pageNum + 1) * this.numQuidgetsPerPage - 1;
      if(this._allQuidgetNumQuidgets[this._currentUserLogin] != undefined)
      {
         _loc2_ = Math.min(this._allQuidgetNumQuidgets[this._currentUserLogin] - 1,_loc2_);
      }
      trace("[Quilt " + this._objId + "] lastQuidgetNeedDataFor:" + _loc2_);
      if(this.quidgetData[_loc2_] == undefined)
      {
         this.getQuidgetData();
      }
      else
      {
         trace("[Quilt " + this._objId + "] -----no quidget data needed!:" + this._fnAfterPageOfQuidgetsReady);
         this.makeQuidgetsAsNeeded();
         if(this._pageChangeDir != 0)
         {
            this._fnAfterPageOfQuidgetsReady();
         }
      }
   }
   function fnNPCFriendTimer()
   {
      if(_root.section.mcQuilt == undefined)
      {
         var _loc3_ = Math.round((getTimer() - _root.quiltTest.time) / 1000);
         if(this._popModel == undefined)
         {
            this._popModel = com.poptropica.models.PopModel.getInstance();
         }
         this._popModel.gameplayMC.trackActivityTime(_loc3_,_root.quiltTest.campaign,"TotalTime");
         _root.quiltTest.onEnterFrame = null;
         delete _root.quiltTest.onEnterFrame;
         _root.quiltTest.removeMovieClip();
      }
   }
   function fnStopNPCFriendTimer()
   {
      if(_root.quiltTest)
      {
         var _loc3_ = Math.round((getTimer() - _root.quiltTest.time) / 1000);
         if(this._popModel == undefined)
         {
            this._popModel = com.poptropica.models.PopModel.getInstance();
         }
         this._popModel.gameplayMC.trackActivityTime(_loc3_,_root.quiltTest.campaign,"TotalTime");
         _root.quiltTest.onEnterFrame = null;
         delete _root.quiltTest.onEnterFrame;
         _root.quiltTest.removeMovieClip();
      }
   }
   function getQuidgetData()
   {
      trace("[Quilt " + this._objId + "] getQuidgetData. login:" + this._currentUserLogin);
      this.setAsLoading();
      if(this._currentUserLogin.substr(0,4) == com.poptropica.sections.friendsHub.Quilt.NPC_FRIEND_PREFIX)
      {
         var npcfriendXML = new XML();
         npcfriendXML.ignoreWhite = true;
         var me = this;
         npcfriendXML.onLoad = function(success)
         {
            if(success)
            {
               me.parseNPCFriendXML(npcfriendXML);
            }
            else
            {
               trace("Quilt error: missing npc friend xml file");
            }
         };
         npcfriendXML.load("/framework/npcfriends/xml/" + this._currentUserLogin.substr(4) + ".xml");
      }
      else if(this._currentUserLogin == "quizreview")
      {
         if(this._quizReviewInput == undefined)
         {
            this._asset.mcQuizReviewContainer.attachMovie("quizReviewInputAsset","mcQuizReviewInput",this._asset.mcQuizReviewContainer.getNextHighestDepth());
            this._quizReviewInput = this._asset.mcQuizReviewContainer.mcQuizReviewInput;
            this._quizReviewInput.btnTest.onRelease = Delegate.create(this,this.onQuizReviewTestClick);
         }
         this._state = "normal";
         this.updateLoadingMessage();
      }
      else if(this._currentUserLogin.indexOf("GUEST;") >= 0)
      {
         this.useCannedData(99);
      }
      else
      {
         this._postVars = new LoadVars();
         com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(this._postVars);
         this._phpResults = new LoadVars();
         this._phpResults.onLoad = Delegate.create(this,this.onPhpGetQuidgetsComplete);
         var _loc3_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/get_quidgets.php";
         this._postVars.lookup_user = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.login != this._currentUserLogin ? this._currentUserLogin : "";
         this._postVars.quantity = this.numQuidgetsPerPage;
         this._postVars.offset = this._pageNum * this.numQuidgetsPerPage;
         this._postVars.sorting_type = this._filterStr;
         this._postVars.sendAndLoad(_loc3_,this._phpResults,"POST");
         trace("[Quilt " + this._objId + "] ------------------------ get_quidgets.php ---------------------- ");
         for(var _loc2_ in this._postVars)
         {
            trace("[Quilt " + this._objId + "] getQuidgetData. _postVars." + _loc2_ + ":" + this._postVars[_loc2_]);
         }
      }
   }
   function parseNPCFriendXML(aXML)
   {
      com.poptropica.util.Debug.trace("Quilt :: parseNPCFriendXML",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(aXML.firstChild.hasChildNodes())
      {
         var _loc17_ = 0;
         var _loc14_ = undefined;
         var _loc15_ = undefined;
         var _loc12_ = aXML.firstChild.firstChild;
         while(_loc12_ != null)
         {
            if(_loc12_.nodeName == "campaign")
            {
               var _loc2_ = _loc12_.firstChild;
               while(_loc2_ != null)
               {
                  switch(_loc2_.nodeName)
                  {
                     case "campaign_name":
                        _loc14_ = String(_loc2_.firstChild.nodeValue);
                        this._campaigns[this._currentUserLogin] = _loc14_;
                        break;
                     case "click_url":
                        _loc15_ = String(_loc2_.firstChild.nodeValue);
                  }
                  _loc2_ = _loc2_.nextSibling;
               }
            }
            else if(_loc12_.nodeName == "quidget")
            {
               var _loc3_ = {};
               _loc2_ = _loc12_.firstChild;
               while(_loc2_ != null)
               {
                  switch(_loc2_.nodeName)
                  {
                     case "count":
                     case "look":
                     case "total":
                     case "state_code":
                     case "mood":
                     case "ranking":
                        _loc3_[_loc2_.nodeName] = Number(_loc2_.firstChild.nodeValue);
                        break;
                     case "photos":
                        _loc3_.photos = [];
                        var _loc7_ = _loc2_.firstChild;
                        while(_loc7_ != null)
                        {
                           var _loc6_ = {};
                           var _loc4_ = _loc7_.firstChild;
                           while(_loc4_ != null)
                           {
                              switch(_loc4_.nodeName)
                              {
                                 case "file":
                                    _loc6_.photoPath = "framework/npcfriends/quidgets/" + String(_loc4_.firstChild.nodeValue);
                                    break;
                                 case "caption":
                                    _loc6_.photoCaption = String(_loc4_.firstChild.nodeValue);
                              }
                              _loc4_ = _loc4_.nextSibling;
                           }
                           _loc6_.island = "";
                           _loc3_.photos.push(_loc6_);
                           _loc7_ = _loc7_.nextSibling;
                        }
                        _loc3_.count = _loc3_.photos.length;
                        break;
                     case "looks":
                        _loc3_.looks = [];
                        var _loc8_ = _loc2_.firstChild;
                        while(_loc8_ != null)
                        {
                           _loc3_.looks.push(String(_loc8_.firstChild.nodeValue));
                           _loc8_ = _loc8_.nextSibling;
                        }
                        _loc3_.numLooks = _loc3_.looks.length;
                        break;
                     case "islands":
                        var _loc10_ = String(_loc2_.firstChild.nodeValue);
                        if(_loc10_ == "")
                        {
                           _loc3_[_loc2_.nodeName] = [];
                           _loc3_.total = 0;
                        }
                        else
                        {
                           var _loc5_ = _loc10_.split(",");
                           _loc3_.total = _loc5_.length;
                           var _loc13_ = {};
                           for(var _loc16_ in _loc5_)
                           {
                              _loc10_ = _loc5_[_loc16_];
                              var _loc11_ = _loc10_.split(":");
                              _loc13_[_loc11_[0]] = _loc11_[1];
                           }
                           _loc3_[_loc2_.nodeName] = _loc13_;
                        }
                        break;
                     case "banner":
                        _loc5_ = String(_loc2_.firstChild.nodeValue).split(",");
                        var _loc9_ = {};
                        _loc9_.x = Number(_loc5_[0]);
                        _loc9_.y = Number(_loc5_[1]);
                        _loc9_.file = _loc5_[2];
                        _loc9_.campaign = _loc14_;
                        _loc3_.banner = _loc9_;
                        break;
                     default:
                        _loc3_[_loc2_.nodeName] = String(_loc2_.firstChild.nodeValue);
                        break;
                  }
                  _loc2_ = _loc2_.nextSibling;
               }
               _loc3_.npc_friend = true;
               _loc3_.campaign_name = _loc14_;
               if(_loc3_.click_url == null)
               {
                  _loc3_.click_url = _loc15_;
               }
               if(_loc3_.banner)
               {
                  _loc3_.banner.clickurl = _loc3_.click_url;
               }
               this._allQuidgetData[this._currentUserLogin][_loc17_] = _loc3_;
               _loc17_ = _loc17_ + 1;
            }
            _loc12_ = _loc12_.nextSibling;
         }
         this._allQuidgetNumQuidgets[this._currentUserLogin] = _loc17_;
         trace("Quilt quidget count: " + _loc17_);
         this.makeQuidgetsAsNeeded();
      }
      else
      {
         trace("Quilt error parsing npc friend xml");
      }
   }
   function onQuizReviewTestClick()
   {
      trace("[Quilt] onQuizReviewTestClick... using canned data");
      this.useCannedData(77);
      this.drawInitialPage();
   }
   function onPhpGetQuidgetsComplete(success)
   {
      trace("[Quilt " + this._objId + "] onPhpGetQuidgetsComplete. success:" + success);
      if(this._phpResults.answer == undefined)
      {
         return undefined;
      }
      for(var _loc4_ in this._phpResults)
      {
         trace("[Quilt " + this._objId + "] onPhpGetQuidgetsComplete. _phpResults." + _loc4_ + ":" + this._phpResults[_loc4_]);
      }
      var _loc5_ = "";
      var _loc0_ = null;
      if((_loc0_ = this._phpResults.answer) !== "ok")
      {
         _loc5_ = "Sorry, profiles are not available right now. Please check back later.";
      }
      else
      {
         var _loc6_ = this._phpResults.user_quidget_json;
         trace("[Quilt " + this._objId + "] jstr:" + _loc6_);
         var _loc2_ = this._json.parse(_loc6_);
         this._allQuidgetNumQuidgets[this._currentUserLogin] = _loc2_.total;
         trace("[Quilt " + this._objId + "] _allQuidgetNumQuidgets[_currentUserLogin]:" + this._allQuidgetNumQuidgets[this._currentUserLogin]);
         trace("_postVars.offset is " + this._postVars.offset);
         trace("_allQuidgetData[_currentUserLogin] has " + this._allQuidgetData[this._currentUserLogin].length + " items already");
         for(_loc4_ in _loc2_.quidgets)
         {
            var _loc3_ = Number(this._postVars.offset) + Number(_loc4_);
            trace("[Quilt " + this._objId + "] putting quidget" + _loc2_.quidgets[_loc4_].name + "into position " + _loc3_ + " :" + _loc2_.quidgets[_loc4_]);
            this._allQuidgetData[this._currentUserLogin][_loc3_] = _loc2_.quidgets[_loc4_];
         }
         this._lastLoadedLogin = this._currentUserLogin;
         this.makeQuidgetsAsNeeded();
      }
      if(_loc5_ != "")
      {
         this._asset.mcTopMsg._visible = true;
         this._asset.mcTopMsg.tf.text = _loc5_;
         this._asset.mcLoadingMessage._visible = true;
      }
   }
   function makeQuidgetsAsNeeded()
   {
      var _loc3_ = undefined;
      var _loc7_ = undefined;
      var _loc4_ = undefined;
      trace("[Quilt " + this._objId + "] MakeQuidgetsAsNeeded num quidgets loaded:" + this._allQuidgetData[this._currentUserLogin].length + "  out of " + this._allQuidgetNumQuidgets[this._currentUserLogin]);
      if(this._campaigns[this._currentUserLogin])
      {
         var _loc10_ = this._campaigns[this._currentUserLogin];
         com.poptropica.controllers.PopController.getInstance().track(_loc10_,"ViewedQuilt");
         _root.quiltTest.removeMovieClip();
         _root.createEmptyMovieClip("quiltTest",_root.getNextHighestDepth());
         _root.quiltTest.onEnterFrame = this.fnNPCFriendTimer;
         _root.quiltTest.time = getTimer();
         _root.quiltTest.campaign = _loc10_;
      }
      var _loc5_ = 0;
      while(_loc5_ < this._allQuidgetData[this._currentUserLogin].length)
      {
         if(this._quidgetArr[_loc5_] == undefined)
         {
            _loc3_ = this._allQuidgetData[this._currentUserLogin][_loc5_];
            trace("Quilt::makeQuidgetsAsNeeded() uses qData");
            for(var _loc9_ in _loc3_)
            {
               trace(_loc9_ + ">" + _loc3_[_loc9_]);
            }
            if(_loc3_.name == undefined)
            {
               _loc3_.name = "membership";
            }
            if(_loc3_.name == "medallion_summary")
            {
               _loc3_.name = "medallionSummary";
            }
            if(_loc3_.name == "battle_ranking")
            {
               _loc3_.name = "battleRank";
            }
            _loc7_ = "quidget" + _loc5_;
            var _loc6_ = _loc3_.name + "Quidget";
            trace("[Quilt " + this._objId + "]attempting to create quidget: _quidgetContainer:" + this._quidgetContainer + ", c:" + _loc6_ + ", n:" + _loc7_);
            var _loc8_ = this._quidgetContainer.attachMovie(_loc6_,_loc7_,this._quidgetContainer.getNextHighestDepth());
            _loc4_ = com.poptropica.sections.quidget.QuidgetBase(_loc8_);
            if(_loc4_ == undefined)
            {
               trace("[Quilt " + this._objId + "]**************** failed to make quidge of kind:" + _loc6_ + "   quidget:" + _loc4_);
            }
            else
            {
               if(_loc3_.name == "quiz" && this._currentUserLogin == "quizreview")
               {
                  _loc4_.debugFlag = true;
               }
               _loc4_._y = -1000;
               _loc4_.qName = _loc3_.name;
               _loc4_.init(_loc3_);
               this._quidgetArr.push(_loc4_);
               _loc4_.active = false;
               _loc4_.addEventListener("rollOver",Delegate.create(this,this.onQuidgetRollover));
               _loc4_.addEventListener("rollOut",Delegate.create(this,this.onQuidgetRollout));
               _loc4_.addEventListener("loadComplete",Delegate.create(this,this.onQuidgetLoadComplete));
               _loc4_.addEventListener("delete",Delegate.create(this,this.onQuidgetDelete));
            }
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function useCannedData(t)
   {
      trace("[Quilt " + this._objId + "] useCannedData:" + t);
      this._allQuidgetData[this._currentUserLogin] = [];
      switch(t)
      {
         case 77:
            var _loc5_ = [];
            _loc5_ = this._quizReviewInput.tfQuizId.text.split(",");
            var _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               var _loc3_ = _loc5_[_loc2_].split("*")[0];
               var _loc4_ = {name:"quiz",type:"personality",quiz_name:"testName",id:_loc3_,score:random(2),xml_path:"framework/assets/popquiz/xml/quiz_" + _loc3_ + ".xml"};
               if(_loc5_[_loc2_].split("*").length > 0)
               {
                  _loc4_.type = "ad";
               }
               trace("[Quilt] id:" + _loc3_);
               this._allQuidgetData[this._currentUserLogin].push(_loc4_);
               _loc2_ = _loc2_ + 1;
            }
            break;
         case 88:
            _loc5_ = [12184,12185,12171,12172,12173,12167,12123,12124,12135,12136,12137,12138,12139,12140,12141,12145,12146,12050,12051,12052,12053,12054,12055,12056,12057,12058,12059,12060,12061,12062,12063,12064,12065,12066,12067,12071,12072,12073,12074,12075,12076,12077,12078,12079,12087,12088,12089,12090,12091,12092,12093,12094,12095,12096,12097,12098,12099,12100,12101,12102,12103,12104,12105,12106,12107,12125];
            _loc2_ = 0;
            while(_loc2_ < _loc5_.length)
            {
               this._allQuidgetData[this._currentUserLogin].push({name:"quiz",type:"personality",quiz_name:"testName",id:_loc5_[_loc2_],score:random(2),xml_path:"framework/assets/popquiz/xml/quiz_" + _loc5_[_loc2_] + ".xml"});
               _loc2_ = _loc2_ + 1;
            }
            break;
         case 99:
            var _loc16_ = "{\"total\":8,\"quidgets\":[{\"total\":0,\"islands\":[],\"name\":\"medallion_summary\",\"type\":\"accomplishment\"},{\"country_code\":\"-1\",\"state_code\":-1,\"name\":\"location\",\"type\":\"personality\"},{\"name\":\"photos\",\"type\":\"accomplishment\",\"count\":0,\"photo\":[]},{\"name\":\"closet\",\"type\":\"personality\",\"count\":10,\"look\":-1},{\"type\":\"personality\",\"name\":\"mood\",\"mood\":-1},{\"name\":\"friends\",\"type\":\"accomplishment\",\"count\":\"1\"},{\"name\":\"battle_ranking\",\"type\":\"accomplishment\",\"ranking\":0},{\"name\":\"membership\",\"type\":\"accomplishment\",\"status\":\"notmember\",\"date\":-1}]}";
            var _loc9_ = undefined;
            _loc9_ = [{total:0,islands:[],name:"medallion_summary",type:"accomplishment"},{country_code:"-1",state_code:-1,name:"location",type:"personality"},{name:"photos",type:"accomplishment",count:0,photo:[]},{name:"closet",type:"personality",count:10,look:-1},{type:"personality",name:"mood",mood:-1},{name:"friends",type:"accomplishment",count:"0"},{name:"battle_ranking",type:"accomplishment",ranking:0},{name:"membership",type:"accomplishment",status:"notmember",date:-1}];
            this._allQuidgetData[this._currentUserLogin] = _loc9_;
            break;
         case 111:
            _loc9_ = [{name:"tribe",type:"personality",id:4005}];
            this._allQuidgetData[this._currentUserLogin] = _loc9_;
      }
      this._allQuidgetNumQuidgets[this._currentUserLogin] = this._allQuidgetData[this._currentUserLogin].length;
      this.makeQuidgetsAsNeeded();
      this._state = "normal";
      this.updateLoadingMessage();
      this.loadFirstPage();
   }
   function onQuidgetRollover(e)
   {
      if(e.quidget._visible)
      {
         com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().setMessage(e.quidget.asset,e.quidget.rolloverString);
      }
   }
   function onQuidgetRollout(o)
   {
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().objRollout(o.quidget.asset);
   }
   function animateOpenIfNecessary()
   {
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().isQuiltOpen = true;
      if(!this._isVisible)
      {
         com.greensock.TweenMax.to(this._asset,1,{_y:0});
      }
   }
   function setOpen()
   {
      this._asset._y = 0;
      this._isVisible = true;
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().isQuiltOpen = true;
   }
   function loadUser(o)
   {
      if(com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.login != o.login)
      {
         com.poptropica.sections.friendsHub.FriendsViewCounter.incrementCounter("friend_profile");
      }
      trace("[Quilt " + this._objId + "] loadUser. _state:" + this._state + " user:" + o.login + "   _lastLoadedLogin:" + this._lastLoadedLogin);
      if(o.login == undefined && _root._url.indexOf("file:/") != -1)
      {
         o.login = "pizmogames";
      }
      if(o.login == undefined)
      {
         return undefined;
      }
      if(this._lastLoadedLogin == o.login && this._lastLoadedLogin != undefined)
      {
         return undefined;
      }
      this._dropDown.setItemByValue("all",false);
      this._filterStr = "all";
      this._currentUserLogin = o.login;
      this._pageNum = 0;
      if(this._state == "loading")
      {
         this.onQuidgetKillAnimComplete();
      }
      else
      {
         this.setAsLoading();
         this.animateOpenIfNecessary();
         var _loc4_ = undefined;
         var _loc5_ = undefined;
         var _loc6_ = undefined;
         _loc6_ = 0;
         var _loc9_ = 0.9;
         var _loc3_ = 0;
         while(_loc3_ < this._quidgetArr.length)
         {
            _loc4_ = this._quidgetArr[_loc3_];
            _loc5_ = (this._quidgetArr.length - _loc3_) / 60;
            com.greensock.TweenMax.killTweensOf(_loc4_);
            com.greensock.TweenMax.to(_loc4_,_loc9_,{delay:_loc5_,_y:_loc4_._y + 500,ease:com.greensock.easing.Sine.easeOut});
            if(_loc5_ > _loc6_)
            {
               _loc6_ = _loc5_;
            }
            _loc3_ = _loc3_ + 1;
         }
         com.greensock.TweenMax.delayedCall(_loc6_ + _loc9_ + 0.5,this.onQuidgetKillAnimComplete,null,this);
      }
   }
   function onQuidgetKillAnimComplete()
   {
      this._buildAnim = "dropFromHorizon";
      this.loadFirstPage();
   }
   function hideClip(mc)
   {
      mc._visible = false;
   }
   function updateLoadingMessage()
   {
      trace("[Quilt " + this._objId + "] updateLoadingMessage. pagenum:" + this._pageNum);
      this._asset.mcLoadingMessage._visible = this._state == "loading" && this._pageNum == 0;
      this._asset.btnNext._visible = this._state != "loading";
      this._asset.btnPrev._visible = this._state != "loading";
      this._asset.mcNextLoadingMsg._visible = this._state == "loading" && this._pageNum > 0;
   }
   function setAsLoading()
   {
      this._state = "loading";
      this._dropDown.active = false;
      this.updateLoadingMessage();
   }
   function onQuidgetLoadComplete(o)
   {
      var _loc3_ = undefined;
      var _loc4_ = true;
      if(this._state == "loading")
      {
         var _loc2_ = 0;
         while(_loc2_ < this._quidgetArr.length)
         {
            _loc3_ = this._quidgetArr[_loc2_];
            if(!_loc3_.isLoaded)
            {
               _loc4_ = false;
            }
            _loc2_ = _loc2_ + 1;
         }
         if(_loc4_)
         {
            com.greensock.TweenMax.delayedCall(0.1,this.onDelayAfterLoad,null,this);
            this._state = "loaded";
         }
      }
   }
   function onDelayAfterLoad()
   {
      if(this._state == "loaded")
      {
         this._state = "normal";
         this._dropDown.active = true;
         var _loc2_ = 0;
         while(_loc2_ < this._quidgetArr.length)
         {
            if(this._quidgetArr[_loc2_].qName == "quiz")
            {
               trace("[Quilt " + this._objId + "] quidget:" + this._quidgetArr[_loc2_]);
               this._quidgetArr[_loc2_].loadXml();
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      trace("[Quilt " + this._objId + "] onDelayAfterLoad() _fnAfterPageOfQuidgetsReady:" + this._fnAfterPageOfQuidgetsReady);
      this._fnAfterPageOfQuidgetsReady();
   }
   function drawInitialPage()
   {
      this.addEventListener("drawComplete",Delegate.create(this,this.checkInitialQuidgetToOpen));
      this._pageNum = 0;
      this.draw(this._buildAnim);
   }
   function checkInitialQuidgetToOpen()
   {
      this.removeEventListener("drawComplete",arguments.caller);
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialQuidgetToOpen != undefined)
      {
         var _loc4_ = this.findQuidgetByName(com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialQuidgetToOpen);
         com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialQuidgetToOpen = undefined;
         trace("[Quilt " + this._objId + "] initialQuidgetToOpen:" + _loc4_);
         _loc4_.onAssetClick();
         _global.friendsHubInitialQuidgetToOpen = undefined;
      }
   }
   function findQuidgetByName(t)
   {
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this._quidgetArr.length)
      {
         _loc3_ = this._quidgetArr[_loc2_];
         trace("quidget.type:" + _loc3_.name + " = " + t + "?");
         if(_loc3_.name == t)
         {
            _loc5_ = _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function onQuidgetDelete(o)
   {
      this.deleteQuidget(o.quidget);
   }
   function deleteQuidget(quidget)
   {
      var _loc2_ = new LoadVars();
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc2_);
      this._phpResults = new LoadVars();
      this._phpResults.onLoad = Delegate.create(this,this.onRemoveQuizComplete);
      var _loc5_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/remove_quidget.php";
      trace("[Quilt " + this._objId + "]  QuidgetQuiz(quidget):" + com.poptropica.sections.quidget.QuidgetQuiz(quidget) + "    " + quidget.id);
      _loc2_.quiz_id = com.poptropica.sections.quidget.QuidgetQuiz(quidget).id;
      _loc2_.sendAndLoad(_loc5_,this._phpResults,"POST");
      trace("[Quilt " + this._objId + "] --------------------- remove_quidget.php ---------------------- ");
      for(var _loc3_ in _loc2_)
      {
         trace("[Quilt " + this._objId + "]       " + _loc3_ + ":" + _loc2_[_loc3_]);
      }
   }
   function onRemoveQuizComplete()
   {
      this._allQuidgetData[this._currentUserLogin] = undefined;
      this.loadFirstPage();
   }
   function updatePageBtns()
   {
      trace("[Quilt.as] updatePageBtns _pageNum:" + this._pageNum + "," + this._pageNumMax);
      if(this._pageNum == 0 && this._pageNumMax == 0)
      {
         this._asset.btnPrev._alpha = 0;
         this._asset.btnNext._alpha = 0;
      }
      else
      {
         this._asset.btnPrev._alpha = this._pageNum <= 0 ? 0 : 100;
         this._asset.btnNext._alpha = this._pageNum >= this._pageNumMax ? 0 : 100;
      }
   }
   function draw(animType, pageOffset)
   {
      trace("[Quilt " + this._objId + "]draw. arguments.caller:" + arguments.caller + " this:" + this);
      var _loc22_ = undefined;
      var _loc6_ = undefined;
      var _loc7_ = undefined;
      var _loc3_ = undefined;
      if(pageOffset == undefined)
      {
         pageOffset = 0;
      }
      if(animType == undefined)
      {
         animType = "none";
      }
      var _loc10_ = 0.1;
      var _loc4_ = undefined;
      var _loc31_ = this._quidgetArr.length;
      var _loc8_ = 0;
      while(_loc8_ < _loc31_)
      {
         _loc3_ = this._quidgetArr[_loc8_];
         _loc3_.active = true;
         _loc22_ = Math.floor(_loc8_ / (this.NUM_COLS * this.NUM_ROWS));
         var _loc9_ = _loc8_ % this.NUM_COLS;
         var _loc13_ = Math.floor(_loc8_ % (this.NUM_COLS * this.NUM_ROWS) / this.NUM_COLS);
         this._quidgetArr[_loc8_]._visible = true;
         _loc6_ = (_loc22_ - this._pageNum + pageOffset) * 805 + this.X_BASE + _loc9_ * this.X_SPACING;
         _loc7_ = this.Y_BASE + _loc13_ * this.Y_SPACING;
         var _loc14_ = 0;
         switch(animType)
         {
            case "scaleInPlace":
               _loc14_ = _loc9_ * 0.1 + _loc13_ * 0.05;
               _loc3_._xscale = 0.001;
               _loc3_._yscale = 50;
               _loc3_._x = _loc6_ + 60;
               _loc3_._y = _loc7_ + 40;
               _loc4_ = 1;
               com.greensock.TweenMax.killTweensOf(_loc3_);
               com.greensock.TweenMax.to(_loc3_,_loc4_,{delay:_loc14_,_x:_loc6_,_y:_loc7_,_alpha:100,_xscale:100,_yscale:100,ease:com.greensock.easing.Elastic.easeOut});
               _loc10_ = Math.max(_loc14_,_loc10_ - _loc4_) + _loc4_;
               break;
            case "dropFromHorizon":
               _loc14_ = _loc9_ * 0.1 + _loc13_ * 0.05;
               _loc3_._x = _loc6_ + 30;
               _loc3_._y = 200;
               _loc3_._yscale = _loc0_ = 50;
               _loc3_._xscale = _loc0_;
               _loc4_ = 0.7;
               com.greensock.TweenMax.killTweensOf(_loc3_);
               com.greensock.TweenMax.to(_loc3_,1,{delay:_loc14_,_x:_loc6_,_y:_loc7_,_alpha:100,_xscale:100,_yscale:100,ease:com.greensock.easing.Bounce.easeOut,easeParams:[1.2,1.5]});
               _loc10_ = Math.max(_loc14_,_loc10_ - _loc4_) + _loc4_;
               break;
            case "growFromChar":
               _loc14_ = _loc9_ * 0.1 + _loc13_ * 0.05;
               var _loc19_ = new flash.geom.Point();
               this._asset.globalToLocal(_loc19_);
               _loc3_._x = _loc19_.x;
               _loc3_._y = _loc19_.y - 70;
               _loc3_._yscale = _loc0_ = 10;
               _loc3_._xscale = _loc0_;
               _loc4_ = 0.7;
               com.greensock.TweenMax.killTweensOf(_loc3_);
               com.greensock.TweenMax.to(_loc3_,_loc4_ * 0.97,{delay:_loc14_,_x:280 + _loc9_ * 50,_y:320 + _loc13_ * 30,_xscale:40,_yscale:40,_alpha:100,ease:com.greensock.easing.Sine.easeOut});
               com.greensock.TweenMax.to(_loc3_,1,{delay:_loc4_ + 0.3,_x:_loc6_,_y:_loc7_,_alpha:100,_xscale:100,_yscale:100,ease:com.greensock.easing.Elastic.easeOut,easeParams:[1.2,1.5]});
               _loc10_ = Math.max(_loc14_,_loc10_ - _loc4_) + _loc4_;
               break;
            case "bounceIn":
               _loc3_._y = _loc7_;
               if(_loc6_ > 805)
               {
                  _loc3_._x = _loc6_;
               }
               else
               {
                  var _loc12_ = _loc6_;
                  var _loc11_ = _loc7_;
                  var _loc15_ = [];
                  var _loc16_ = (- _loc9_ / 2 - 1) / 3;
                  var _loc5_ = (-3 - 2 * Math.random()) / 2;
                  var _loc20_ = 1.02;
                  var _loc21_ = _loc7_;
                  var _loc18_ = 1.3;
                  var _loc17_ = 0;
                  while(_loc12_ > -160)
                  {
                     if(_loc17_ % 4 == 0)
                     {
                        _loc15_.unshift(new flash.geom.Point(_loc12_,_loc11_));
                     }
                     _loc17_ = _loc17_ + 1;
                     _loc12_ += _loc16_;
                     _loc11_ += _loc5_;
                     _loc5_ += _loc20_;
                     if(_loc11_ >= _loc21_)
                     {
                        _loc16_ *= _loc18_;
                        _loc5_ *= _loc18_;
                        _loc5_ = - _loc5_;
                     }
                  }
                  _loc3_._x = _loc15_[0].x;
                  _loc3_._y = _loc15_[0].y;
                  if(_loc8_ == 8)
                  {
                     _loc14_ = 2.5;
                  }
                  else
                  {
                     _loc14_ = (6 - _loc9_) / 4 + Math.random() / 5;
                  }
                  _loc3_.setAnim(_loc15_);
                  com.greensock.TweenMax.delayedCall(_loc14_,_loc3_.startAnim,null,_loc3_);
                  _loc10_ = Math.max(_loc14_,_loc10_ - 2) + 2;
               }
               break;
            case "none":
               _loc3_._x = _loc6_;
               _loc3_._y = _loc7_;
               break;
            case "fromPreviousPosition":
               com.greensock.TweenMax.killTweensOf(_loc3_);
               com.greensock.TweenMax.to(_loc3_,0.75,{_x:_loc6_,_y:_loc7_,_alpha:100,_xscale:100,_yscale:100,ease:com.greensock.easing.Sine.easeInOut});
         }
         _loc8_ = _loc8_ + 1;
      }
      com.greensock.TweenMax.delayedCall(_loc10_,this.drawAnimComplete,null,this);
      this._quidgetContainer.swapDepths(this._asset.getNextHighestDepth());
      this._pageNumMax = Math.max(0,Math.floor((this._allQuidgetNumQuidgets[this._currentUserLogin] - 1) / this.numQuidgetsPerPage));
      this.updatePageBtns();
      this.dispatchEvent({type:"drawComplete"});
   }
   function drawAnimComplete()
   {
      this.updateLoadingMessage();
   }
   function restoreZorder()
   {
      this._asset.mcDropDown.swapDepths(this._asset.quidgetContainer);
   }
   function nextBounceTween(ths, quidget)
   {
      if(Math.abs(quidget.accelY) > 4)
      {
         var _loc2_ = Math.max(0.05,Math.abs(quidget.accelY) / 1000);
         com.greensock.TweenMax.killTweensOf(quidget);
         com.greensock.TweenMax.to(quidget,_loc2_,{_y:quidget._y + quidget.accelY,yoyo:true,repeat:1,onComplete:ths.nextBounceTween,onCompleteParams:[ths,quidget],ease:com.greensock.easing.Sine.easeOut});
         quidget.accelY *= 0.55;
      }
   }
   function onQuiltDropdownSelected(a)
   {
      trace("[Quilt " + this._objId + "]onDropDownMenuItemSelected. value:" + a.selectedItem.value);
      if(this._filterStr != a.selectedItem.val)
      {
         this._filterStr = a.selectedItem.val;
         this.clearCurrentUserCache();
      }
      this.loadFirstPage();
   }
   function loadFirstPage()
   {
      this.clearQuidgets();
      this.initNewUser();
      this._fnAfterPageOfQuidgetsReady = this.drawInitialPage;
      this.checkGetQuidgetData();
   }
   function onPrevClick()
   {
      this.changePage(-1);
      com.poptropica.controllers.PopController.getInstance().track("Friends","PreviousNextClicked","","",false,"Hub");
   }
   function onNextClick()
   {
      com.poptropica.controllers.PopController.getInstance().track("Friends","PreviousNextClicked","","",false,"Hub");
      this.changePage(1);
   }
   function onCloseQuiltClick()
   {
      com.greensock.TweenMax.to(this._asset,1,{_y:this.CLOSED_Y});
      this._isVisible = false;
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().isQuiltOpen = false;
      this.dispatchEvent({type:"close"});
   }
   function changePage(dir)
   {
      if(this._pageNum + dir < 0 || this._pageNum + dir > this._pageNumMax)
      {
         return undefined;
      }
      if(this._state == "normal")
      {
         this._pageChangeDir = dir;
         this._pageNum += this._pageChangeDir;
         this._fnAfterPageOfQuidgetsReady = this.enactPageChange;
         this.checkGetQuidgetData();
      }
   }
   function enactPageChange()
   {
      trace("[Quilt " + this._objId + "] enactPageChange. this:" + this);
      this.makeQuidgetsAsNeeded();
      this.draw("none",this._pageChangeDir);
      this._state = "animating";
      var _loc8_ = 0.9;
      var _loc3_ = undefined;
      var _loc9_ = new flash.geom.Point(400 - this._pageChangeDir * 400,320);
      var _loc5_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this._quidgetArr.length)
      {
         _loc3_ = this._quidgetArr[_loc2_];
         var _loc4_ = _loc2_;
         if(this._pageChangeDir == -1)
         {
            _loc4_ = this._quidgetArr.length - _loc2_;
         }
         _loc5_ = _loc4_ * 0.008 + Math.random() * 0.04;
         com.greensock.TweenMax.killTweensOf(_loc3_);
         com.greensock.TweenMax.to(_loc3_,_loc8_,{delay:_loc5_,_x:_loc3_._x - this._pageChangeDir * 805,ease:com.greensock.easing.Elastic.easeInOut});
         _loc2_ = _loc2_ + 1;
      }
      com.greensock.TweenMax.delayedCall(_loc8_ + _loc5_ + 0.01,this.setStateNormal,null,this);
      this.updatePageBtns();
   }
   function get numQuidgetsPerPage()
   {
      return this.NUM_COLS * this.NUM_ROWS;
   }
   function setStateNormal()
   {
      this._state = "normal";
   }
   function clearQuidgets()
   {
      var _loc2_ = 0;
      while(_loc2_ < this._quidgetArr.length)
      {
         com.greensock.TweenMax.killTweensOf(this._quidgetArr[_loc2_]);
         this._quidgetArr[_loc2_]._visible = false;
         this._quidgetArr[_loc2_]._y = -1000;
         this._quidgetArr[_loc2_].removeMovieClip();
         this._quidgetArr[_loc2_].active = false;
         _loc2_ = _loc2_ + 1;
      }
      this._dropDown.removeEventListener("itemSelected",this);
   }
   function clearLastLoaded()
   {
      this._lastLoadedLogin = undefined;
   }
   function get isVisible()
   {
      return this._isVisible;
   }
   function killQuidget(q)
   {
      q.removeMovieClip();
   }
   function onUnloadHandler()
   {
   }
   function set active(b)
   {
      this._active = b;
      this.setQuidgetsActive(b);
   }
   function setQuidgetsActive(b)
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this._quidgetArr.length)
      {
         _loc3_ = this._quidgetArr[_loc2_];
         _loc3_.active = b;
         _loc2_ = _loc2_ + 1;
      }
   }
   function get quidgetData()
   {
      return this._allQuidgetData[this._currentUserLogin];
   }
   function noBigAd()
   {
      this._asset.btnClose._visible = false;
   }
   function clearCurrentUserCache()
   {
      this._allQuidgetData[this._currentUserLogin] = undefined;
   }
   function set visible(b)
   {
      this._asset._visible = b;
      this.active = b;
   }
   function openQuidgetByName(name)
   {
      trace("openQuidgetByName");
      flash.external.ExternalInterface.call("dbug","openQuidgetByName");
      var _loc2_ = this.findQuidgetByName(name);
      flash.external.ExternalInterface.call("dbug","THE QUIDGET: " + _loc2_);
      _loc2_.onAssetClick();
   }
   function countProps(o)
   {
      var _loc1_ = 0;
      for(var _loc2_ in o)
      {
         _loc1_ = _loc1_ + 1;
      }
      return _loc1_;
   }
}
