class com.poptropica.controllers.PopController extends com.poptropica.mvc.AbstractController
{
   var _model;
   var _getPrefixCommand;
   var _getXMLCommand;
   static var instance;
   function PopController(cm)
   {
      super(cm);
      com.poptropica.util.Debug.trace("PopController::v2",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   static function getInstance(cm)
   {
      if(com.poptropica.controllers.PopController.instance == undefined)
      {
         com.poptropica.controllers.PopController.instance = new com.poptropica.controllers.PopController(cm);
      }
      return com.poptropica.controllers.PopController.instance;
   }
   function initProfileData()
   {
      var _loc3_ = new com.poptropica.models.proxy.profile.StatusProxy();
      _loc3_.loadData(this.onProfileStatusDataLoaded);
      var _loc4_ = new com.poptropica.models.proxy.profile.PrivacyProxy();
      _loc4_.loadData(this.onProfilePrivacyDataLoaded);
      var _loc2_ = new com.poptropica.models.proxy.badges.AlbumsProxy();
      _loc2_.loadData(this.onProfileAlbumsDataLoaded);
   }
   function onProfileAlbumSelected(albumId, setOffset, nSets)
   {
      var _loc2_ = new com.poptropica.models.proxy.badges.AlbumPageProxy();
      _loc2_.loadData(this.onProfileAlbumPageDataLoaded,albumId,setOffset,nSets);
   }
   function onProfileBadgeSetSelected(badgeSetId)
   {
      var _loc2_ = new com.poptropica.models.proxy.badges.BadgeSetProxy();
      _loc2_.loadData(this.onProfileBadgeSetDataLoaded,badgeSetId);
   }
   function onProfilePrivacySelected(privacyId)
   {
      var _loc2_ = new com.poptropica.models.proxy.profile.PrivacyProxy();
      _loc2_.sendData(this.onPrivacySet,privacyId);
   }
   function onProfileStatusSelected(messageId)
   {
      var _loc2_ = new com.poptropica.models.proxy.profile.StatusProxy();
      _loc2_.sendData(this.onStatusSet,messageId);
   }
   function onProfileAlbumPageDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).albumPageVO = new com.poptropica.models.vo.badges.AlbumPageVO(pData);
   }
   function onProfileBadgeSetDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).badgeSetVO = new com.poptropica.models.vo.badges.BadgeSetVO(pData);
   }
   function onStatusSet(pData)
   {
      trace("PopController :: onStatusSet() - server respons: " + pData);
   }
   function onPrivacySet(pData)
   {
      trace("PopController :: onPrivacySet() - server respons: " + pData);
   }
   function markClipsViewed(pArrayOfIds)
   {
      var _loc1_ = new com.poptropica.models.proxy.dailyPop.MarkCreatorClipsViewed();
      _loc1_.sendData(null,pArrayOfIds);
   }
   function initDailyPopGameDetailsPageData(pGameId)
   {
      var _loc2_ = new com.poptropica.models.proxy.dailyPop.GameDetailsProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopGameDetailsDataLoaded),pGameId);
   }
   function onDailyPopGameDetailsDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setDailyPopGameDetailsData(new com.poptropica.models.vo.dailyPopVO.GameDetailsVO(pData));
   }
   function initDailyPopGameIndexPageData(pPartnerId)
   {
      if(com.poptropica.models.PopModel(this._model).dailyPopGameIndexPageVO)
      {
         com.poptropica.models.PopModel(this._model).notifyObserversAboutGamesIndexPageDataSet();
      }
      else
      {
         var _loc2_ = new com.poptropica.models.proxy.dailyPop.GamesProxy();
         _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopGamesDataLoaded),pPartnerId);
      }
   }
   function initDailyPopChallengesQuizTypesData()
   {
      if(!com.poptropica.models.PopModel(this._model).getChallengesVO().quizeTypesCollection)
      {
         var _loc2_ = new com.poptropica.models.proxy.dailyPop.challenges.QuizeTypesProxy();
         _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopChallengeQuizeTypesLoaded));
      }
      else
      {
         com.poptropica.models.PopModel(this._model).notifyQuizesTypesLoaded();
      }
   }
   function initDailyPopChallengesOfTheDayData()
   {
      if(!com.poptropica.models.PopModel(this._model).getChallengesVO().challengeOfTheDay)
      {
         var _loc2_ = new com.poptropica.models.proxy.dailyPop.challenges.ChallengeOfTheDayProxy();
         _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopChallengeOfTheDayLoaded));
      }
      else
      {
         com.poptropica.models.PopModel(this._model).notifyChallengesOfTheDayLoaded();
      }
   }
   function onDailyPopChallengeQuizeTypesLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setQuizesTypes(pData);
   }
   function onDailyPopChallengeOfTheDayLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setChallengesOfTheDay(pData);
   }
   function initDailyPopChallengesGetQuizes(pQuantity, pOffset, pType, pChallengeQuizId)
   {
      var _loc1_ = new com.poptropica.controllers.commands.dailyPop.challenges.GetQuizesCommand();
      _loc1_.exec(pQuantity,pOffset,pType,pChallengeQuizId);
   }
   function sendQuizResult(pQuizId, pScore, pWinLoss, pTime, pPersonalHighScore)
   {
      var _loc1_ = new com.poptropica.models.proxy.dailyPop.challenges.SubmitQuizProxy();
      _loc1_.sendData(null,pQuizId,pScore,pWinLoss,pTime,pPersonalHighScore);
   }
   function initUserChallengesResult(pChallengeQuizId)
   {
      var _loc1_ = new com.poptropica.controllers.commands.dailyPop.challenges.GetUCRCommand();
      _loc1_.exec(pChallengeQuizId);
   }
   function sendUserChallengeResult(pChallangesId)
   {
      var _loc2_ = new com.poptropica.models.proxy.dailyPop.challenges.SetUserChallengeResultProxy();
      _loc2_.loadData(undefined,pChallangesId);
      com.poptropica.models.PopModel(this._model).setUserChallengesResult(pChallangesId);
   }
   function initUserItemsRatingData(pArrayOfIds)
   {
      var _loc2_ = new com.poptropica.models.proxy.rating.UserRatingProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onUserItemsRatingDataLoaded),pArrayOfIds);
   }
   function initAgrigateItemsRatingData(pArrayOfIds)
   {
      var _loc2_ = new com.poptropica.models.proxy.rating.ItemsRatingsProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onUserItemsRatingDataLoaded),pArrayOfIds);
   }
   function onUserItemsRatingDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setUserItemsRatingData(new com.poptropica.models.vo.rating.RatingVO(pData));
   }
   function userRateItem(pItemId, pRate)
   {
      var _loc2_ = new com.poptropica.models.proxy.rating.UserRateItemProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onUserRateItemDataLoaded),pItemId,pRate);
   }
   function onUserRateItemDataLoaded(pData)
   {
      com.poptropica.util.Debug.trace("PopController::onUserRateItemDataLoaded() -> answer = " + unescape(pData),com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function onDailyPopGamesDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setDailyPopGameIndexPageData(com.poptropica.util.DailyPopUtils.parseDailyPopGamesData(pData));
   }
   function initDailyPopComicHomePageData()
   {
      if(com.poptropica.models.PopModel(this._model).dailyPopComicHomePageVO)
      {
         com.poptropica.models.PopModel(this._model).notifyObserversAboutComicHomePageDataSet();
      }
      else
      {
         var _loc2_ = new com.poptropica.models.proxy.dailyPop.ComicsProxy();
         _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopComicsDataLoaded));
      }
   }
   function initComicViewerVoData(pId, pUserName, pDbId, pComicTitle)
   {
      var _loc2_ = new com.poptropica.models.proxy.ComicStripsProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onComicViewerVoDataLoaded,pComicTitle,pId),pId,pUserName,pDbId);
   }
   function initDailyPopSneakPeeksData(offset)
   {
      if(com.poptropica.models.PopModel(this._model).listSneakPeeksVO && com.poptropica.models.PopModel(this._model).offsetSneakPeeks == offset)
      {
         com.poptropica.models.PopModel(this._model).notifyObserversAboutSneakPeekDataSet();
      }
      else
      {
         com.poptropica.models.PopModel(this._model).offsetSneakPeeks = offset;
         var _loc2_ = new com.poptropica.models.proxy.dailyPop.SneakPeeksProxy();
         _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopSneakPeeksDataLoaded));
      }
   }
   function onDailyPopSneakPeeksDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setDailyPopSneakPeeksData(com.poptropica.util.DailyPopUtils.parseSneakPeeksData(pData));
   }
   function initDailyPopSneakPeeksPreviousData(offset)
   {
      com.poptropica.models.PopModel(this._model).offsetSneakPeeks = offset;
      var _loc2_ = new com.poptropica.models.proxy.dailyPop.SneakPeeksProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopSneakPeeksPreviousDataLoaded));
   }
   function onDailyPopSneakPeeksPreviousDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setDailyPopSneakPeeksPreviousData(com.poptropica.util.DailyPopUtils.parseSneakPeeksData(pData));
   }
   function initDailyPopSneakPeeksPreviewData(offset)
   {
      com.poptropica.models.PopModel.getInstance().offsetSneakPeeks = offset;
      var _loc2_ = new com.poptropica.models.proxy.dailyPop.SneakPeeksProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopSneakPeeksPreviewDataLoaded));
   }
   function onDailyPopSneakPeeksPreviewDataLoaded(pData)
   {
      com.poptropica.models.PopModel.getInstance().setDailyPopSneakPeeksPreviewData(com.poptropica.util.DailyPopUtils.parseSneakPeeksData(pData));
   }
   function copyDailyPopSneakPeeksPreview()
   {
      com.poptropica.models.PopModel(this._model).copyDailyPopSneakPeeksPreview();
   }
   function initDailyPopCreatorClipsData()
   {
      if(com.poptropica.models.PopModel(this._model).listCreatorClipsVO)
      {
         com.poptropica.models.PopModel(this._model).notifyObserversAboutCreatorClipsDataSet();
      }
      else
      {
         var _loc2_ = new com.poptropica.models.proxy.dailyPop.GetCreatorClipsProxy();
         _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDailyPopCreatorClipsDataLoaded));
      }
   }
   function onDailyPopCreatorClipsDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setDailyPopCreatorClipsData(com.poptropica.util.DailyPopUtils.parseSneakPeeksData(pData));
   }
   function onDailyPopComicsDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).setDailyPopComicData(com.poptropica.util.DailyPopUtils.parseDailyPopComicData(pData));
   }
   function onProfileStatusDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).statusVO = new com.poptropica.models.vo.profile.StatusVO(pData);
   }
   function onProfilePrivacyDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).privacyVO = new com.poptropica.models.vo.profile.PrivacyVO(pData);
   }
   function onProfileAlbumsDataLoaded(pData)
   {
      com.poptropica.models.PopModel(this._model).albumsVO = new com.poptropica.models.vo.badges.AlbumsVO(pData);
   }
   function onComicViewerVoDataLoaded(pData, pComicTitle, pId)
   {
      com.poptropica.models.PopModel(this._model).setComicViewerVO(com.poptropica.util.ComicViewerUtil.parseComicViewerVoData(pData,pComicTitle,pId));
   }
   function setState(str)
   {
      com.poptropica.util.Debug.trace("PopController::setState() str=" + str,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).state = str;
   }
   function sendUpdateNotification(pNotType, pNotObject)
   {
      com.poptropica.util.Debug.trace("PopController::sendNotification() pNotType=" + pNotType,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(pNotType,pNotObject);
   }
   function setRootVar(varName, obj)
   {
      com.poptropica.util.Debug.trace("PopController::setRootVar()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).rt_mc[varName] = obj;
   }
   function toplevelPopUp(pPath)
   {
      com.poptropica.util.Debug.trace("PopController::toplevelPopUp() pPath=" + pPath,com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function loadingSequenceComplete(pSequenceCompleted)
   {
      com.poptropica.util.Debug.trace("PopController::loadingSequenceComplete() pSequenceCompleted=" + pSequenceCompleted,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      switch(pSequenceCompleted)
      {
         case "startup":
            var me = this;
            var _loc3_ = function()
            {
               com.poptropica.util.Debug.trace("PopController::afterPrefixLoaded() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
               me.loadingSequenceComplete("getPrefix");
            };
            this._getPrefixCommand = new com.poptropica.controllers.commands.GetPrefixCommand();
            this._getPrefixCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,_loc3_));
            this._getPrefixCommand.exec();
            break;
         case "getPrefix":
            var me = this;
            var _loc6_ = function()
            {
               com.poptropica.util.Debug.trace("PopController::afterXMLLoaded() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
               me.loadingSequenceComplete("getConfigXML");
            };
            this._getXMLCommand = new com.poptropica.controllers.commands.GetConfigXMLCommand();
            this._getXMLCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,_loc6_));
            this._getXMLCommand.exec();
            break;
         case "getConfigXML":
            this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.RETRIEVE_GAMEPLAY,com.poptropica.models.PopModel(this._model).gameplay_url);
            break;
         case "gameplay":
            this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.LOAD_SEQUENCE_COMPLETE);
            var _loc2_ = new com.poptropica.controllers.commands.ExtractVariablesFromGameplayCommand();
            _loc2_.exec();
            var _loc5_ = new com.poptropica.controllers.commands.RetrofittingWorkaroundsCommand(com.poptropica.models.PopModel(this._model).rt_mc);
            _loc5_.exec();
            this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.BUILD,com.poptropica.models.PopModel(this._model).state);
            if(com.poptropica.models.PopModel(this._model).state == com.poptropica.models.PopAppStates.INIT)
            {
               this.setPath("gameplay");
            }
            else if(com.poptropica.models.PopModel(this._model).state == com.poptropica.models.PopAppStates.RETURN_USER_STANDARD)
            {
               this.setPath(com.poptropica.models.PopModel(this._model).startup_path);
            }
            var _loc4_ = com.poptropica.models.PopModelConst.gameplayMC._gameplayView.getWrapperSection();
            if(_loc4_ != "home")
            {
               com.poptropica.controllers.AdController.getInstance().loadWrapper();
            }
      }
   }
   function successfulRegistration(infoObj, senderHash)
   {
      com.poptropica.util.Debug.trace("PopController::successfulRegistration() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).poptropica_user.login = infoObj.login;
      com.poptropica.models.PopModel(this._model).poptropica_user.password_hash = senderHash;
      com.poptropica.models.PopModel(this._model).db_id = infoObj.dbid;
      this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.REGISTRATION,null);
   }
   function returnToGameAndSave()
   {
      com.poptropica.util.Debug.trace("PopController::returnToGameAndSave()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).setPathSection("gameplay");
      this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.INIT_SAVE_SEQUENCE,null);
   }
   function returnToGame()
   {
      com.poptropica.util.Debug.trace("PopController::returnToGame()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).setPathSection("gameplay");
   }
   function submitPromoCode(promoCode)
   {
      com.poptropica.util.Debug.trace("PopController::submitPromoCode() promoCode=" + promoCode,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.models.proxy.PromoCodeProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onPromoCodeLoaded),promoCode);
   }
   function onPromoCodeLoaded(pData)
   {
      com.poptropica.util.Debug.trace("PopController::onPromoCodeLoaded() pData=" + pData,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = com.poptropica.util.HomeUtils.parsePromoCodeSubmitData(pData);
      if(_loc2_.activated)
      {
         this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.PROMO_CODE_ACTIVATED,_loc2_);
         if(_loc2_.items != null && _loc2_.items.length > 0)
         {
            com.poptropica.models.PopModel(this._model).awardItems(_loc2_.items,_loc2_.itemCategories);
         }
         if(_loc2_.credits != null && _loc2_.credits != undefined && _loc2_.credits != 0 && Number(_loc2_.credits) != NaN)
         {
            com.poptropica.models.PopModel(this._model).awardCredits(Number(_loc2_.credits));
         }
      }
      else
      {
         this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.PROMO_CODE_ACTIVATION_ERROR,_loc2_);
      }
   }
   function showModalTextWindow(pTxt, pShowCloseBtn)
   {
      com.poptropica.util.Debug.trace("PopController::showModalTextWindow() pTxt=" + pTxt,com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function showFrameworkPopup(pPath, pParameters, showShadow)
   {
      com.poptropica.util.Debug.trace("PopController::showFrameworkPopup()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(showShadow == undefined)
      {
         showShadow = true;
      }
      var _loc2_ = {path:pPath,popupParameters:pParameters,showShadow:showShadow};
      this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.SHOW_FRAMEWORK_POPUP,_loc2_);
   }
   function removeFrameworkPopup()
   {
      com.poptropica.util.Debug.trace("PopController::removeFrameworkPopup()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this.sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.REMOVE_FRAMEWORK_POPUP,null);
   }
   function link(pStr)
   {
      var _loc12_ = Boolean(pStr.indexOf("pop://") == -1);
      com.poptropica.util.Debug.trace("PopController::link()  pStr=" + pStr + " isExternalLink! : " + _loc12_,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(_loc12_)
      {
         if(pStr.indexOf("[LOGIN]") > 0)
         {
            var _loc15_ = pStr.split("[LOGIN]")[0];
            var _loc8_ = com.poptropica.models.PopModel(this._model).gameplayMC.createEmptyMovieClip("send_mc",com.poptropica.models.PopModel(this._model).gameplayMC.getNextHighestDepth());
            _loc8_.login = com.poptropica.models.PopModelConst.avatar.loadLogin();
            _loc8_.logged_in = !com.poptropica.models.PopModelConst.avatar.isRegistred() ? 0 : 1;
            _loc8_.getURL(_loc15_,"_blank","POST");
         }
         else
         {
            if(pStr.indexOf("[RANDOM]") > 0)
            {
               pStr = utils.Utils.stringReplace(pStr,"[RANDOM]",String(random(10000)));
            }
            getURL(pStr,"_blank");
         }
      }
      else
      {
         var _loc7_ = pStr.substr(6);
         var _loc2_ = _loc7_.split("/");
         trace("AS3Embassy ::internal link()  internalPath : " + _loc7_);
         switch(_loc2_[0])
         {
            case "gameplay":
               if(_loc2_.length == 1)
               {
                  trace("AS3Embassy ::internal link()  internalPath 1 ");
                  com.poptropica.models.PopModel(this._model).path = _loc7_;
               }
               else
               {
                  trace("AS3Embassy ::internal link()  internalPath 2 ");
                  var _loc3_ = _loc2_[1];
                  var _loc4_ = undefined;
                  var _loc5_ = undefined;
                  if(_loc2_[2] == "START")
                  {
                     _loc4_ = String(com.poptropica.models.PopModel(this._model).getIslandProperty(_loc3_,"island_main"));
                     _loc5_ = Object(com.poptropica.models.PopModel(this._model).getIslandProperty(_loc3_,"init_coords"));
                  }
                  else
                  {
                     _loc4_ = _loc2_[2];
                     var _loc9_ = _loc2_[3];
                     if(_loc9_ == undefined || _loc9_ == "")
                     {
                        _loc9_ = String(com.poptropica.models.PopModel(this._model).getIslandProperty(_loc3_,"init_coords"));
                     }
                     else
                     {
                        var _loc14_ = _loc9_.split(",");
                        _loc5_ = new Object();
                        _loc5_.x = _loc14_[0];
                        _loc5_.y = _loc14_[1];
                     }
                  }
                  if(_loc4_ != undefined)
                  {
                     if(_loc4_.indexOf(".") == -1)
                     {
                        if(_loc3_ != undefined)
                        {
                           _loc3_ = _loc3_.substr(0,1).toUpperCase() + _loc3_.substr(1);
                           trace("AS3Embassy ::link()  loading as2 scene islandName=" + _loc3_ + "  sceneName=" + _loc4_ + " : _model : " + this._model + " char : " + com.poptropica.models.PopModel(this._model).gameplayMC.camera.scene.char + " loadScene : " + com.poptropica.models.PopModel(this._model).gameplayMC.camera.scene.char.loadScene + " mc : " + com.poptropica.models.PopModel(this._model).gameplayMC);
                           com.poptropica.models.PopModel(this._model).gameplayMC.camera.scene.char.loadScene(_loc4_,_loc5_.x,_loc5_.y,_loc3_);
                        }
                        else
                        {
                           trace("AS3Embassy ::link()  ERROR: Not enough data to link to as2 scene - islandName=" + _loc3_ + "  sceneName=" + _loc4_);
                        }
                     }
                     else
                     {
                        trace("AS3Embassy ::link()  loading as3 scene : " + _loc4_ + " method : " + com.poptropica.models.PopModel(this._model).gameplayMC.loadSceneAS3);
                        com.poptropica.models.PopModel(this._model).gameplayMC.loadSceneAS3(_loc4_,_loc5_.x,_loc5_.y,"right");
                     }
                  }
                  else
                  {
                     trace("AS3Embassy ::link()  ERROR: Not enough data to link to scene - islandName=" + _loc3_ + "  sceneName=" + _loc4_);
                     com.poptropica.util.Debug.trace("PopController::link()  ERROR: Not enough data to link to scene - islandName=" + _loc3_ + "  sceneName=" + _loc4_,com.poptropica.util.Debug.WARNING);
                  }
               }
               break;
            case "stats":
               com.poptropica.models.PopModel(this._model).path = _loc7_;
               break;
            case "popup":
               if(_loc2_[1] == "travelmap" && _loc2_[2] != undefined && _loc2_[2].indexOf(",") != -1)
               {
                  trace("map coords being processed from: " + _loc2_[2]);
                  var _loc13_ = _loc2_[2].split(",");
                  var _loc11_ = Number(_loc13_[0]);
                  var _loc10_ = Number(_loc13_[1]);
                  if(!isNaN(_loc11_) && !isNaN(_loc10_))
                  {
                     trace("map coords valid: " + _loc11_ + "," + _loc10_);
                     com.poptropica.models.PopModel(this._model).gameplayMC.mapCoords = [_loc11_,_loc10_];
                  }
                  com.poptropica.models.PopModel(this._model).gameplayMC.popup("travelmap.swf",false);
               }
               else
               {
                  com.poptropica.models.PopModel(this._model).gameplayMC.popup(_loc2_[1] + ".swf",_loc2_[2]);
               }
               break;
            case "membershipTour":
               _loc8_ = com.poptropica.models.PopModel(this._model).gameplayMC.createEmptyMovieClip("send_mc",com.poptropica.models.PopModel(this._model).gameplayMC.getNextHighestDepth());
               _loc8_.login = com.poptropica.models.PopModelConst.avatar.loadLogin();
               _loc8_.logged_in = !com.poptropica.models.PopModelConst.avatar.isRegistred() ? 0 : 1;
               trace("PopController::link() : prefix : " + com.poptropica.models.PopModelConst.prefix + " sender.login : " + _loc8_.login);
               _loc8_.getURL(com.poptropica.models.PopModelConst.prefix + "/about/membership-tour.html","_blank","POST");
               break;
            default:
               com.poptropica.models.PopModel(this._model).path = _loc7_;
         }
      }
   }
   function loadTrackingPixel(pStr)
   {
      if(pStr.indexOf("[RANDOM]") > 0)
      {
         pStr = utils.Utils.stringReplace(pStr,"[RANDOM]",String(random(10000)));
      }
      getURL("javascript: loadTrackingPixel(\'" + pStr + "\')","");
   }
   function track(CampaignName, EventToTrack, ChoiceName, SubChoiceName, trackScene, cluster, sceneName)
   {
      if(CampaignName != null && CampaignName != undefined && CampaignName != "")
      {
         trace("AdManager.trackCampaign: campaign: " + CampaignName + ", event: " + EventToTrack + ", choice: " + ChoiceName + ", subchoice: " + SubChoiceName);
      }
      com.poptropica.util.Debug.trace("PopController::track() Cluster=" + cluster + " CampaignName=" + CampaignName + "  EventToTrack=" + EventToTrack + "  ChoiceName=" + ChoiceName + "  SubChoiceName=" + SubChoiceName + "   trackScene=" + trackScene + " SceneName:" + sceneName,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc5_ = new com.poptropica.controllers.commands.TrackCommand();
      _loc5_.exec(CampaignName,EventToTrack,ChoiceName,SubChoiceName,trackScene,cluster,sceneName);
   }
   function sendTrackingPixel(aTrackingPixel, aLocation)
   {
      if(aTrackingPixel != undefined && aTrackingPixel != "")
      {
         com.poptropica.util.Debug.trace("PopController::sendTrackingPixel() at " + aLocation + ": TrackingPixel=" + aTrackingPixel,com.poptropica.util.Debug.VERBOSE_MESSAGE);
         if(aTrackingPixel.indexOf("[RANDOM]") > 0)
         {
            aTrackingPixel = utils.Utils.stringReplace(aTrackingPixel,"[RANDOM]",String(random(10000)));
         }
         getURL("javascript: loadTrackingPixel(\'" + aTrackingPixel + "\')","");
      }
   }
   function setPointerDisplay(str)
   {
      com.poptropica.views.PointerView.getInstance().changePointerDisplay(str);
   }
   function checkForRetrofittingWorkaroundOnSectionChange(pOldSectionName, pNewSectionName)
   {
      if(pOldSectionName != pNewSectionName)
      {
         if(com.poptropica.models.PopModel(this._model).isSectionRetrofitted(pOldSectionName))
         {
            var _loc4_ = new com.poptropica.controllers.commands.PullVarsFromFrameworkCommand();
            _loc4_.exec(pOldSectionName,pNewSectionName);
         }
         if(com.poptropica.models.PopModel(this._model).isSectionRetrofitted(pNewSectionName))
         {
            var _loc5_ = new com.poptropica.controllers.commands.PassVarsToFrameworkCommand();
            _loc5_.exec(pOldSectionName,pNewSectionName);
         }
      }
   }
   function setPath(str)
   {
      com.poptropica.util.Debug.trace("PopController::setPath() path=" + str,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc3_ = str.split("/")[0];
      this.checkForRetrofittingWorkaroundOnSectionChange(com.poptropica.models.PopModel(this._model).pathArray[0],_loc3_);
      if(_loc3_ == "stats")
      {
         _root.loadStore = true;
      }
      com.poptropica.models.PopModel(this._model).path = str;
   }
   function setSection(section)
   {
      com.poptropica.util.Debug.trace("PopController::setSection() section=" + section,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this.checkForRetrofittingWorkaroundOnSectionChange(com.poptropica.models.PopModel(this._model).pathArray[0],section);
      com.poptropica.models.PopModel(this._model).setPathSection(section);
   }
   function setSubSection(subsection)
   {
      com.poptropica.util.Debug.trace("PopController::setSubSection() subsection=" + subsection,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).setPathSubSection(subsection);
   }
   function setSectionStatus(status)
   {
      com.poptropica.util.Debug.trace("PopController::setSectionStatus() status=" + status,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).setSectionStatus(status);
   }
}
