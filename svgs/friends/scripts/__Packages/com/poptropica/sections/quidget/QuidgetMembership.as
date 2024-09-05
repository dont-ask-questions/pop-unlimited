class com.poptropica.sections.quidget.QuidgetMembership extends com.poptropica.sections.quidget.QuidgetBase
{
   var _status;
   var _asset;
   var _popup;
   function QuidgetMembership()
   {
      super();
      trace("[QuidgetMembership] Constructor");
   }
   function init(d)
   {
      this._status = d.status;
      this.loadQuidgetSwf();
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetMembership] onPopQuizLoadInit. _status?:" + this._status);
      var _loc2_ = this._status.indexOf("active") == -1 ? "nonMemberQuidgetAsset" : "memberQuidgetAsset";
      this._asset.contentContainer.content.attachMovie(_loc2_,"quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this.setEditable(true);
      }
      this.dispatchLoadComplete();
   }
   function createRolloverIcons()
   {
   }
   function onAssetClick()
   {
      var _loc2_ = this._status + "Popup";
      com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass(_loc2_,new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/membership_quidget_assets.swf");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
   }
   function onBuyClick()
   {
      com.poptropica.controllers.PopController.getInstance().showFrameworkPopup("popups/membership_tour.swf",null);
   }
   function onPopupReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      if(this._popup.btnBuy != undefined)
      {
         this._popup.btnBuy.onRelease = Delegate.create(this,this.onBuyClick);
      }
      if(this._popup.btnRenew != undefined)
      {
         this._popup.btnRenew.onRelease = Delegate.create(this,this.onBuyClick);
      }
   }
   function onPopupClose(callingObj)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      this.makeIconFlash();
   }
   function isAccomplishment()
   {
      return true;
   }
   function isPersonality()
   {
      return false;
   }
   function get name()
   {
      return "membership";
   }
   function get rolloverString()
   {
      var _loc2_ = undefined;
      switch(this._status)
      {
         case "active-renew":
         case "active-norenew":
            _loc2_ = "Membership Status: Active";
            break;
         case "notmember":
            _loc2_ = "Membership Status: Inactive";
            break;
         case "expired":
            _loc2_ = "Membership Status: Expired";
      }
      return _loc2_;
   }
}
