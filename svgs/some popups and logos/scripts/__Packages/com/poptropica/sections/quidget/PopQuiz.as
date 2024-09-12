class com.poptropica.sections.quidget.PopQuiz extends Object
{
   var objId;
   var _asset;
   var _container;
   var _xmlPath;
   var _context;
   var _id;
   var _quizXml;
   var _popupModeToShow;
   var _quizDisplay;
   var _usingCustomLayout;
   var _quizData;
   var _nextStandardQuidgetNumToLoad;
   var _answerNum;
   var _btnCenterX;
   var _numButtons;
   var _confirmDeleteDialog;
   var controller;
   var _phpResults;
   var bouncer;
   function PopQuiz(mc)
   {
      super();
      this.objId = random(100000);
      trace("[PopQuiz " + this.objId + "] Constructor. mc:" + mc);
      if(mc != undefined)
      {
         this.asset = mc;
      }
      mx.events.EventDispatcher.initialize(this);
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
   function set asset(mc)
   {
      this._asset = mc;
      if(this._asset == undefined)
      {
         this.dispatchEvent({type:"loadError"});
      }
      else
      {
         this._container = this._asset.content;
      }
   }
   function init(pContext, __id, xmlPath)
   {
      this._xmlPath = xmlPath.split("\\").join();
      trace("[PopQuiz " + this.objId + "] init:" + pContext + "   id:" + __id + "   path:" + xmlPath);
      this._context = pContext;
      this._id = __id;
      this.loadXml();
   }
   function loadXml()
   {
      com.poptropica.sections.quidget.PopQuizModel.getInstance().addEventListener("quizXmlLoaded",Delegate.create(this,this.onQuizXmlLoaded));
      com.poptropica.sections.quidget.PopQuizModel.getInstance().addEventListener("quizXmlLoadError",Delegate.create(this,this.onQuizXmlLoadError));
      com.poptropica.sections.quidget.PopQuizModel.getInstance().loadQuizXml(this._id,this._xmlPath);
   }
   function onQuizXmlLoaded(o)
   {
      trace("[PopQuiz " + this.objId + "] onQuizXmlLoaded() o.data:" + o.data + "  o.id:" + o.id);
      if(o.id == this._id)
      {
         com.poptropica.sections.quidget.PopQuizModel.getInstance().removeEventListener("quizXmlLoaded",arguments.caller);
         com.poptropica.sections.quidget.PopQuizModel.getInstance().removeEventListener("quizXmlLoadError",arguments.caller);
         this._quizXml = o.data;
         this.loadAsset();
      }
   }
   function onQuizXmlLoadError()
   {
      this.dispatchEvent({type:"loadError"});
   }
   function loadAsset()
   {
      var _loc3_ = new MovieClipLoader();
      var _loc2_ = {};
      _loc3_.addListener(_loc2_);
      _loc2_.onLoadInit = Delegate.create(this,this.onAssetLoad);
      _loc2_.onLoadError = Delegate.create(this,this.onAssetLoadError);
      var _loc4_ = "framework/assets/popquiz/pop_quiz_assets_" + this._id + ".swf";
      _loc3_.loadClip(_loc4_,this._container);
   }
   function onAssetLoadError()
   {
      this.dispatchEvent({type:"loadError"});
   }
   function onAssetLoad(mc)
   {
      trace("[PopQuiz " + this.objId + "] onAssetLoad. mc" + mc);
      this._container = mc;
      this._popupModeToShow = "ask";
      if(this.isAd() && !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf && this._context == "quilt")
      {
         this._popupModeToShow = "adReadOnly";
      }
      switch(this._popupModeToShow)
      {
         case "ask":
            this._quizDisplay = this._container.attachMovie("popQuiz" + this._id + "Layout","popQuizAsk",this._container.getNextHighestDepth());
            this._usingCustomLayout = this._quizDisplay != undefined;
            if(this._quizDisplay == undefined)
            {
               trace("[PopQuiz " + this.objId + "] onAssetLoad. No custom layout found... Switching to standard layout");
               var _loc3_ = new MovieClipLoader();
               var _loc2_ = {};
               _loc3_.addListener(_loc2_);
               _loc2_.onLoadInit = Delegate.create(this,this.onAssetLoadStandard);
               var _loc4_ = "framework/assets/popquiz/pop_quiz_core_assets.swf";
               _loc3_.loadClip(_loc4_,this._container);
            }
            else
            {
               this.onAssetLoadCustom(this._container);
            }
            if(this.isAd())
            {
               com.poptropica.controllers.PopController.getInstance().track(this._quizData.campaign_name,"Impression","Popup","",false,"Hub",this._quizData.quiz_name);
               com.poptropica.controllers.PopController.getInstance().sendTrackingPixel(this._quizData.impression_URL,"PopQuizAssetLoad_Ask");
            }
            break;
         case "adReadOnly":
            this._quizDisplay = this._container.attachMovie("popQuiz" + this._id + "PopupAd","popQuizAsk",this._container.getNextHighestDepth());
            com.poptropica.controllers.PopController.getInstance().track(this._quizData.campaign_name,"Impression","Popup","",false,"FriendHub",this._quizData.quiz_name);
            com.poptropica.controllers.PopController.getInstance().sendTrackingPixel(this._quizData.impression_URL,"PopQuizAssetLoad_AdReadOnly");
      }
      if(this.isAd())
      {
         this._quizDisplay.btnClickThru.onRelease = Delegate.create(this,this.adBtnClick);
         this._quizDisplay.btnClickThru.onRollOver = Delegate.create(this,this.adBtnRollOver);
         this._quizDisplay.btnClickThru.onRollOut = Delegate.create(this,this.adBtnRollOut);
      }
   }
   function adBtnRollOver()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
   }
   function adBtnRollOut()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function isAd()
   {
      return this._quizData.type == "ad";
   }
   function adBtnClick()
   {
      trace("[PopQuiz " + this.objId + "] adBtnClick.");
      var _loc2_ = undefined;
      switch(this._context)
      {
         case "quilt":
            _loc2_ = "Hub";
            if(this._popupModeToShow == "adReadOnly")
            {
               _loc2_ = "FriendHub";
            }
            break;
         case "welcomeBack":
            _loc2_ = "WelcomeBack";
      }
      com.poptropica.controllers.PopController.getInstance().track(this._quizData.campaign_name,"ClicktoSponsor","","",false,_loc2_,this._quizData.quiz_name);
      getURL(this._quizData.click_through_URL,"_blank");
   }
   function onAssetLoadStandard(mc)
   {
      if(mc != undefined)
      {
         this._container = mc;
      }
      var _loc4_ = this._quizXml.answer.length;
      var _loc5_ = 3;
      var _loc6_ = undefined;
      if(_loc4_ > _loc5_)
      {
         _loc6_ = "4+";
      }
      else
      {
         _loc6_ = String(_loc4_);
      }
      var _loc7_ = "popQuizStandard" + _loc6_ + "Choices";
      trace("     ------->>>> linkage!!!!!:" + _loc7_ + "   _quizXml:" + this._quizXml);
      this._quizDisplay = this._container.attachMovie(_loc7_,"popQuizAsk",this._container.getNextHighestDepth());
      this.setAskText();
      if(_loc4_ > _loc5_)
      {
         var _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            var _loc3_ = this._quizDisplay.btnContainer.attachMovie("quizBtn","mcChoice" + _loc2_,this._quizDisplay.btnContainer.getNextHighestDepth());
            _loc3_._x = _loc2_ * 130;
            _loc2_ = _loc2_ + 1;
         }
         this._quizDisplay.onEnterFrame = Delegate.create(this,this.checkCoverFlow);
         this._quizDisplay.btnContainer._x = 20;
      }
      this._nextStandardQuidgetNumToLoad = 0;
      this.loadNextStandardQuidget();
   }
   function onAssetLoadCustom(mc)
   {
      if(mc != undefined)
      {
         this._container = mc;
      }
      var _loc4_ = this._quizXml.answer.length;
      var _loc8_ = undefined;
      if(_loc4_ > 3 || this._usingCustomLayout)
      {
         _loc8_ = "4+";
      }
      this.setAskText();
      trace("[PopQuiz " + this.objId + "] onAssetLoadCustom:" + this._container + "," + this._container.popQuizAsk + "," + this._quizDisplay + " numAnswers:" + _loc4_);
      var _loc6_ = _loc4_ >= 3 ? 130 : 140;
      var _loc5_ = _loc4_ >= 3 ? 0 : 26;
      if(_loc4_ > 3 || this._usingCustomLayout)
      {
         var _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            var _loc3_ = this._quizDisplay.btnContainer.attachMovie("quizBtn","mcChoice" + _loc2_,this._quizDisplay.btnContainer.getNextHighestDepth());
            _loc3_._x = _loc5_ + _loc2_ * _loc6_;
            _loc2_ = _loc2_ + 1;
         }
         this._quizDisplay.onEnterFrame = Delegate.create(this,this.checkCoverFlow);
         this._quizDisplay.btnContainer._x = 20;
      }
      this._nextStandardQuidgetNumToLoad = 0;
      this.loadNextStandardQuidget();
   }
   function checkCoverFlow()
   {
      var _loc3_ = this._quizDisplay._xmouse;
      if(_loc3_ > -40 && _loc3_ < 390)
      {
         var _loc4_ = _loc3_ - 175;
         var _loc2_ = this._quizDisplay.btnContainer._x - _loc4_ * 0.2;
         _loc2_ = Math.max(_loc2_,(- (this._quizXml.answer.length - 2)) * 130 + 80);
         _loc2_ = Math.min(_loc2_,20);
         this._quizDisplay.btnContainer._x = _loc2_;
      }
   }
   function loadNextStandardQuidget()
   {
      var _loc5_ = new MovieClipLoader();
      var _loc3_ = {};
      _loc5_.addListener(_loc3_);
      _loc3_.onLoadInit = Delegate.create(this,this.onLoadNextStandardQuidget);
      var _loc4_ = "framework/assets/popquiz/pop_quiz_assets_" + this._id + ".swf";
      var _loc2_ = "mcChoice" + this._nextStandardQuidgetNumToLoad;
      var _loc6_ = this._quizDisplay.btnContainer["mcChoice" + this._nextStandardQuidgetNumToLoad].bouncer;
      trace("?????? :" + this._quizDisplay.btnContainer + ", " + this._quizDisplay.btnContainer[_loc2_] + "   str:" + _loc2_ + "   bouncer:" + this._quizDisplay.btnContainer["mcChoice" + this._nextStandardQuidgetNumToLoad].bouncer);
      trace("[PopQuiz " + this.objId + "] trying to load " + _loc4_ + " into clip: " + _loc6_);
      _loc5_.loadClip(_loc4_,_loc6_);
   }
   function onLoadNextStandardQuidget()
   {
      var _loc2_ = this._quizDisplay.btnContainer["mcChoice" + this._nextStandardQuidgetNumToLoad].bouncer;
      var _loc3_ = undefined;
      _loc3_ = _loc2_.attachMovie("popQuizCustomButtonQuidgets_" + this._id,"quidget",_loc2_.getNextHighestDepth());
      if(_loc3_ == undefined)
      {
         _loc3_ = _loc2_.attachMovie("popQuizQuidgets_" + this._id,"quidget",_loc2_.getNextHighestDepth());
      }
      if(_loc3_ == undefined)
      {
         this.dispatchEvent({type:"loadError"});
         trace("ERROR------------- choiceClip == undefined");
      }
      _loc3_.gotoAndStop(this._nextStandardQuidgetNumToLoad + 1);
      this._nextStandardQuidgetNumToLoad = this._nextStandardQuidgetNumToLoad + 1;
      if(this._nextStandardQuidgetNumToLoad < this._quizXml.answer.length)
      {
         this.loadNextStandardQuidget();
      }
      else
      {
         this.initAsk();
      }
   }
   function getSolutionIcon()
   {
      trace("[PopQuiz " + this.objId + "] getSolutionIcon:" + this._quizDisplay + " , answernum:" + this._answerNum);
      return this._quizDisplay.btnContainer["mcChoice" + this._answerNum];
   }
   function initAsk()
   {
      if(!this.isAd())
      {
         var _loc15_ = this._asset.attachMovie("trashIcon","mcTrashCanIcon",this._asset.getNextHighestDepth());
         _loc15_._x = -164;
         _loc15_._y = 58;
         _loc15_.onRelease = Delegate.create(this,this.onDeleteClick);
      }
      else
      {
         trace("?????? quizdata.type:" + this._quizData.type);
      }
      trace("[PopQuiz " + this.objId + "] initAsk. mc:" + this._quizDisplay + ", choice 0:" + this._quizDisplay.btnContainer.mcChoice0);
      com.greensock.TweenMax.to(this._container,1,{_alpha:100});
      var _loc3_ = 0;
      var _loc6_ = 1000;
      var _loc7_ = -1000;
      while(this._quizDisplay.btnContainer["mcChoice" + _loc3_] != undefined)
      {
         var _loc2_ = this._quizDisplay.btnContainer["mcChoice" + _loc3_];
         _loc2_.num = _loc3_;
         _loc2_.origX = _loc2_._x;
         _loc2_.controller = this;
         _loc2_.answer = this._quizXml.answer[_loc3_];
         _loc2_.tf.text = this._quizXml.answer[_loc3_];
         if(this._quizXml.custom.hideAnswerText == "true")
         {
            _loc2_.tf._visible = false;
         }
         if(_loc2_.bouncer.mcChoiceText != undefined)
         {
            _loc2_.bouncer.mcChoiceText.tf.text = _loc2_.answer;
         }
         _loc6_ = Math.min(_loc2_._x,_loc6_);
         _loc7_ = Math.max(_loc2_._x,_loc7_);
         this.setButtonInteractive(_loc2_,true);
         var _loc4_ = 0.68;
         var _loc11_ = _loc3_ * 0.25;
         _loc2_.bouncer._y = 0;
         var _loc5_ = undefined;
         if(this._quizXml.custom.bounceAmount != undefined)
         {
            _loc5_ = _loc2_.bouncer._y + Number(this._quizXml.custom.bounceAmount);
         }
         else
         {
            _loc5_ = _loc2_.bouncer._y + 10;
         }
         com.greensock.TweenMax.killTweensOf(_loc2_.bouncer);
         com.greensock.TweenMax.to(_loc2_.bouncer,_loc4_,{delay:_loc11_,_y:_loc5_,yoyo:true,repeat:-1,ease:com.greensock.easing.Sine.easeInOut});
         if(_loc2_.shadow != undefined)
         {
            com.greensock.TweenMax.killTweensOf(_loc2_.shadow);
            com.greensock.TweenMax.to(_loc2_.shadow,_loc4_,{delay:_loc11_,_xscale:_loc2_.shadow._xscale * 1.07,_yscale:_loc2_.shadow._yscale * 1.07,yoyo:true,repeat:-1,ease:com.greensock.easing.Sine.easeInOut});
         }
         _loc3_ = _loc3_ + 1;
      }
      this._btnCenterX = (_loc6_ + _loc7_) / 2;
      this._numButtons = _loc3_;
      this.setAskText();
      this.dispatchEvent({type:"ready"});
   }
   function onDeleteClick()
   {
      trace("[PopQuiz " + this.objId + "] onDeleteClick");
      this._confirmDeleteDialog = this._asset.attachMovie("quizDeleteConfirmDialog","quizDeleteConfirmDialog",this._asset.getNextHighestDepth());
      this._confirmDeleteDialog._x = 3;
      this._confirmDeleteDialog.btnYes.onRelease = Delegate.create(this,this.onDeleteConfirmClick);
      this._confirmDeleteDialog.btnNo.onRelease = Delegate.create(this,this.onDeleteNoClick);
   }
   function onDeleteConfirmClick()
   {
      this.dispatchEvent({type:"delete"});
   }
   function onDeleteNoClick()
   {
      this._confirmDeleteDialog.removeMovieClip();
   }
   function setButtonInteractive(btn, b)
   {
      if(b)
      {
         btn.addEventListener("click",Delegate.create(this,this.buttonRelease));
         btn.onRelease = this.onButtonRelease;
         btn.onRollOver = this.onButtonRollOver;
         btn.onRollOut = this.onButtonRollout;
      }
      else
      {
         delete btn.onRelease;
         delete btn.onRollOver;
         delete btn.onRollOut;
      }
   }
   function setAskText()
   {
      trace("[PopQuiz " + this.objId + "] setAskText. _quizXml.question:" + this._quizXml.question);
      this._quizDisplay.tf0.text = this._quizXml.question;
      this._quizDisplay.tf0._y = this._quizDisplay.tf0.textHeight <= 28 ? 12 : 2;
   }
   function onButtonRelease()
   {
      this.controller.buttonRelease(this);
   }
   function buttonRelease(btn)
   {
      trace("[PopQuiz " + this.objId + "] buttonRelease: btnNum:" + btn.num);
      this._quizDisplay.performClickAction(Number(btn.num));
      this.submitAnswer(Number(btn.num));
      var _loc5_ = 0.6;
      var _loc2_ = 0;
      while(_loc2_ < this._numButtons)
      {
         var _loc3_ = this._quizDisplay.btnContainer["mcChoice" + _loc2_];
         if(_loc2_ != this._answerNum)
         {
            com.greensock.TweenMax.to(_loc3_,_loc5_,{_alpha:0});
         }
         this.setButtonInteractive(_loc3_,false);
         _loc2_ = _loc2_ + 1;
      }
      com.greensock.TweenMax.delayedCall(_loc5_ + 0.1,this.removeMask,null,this);
      trace("[PopQuiz " + this.objId + "] onButtonRelase. context" + "," + this._context + "  _quizDisplay.bg:" + this._quizDisplay.bg);
      switch(this._context)
      {
         case "quilt":
            this._container.bg._visible = false;
            this._container.btnClose._visible = false;
            this._container.tf._visible = false;
            btn.bouncer.filters = [];
            break;
         case "welcomeBack":
      }
   }
   function removeMask()
   {
      trace("[PopQuiz " + this.objId + "] removeMask _quizDisplay.mcMask:" + this._quizDisplay.mcMask);
      if(this._quizDisplay.mcMask)
      {
         this._quizDisplay.mcMask.gotoAndStop(2);
      }
   }
   function submitAnswer(answerNum)
   {
      trace("[PopQuiz " + this.objId + "] submitAnswer:" + answerNum);
      this._answerNum = answerNum;
      var _loc2_ = new LoadVars();
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc2_);
      _loc2_.score = this._answerNum;
      _loc2_.quiz_id = this._id;
      this._phpResults = new LoadVars();
      this._phpResults.onLoad = Delegate.create(this,this.onPhpSubmitComplete);
      var _loc3_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/submit_quidget.php";
      _loc2_.sendAndLoad(_loc3_,this._phpResults,"POST");
      delete this._quizDisplay.onEnterFrame;
      this.dispatchEvent({type:"popQuizChoiceMade"});
   }
   function onPhpSubmitComplete()
   {
      trace("[PopQuiz " + this.objId + "] onPhpSubmitComplete");
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
   }
   function onButtonRollOver()
   {
      var _loc2_ = new flash.filters.GlowFilter(16776960,30,5,5,5,5);
      this.bouncer.filters = [_loc2_];
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
   }
   function onButtonRollout()
   {
      this.bouncer.filters = [];
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function backToAsk()
   {
      this._asset.btnBack._alpha = 0;
      var _loc3_ = 0;
      while(_loc3_ < this._numButtons)
      {
         var _loc2_ = this._quizDisplay.btnContainer["mcChoice" + _loc3_];
         if(_loc3_ == this._answerNum)
         {
            com.greensock.TweenMax.to(_loc2_,0.6,{_x:_loc2_.origX,ease:com.greensock.easing.Sine.easeInOut});
         }
         else
         {
            com.greensock.TweenMax.to(_loc2_,0.6,{_alpha:100});
         }
         _loc2_.bouncer.filters = [];
         this.setButtonInteractive(_loc2_,true);
         _loc3_ = _loc3_ + 1;
      }
      this.setAskText();
   }
   function get answerNum()
   {
      return this._answerNum;
   }
   function get question()
   {
      return this._quizXml.question;
   }
   function get quizXml()
   {
      return this._quizXml;
   }
   function setAnswered(i)
   {
      trace("[PopQuiz " + this.objId + "] setAnswered:" + i);
   }
   function set id(pId)
   {
      this._id = pId;
   }
   function set xmlPath(xmlP)
   {
      this._xmlPath = xmlP;
   }
   function get answerStr()
   {
      return this._quizXml.answer[this._answerNum];
   }
   function set quizData(o)
   {
      this._quizData = o;
   }
}
