class com.poptropica.models.PopModel extends com.poptropica.util.Observable
{
   var _latest_gameplay_bm;
   var _dailyPopGameIndexPageVO;
   var _sectionDimensionString;
   var _dailyPopChallengesPageVO;
   var _dailyPopComicHomePageVO;
   var _listCreatorClipsVO;
   var _listSneakPeeksVO;
   var _listSneakPeeksPreviewVO;
   var _comicViewerVO;
   var _desc;
   var _islandData;
   var _startup_path;
   var _rt_mc;
   var _gameplay_url;
   var _pathStr;
   var _offsetSneakPeeks;
   var _statusVO;
   var _privacyVO;
   var _albumsVO;
   var _albumPageVO;
   var _badgeSetVO;
   static var instance;
   var _sStatus = com.poptropica.sections.SectionStatus.SECTION_UNLOAD;
   var _pathArray = new Array();
   var _isTestMode = true;
   var _isBuilt = false;
   var _retrofittedSectionNames = ["stats","friends"];
   static var _SNEAK_PEEKS_QUANTITY = 10;
   function PopModel()
   {
      super();
      com.poptropica.util.Debug.trace("PopModel::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._latest_gameplay_bm = new flash.display.BitmapData(370,210,false,16777215);
      com.poptropica.models.PopModelConst.state = com.poptropica.models.PopAppStates.INIT;
   }
   static function getInstance()
   {
      if(com.poptropica.models.PopModel.instance == undefined)
      {
         com.poptropica.models.PopModel.instance = new com.poptropica.models.PopModel();
      }
      return com.poptropica.models.PopModel.instance;
   }
   function setDailyPopGameDetailsData(pGameDetails)
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_GAMES_DETAILS_ASSETS_LOADED,pGameDetails);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function sendUpdateNotification(pNotType, pNotObject)
   {
      com.poptropica.util.Debug.trace("PopModel::sendNotification() pNotType=" + pNotType,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(pNotType,pNotObject);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setDailyPopGameIndexPageData(pArray)
   {
      com.poptropica.util.Debug.trace("PopModel::setDailyPopGameIndexPageData() pArray.length=" + pArray.length,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._dailyPopGameIndexPageVO = new com.poptropica.models.vo.dailyPopVO.GameIndexPageVO();
      this._dailyPopGameIndexPageVO.arrayOfGamesVO = pArray;
      this.notifyObserversAboutGamesIndexPageDataSet();
   }
   function set sectionDimensionString(s)
   {
      trace(")))))))[PopModel] sectionDimensionString: " + s);
      this._sectionDimensionString = s;
   }
   function get sectionDimensionString()
   {
      return this._sectionDimensionString;
   }
   function notifyObserversAboutGamesIndexPageDataSet()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_GAMES_INDEX_PAGE_ASSETS_LOADED,this._dailyPopGameIndexPageVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function getChallengesVO()
   {
      return this._dailyPopChallengesPageVO = !this._dailyPopChallengesPageVO ? new com.poptropica.models.vo.dailyPopVO.ChallengesVO() : this._dailyPopChallengesPageVO;
   }
   function setQuizesTypes(pData)
   {
      this.getChallengesVO().setQuizeTypesCollectionData(pData);
      this.notifyQuizesTypesLoaded();
   }
   function notifyQuizesTypesLoaded()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_CHALLENGES_QUIZE_TYPES_LOADED,this.getChallengesVO().quizeTypesCollection);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setChallengesOfTheDay(pData)
   {
      this.getChallengesVO().setChallengeOfTheDayData(pData);
      this.notifyChallengesOfTheDayLoaded();
   }
   function notifyChallengesOfTheDayLoaded()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_CHALLENGES_OF_THE_DAY_LOADED,this.getChallengesVO().challengeOfTheDay);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function notifyQuizesWithResultsLoaded()
   {
      com.poptropica.util.Debug.trace("PopModel::notifyQuizesWithResultsLoaded ()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_CHALLENGES_QUIZES_WITH_RESULTS_LOADED,null);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function notifyUserChallengesResultsLoaded()
   {
      com.poptropica.util.Debug.trace("PopModel::notifyUserChallengesResultsLoaded ()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_USER_CHALLENGES_RESULTS_LOADED,null);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setUserChallengesResult(pChallangesId)
   {
      this.getChallengesVO().challengeOfTheDayResult.setUserChallengeResultByChallengeId(pChallangesId);
   }
   function setUserItemsRatingData(pRatingVO)
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.USER_ITEMS_RATING_SET,pRatingVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setDailyPopComicData(pArray)
   {
      com.poptropica.util.Debug.trace("PopModel::setDailyPopComicData() pArray.length=" + pArray.length,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._dailyPopComicHomePageVO = new com.poptropica.models.vo.dailyPopVO.ComicHomePageVO();
      this._dailyPopComicHomePageVO.arrayOfComicsVO = pArray;
      this.notifyObserversAboutComicHomePageDataSet();
   }
   function notifyObserversAboutComicHomePageDataSet()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_COMIC_HOME_PAGE_ASSETS_LOADED,this._dailyPopComicHomePageVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function notifyObserversAboutCreatorClipsDataSet()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_CREATOR_CLIPS_ASSETS_LOADED,this._listCreatorClipsVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setDailyPopCreatorClipsData(list)
   {
      this._listCreatorClipsVO = list;
      this.notifyObserversAboutCreatorClipsDataSet();
   }
   function notifyObserversAboutSneakPeekDataSet()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_SNEAK_PEEKS_ASSETS_LOADED,this._listSneakPeeksVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function notifyObserversAboutSneakPeekPreviewDataSet()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_SNEAK_PEEKS_PREVIEW_ASSETS_LOADED,this._listSneakPeeksPreviewVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function notifyObserversAboutSneakPeekPreviousDataSet()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.DAILY_POP_SNEAK_PEEKS_PREVIOUS_ASSETS_LOADED,this._listSneakPeeksVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setDailyPopSneakPeeksData(list)
   {
      this._listSneakPeeksVO = list;
      this.notifyObserversAboutSneakPeekDataSet();
   }
   function setDailyPopSneakPeeksPreviewData(list)
   {
      this._listSneakPeeksPreviewVO = list;
      this.notifyObserversAboutSneakPeekPreviewDataSet();
   }
   function setDailyPopSneakPeeksPreviousData(list)
   {
      this._listSneakPeeksVO = list;
      this.notifyObserversAboutSneakPeekPreviousDataSet();
   }
   function copyDailyPopSneakPeeksPreview()
   {
      this.setDailyPopSneakPeeksData(this._listSneakPeeksPreviewVO);
   }
   function dailyPopSneakPeeksPreviewIsEmpty()
   {
      if(this._listSneakPeeksPreviewVO != undefined && this._listSneakPeeksPreviewVO != null && this._listSneakPeeksPreviewVO.length > 0)
      {
         return false;
      }
      return true;
   }
   function setComicViewerVO(value)
   {
      this._comicViewerVO = value;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.COMIC_VIEWER_DATA_SET,this._comicViewerVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get comicViewerVO()
   {
      return this._comicViewerVO;
   }
   function awardCredits(pCredits)
   {
      com.poptropica.util.Debug.trace("PopModel::awardCredits() pCredits=" + pCredits,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.LSOManager.getInstance().incrementCredits(pCredits);
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.CREDITS_CHANGE,pCredits);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function awardItems(pItems, pItemCategories)
   {
      com.poptropica.util.Debug.trace("PopModel::awardItems() pItems=" + pItems.toString(),com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < pItems.length)
      {
         _loc4_ = pItems[_loc2_];
         _loc3_ = pItemCategories[_loc2_];
         if(utils.Utils.isNull(_loc3_))
         {
            _loc3_ == undefined;
         }
         if(!com.poptropica.models.PopModelConst.avatar.checkItem(_loc4_,_loc3_))
         {
            com.poptropica.models.PopModelConst.avatar.getItem(_loc4_,_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc7_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.AWARD_ITEMS,pItems);
      this.setChanged();
      this.notifyObservers(_loc7_);
   }
   function cleanOutCampaignData()
   {
      com.poptropica.util.Debug.trace("PopModel::cleanOutCampaignData() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc4_ = SharedObject.getLocal("campaignData","/");
      var _loc3_ = [];
      if(_loc4_.data.islands != undefined)
      {
         delete _loc4_.data.islands;
      }
      if(_loc4_.data.campaigns != undefined)
      {
         var _loc9_ = new Date();
         var _loc8_ = Date.UTC(_loc9_.getFullYear(),_loc9_.getMonth(),_loc9_.getDate(),_loc9_.getHours(),_loc9_.getMinutes(),_loc9_.getSeconds());
         var _loc7_ = 5356800000;
         var _loc2_ = _loc4_.data.campaigns.length - 1;
         while(_loc2_ != -1)
         {
            var _loc1_ = _loc4_.data.campaigns[_loc2_];
            var _loc5_ = false;
            if(_loc1_.type == "caps")
            {
               for(var _loc6_ in _loc3_)
               {
                  if(_loc1_.campaign.campaign_name == _loc3_[_loc6_])
                  {
                     _loc5_ = true;
                     break;
                  }
               }
            }
            if(_loc1_.campaign.frequency_cap_count == null || _loc1_.campaign.frequency_cap_count == 0 || _loc8_ - _loc1_.campaign.frequency_cap_first_visit > _loc7_)
            {
               _loc4_.data.campaigns.splice(_loc2_,1);
            }
            else if(_loc5_)
            {
               trace("getCampaignInfo :: Deleting extra cap in LSO: " + _loc1_.campaign.campaign_name);
               _loc4_.data.campaigns.splice(_loc2_,1);
            }
            else
            {
               trace("getCampaignInfo :: Keep campaign in LSO: " + _loc1_.campaign.campaign_name);
            }
            if(_loc1_.type == "caps")
            {
               _loc3_.push(_loc1_.campaign.campaign_name);
            }
            _loc2_ = _loc2_ - 1;
         }
      }
      var _loc10_ = null;
      _loc10_ = _loc4_.flush();
   }
   function saveCampaignInfo(recInfo, pType, pIsland, pOffMain)
   {
      com.poptropica.util.Debug.trace("PopModel::saveCampaignInfo() pType=" + pType + "   pIsland=" + pIsland + "  pOffMain=" + pOffMain,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      pIsland = pIsland.substr(0,1).toUpperCase() + pIsland.substr(1);
      if(recInfo.frequency_cap_first_visit == null || recInfo.frequency_cap_first_visit == undefined)
      {
         recInfo.frequency_cap_first_visit = 0;
      }
      if(recInfo.frequency_cap_num_visits == null || recInfo.frequency_cap_num_visits == undefined)
      {
         recInfo.frequency_cap_num_visits = 0;
      }
      var _loc13_ = SharedObject.getLocal("campaignData","/");
      if(_loc13_.data.campaigns == null || _loc13_.data.campaigns == undefined)
      {
         _loc13_.data.campaigns = new Array();
      }
      var _loc3_ = _loc13_.data.campaigns;
      var _loc12_ = _loc3_.length;
      var _loc4_ = undefined;
      var _loc6_ = undefined;
      var _loc10_ = false;
      var _loc7_ = pType == com.poptropica.models.AdCampaignType.WRAPPER || pType.substr(0,7) == "Browser";
      var _loc2_ = 0;
      while(_loc2_ < _loc12_)
      {
         if(_loc3_[_loc2_].type == pType && _loc3_[_loc2_].island == pIsland)
         {
            com.poptropica.util.Debug.trace("PopModel::saveCampaignInfo :: saving1 : " + arguments,com.poptropica.util.Debug.VERBOSE_MESSAGE);
            if(!_loc7_ || _loc7_ && _loc3_[_loc2_].offMain == pOffMain)
            {
               _loc6_ = _loc3_[_loc2_];
               _loc4_ = _loc6_.campaign;
               _loc10_ = true;
               break;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      if(!_loc10_)
      {
         _loc6_ = {};
         _loc4_ = {};
         _loc6_.campaign = _loc4_;
         _loc6_.type = pType;
         _loc6_.island = pIsland;
         _loc6_.offMain = pOffMain;
         _loc13_.data.campaigns.push(_loc6_);
      }
      trace("GetAdCommand:: saving ad to LSO: " + pType + ", " + recInfo.campaign_name + ", offmain=" + pOffMain + ", new=" + !_loc10_);
      _loc4_.campaign_name = recInfo.campaign_name;
      _loc4_.click_through_URL = recInfo.click_through_URL;
      _loc4_.impression_URL = recInfo.impression_URL;
      _loc4_.campaign_file1 = recInfo.campaign_file1;
      _loc4_.campaign_file2 = recInfo.campaign_file2;
      _loc4_.frequency_cap_count = recInfo.frequency_cap_count;
      _loc4_.frequency_cap_period = recInfo.frequency_cap_period;
      _loc4_.campaign_repeat_spacing = Number(recInfo.campaign_repeat_spacing);
      if(recInfo.frequency_cap_first_visit != 0)
      {
         _loc4_.frequency_cap_num_visits = recInfo.frequency_cap_num_visits;
         _loc4_.frequency_cap_first_visit = recInfo.frequency_cap_first_visit;
      }
      if(recInfo.frequency_cap_count == null)
      {
         delete _loc4_.frequency_cap_num_visits;
         delete _loc4_.frequency_cap_first_visit;
      }
      var _loc14_ = null;
      _loc14_ = _loc13_.flush();
      if(_loc14_ == false)
      {
         com.poptropica.util.Debug.trace("Error flushing the campaign SO",com.poptropica.util.Debug.WARNING);
      }
      else
      {
         com.poptropica.util.Debug.trace("Campaign Committed to Shared Object",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      }
   }
   function getCampaignInfo(type, pIsland, offMain)
   {
      com.poptropica.util.Debug.trace("PopModel::getCampaignInfo() type=" + type + "  pIsland=" + pIsland + "  offMain=" + offMain,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc19_ = SharedObject.getLocal("campaignData","/");
      var _loc5_ = _loc19_.data.campaigns;
      var _loc11_ = _loc5_.length;
      var _loc20_ = new Date();
      var _loc10_ = Date.UTC(_loc20_.getFullYear(),_loc20_.getMonth(),_loc20_.getDate(),_loc20_.getHours(),_loc20_.getMinutes(),_loc20_.getSeconds());
      var _loc17_ = type == com.poptropica.models.AdCampaignType.WRAPPER;
      com.poptropica.util.Debug.trace("PopModel::getCampaignInfo() is wrapper: " + _loc17_,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = _loc11_ - 1;
      while(_loc2_ > -1)
      {
         var _loc16_ = _loc17_ && _loc5_[_loc2_].offMain == offMain;
         if(_loc5_[_loc2_].type == type && _loc5_[_loc2_].island == pIsland && (!_loc17_ || _loc16_))
         {
            trace("getCampaignInfo :: checking : " + _loc5_[_loc2_].type + " , " + _loc5_[_loc2_].island + " , " + _loc5_[_loc2_].offMain);
            var _loc8_ = false;
            var _loc9_ = true;
            if(_loc5_[_loc2_].campaign.frequency_cap_count != 0)
            {
               trace("getCampaignInfo :: frequency cap exists, checking for up-to-date info");
               var _loc7_ = _loc5_[_loc2_].campaign.frequency_cap_num_visits;
               var _loc6_ = _loc5_[_loc2_].campaign.frequency_cap_first_visit;
               var _loc4_ = _loc19_.data.campaigns;
               _loc11_ = _loc4_.length;
               var _loc3_ = 0;
               while(_loc3_ < _loc11_)
               {
                  if(_loc4_[_loc3_].campaign.campaign_name == _loc4_[_loc2_].campaign.campaign_name)
                  {
                     if(_loc4_[_loc3_].campaign.frequency_cap_first_visit != 0)
                     {
                        if(_loc6_ == null || _loc4_[_loc3_].campaign.frequency_cap_first_visit > _loc6_)
                        {
                           _loc7_ = _loc4_[_loc3_].campaign.frequency_cap_num_visits;
                           _loc6_ = _loc4_[_loc3_].campaign.frequency_cap_first_visit;
                           _loc8_ = true;
                        }
                        else if(_loc4_[_loc3_].campaign.frequency_cap_first_visit == _loc6_)
                        {
                           if(_loc4_[_loc3_].campaign.frequency_cap_num_visits > _loc7_)
                           {
                              _loc7_ = _loc4_[_loc3_].campaign.frequency_cap_num_visits;
                              _loc8_ = true;
                           }
                        }
                     }
                  }
                  _loc3_ = _loc3_ + 1;
               }
               if(_loc6_ == null)
               {
                  _loc6_ = _loc10_;
                  _loc7_ = 0;
                  _loc8_ = true;
               }
               else if(_loc10_ - _loc6_ > _loc5_[_loc2_].campaign.frequency_cap_period * 1000)
               {
                  var _loc18_ = _loc10_ - _loc6_;
                  _loc6_ = _loc10_;
                  _loc7_ = 0;
                  _loc8_ = true;
               }
               if(_loc7_ < _loc5_[_loc2_].campaign.frequency_cap_count)
               {
                  _loc7_ = _loc7_ + 1;
                  trace("getCampaignInfo :: frequency cap is now " + _loc7_);
                  _loc8_ = true;
               }
               else
               {
                  _loc9_ = false;
               }
            }
            com.poptropica.util.Debug.trace("getCampaignInfo() type=" + type + "  pIsland=" + pIsland + "  offMain=" + offMain + " updateLSO=" + _loc8_,com.poptropica.util.Debug.VERBOSE_MESSAGE);
            if(_loc9_ || _loc8_)
            {
               var _loc12_ = new com.poptropica.models.vo.AdvertisementVO(_loc5_[_loc2_].campaign.campaign_name,_loc5_[_loc2_].campaign.click_through_URL,_loc5_[_loc2_].campaign.impression_URL,_loc5_[_loc2_].campaign.campaign_file1,_loc5_[_loc2_].campaign.campaign_file2,_loc5_[_loc2_].campaign.frequency_cap_count,_loc5_[_loc2_].campaign.frequency_cap_period,_loc5_[_loc2_].campaign.campaign_repeat_spacing,_loc7_,_loc6_);
               if(_loc8_)
               {
                  this.saveCampaignInfo(_loc12_,type,pIsland,offMain);
               }
               if(_loc9_)
               {
                  com.poptropica.util.Debug.trace("Campaign Retrieved from Shared Object",com.poptropica.util.Debug.VERBOSE_MESSAGE);
                  return _loc12_;
               }
            }
         }
         _loc2_ = _loc2_ - 1;
      }
      com.poptropica.util.Debug.trace("no campaign was found. can logWWW? " + typeof com.poptropica.models.PopModelConst.gameplayMC.logWWW);
      return null;
   }
   function isActiveMember()
   {
      if(this.avatar.FunBrain_so.data.mem_status == "active-renew" || this.avatar.FunBrain_so.data.mem_status == "active-norenew")
      {
         return true;
      }
      return false;
   }
   function get is_logged_in()
   {
      if(com.poptropica.models.PopModelConst.poptropicaUser.password_hash != undefined && com.poptropica.models.PopModelConst.poptropicaUser.password_hash != null)
      {
         return true;
      }
      return false;
   }
   function get isRegistered()
   {
      return com.poptropica.models.LSOManager.getInstance().getIsRegistered();
   }
   function get isPartiallyRegistered()
   {
      var _loc1_ = SharedObject.getLocal("Char","/");
      var _loc2_ = false;
      if(_loc1_.data.login != undefined)
      {
         if(_loc1_.data.login.indexOf(";") != -1)
         {
            _loc2_ = true;
         }
      }
      trace("[PopModel] isPartiallyRegistered:" + _loc2_ + "  lso.data.login:" + _loc1_.data.login);
      return _loc2_;
   }
   function get island()
   {
      return com.poptropica.models.PopModelConst.island;
   }
   function set island(pSt)
   {
      com.poptropica.util.Debug.trace("PopModel::set island() pSt=" + pSt,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.island = pSt;
   }
   function get camera()
   {
      return com.poptropica.models.PopModelConst.gameplayCamera;
   }
   function set navbarMC(pMc)
   {
      com.poptropica.util.Debug.trace("PopModel::set navbarMC() pMc=" + pMc,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.navbarMC = pMc;
   }
   function get navbarMC()
   {
      return com.poptropica.models.PopModelConst.navbarMC;
   }
   function set gameplayMC(pMc)
   {
      com.poptropica.util.Debug.trace("PopModel::set gameplayMC() pMc=" + pMc,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.gameplayMC = pMc;
   }
   function get gameplayMC()
   {
      return com.poptropica.models.PopModelConst.gameplayMC;
   }
   function set camera(pMc)
   {
      com.poptropica.util.Debug.trace("PopModel::set camera() pMc=" + pMc,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.gameplayCamera = pMc;
   }
   function get avatar()
   {
      return com.poptropica.models.PopModelConst.avatar;
   }
   function set avatar(pMc)
   {
      com.poptropica.util.Debug.trace("PopModel::set avatar() pMc=" + pMc,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.avatar = pMc;
   }
   function get latest_gameplay_bm()
   {
      return this._latest_gameplay_bm;
   }
   function set latest_gameplay_bm(pBm)
   {
      com.poptropica.util.Debug.trace("PopModel::set latest_gameplay_bm() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._latest_gameplay_bm = pBm;
   }
   function get desc()
   {
      return this._desc;
   }
   function set desc(pSt)
   {
      com.poptropica.util.Debug.trace("PopModel::set desc() pSt=" + pSt,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._desc = pSt;
   }
   function get lastPrefixUpdate()
   {
      return com.poptropica.models.PopModelConst.lastPrefixUpdate;
   }
   function set lastPrefixUpdate(pDt)
   {
      com.poptropica.util.Debug.trace("PopModel::set lastPrefixUpdate() pDt=" + pDt,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.LSOManager.getInstance().setLastPrefixUpdate(pDt);
      com.poptropica.models.PopModelConst.lastPrefixUpdate = pDt;
   }
   function get prefix()
   {
      return com.poptropica.models.PopModelConst.prefix;
   }
   function set prefix(pPre)
   {
      com.poptropica.util.Debug.trace("PopModel::set prefix() pPre=" + pPre,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.LSOManager.getInstance().setPrefix(pPre);
      com.poptropica.models.PopModelConst.prefix = pPre;
   }
   function set isBuilt(pIsBuilt)
   {
      com.poptropica.util.Debug.trace("PopModel::set isBuilt() pIsBuilt=" + pIsBuilt,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._isBuilt = pIsBuilt;
   }
   function get isBuilt()
   {
      return this._isBuilt;
   }
   function get poptropica_user()
   {
      return com.poptropica.models.PopModelConst.poptropicaUser;
   }
   function set poptropica_user(pPU)
   {
      com.poptropica.util.Debug.trace("PopModel::set poptropica_user()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.poptropicaUser = pPU;
   }
   function get login()
   {
      return com.poptropica.models.PopModelConst.poptropicaUser.login;
   }
   function set login(pS)
   {
      com.poptropica.util.Debug.trace("PopModel::set login() pS=" + pS,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.poptropicaUser.login = pS;
   }
   function get password_hash()
   {
      return com.poptropica.models.PopModelConst.poptropicaUser.password_hash;
   }
   function set password_hash(pS)
   {
      com.poptropica.util.Debug.trace("PopModel::set password_hash() pS=" + pS,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.poptropicaUser.password_hash = pS;
   }
   function get db_id()
   {
      return com.poptropica.models.PopModelConst.dbID;
   }
   function set db_id(pS)
   {
      com.poptropica.util.Debug.trace("PopModel::set db_id() pS=" + pS,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.dbID = pS;
   }
   function get islandData()
   {
      return this._islandData;
   }
   function set islandData(pA)
   {
      com.poptropica.util.Debug.trace("PopModel::set islandData()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._islandData = pA;
   }
   function getIslandProperty(islandName, propName)
   {
      com.poptropica.util.Debug.trace("PopModel::set getIslandProperty() islandName=" + islandName + "   propName=" + propName,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = 0;
      while(_loc2_ < this._islandData.length)
      {
         if(this._islandData[_loc2_].name == islandName)
         {
            return this._islandData[_loc2_][propName];
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function getArrayOfIslandNames()
   {
      var _loc3_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this._islandData.length)
      {
         _loc3_.push(this._islandData[_loc2_].name);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function getArrayOfDescriptiveIslandNames()
   {
      var _loc3_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this._islandData.length)
      {
         _loc3_.push(this._islandData[_loc2_].cluster_name);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function isSectionRetrofitted(pSection)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._retrofittedSectionNames.length)
      {
         if(this._retrofittedSectionNames[_loc2_] == pSection)
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function get roomName()
   {
      return com.poptropica.models.PopModelConst.roomName;
   }
   function set roomName(pS)
   {
      com.poptropica.util.Debug.trace("PopModel::set roomName() pS=" + pS,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.roomName = pS;
   }
   function get startup_path()
   {
      return this._startup_path;
   }
   function set startup_path(pPath)
   {
      com.poptropica.util.Debug.trace("PopModel::set startup_path() pPath=" + pPath,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._startup_path = pPath;
   }
   function get rt_mc()
   {
      return this._rt_mc;
   }
   function set rt_mc(pRtMc)
   {
      com.poptropica.util.Debug.trace("PopModel::set rt_mc() pRtMc=" + pRtMc,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._rt_mc = pRtMc;
   }
   function get isTestMode()
   {
      return this._isTestMode;
   }
   function set isTestMode(inIsTestMode)
   {
      com.poptropica.util.Debug.trace("PopModel::set isTestMode() inIsTestMode=" + inIsTestMode,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._isTestMode = inIsTestMode;
   }
   function get gameplay_width()
   {
      return com.poptropica.models.PopModelConst.gameplayWidth;
   }
   function get gameplay_height()
   {
      return com.poptropica.models.PopModelConst.gameplayHeight;
   }
   function get gameplayX()
   {
      return com.poptropica.models.PopModelConst.gameplayX;
   }
   function get gameplayY()
   {
      return com.poptropica.models.PopModelConst.gameplayY;
   }
   function get state()
   {
      return com.poptropica.models.PopModelConst.state;
   }
   function set state(str)
   {
      com.poptropica.util.Debug.trace("PopModel::set state() str=" + str,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.state = str;
      var _loc2_ = com.poptropica.models.PopAppStates.getDimensionsFromState(com.poptropica.models.PopModelConst.state);
      com.poptropica.models.PopModelConst.gameplayWidth = _loc2_.width;
      com.poptropica.models.PopModelConst.gameplayHeight = _loc2_.height;
      var _loc3_ = com.poptropica.models.PopAppStates.getPositioningFromState(com.poptropica.models.PopModelConst.state);
      com.poptropica.models.PopModelConst.gameplayX = _loc3_.x;
      com.poptropica.models.PopModelConst.gameplayY = _loc3_.y;
      var _loc5_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.SET_STATE,str);
      this.setChanged();
      this.notifyObservers(_loc5_);
   }
   function set gameplay_url(str)
   {
      com.poptropica.util.Debug.trace("PopModel::set gameplay_url() str=" + str,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._gameplay_url = str;
      var _loc3_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.SET_GAMEPLAY_URL,str);
      this.setChanged();
      this.notifyObservers(_loc3_);
   }
   function get gameplay_url()
   {
      com.poptropica.util.Debug.trace("PopModel::get gameplay_url() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      return this._gameplay_url;
   }
   function set path(str)
   {
      com.poptropica.util.Debug.trace("PopModel::set path() new path=" + str,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(!this._isBuilt)
      {
         return;
      }
      this._pathStr = str;
      this._pathArray = str.split("/");
      var _loc3_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.SET_PATH,str);
      this.setChanged();
      this.notifyObservers(_loc3_);
   }
   function get path()
   {
      com.poptropica.util.Debug.trace("PopModel::get path() path=" + this._pathStr,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      return this._pathStr;
   }
   function get pathArray()
   {
      return this._pathArray;
   }
   function setPathSection(section)
   {
      com.poptropica.util.Debug.trace("PopModel::setPathSection() section=" + section,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(!this._isBuilt)
      {
         return undefined;
      }
      this._pathArray = [String(section)];
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.SECTION_CHANGE,section);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setPathSubSection(subsection)
   {
      com.poptropica.util.Debug.trace("PopModel::setPathSubSection() subsection=" + subsection,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(!this._isBuilt)
      {
         return undefined;
      }
      this._pathArray = [this._pathArray[0],subsection];
      this._pathStr = this._pathArray.join("/");
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.SUBSECTION_CHANGE,subsection);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function setSectionStatus(status)
   {
      com.poptropica.util.Debug.trace("PopModel::setSectionStatus() status=" + status,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._sStatus = status;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.SET_SECTION_STATUS,status);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get sStatus()
   {
      return this._sStatus;
   }
   function get dailyPopComicHomePageVO()
   {
      return this._dailyPopComicHomePageVO;
   }
   function get listSneakPeeksVO()
   {
      return this._listSneakPeeksVO;
   }
   function set listSneakPeeksPreviewVO(list)
   {
      this._listSneakPeeksPreviewVO = list;
   }
   function get SNEAK_PEEKS_QUANTITY()
   {
      return com.poptropica.models.PopModel._SNEAK_PEEKS_QUANTITY;
   }
   function get offsetSneakPeeks()
   {
      return this._offsetSneakPeeks;
   }
   function set offsetSneakPeeks(value)
   {
      this._offsetSneakPeeks = value;
   }
   function get dailyPopGameIndexPageVO()
   {
      return this._dailyPopGameIndexPageVO;
   }
   function get statusVO()
   {
      return this._statusVO;
   }
   function set statusVO(value)
   {
      com.poptropica.util.Debug.trace("PopModel::set statusVO() - " + value,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._statusVO = value;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.PROFILE_STATUS_SET,this._statusVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get privacyVO()
   {
      return this._privacyVO;
   }
   function set privacyVO(value)
   {
      com.poptropica.util.Debug.trace("PopModel::set privacyVO() - " + value,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._privacyVO = value;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.PROFILE_PRIVACY_SET,this._privacyVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get albumsVO()
   {
      return this._albumsVO;
   }
   function set albumsVO(value)
   {
      com.poptropica.util.Debug.trace("PopModel::set albumsVO() - " + value,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._albumsVO = value;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.ALBUMS_DATA_SET,this._albumsVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get albumPageVO()
   {
      return this._albumPageVO;
   }
   function set albumPageVO(value)
   {
      com.poptropica.util.Debug.trace("PopModel::set albumPageVO() - " + value,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._albumPageVO = value;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.ALBUM_PAGE_DATA_SET,this._albumPageVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get badgeSetVO()
   {
      return this._badgeSetVO;
   }
   function set badgeSetVO(value)
   {
      com.poptropica.util.Debug.trace("PopModel::set badgeSetVO() - " + value,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._badgeSetVO = value;
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.BADGE_SET_DATA_SET,this._badgeSetVO);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
   function get listCreatorClipsVO()
   {
      return this._listCreatorClipsVO;
   }
   function getCampaignName()
   {
      return "";
   }
   function gotoMembershipHtmlPage(eventName)
   {
      com.poptropica.models.PopModelConst.gameplayMC.trackCampaign("","MembershipEvent","BuyCreditsOrMembership");
      com.poptropica.models.PopModelConst.gameplayMC.trackCampaign("","StoreEvent","GetMembership",eventName);
      var _loc2_ = _root.createEmptyMovieClip("send_mc",1);
      _loc2_.login = com.poptropica.models.PopModelConst.avatar.loadLogin();
      _loc2_.pass_hash = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.password;
      _loc2_.logged_in = !com.poptropica.models.PopModelConst.avatar.isRegistred() ? 0 : 1;
      _loc2_.getURL(com.poptropica.models.PopModelConst.prefix + "/store/buy-membership.html","_blank","POST");
   }
   function sendPhotoNotification()
   {
      var _loc2_ = new com.poptropica.models.PopUpdateInfo(com.poptropica.models.PopUpdateNotificationTypes.PHOTO_SAVED);
      this.setChanged();
      this.notifyObservers(_loc2_);
   }
}
