class com.poptropica.views.home.WelcomeBackView extends com.poptropica.mvc.AbstractView
{
   var _content_mc;
   var _model;
   var _welcome_back_mc;
   var _return_btn_mc;
   var _return_image;
   var _membership_tour_banner;
   var _store_item_box;
   var _carusel_mc;
   var _feed_quiz_tabs_mc;
   var _credits_btn_mc;
   var _enter_btn_mc;
   var _promo_code_tf;
   var _credits_tf;
   var my_int_cred;
   var _feedQuizTabs;
   var _surveyProxy;
   var _survey_popup;
   var my_int;
   var _error_window;
   var _keyboardListener;
   var _controller;
   var _save_game_popup;
   var _caruselVO;
   var _updateTime;
   var _arrayOfCaruselContentUrls;
   var _arrayOfCaruselLinks;
   var _arrayOfCaruselCampaigns;
   var _arrayOfDots;
   var _caruselImpressions;
   var _updateCaruselIintervalID;
   var _smallPromoVO;
   static var CARUSEL_DOTS_START_X = 30;
   static var CARUSEL_DOTS_START_Y = 233;
   static var CARUSEL_DOTS_WIDTH_BETWEEN = 20;
   var _currentCaruselIndex = 1;
   var _saveGameWindowLevel = 100;
   var _dotsLevel = 50;
   var _promoCodeWindowLevel = 70;
   var _videoPlaying = false;
   var _cancelCaruselInput = false;
   var _preventCaruselInputTimer = 0;
   var _memberGetSurveyDateRange = null;
   var _streamingVideoContainer = null;
   var _videoLoading = false;
   var _streamingVideo = false;
   var _streamingVideoLoaded = false;
   function WelcomeBackView(m, c, target, depth)
   {
      super(m,c);
      com.poptropica.util.Debug.trace("WelcomeBackView::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._content_mc = target.createEmptyMovieClip("welcome_back_mc",depth);
      com.poptropica.models.PopModel(this._model).setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_LOADING);
      this.make();
   }
   function update(o, infoObj)
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::update()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      switch(infoObj._type)
      {
         case com.poptropica.models.PopUpdateNotificationTypes.PROMO_CODE_ACTIVATION_ERROR:
            this.toggleLoadingScreen(false);
            var _loc3_ = com.poptropica.models.vo.PromoCodeResponseVO(infoObj._data);
            this.showErrorWindow(_loc3_.errorMessage);
            break;
         case com.poptropica.models.PopUpdateNotificationTypes.CREDITS_CHANGE:
            this.toggleLoadingScreen(false);
            var _loc2_ = com.poptropica.models.PopModelConst.avatar.loadCredits();
            this.displayUserCredits(_loc2_);
            this._welcome_back_mc.tfMC.gotoAndPlay("animationLBL");
      }
   }
   function make()
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::make()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).gameplayMC.trackCampaign("AdInventory","AdSpotPresented","Home Page Carousel");
      this._welcome_back_mc = this._content_mc.attachMovie("LibWelcomeBack","welcomeBack_mc",1,{_y:45});
      this._return_btn_mc = this._welcome_back_mc.mcReturnBtn;
      this._return_image = this._welcome_back_mc.mcReturnGameImg.mcContainer;
      this._membership_tour_banner = this._welcome_back_mc.mcGetMembership;
      this._store_item_box = this._welcome_back_mc.mcStoreItemBox;
      this._carusel_mc = this._welcome_back_mc.mcLargPromoP1;
      this._feed_quiz_tabs_mc = this._welcome_back_mc.mcFeedQuizTabs;
      this._credits_btn_mc = this._membership_tour_banner.mcBuyMore;
      this._enter_btn_mc = this._membership_tour_banner.mcEnterBtn;
      this._promo_code_tf = this._membership_tour_banner.tfCode;
      this._credits_tf = this._membership_tour_banner.mcCreditsText.tfJustTextMC.tfCredits;
      com.poptropica.util.Debug.trace("WelcomeBackView::buttons() : " + this._promo_code_tf + " : " + this._enter_btn_mc,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc7_ = com.poptropica.models.PopModel(this._model).island;
      com.poptropica.util.Debug.trace("island is " + _loc7_);
      this._credits_btn_mc.stop();
      this._carusel_mc.stop();
      this._store_item_box.stop();
      this._return_image.attachBitmap(com.poptropica.models.PopModel(this._model).latest_gameplay_bm,this._return_image.getNextHighestDepth(),"auto",true);
      var _loc12_ = com.poptropica.controllers.PopController(this.getController());
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._enter_btn_mc,2);
      this._enter_btn_mc.onRelease = com.poptropica.util.EventDelegate.create(this,this.onSubmitPromoPress);
      this._credits_btn_mc.onRelease = com.poptropica.util.EventDelegate.create(this,this.onBuyMorePress);
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._credits_btn_mc,2);
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._return_btn_mc,2);
      this._return_btn_mc.onRelease = com.poptropica.util.EventDelegate.create(this,this.onReturnGameBtnPress);
      var _loc9_ = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.mem_status;
      this._membership_tour_banner.gotoAndStop(_loc9_);
      this._membership_tour_banner.onEnterFrame = com.poptropica.util.EventDelegate.create(this,this.onMembershipTourBannerFrameReached);
      var _loc4_ = new com.poptropica.controllers.commands.GetAdCommand();
      _loc4_.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onHomePageSmallPromoData));
      _loc4_.type = "Home Page Small Promo";
      _loc4_.override_offmain = 1;
      _loc4_.exec();
      var _loc3_ = new com.poptropica.controllers.commands.GetAdCommand();
      _loc3_.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onHomePageCarouselData));
      _loc3_.type = "Home Page Carousel";
      if("Poptropolis" == _loc7_)
      {
         _loc3_.override_island = "Zombie";
      }
      _loc3_.override_offmain = 1;
      _loc3_.testDataPath = "test_data/home/get_campaigns_carousel.txt";
      _loc3_.exec();
      this._promo_code_tf.onSetFocus = com.poptropica.util.EventDelegate.create(this,this.onPromoCodeFocus);
      this._promo_code_tf.onKillFocus = com.poptropica.util.EventDelegate.create(this,this.onPromoCodeKillFocus);
      this.my_int_cred = setInterval(this,"getUserCreditsDelayed",200);
      if(!com.poptropica.models.PopModel(this._model).isTestMode)
      {
         this.createSavePopup();
      }
      if(!com.poptropica.models.PopModel(this._model).isRegistered)
      {
      }
      var _loc10_ = _root._url.indexOf("file://") != -1;
      if(com.poptropica.models.PopModel.getInstance().isRegistered || _loc10_)
      {
         this._feed_quiz_tabs_mc.feed._visible = true;
         this._feed_quiz_tabs_mc.quiz._visible = true;
         this._feedQuizTabs = new com.poptropica.components.tab.TabController(this._feed_quiz_tabs_mc);
         var _loc6_ = new com.poptropica.views.home.welcomeBack.QuizTab(this._feed_quiz_tabs_mc.quiz);
         _loc6_.addEventListener("NO_QUIZZES_FIRSTLOAD",com.poptropica.util.EventDelegate.create(this,this.goToFeedTab));
         _loc6_.addEventListener("NO_QUIZZES",com.poptropica.util.EventDelegate.create(this,this.goToFeedTabWait));
         var _loc8_ = new com.poptropica.views.home.welcomeBack.FeedTab(this._feed_quiz_tabs_mc.feed);
         _loc8_.addEventListener("INITIALIZED",com.poptropica.util.EventDelegate.create(this,this.killTimer));
         var _loc5_ = [];
         _loc5_.push(_loc6_);
         _loc5_.push(_loc8_);
         this._feedQuizTabs.init(_loc5_);
      }
      else
      {
         this._feed_quiz_tabs_mc.feed._visible = false;
         this._feed_quiz_tabs_mc.quiz._visible = false;
         this._feed_quiz_tabs_mc.tfNonRegMsg.text = "Save your game to take Quizzes and make Friends!";
      }
      com.poptropica.models.PopModel(this._model).setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
   }
   function replaceMembershipTourBanner(banner)
   {
      banner._visible = false;
      var _loc2_ = this._content_mc.attachMovie("specialPromoPanel","promoPanel",this._content_mc.getNextHighestDepth(),{_x:542,_y:286});
      _loc2_.onRelease = function()
      {
         var _loc1_ = com.poptropica.models.PopModel.getInstance();
         _loc1_.gameplayMC.loadSceneAS3("game.scenes.lands.lab2.Lab2");
      };
      _loc2_.onRollOver = function()
      {
         com.poptropica.controllers.PopController.getInstance(com.poptropica.models.PopModel.getInstance()).setPointerDisplay("click");
      };
   }
   function onMembershipTourBannerFrameReached()
   {
      trace("[WelcomeBackView] onMembershipTourBannerFrameReached. _membership_tour_banner:" + this._membership_tour_banner);
      delete this._membership_tour_banner.onEnterFrame;
      if(this._membership_tour_banner.btnBuy)
      {
         this._membership_tour_banner.btnCover.onRelease = com.poptropica.util.EventDelegate.create(this,this.onMemberShipBannerPress);
         this._membership_tour_banner.btnBuy.onRelease = com.poptropica.util.EventDelegate.create(this,this.onMemberShipBannerPress);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._membership_tour_banner.btnCover,2);
         com.poptropica.util.CursorViewChanger.getInstance().addElement(this._membership_tour_banner.btnBuy,2);
      }
   }
   function getMemberSurveyDateRange()
   {
      this._memberGetSurveyDateRange = new com.poptropica.controllers.commands.GetMemberSurveyXMLCommand();
      this._memberGetSurveyDateRange.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.loadMemberDate));
      this._memberGetSurveyDateRange.exec();
   }
   function checkForViewedSurvey()
   {
      if(_root.country == "US")
      {
         var _loc3_ = SharedObject.getLocal("Temp","/");
         var _loc4_ = "sandboxSurvey";
         if(_loc3_.data[_loc4_] == undefined)
         {
            _loc3_.clear();
            _loc3_.data[_loc4_] = true;
            _loc3_.flush();
            this.showSurvey();
         }
      }
   }
   function loadMemberDate()
   {
      if(this._memberGetSurveyDateRange != null)
      {
         this._surveyProxy = new com.poptropica.models.proxy.ProxyObject();
         this._surveyProxy.callback = Delegate.create(this,this.checkForMemberSurvey);
         this._surveyProxy.doConnect("get_mem_date.php");
      }
      else
      {
         this.getMemberSurveyDateRange();
      }
   }
   function checkForMemberSurvey(data)
   {
      if(data.answer == "ok")
      {
         var _loc2_ = this.parseDate(unescape(data.mem_started));
         var _loc3_ = this.parseDate(unescape(this._memberGetSurveyDateRange.startDate));
         var _loc4_ = this.parseDate(unescape(this._memberGetSurveyDateRange.endDate));
         flash.external.ExternalInterface.call("dbug","testing member date4 : member started : " + _loc2_ + " start range : " + _loc3_ + " end range : " + _loc4_);
         if(utils.Utils.checkDateRange(_loc2_,_loc3_,_loc4_))
         {
            this.showSurvey();
         }
      }
   }
   function parseDate(fullDate)
   {
      var _loc2_ = fullDate.slice(0,10);
      var _loc1_ = new Array();
      _loc1_[0] = Number(_loc2_.slice(0,4));
      _loc1_[1] = Number(_loc2_.slice(5,7));
      _loc1_[2] = Number(_loc2_.slice(8));
      return _loc1_;
   }
   function showSurvey()
   {
      var _loc2_ = SharedObject.getLocal("Temp","/");
      trace("Show Survey");
      flash.external.ExternalInterface.call("dbug","seensurvey" + _loc2_.data.viewedMemberSurvey);
      if(_loc2_.data.viewedMemberSurvey == undefined)
      {
         this._survey_popup = new com.poptropica.views.home.welcomeBack.MemberSurvey(this._welcome_back_mc.attachMovie("surveyPopup","surveyPopup",this._saveGameWindowLevel,{_x:-1,_y:-5}));
         _loc2_.data.viewedMemberSurvey = true;
         _loc2_.flush();
      }
   }
   function goToFeedTabWait()
   {
      this.my_int = setInterval(this,"goToFeedTab",5000);
   }
   function goToFeedTab()
   {
      clearInterval(this.my_int);
      this._feedQuizTabs.openNextTab();
   }
   function killTimer()
   {
      clearInterval(this.my_int);
   }
   function getUserCreditsDelayed()
   {
      clearInterval(this.my_int_cred);
      var _this = this;
      var _loc2_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         var _loc1_ = receiver.credits;
         _this.displayUserCredits(_loc1_);
      };
      var _loc3_ = com.poptropica.models.PopModel.getInstance();
      _loc2_.name = _loc3_.poptropica_user.login;
      _loc2_.pass_hash = _loc3_.poptropica_user.password_hash;
      _loc2_.dbid = parseInt(_loc3_.db_id);
      _loc2_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/get_credits.php",receiver,"POST");
   }
   function displayUserCredits(credits)
   {
      trace("creds");
      if(credits == undefined || credits == null)
      {
         credits = 0;
      }
      var _loc3_ = "credits";
      if(credits == 1)
      {
         _loc3_ = "credit";
      }
      this._credits_tf.htmlText = "You have <br><font color=\'#00F623\'>" + credits + "</font> " + _loc3_;
   }
   function showErrorWindow(pTxt)
   {
      var _loc2_ = this._welcome_back_mc.attachMovie("LibPromoErrorWindow","pc_error_mc",this._promoCodeWindowLevel,{_x:0,_y:0});
      this._error_window = new com.poptropica.views.home.welcomeBack.ErrorWindow(_loc2_,pTxt,true);
      this._error_window.addEventListener(com.poptropica.views.home.welcomeBack.ErrorWindow.OK_CLICK,com.poptropica.util.EventDelegate.create(this,this.onPressOKInErrorWindow));
   }
   function onPressOKInErrorWindow()
   {
      removeMovieClip(this._error_window.mc);
      delete this._error_window;
   }
   function onLoadingOver()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function onLoadingOut()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function toggleLoadingScreen(pShow)
   {
      if(pShow)
      {
         com.poptropica.controllers.PopController.getInstance().setPointerDisplay("loading");
      }
      else
      {
         com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
      }
   }
   function toggleKeyInactivity(inB)
   {
      if(inB)
      {
         this._keyboardListener = new Object();
         this._keyboardListener.onKeyUp = com.poptropica.util.EventDelegate.create(this,this.onPromoKeyUp);
         Key.addListener(this._keyboardListener);
      }
      else if(this._keyboardListener)
      {
         this._keyboardListener.onKeyUp = undefined;
         Key.removeListener(this._keyboardListener);
      }
   }
   function onPromoKeyUp()
   {
      var _loc2_ = Key.getCode();
      if(_loc2_ == 13)
      {
         this.checkAndSubmit();
         this.toggleKeyInactivity(false);
      }
   }
   function checkAndSubmit()
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::checkAndSubmit() : " + this._promo_code_tf + " : " + this._promo_code_tf.text,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = com.poptropica.controllers.PopController(this.getController());
      if(this._promo_code_tf.text != "" && this._promo_code_tf.text != "PROMO CODE")
      {
         this.toggleLoadingScreen(true);
         com.poptropica.models.PopModelConst.gameplayMC.loadStore = true;
         com.poptropica.models.PopModelConst._gameplayMC.submitPromoCode = this._promo_code_tf.text;
         com.poptropica.controllers.PopController(this._controller).link("pop://stats");
         Selection.setFocus(undefined);
         this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.PROMO_CODE_ENTERED);
         return true;
      }
      this.showErrorWindow("Please provide a promo code before submitting",true);
      Selection.setFocus(undefined);
      return false;
   }
   function onSubmitPromoPress()
   {
      this.checkAndSubmit();
   }
   function onPromoCodeKillFocus()
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::kill focus() : " + this._promo_code_tf + " : " + this._promo_code_tf.text,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this.toggleKeyInactivity(false);
      if(this._promo_code_tf.text == "")
      {
         this._promo_code_tf.text = "PROMO CODE";
      }
   }
   function onPromoCodeFocus(e)
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::focus() : " + this._promo_code_tf + " : " + this._promo_code_tf.text,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this.toggleKeyInactivity(true);
      if(this._promo_code_tf.text == "PROMO CODE")
      {
         this._promo_code_tf.text = "";
      }
   }
   function createSavePopup()
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::createSavePopup()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = com.poptropica.models.PopModel(this._model).isRegistered;
      if(!_loc2_)
      {
         this._save_game_popup = new com.poptropica.views.home.welcomeBack.SaveGamePopup(this._welcome_back_mc.attachMovie("mcWelcomeBackPopup","save_popup",this._saveGameWindowLevel,{_x:-1,_y:-5}));
      }
   }
   function onBuyMorePress()
   {
      this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.CREDITS_CLICKED);
      com.poptropica.controllers.PopController(this._controller).link("pop://membershipTour");
   }
   function onMemberShipBannerPress()
   {
      this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.MEMBERSHIP_CLICKED);
      com.poptropica.controllers.PopController(this._controller).link("pop://membershipTour");
   }
   function logWWW(s)
   {
      if(flash.external.ExternalInterface.available)
      {
         flash.external.ExternalInterface.call("dbug",s);
      }
      trace(s);
   }
   function onReturnGameBtnPress()
   {
      trace("returnToGame pressed, can logwww? " + typeof _root.logWWW + ", rootdesc " + _root.desc);
      this.logWWW("returnToGame pressed " + _root.desc);
      this._return_btn_mc.gotoAndStop(2);
      this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.GAME_RETURN_CLICKED);
      if("GlobalAS3Embassy" == _root.desc)
      {
         var _loc3_ = SharedObject.getLocal("TransitToken","/");
         for(var _loc4_ in _loc3_.data)
         {
            trace(_loc4_ + " : " + _loc3_.data[_loc4_]);
         }
         trace("AS3Embassy :: transitToken.data.loadAS3 " + _loc3_.data.loadAS3);
         if(_loc3_.data.loadAS3)
         {
            _loc3_.data.nextScene = null;
            _loc3_.data.loadAS3 = false;
            _loc3_.flush();
            com.poptropica.models.PopModelConst.gameplayMC.camera.scene.loadAS3Scene();
            trace("AS3Embassy :: loading as3 directly PopModelConst.gameplayMC.camera.scene.loadAS3Scene : " + com.poptropica.models.PopModelConst.gameplayMC.camera.scene.loadAS3Scene);
         }
         else
         {
            this.logWWW("embassy gets no token data loadAS3, load " + _loc3_.data.prevScene);
            com.poptropica.models.PopModelConst.gameplayMC.loadSceneAS3(_loc3_.data.prevScene);
         }
      }
      else
      {
         this.logWWW("embassy not root dest so set section gameplay");
         com.poptropica.controllers.PopController.getInstance().setSection("gameplay");
      }
   }
   function onHomePageCarouselData(event)
   {
      this._caruselVO = com.poptropica.models.vo.AdvertisementVO(event._data);
      if(!this._caruselVO.campaign_file1)
      {
         return undefined;
      }
      var _loc2_ = this.getCountOfSubStr(this._caruselVO.campaign_file1,"var");
      if(Number(_loc2_) <= 0)
      {
         return undefined;
      }
      this._updateTime = Number(this._caruselVO.campaign_file1.substr(this._caruselVO.campaign_file1.lastIndexOf("updateTime=") + "updateTime=".length,this._caruselVO.campaign_file1.length));
      this._arrayOfCaruselContentUrls = this.parseCaruselContentUrls(this._caruselVO.campaign_file1,_loc2_,true);
      if(this._caruselVO.click_through_URL != undefined)
      {
         this._arrayOfCaruselLinks = this.parseCaruselContentUrls(this._caruselVO.click_through_URL,_loc2_,false);
      }
      else if(this._caruselVO.campaign_file2 != undefined)
      {
         this._arrayOfCaruselLinks = this.parseCaruselContentUrls(this._caruselVO.campaign_file2,_loc2_,false);
      }
      this._arrayOfCaruselCampaigns = this.parseCaruselContentUrls(this._caruselVO.campaign_name,_loc2_,false);
      this.createDots(_loc2_);
      this.currentCaruselIndex = 0;
   }
   function onCaruselUpdateInterval()
   {
      this.currentCaruselIndex = this.currentCaruselIndex + 1;
   }
   function createDots(pCount)
   {
      this._arrayOfDots = new Array();
      this._caruselImpressions = new Array();
      var _loc4_ = this._welcome_back_mc.createEmptyMovieClip("dot_container_mc",this._dotsLevel);
      _loc4_._x = this._carusel_mc._x + com.poptropica.views.home.WelcomeBackView.CARUSEL_DOTS_START_X;
      _loc4_._y = this._carusel_mc._y + com.poptropica.views.home.WelcomeBackView.CARUSEL_DOTS_START_Y;
      var _loc2_ = 0;
      while(_loc2_ < pCount)
      {
         this._caruselImpressions[_loc2_] = false;
         var _loc3_ = _loc4_.attachMovie("mcPromoControlItem","dot" + _loc2_,_loc4_.getNextHighestDepth());
         _loc3_._x = _loc2_ * com.poptropica.views.home.WelcomeBackView.CARUSEL_DOTS_WIDTH_BETWEEN;
         _loc3_.onRelease = com.poptropica.util.EventDelegate.create(this,this.onCaruselControlPress,_loc2_);
         _loc3_.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onCaruselControlOver,_loc2_);
         _loc3_.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onCaruselControlOut,_loc2_);
         this._arrayOfDots.push(_loc3_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function setUpCarouselActivity(pActive)
   {
      if(pActive)
      {
         if(this.isVideoLink(this._arrayOfCaruselLinks[this.currentCaruselIndex]))
         {
            this._videoLoading = true;
            if(this.isStreaming(this._arrayOfCaruselLinks[this.currentCaruselIndex]))
            {
               this.streamVideo();
            }
            else
            {
               this.loadVideo();
            }
         }
         MovieClip(this._carusel_mc).carouselActionMc.enabled = true;
         MovieClip(this._carusel_mc).carouselActionMc.onPress = com.poptropica.util.EventDelegate.create(this,this.onCaruselPress);
         MovieClip(this._carusel_mc).carouselActionMc.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onCaruselOver);
         MovieClip(this._carusel_mc).carouselActionMc.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onCaruselOut);
         MovieClip(this._carusel_mc).carouselActionMc._visible = true;
      }
      else
      {
         if(this.isVideoLink(this._arrayOfCaruselLinks[this.currentCaruselIndex]))
         {
            this.stopVideo();
         }
         MovieClip(this._carusel_mc).carouselActionMc.onPress = undefined;
         MovieClip(this._carusel_mc).carouselActionMc.onRollOver = undefined;
         MovieClip(this._carusel_mc).carouselActionMc.onRollOut = undefined;
         MovieClip(this._carusel_mc).carouselActionMc.enabled = false;
         MovieClip(this._carusel_mc).carouselActionMc._visible = false;
      }
   }
   function loadVideo()
   {
      var _loc3_ = this._carusel_mc.mcCaruselContainer;
      if(_loc3_.video == undefined)
      {
         _global.setTimeout(Delegate.create(this,this.loadVideo),100);
         return undefined;
      }
      var _loc4_ = new Object();
      _loc3_.playNowBtn._alpha = 0;
      _loc3_.bg._alpha = 0;
      _loc4_.metadataReceived = Delegate.create(this,this.setupVideo);
      _loc3_.video.addEventListener("metadataReceived",_loc4_);
      _loc3_.video.complete = Delegate.create(this,this.videoComplete,true);
      _loc3_.video.contentPath = this.getVideoPath(this._arrayOfCaruselLinks[this.currentCaruselIndex]);
   }
   function setupStreamingVideo()
   {
      if(this._streamingVideoContainer.isPlayerLoaded())
      {
         var _loc3_ = this._carusel_mc.mcCaruselContainer;
         this._streamingVideoContainer.setSize(501,263);
         this._streamingVideoContainer.addEventListener("onStateChange",Delegate.create(this,this.streamingVideoStateChange));
         _loc3_.start._alpha = 100;
         _loc3_.playNowBtn._alpha = 100;
         _loc3_.bg._alpha = 100;
         this._videoLoading = false;
      }
      else
      {
         _global.setTimeout(Delegate.create(this,this.setupStreamingVideo),100);
      }
   }
   function setupVideo(eventObject)
   {
      var _loc2_ = this._carusel_mc.mcCaruselContainer;
      var _loc4_ = _loc2_._width - _loc2_.video.metadata.width;
      var _loc3_ = _loc2_._height - _loc2_.video.metadata.height;
      _loc2_.video._x += _loc4_ * 0.5;
      _loc2_.video._y += _loc3_ * 0.5;
      _loc2_.start._alpha = 100;
      _loc2_.playNowBtn._alpha = 100;
      _loc2_.bg._alpha = 100;
      this._videoLoading = false;
   }
   function videoComplete(finished)
   {
      if(finished)
      {
         var _loc2_ = this._carusel_mc.mcCaruselContainer;
         com.greensock.TweenLite.to(_loc2_.end,1,{_alpha:100});
         this._videoPlaying = false;
      }
      this._updateCaruselIintervalID = setInterval(this,"onCaruselUpdateInterval",this._updateTime * 1000);
   }
   function playVideo()
   {
      if(!this._videoLoading)
      {
         var _loc2_ = this._carusel_mc.mcCaruselContainer;
         this._videoPlaying = true;
         clearInterval(this._updateCaruselIintervalID);
         _loc2_.start._alpha = 0;
         _loc2_.playNowBtn._alpha = 0;
         if(this._streamingVideo)
         {
            if(!this._streamingVideoLoaded)
            {
               this._streamingVideoLoaded = true;
               this._streamingVideoContainer.loadVideoByUrl(this.getVideoPath(this._arrayOfCaruselLinks[this.currentCaruselIndex]));
            }
            else
            {
               this._streamingVideoContainer.playVideo();
            }
         }
         else
         {
            _loc2_.video.play();
         }
      }
   }
   function stopVideo()
   {
      var _loc2_ = this._carusel_mc.mcCaruselContainer;
      this._videoPlaying = false;
      trace("video :: stop : " + _loc2_ + " : " + this._streamingVideoContainer);
      if(this._streamingVideo)
      {
         this._streamingVideoContainer.stopVideo();
      }
      else
      {
         _loc2_.video.stop();
      }
   }
   function pauseVideo()
   {
      var _loc2_ = this._carusel_mc.mcCaruselContainer;
      this._videoPlaying = false;
      _loc2_.playNowBtn._alpha = 100;
      if(this._streamingVideo)
      {
         this._streamingVideoContainer.pauseVideo();
      }
      else
      {
         _loc2_.video.pause();
      }
   }
   function isVideoLink(link)
   {
      var _loc1_ = "video://";
      return Boolean(link.indexOf(_loc1_) != -1);
   }
   function getVideoPath(link)
   {
      var _loc1_ = "video://";
      return link.substr(_loc1_.length);
   }
   function isStreaming(link)
   {
      var _loc1_ = ".flv";
      return Boolean(link.indexOf(_loc1_) == -1);
   }
   function streamVideo()
   {
      var _loc3_ = this._carusel_mc.mcCaruselContainer;
      if(_loc3_.video == undefined)
      {
         _global.setTimeout(Delegate.create(this,this.streamVideo),100);
         return undefined;
      }
      this._streamingVideo = true;
      this._streamingVideoLoaded = false;
      var _loc7_ = "http://www.youtube.com/apiplayer";
      var _loc6_ = "http://www.youtube.com";
      var _loc8_ = "http://www.youtube.com/crossdomain.xml";
      if(this._streamingVideoContainer != null)
      {
         this._streamingVideoContainer.removeMovieClip();
      }
      this._streamingVideoContainer = _loc3_.video.createEmptyMovieClip("streamingVideoContainer",_loc3_.video.getNextHighestDepth());
      System.security.allowDomain(_loc6_);
      System.security.loadPolicyFile(_loc8_);
      var _loc5_ = new MovieClipLoader();
      var _loc4_ = new Object();
      _loc4_.onLoadInit = Delegate.create(this,this.setupStreamingVideo);
      _loc5_.addListener(_loc4_);
      _loc5_.loadClip(_loc7_,this._streamingVideoContainer);
   }
   function streamingVideoStateChange(newState)
   {
      if(newState == 0)
      {
         this.videoComplete(true);
      }
   }
   function onCarouselImageLoaded()
   {
      this.setUpCarouselActivity(true);
      if(!this._caruselImpressions[this.currentCaruselIndex])
      {
         this._caruselImpressions[this.currentCaruselIndex] = true;
         var _loc2_ = this._arrayOfCaruselCampaigns[this._currentCaruselIndex];
         this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.LARGE_PROMO_IMPRESSION,String(this._currentCaruselIndex),undefined,_loc2_);
         if(_loc2_.substr(0,2) == "AI")
         {
            com.poptropica.models.PopModel(this._model).gameplayMC.trackCampaign(_loc2_,"AdImpression","Home Page Carousel");
         }
      }
   }
   function onCaruselPress()
   {
      if(this._cancelCaruselInput)
      {
         return undefined;
      }
      if(this.isVideoLink(this._arrayOfCaruselLinks[this.currentCaruselIndex]))
      {
         if(!this._videoLoading)
         {
            if(!this._videoPlaying)
            {
               this.playVideo();
            }
            else
            {
               this.videoComplete();
               this.pauseVideo();
            }
         }
      }
      else
      {
         this._cancelCaruselInput = true;
         if(this._arrayOfCaruselLinks[this.currentCaruselIndex].toLowerCase().indexOf("pop://") == -1)
         {
            this._preventCaruselInputTimer = 31;
            this._carusel_mc.onEnterFrame = Delegate.create(this,this.preventCaruselInput);
         }
         com.poptropica.controllers.PopController(this._controller).link(this._arrayOfCaruselLinks[this.currentCaruselIndex]);
      }
      this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.LARGE_PROMO_CLICKED,String(this._currentCaruselIndex),undefined,this._arrayOfCaruselCampaigns[this._currentCaruselIndex]);
   }
   function preventCaruselInput()
   {
      this._preventCaruselInputTimer = this._preventCaruselInputTimer - 1;
      if(this._preventCaruselInputTimer <= 0)
      {
         this._cancelCaruselInput = false;
         delete this._carusel_mc.onEnterFrame;
      }
   }
   function onCaruselOver()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
      this.updateCarouselSelection();
   }
   function onCaruselOut()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
      this.updateCarouselSelection();
   }
   function updateCarouselSelection()
   {
      var _loc3_ = this._carusel_mc.carouselActionMc.hitTest(_root._xmouse,_root._ymouse);
      if(_loc3_)
      {
         this._carusel_mc.gotoAndStop(2);
         if(this._carusel_mc.mcCaruselContainer.rollOverHandler && (this._carusel_mc.mcCaruselContainer.btnState == "out" || this._carusel_mc.mcCaruselContainer.btnState == undefined))
         {
            this._carusel_mc.mcCaruselContainer.rollOverHandler();
         }
      }
      else
      {
         this._carusel_mc.gotoAndStop(1);
         if(this._carusel_mc.mcCaruselContainer.rollOutHandler && this._carusel_mc.mcCaruselContainer.btnState == "over")
         {
            this._carusel_mc.mcCaruselContainer.rollOutHandler();
         }
      }
   }
   function onCarouselEnterFrame()
   {
      this.updateCarouselSelection();
   }
   function onCaruselControlPress(pIndex)
   {
      this.currentCaruselIndex = pIndex;
   }
   function onCaruselControlOver(value)
   {
      var _loc2_ = value < this._arrayOfDots.length ? value : 0;
      this._arrayOfDots[_loc2_].gotoAndStop(2);
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
   }
   function onCaruselControlOut(value)
   {
      var _loc2_ = value < this._arrayOfDots.length ? value : 0;
      if(_loc2_ != this.currentCaruselIndex)
      {
         this._arrayOfDots[_loc2_].gotoAndStop(1);
      }
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function onHomePageSmallPromoData(event)
   {
      this._smallPromoVO = com.poptropica.models.vo.AdvertisementVO(event._data);
      var _loc2_ = new com.poptropica.util.loaders.SwfLoader();
      _loc2_.load(this._smallPromoVO._campaign_file1,MovieClip(this._store_item_box.mcContainer));
      this._store_item_box.onPress = com.poptropica.util.EventDelegate.create(this,this.onSmallPromoPress);
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._store_item_box,2);
   }
   function onSmallPromoPress()
   {
      this.trackEvent(com.poptropica.events.trackEvents.WelcomeEvent.STORE_CLICKED);
      com.poptropica.controllers.PopController(this._controller).link(this._smallPromoVO.click_through_URL);
   }
   function destroy()
   {
      if(this._videoPlaying)
      {
         this.stopVideo();
      }
   }
   function clear()
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::clear()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._save_game_popup.clear();
      this._survey_popup.clear();
      this.clearDots();
      Selection.setFocus(undefined);
      this.toggleKeyInactivity(false);
      clearInterval(this._updateCaruselIintervalID);
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._store_item_box);
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._return_btn_mc);
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._membership_tour_banner.btnCover);
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._membership_tour_banner.btnBuy);
      this.setUpCarouselActivity(false);
      this._model.removeObserver(this);
      this._welcome_back_mc.removeMovieClip();
   }
   function clearDots()
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfDots.length)
      {
         var _loc3_ = this._arrayOfDots[_loc2_];
         _loc3_.removeMovieClip();
         _loc2_ = _loc2_ + 1;
      }
      delete this._arrayOfDots;
   }
   function get currentCaruselIndex()
   {
      return this._currentCaruselIndex;
   }
   function set currentCaruselIndex(value)
   {
      this.setUpCarouselActivity(false);
      this._carusel_mc.gotoAndStop(1);
      this._currentCaruselIndex = value < this._arrayOfDots.length ? value : 0;
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfDots.length)
      {
         var _loc3_ = this._arrayOfDots[_loc2_];
         if(this._currentCaruselIndex == _loc2_)
         {
            _loc3_.gotoAndStop(2);
         }
         else
         {
            _loc3_.gotoAndStop(1);
         }
         _loc2_ = _loc2_ + 1;
      }
      if(this._arrayOfDots.length > 1 && this._updateTime)
      {
         clearInterval(this._updateCaruselIintervalID);
         this._updateCaruselIintervalID = setInterval(this,"onCaruselUpdateInterval",this._updateTime * 1000);
      }
      var _loc4_ = new com.poptropica.util.loaders.SwfLoader();
      var _loc5_ = this._arrayOfCaruselContentUrls[this._currentCaruselIndex];
      _loc4_.addEventListener(com.poptropica.events.LoaderEvent.LOAD_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onCarouselImageLoaded));
      _loc4_.load(_loc5_,MovieClip(this._carusel_mc.mcCaruselContainer));
   }
   function parseCaruselContentUrls(pBaseUrl, countOfVars, containsExtraVariable)
   {
      com.poptropica.util.Debug.trace("WelcomeBackView::parseCaruselContentUrls()  pBaseUrl=" + pBaseUrl,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc6_ = new Array();
      var _loc2_ = 1;
      while(_loc2_ <= countOfVars)
      {
         var _loc4_ = "var" + _loc2_ + "=";
         var _loc1_ = pBaseUrl.indexOf("&var" + String(Number(_loc2_ + 1)) + "=");
         if(_loc1_ == -1 && containsExtraVariable)
         {
            _loc1_ = _loc1_ != -1 ? _loc1_ : pBaseUrl.lastIndexOf("&");
         }
         else
         {
            _loc1_ = _loc1_ != -1 ? _loc1_ : pBaseUrl.length;
         }
         var _loc5_ = pBaseUrl.substring(pBaseUrl.indexOf(_loc4_) + _loc4_.length,_loc1_);
         _loc6_.push(_loc5_);
         _loc2_ = _loc2_ + 1;
      }
      return _loc6_;
   }
   function getCountOfSubStr(pStr, pFindStr)
   {
      return pStr.split(pFindStr).length - 1;
   }
   function trackEvent(pEvent, choice, subChoice, campaignName)
   {
      com.poptropica.controllers.PopController.getInstance().track(campaignName,pEvent,choice,subChoice);
   }
}
