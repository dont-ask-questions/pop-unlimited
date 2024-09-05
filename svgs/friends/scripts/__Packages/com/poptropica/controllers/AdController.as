class com.poptropica.controllers.AdController extends com.poptropica.mvc.AbstractController
{
   var _model;
   var _getCampaignsCallback;
   var _getLocalAdDataCommand;
   var _getCampaignsCommand;
   var _getAdBillboardCommand;
   var _getAdMainStreetCommand;
   var _getAdVendorCartCommand;
   var _getAdWrapperCommand;
   var _getAdAutoCardCommand;
   var _getAdLogOutCommand;
   static var instance;
   var _waitBeforeGettingWrapperAds = 3000;
   var _holdingForAds = false;
   function AdController(cm)
   {
      super(cm);
      com.poptropica.util.Debug.trace("AdController::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   static function getInstance(cm)
   {
      if(com.poptropica.controllers.AdController.instance == undefined)
      {
         com.poptropica.controllers.AdController.instance = new com.poptropica.controllers.AdController(cm);
      }
      return com.poptropica.controllers.AdController.instance;
   }
   function loadWrapper()
   {
      if(com.poptropica.models.PopModel(this._model).state == com.poptropica.models.PopAppStates.RETURN_USER_STANDARD && !com.poptropica.models.PopModel(this._model).gameplayMC.globalScene)
      {
         _global.setTimeout(Delegate.create(this,this.retrieveAdWrapper),this._waitBeforeGettingWrapperAds);
      }
   }
   function getCampaigns(island, callback)
   {
      var _loc3_ = SharedObject.getLocal("campaignData","/");
      var _loc2_ = com.poptropica.models.PopModel(this._model).gameplayMC._url;
      this._getCampaignsCallback = callback;
      this._holdingForAds = true;
      if(_loc2_.substr(0,_loc2_.indexOf(":")) == "file" || _loc2_.substr(0,_loc2_.indexOf(".")) == "http://feta" || _loc2_.substr(0,_loc2_.indexOf(".")) == "http://localhost/pop/base")
      {
         com.poptropica.models.PopModel(this._model).cleanOutCampaignData();
         com.poptropica.controllers.commands.GetAdCommand.local = true;
         this._getLocalAdDataCommand = new com.poptropica.controllers.commands.GetLocalAdDataCommand();
         this._getLocalAdDataCommand.addEventListener("Loaded",com.poptropica.util.EventDelegate.create(this,this.onGetCampaigns));
         this._getLocalAdDataCommand.exec();
      }
      else
      {
         trace("GetAdCommand: getCampaigns: island: " + island);
         trace("GetAdCommand: getCampaigns: island data: " + _loc3_.data.islands[island]);
         if(_loc3_.data.islands[island] == undefined)
         {
            this._getCampaignsCommand = new com.poptropica.controllers.commands.GetAdCommand();
            this._getCampaignsCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onGetCampaigns));
            this._getCampaignsCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onGetCampaignsError));
            this._getCampaignsCommand.type = "All";
            this._getCampaignsCommand.exec();
         }
         else
         {
            this.onGetCampaigns();
         }
      }
   }
   function onGetCampaigns()
   {
      var _loc2_ = com.poptropica.models.PopModel(this._model).gameplayMC.camera.scene;
      var _loc3_ = com.poptropica.models.PopModel(this._model).desc;
      trace("getCampaigns: room name: " + _loc2_.roomName);
      trace("getCampaigns: desc name: " + _loc3_);
      if(_loc2_.ad)
      {
         this.retrieveAdBillboard();
      }
      else if(_loc2_.roomName == "Main Street" || _loc3_ == "GlobalAS3Embassy")
      {
         this.retrieveAdMainStreet();
         if(_loc2_.vendorCartHolder)
         {
            this.retrieveVendorCart();
         }
      }
      else
      {
         if(_loc2_.adArea)
         {
            _loc2_.adArea._visible = false;
         }
         this.resumeGameplayLoading();
      }
   }
   function campaignAssetsReady(type)
   {
      if(type != com.poptropica.models.AdCampaignType.MAIN_STREET && type != com.poptropica.models.AdCampaignType.VENDOR_CART)
      {
         this.resumeGameplayLoading();
      }
   }
   function campaignAssetsLoadError()
   {
      this.resumeGameplayLoading();
   }
   function onGetCampaignsError()
   {
      com.poptropica.models.PopModel(this._model).gameplayMC.scene.adArea._visible = false;
      this.resumeGameplayLoading();
   }
   function resumeGameplayLoading()
   {
      if(this._holdingForAds)
      {
         this._holdingForAds = false;
         com.poptropica.models.PopModelConst.gameplayMC.nextFrame();
      }
   }
   function retrieveAdBillboard()
   {
      com.poptropica.util.Debug.trace("PopController::retrieveAdBillboard()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._getAdBillboardCommand = new com.poptropica.controllers.commands.GetAdCommand();
      this._getAdBillboardCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdBillboard));
      this._getAdBillboardCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdBillboardError));
      this._getAdBillboardCommand.type = "Billboard";
      this._getAdBillboardCommand.exec();
   }
   function onRetrieveAdBillboard(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdBillboard() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.BILLBOARD_AD_RETRIEVED,e._data);
   }
   function onRetrieveAdBillboardError(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdBillboardError() e._message=" + e._message,com.poptropica.util.Debug.WARNING);
      com.poptropica.models.PopModel(this._model).gameplayMC.scene.adArea._visible = false;
      this.resumeGameplayLoading();
   }
   function retrieveAdMainStreet()
   {
      com.poptropica.util.Debug.trace("PopController::retrieveAdMainStreet()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._getAdMainStreetCommand = new com.poptropica.controllers.commands.GetAdCommand();
      this._getAdMainStreetCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdMainStreet));
      this._getAdMainStreetCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdMainStreetError));
      this._getAdMainStreetCommand.type = com.poptropica.models.AdCampaignType.MAIN_STREET;
      this._getAdMainStreetCommand.exec();
   }
   function onRetrieveAdMainStreet(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdMainStreet() data : " + e._data,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.MAINSTREET_AD_RETRIEVED,e._data);
   }
   function onRetrieveAdMainStreetError(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdMainStreetError() e._message=" + e._message,com.poptropica.util.Debug.WARNING);
      com.poptropica.models.PopModel(this._model).gameplayMC.scene.adArea._visible = false;
      this.resumeGameplayLoading();
   }
   function retrieveVendorCart()
   {
      com.poptropica.util.Debug.trace("PopController::retrieveAdVendorCart()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._getAdVendorCartCommand = new com.poptropica.controllers.commands.GetAdCommand();
      this._getAdVendorCartCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onRetrieveVendorCart));
      this._getAdVendorCartCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onRetrieveVendorCartError));
      this._getAdVendorCartCommand.type = com.poptropica.models.AdCampaignType.VENDOR_CART;
      this._getAdVendorCartCommand.exec();
   }
   function onRetrieveVendorCart(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveVendorCart() data : " + e._data,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.VENDORCART_AD_RETRIEVED,e._data);
   }
   function onRetrieveVendorCartError(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveVendorCartError() e._message=" + e._message,com.poptropica.util.Debug.WARNING);
      com.poptropica.models.PopModel(this._model).gameplayMC.scene.vendorCartHolder._visible = false;
   }
   function retrieveAdWrapper()
   {
      com.poptropica.util.Debug.trace("PopController::retrieveAdWrapper()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._getAdWrapperCommand = new com.poptropica.controllers.commands.GetAdCommand();
      this._getAdWrapperCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdWrapper));
      this._getAdWrapperCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdWrapperError));
      this._getAdWrapperCommand.type = "Wrapper";
      this._getAdWrapperCommand.exec();
   }
   function onRetrieveAdWrapper(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdWrapper() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.WRAPPER_AD_RETRIEVED,e._data);
   }
   function onRetrieveAdWrapperError(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdWrapperError() e._message=" + e._message,com.poptropica.util.Debug.WARNING);
   }
   function retrieveAdAutoCard()
   {
      com.poptropica.util.Debug.trace("PopController::retrieveAdAutoCard()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._getAdAutoCardCommand = new com.poptropica.controllers.commands.GetAdCommand();
      this._getAdAutoCardCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdAutoCard));
      this._getAdAutoCardCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdAutoCardError));
      this._getAdAutoCardCommand.type = "AutoCard";
      this._getAdAutoCardCommand.exec();
   }
   function onRetrieveAdAutoCard(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdAutoCard() data : " + e._data,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.AUTOCARD_AD_RETRIEVED,e._data);
   }
   function onRetrieveAdAutoCardError(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdAutoCardError() e._message=" + e._message,com.poptropica.util.Debug.WARNING);
   }
   function retrieveAdLogOut()
   {
      com.poptropica.util.Debug.trace("PopController::retrieveAdLogOut()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._getAdLogOutCommand = new com.poptropica.controllers.commands.GetAdCommand();
      this._getAdLogOutCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdLogOut));
      this._getAdLogOutCommand.addEventListener(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR,com.poptropica.util.EventDelegate.create(this,this.onRetrieveAdLogOutError));
      this._getAdLogOutCommand.type = "Logout";
      this._getAdLogOutCommand.exec();
   }
   function onRetrieveAdLogOut(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdLogOut() data : " + e._data,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel(this._model).sendUpdateNotification(com.poptropica.models.PopUpdateNotificationTypes.LOGOUT_AD_RETRIEVED,e._data);
   }
   function onRetrieveAdLogOutError(e)
   {
      com.poptropica.util.Debug.trace("PopController::onRetrieveAdLogOutError() e._message=" + e._message,com.poptropica.util.Debug.WARNING);
   }
}
