class com.poptropica.sections.quidget.QuidgetQuiz extends com.poptropica.sections.quidget.QuidgetBase
{
   var _quizObj;
   var _objId;
   var _id;
   var _answerNum;
   var _xmlPath;
   var _currentQuizJson;
   var _type;
   var _asset;
   var _popup;
   var _answeredClip;
   var debugFlag;
   var _inited = false;
   var DELAY_AFTER_CHOICE_MADE = 0.5;
   function QuidgetQuiz()
   {
      super();
      this._quizObj = new com.poptropica.sections.quidget.PopQuiz();
   }
   function init(o)
   {
      trace("[QuidgetQuiz " + this._objId + "] init. id:" + o.id);
      if(o.npc_friend == undefined)
      {
         this._id = o.id;
         this._answerNum = o.score;
         this._xmlPath = o.xml_path;
      }
      this._quizObj.quizData = o;
      this._currentQuizJson = o;
      this._type = o.type;
      for(var _loc4_ in o)
      {
         trace("[QuizTab] phpResults     " + _loc4_ + ": " + o[_loc4_]);
      }
      var _loc5_ = new MovieClipLoader();
      var _loc3_ = {};
      _loc5_.addListener(_loc3_);
      if(o.npc_friend)
      {
         _loc3_.onLoadInit = Delegate.create(this,this.quizLoadInitCommon);
         _loc5_.loadClip("framework/npcfriends/quidgets/" + o.file,this._asset.contentContainer.content);
      }
      else
      {
         if(this._answerNum == -1)
         {
            _loc3_.onLoadInit = Delegate.create(this,this.onQuizUnansweredLoadInit);
         }
         else
         {
            _loc3_.onLoadInit = Delegate.create(this,this.onQuizLoadInit);
         }
         _loc5_.loadClip("framework/assets/popquiz/pop_quiz_core_assets.swf",this._asset.contentContainer.content);
      }
   }
   function quizLoadInitCommon()
   {
      var _loc2_ = false;
      var _loc3_ = false;
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         _loc2_ = true;
      }
      else if(this._currentQuizJson.npc_friend && this._currentQuizJson.popup)
      {
         _loc2_ = true;
         _loc3_ = true;
      }
      else if(this._type == "ad")
      {
         if(this.inTargetDemo())
         {
            _loc2_ = true;
            _loc3_ = true;
         }
      }
      if(_loc2_)
      {
         this.setEditable(true,_loc3_);
      }
      this.dispatchLoadComplete();
   }
   function inTargetDemo()
   {
      var _loc5_ = undefined;
      var _loc2_ = SharedObject.getLocal("Char","/");
      var _loc3_ = _loc2_.data.age >= Number(this._currentQuizJson.campaign_min_age) && _loc2_.data.age <= Number(this._currentQuizJson.campaign_max_age);
      var _loc4_ = _loc2_.data.gender == this._currentQuizJson.campaign_gender_id || Number(this._currentQuizJson.campaign_gender_id) == 2;
      trace("[QuidgetQuiz] charLSO.data.age:" + _loc2_.data.age + ", charLSO.data.gender:" + _loc2_.data.gender + "   inAgeRange:" + _loc3_ + "   genderMatch:" + _loc4_);
      trace("_currentQuizJson.campaign_min_age/max:" + this._currentQuizJson.campaign_min_age + "," + this._currentQuizJson.campaign_max_age);
      _loc5_ = _loc3_ && _loc4_;
      return _loc5_;
   }
   function onQuizUnansweredLoadInit()
   {
      var _loc2_ = this._asset.contentContainer.content.attachMovie("popQuizUnansweredAsset","popQuizUnansweredAsset",this._asset.contentContainer.content.getNextHighestDepth());
      this.quizLoadInitCommon();
   }
   function onQuizLoadInit(mc)
   {
      trace("[QuidgetQuiz " + this._objId + "] onQuizLoadInit. ");
      this._quizObj.asset = mc;
      this.quizLoadInitCommon();
      com.poptropica.controllers.PopController.getInstance().track("Friends","Impression","","",false,"Hub",this._currentQuizJson.quiz_name);
      if(this._quizObj.isAd())
      {
         var _loc2_ = "";
         if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
         {
            _loc2_ = "Hub";
         }
         else if(this.inTargetDemo())
         {
            _loc2_ = "FriendHub";
         }
         if(_loc2_ != "")
         {
            com.poptropica.controllers.PopController.getInstance().track(this._currentQuizJson.campaign_name,"Impression","","",false,_loc2_,this._currentQuizJson.quiz_name);
            com.poptropica.controllers.PopController.getInstance().sendTrackingPixel(this._currentQuizJson.impression_URL,"QuidgetQuizLoadInit_" + _loc2_);
         }
      }
      this.draw();
   }
   function draw()
   {
      if(this._answerNum == -1)
      {
         this._asset.mcUnanswered._visible = true;
      }
      else
      {
         this.setPopQuizAnswer(this._answerNum);
      }
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this.setEditable(true);
      }
   }
   function onAssetClick()
   {
      this.checkAsk();
   }
   function checkAsk()
   {
      trace("[QuidgetQuiz " + this._objId + "] checkAsk");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
      var _loc2_ = new flash.geom.Point(this._x + 60,this._y + 40);
      if(this._currentQuizJson.npc_friend)
      {
         this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromSwf("framework/npcfriends/quidgets/" + this._currentQuizJson.popup,_loc2_,false);
      }
      else
      {
         var _loc3_ = "quizAskPopup";
         this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass(_loc3_,_loc2_,"framework/assets/popquiz/pop_quiz_core_assets.swf");
         this._popup.tfMsg._visible = false;
      }
   }
   function onPopupReady(e)
   {
      trace("[QuidgetQuiz " + this._objId + "] onPopupReady" + " _quizObj.objId:" + this._quizObj.objId);
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      if(this._currentQuizJson.npc_friend)
      {
         com.poptropica.controllers.PopController.getInstance().track(this._currentQuizJson.campaign_name,"OpenedPopup",this._currentQuizJson.quiz_name);
         this._popup.clickURL.onRelease = Delegate.create(this,this.onClickURL);
         this._popup.clickURL.onRollOver = Delegate.create(this,this.onRollOverURL);
         this._popup.clickURL.onRollOut = Delegate.create(this,this.onRollOutURL);
      }
      else
      {
         this._popup = e.popup;
         this._quizObj.asset = this._popup;
         this.initQuizObj();
      }
   }
   function onClickURL()
   {
      com.poptropica.controllers.PopController.getInstance().track(this._currentQuizJson.campaign_name,"ClickToSponsor",this._currentQuizJson.quiz_name);
      this.getURL(this._currentQuizJson.click_url,"_blank");
   }
   function onRollOverURL()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
   }
   function onRollOutURL()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function setPopQuizAnswer(i)
   {
      if(this._id)
      {
         this._answerNum = i;
         var _loc2_ = new MovieClipLoader();
         var _loc3_ = {};
         _loc2_.addListener(_loc3_);
         _loc3_.onLoadInit = Delegate.create(this,this.popQuizAnsweredClipLoaded);
         var _loc4_ = "framework/assets/popquiz/pop_quiz_assets_" + this._id + ".swf";
         trace("[QuidgetQuiz " + this._objId + "] setPopQuizAnswer url:" + _loc4_);
         _loc2_.loadClip(_loc4_,this._asset.contentContainer.content);
      }
   }
   function onPopupClose()
   {
      trace("[QuidgetQuiz " + this._objId + "] onPopupClose. _quizObj answer?" + this._quizObj.answerNum);
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      com.greensock.TweenMax.delayedCall(0.03,this.makeIconFlash,null,this);
      if(this._quizObj.answerNum != undefined)
      {
         this._answerNum = this._quizObj.answerNum;
         this.draw();
         com.poptropica.sections.friendsHub.Quilt.getInstance().clearCurrentUserCache();
      }
   }
   function onDropDownItemSelected()
   {
   }
   function initQuizObj()
   {
      if(this._id)
      {
         trace("[QuidgetQuiz " + this._objId + "] initQuizObj. _id:" + this._id);
         this._quizObj.addEventListener("popQuizChoiceMade",Delegate.create(this,this.onPopQuizChoiceMade));
         this._quizObj.addEventListener("delete",Delegate.create(this,this.onDelete));
         this._inited = true;
         this._quizObj.init("quilt",this._id,this._xmlPath);
      }
   }
   function onPopQuizChoiceMade(obj)
   {
      trace("[QuidgetQuiz " + this._objId + "] popQuizChoiceMade. popQuiz:" + this._quizObj.answerNum + " _quizObj.objId:" + this._quizObj.objId);
      this._quizObj.removeEventListener("popQuizChoiceMade",arguments.caller);
      com.greensock.TweenMax.delayedCall(this.DELAY_AFTER_CHOICE_MADE,this.closePopup,null,this);
      com.poptropica.controllers.PopController.getInstance().track("Friends","QuidgetAnswered",this._quizObj.answerStr,"",false,"Hub",this._currentQuizJson.quiz_name);
      if(this._quizObj.isAd())
      {
         com.poptropica.controllers.PopController.getInstance().track(this._currentQuizJson.campaign_name,"QuidgetAnswered",this._quizObj.answerStr,"",false,"Hub",this._currentQuizJson.quiz_name);
      }
   }
   function closePopup()
   {
      if(this._currentQuizJson.npc_friend)
      {
         this._popup.clickURL.onRelease = null;
         delete this._popup.clickURL.onRelease;
         this._popup.clickURL.onRollOver = null;
         delete this._popup.clickURL.onRollOver;
         this._popup.clickURL.onRollOut = null;
         delete this._popup.clickURL.onRollOut;
      }
      this._quizObj.removeEventListener("delete",arguments.caller);
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().objRollout(this._asset);
   }
   function popQuizAnsweredClipLoaded(mc)
   {
      var _loc2_ = "popQuizQuidgets_" + this._id;
      this._answeredClip = mc.attachMovie(_loc2_,"popQuizAnswered",100);
      if(this._answeredClip == undefined)
      {
         trace("[QuidgetQuiz] linkage error: " + _loc2_ + " not found");
      }
      var _loc3_ = Number(this._answerNum) + 1;
      this._answeredClip.gotoAndStop(_loc3_);
      this.convertToBitmap();
   }
   function onDelete()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.dispatchDeleteEvent));
      this.closePopup();
   }
   function dispatchDeleteEvent()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      this.dispatchEvent({type:"delete",quidget:this});
   }
   function onDeleteClick()
   {
      this.dispatchEvent({type:"deleteRequested",quidget:this});
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
      return "quiz";
   }
   function get id()
   {
      return this._id;
   }
   function get rolloverString()
   {
      if(this._currentQuizJson.npc_friend)
      {
         return this._currentQuizJson.rollover;
      }
      var _loc2_ = "";
      if(this.debugFlag)
      {
         _loc2_ = "(id: " + this._id + ") ";
      }
      if(this._answerNum == -1)
      {
         _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? com.poptropica.sections.friendsHub.FriendsModel.getInstance().currentUserAvatarName + " hasn\'t answered the question, \'" : "Click to answer the question, \'";
         _loc2_ += this._quizObj.question + "\'";
      }
      else
      {
         _loc2_ += com.poptropica.sections.quidget.PopQuizModel.getInstance().getAnsweredStr(this._id,this._answerNum,"quilt");
         if(this.inTargetDemo() && this._type == "ad")
         {
            if(this._quizObj.quizXml.quidgetRollover != undefined)
            {
               _loc2_ += "\n" + this._quizObj.quizXml.quidgetRollover;
            }
         }
      }
      return _loc2_;
   }
   function loadXml()
   {
      if(this._id)
      {
         this._quizObj.id = this._id;
         this._quizObj.xmlPath = this._xmlPath;
         this._quizObj.loadXml(this._id,this._xmlPath);
      }
   }
}
