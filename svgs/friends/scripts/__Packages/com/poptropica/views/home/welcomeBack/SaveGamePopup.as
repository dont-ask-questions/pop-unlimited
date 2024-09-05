class com.poptropica.views.home.welcomeBack.SaveGamePopup
{
   var _container_mc;
   var _bg;
   var _saveBtn;
   var _cancelBtn;
   function SaveGamePopup(pTarget)
   {
      this._container_mc = pTarget;
      this.init(this._container_mc);
   }
   function clear()
   {
      delete this._bg.onPress;
      delete this._saveBtn.onRelease;
      delete this._cancelBtn.onRelease;
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._saveBtn);
      com.poptropica.util.CursorViewChanger.getInstance().removeElement(this._cancelBtn);
      this._container_mc.removeMovieClip();
      false;
   }
   function init(pTarget)
   {
      this._bg = pTarget.mcBg;
      this._saveBtn = pTarget.mcSaveBtn;
      this._cancelBtn = pTarget.mcCancelBtn;
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._saveBtn,2);
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._cancelBtn,2);
      this._bg.onPress = function()
      {
      };
      this._bg.useHandCursor = false;
      this._saveBtn.onRelease = com.poptropica.util.EventDelegate.create(this,this.onSaveBtnPress);
      if(this._cancelBtn != undefined)
      {
         this._cancelBtn.onRelease = Delegate.create(this,this.onCancelRelease);
      }
   }
   function onSaveBtnPress()
   {
      this.clear();
      com.poptropica.controllers.PopController.getInstance().returnToGameAndSave();
   }
   function onCancelRelease()
   {
      this.clear();
   }
}
