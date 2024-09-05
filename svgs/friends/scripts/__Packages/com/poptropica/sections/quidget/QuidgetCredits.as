class com.poptropica.sections.quidget.QuidgetCredits extends com.poptropica.sections.quidget.QuidgetBase
{
   var _credits;
   var _asset;
   var _popup;
   function QuidgetCredits()
   {
      super();
      trace("[QuidgetCredits] Constructor");
      this.loadQuidgetSwf();
   }
   function init(d)
   {
      this._credits = d.total;
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetCredits] onPopQuizLoadInit. ");
      this._asset.contentContainer.content.attachMovie("creditsQuidgetAsset","quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      this.setEditable(true);
      this._asset.contentContainer.content.quidgetAsset.tf.text = this._credits;
      this.dispatchLoadComplete();
   }
   function createRolloverIcons()
   {
   }
   function onAssetClick()
   {
      this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("creditsPop",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/credits_quidget_assets.swf");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
   }
   function onPopupReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      this._popup.btn.onRelease = Delegate.create(this,this.onVisitStoreClick);
   }
   function onVisitStoreClick()
   {
      com.poptropica.controllers.PopController.getInstance().setPath("stats");
   }
   function onPopupClose(callingObj)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      this.makeIconFlash();
   }
   function draw()
   {
   }
   function isAccomplishment()
   {
      return false;
   }
   function isPersonality()
   {
      return false;
   }
   function get name()
   {
      return "credits";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson + " have " + this._credits + " credits.";
      return _loc2_;
   }
}
