class com.poptropica.views.home.welcomeBack.MemberSurvey
{
   var _container_mc;
   var _bg;
   var _okButton;
   var _closeButton;
   var _url = "http://www.morar-research.com/?id=adc2cb4f9dS0000000";
   var _campaignName = "SandboxSurvey1";
   function MemberSurvey(pTarget)
   {
      this._container_mc = pTarget;
      this.init(this._container_mc);
   }
   function clear()
   {
      delete this._bg.onPress;
      delete this._okButton.onRelease;
      delete this._closeButton.onRelease;
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._okButton);
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._closeButton);
      this._container_mc.removeMovieClip();
      com.poptropica.models.PopModelConst.gameplayMC.avatar.completeEvent("viewedMemberSurvey","Early");
      false;
   }
   function init(pTarget)
   {
      this._bg = pTarget.bg;
      this._okButton = pTarget.okButton;
      this._closeButton = pTarget.closeButton;
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._okButton,2);
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._closeButton,2);
      this._bg.onPress = function()
      {
      };
      this._bg.useHandCursor = false;
      this._okButton.onRelease = com.poptropica.util.EventDelegate.create(this,this.onOkBtnPress);
      this._closeButton.onRelease = com.poptropica.util.EventDelegate.create(this,this.onCloseBtnPress);
   }
   function onOkBtnPress()
   {
      this.clear();
      var _loc3_ = SharedObject.getLocal("Char","/");
      var _loc2_ = 0;
      var _loc4_ = _loc3_.data.mem_status;
      if(_loc4_ == "active-renew" || _loc4_ == "active-norenew")
      {
         _loc2_ = 2;
      }
      var _loc5_ = Number(_loc3_.data.gender);
      _loc2_ += _loc5_;
      this._url += String(_loc2_);
      getURL(this._url,"blank");
   }
   function onCloseBtnPress()
   {
      this.clear();
   }
}
