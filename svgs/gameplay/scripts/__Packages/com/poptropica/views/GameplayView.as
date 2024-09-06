class com.poptropica.views.GameplayView extends com.poptropica.mvc.AbstractView
{
   var _gameplayContainerMc;
   var _current_section;
   var _model;
   var _returnToGameCounter = 0;
   var _leaveGameCounter = 0;
   function GameplayView(m, c, pTarget)
   {
      super(m,c);
      com.poptropica.util.Debug.trace("GameplayView::() pTarget=" + pTarget,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._gameplayContainerMc = pTarget;
   }
   function update(o, pInfoObj)
   {
      com.poptropica.util.Debug.trace("GameplayView::update()  pInfoObj._type=" + pInfoObj._type,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      switch(pInfoObj._type)
      {
         case com.poptropica.models.PopUpdateNotificationTypes.SECTION_CHANGE:
            var _loc2_ = String(pInfoObj._data);
            this.checkForGameAction(_loc2_,this._current_section);
            this.checkForItemsExceptionPopup(_loc2_,this._current_section);
            this._current_section = _loc2_;
            com.poptropica.models.PopModelConst.section = this._current_section;
            break;
         case com.poptropica.models.PopUpdateNotificationTypes.SET_PATH:
            var _loc6_ = String(pInfoObj._data);
            var _loc5_ = _loc6_.split("/");
            var _loc3_ = _loc5_[0];
            this.checkForGameAction(_loc3_,this._current_section);
            this.checkForItemsExceptionPopup(_loc3_,this._current_section);
            this._current_section = _loc3_;
            com.poptropica.models.PopModelConst.section = this._current_section;
            break;
         case com.poptropica.models.PopUpdateNotificationTypes.GAMEPLAY_LOADED:
            this._gameplayContainerMc.updateLatestGameplayBitmap();
            break;
         case com.poptropica.models.PopUpdateNotificationTypes.INIT_SAVE_SEQUENCE:
            this._gameplayContainerMc.saveGame();
      }
   }
   function checkForItemsExceptionPopup(pNewSection, pCurrSection)
   {
      com.poptropica.util.Debug.trace("GameplayView::checkForItemsExceptionPopup() pNewSection=" + pNewSection,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(pNewSection == "items")
      {
         this._gameplayContainerMc.openInventoryPopup();
      }
      if(pCurrSection == "items")
      {
         this._gameplayContainerMc.removeInventoryPopup();
      }
   }
   function checkForGameAction(pNewSection, pCurrSection)
   {
      com.poptropica.util.Debug.trace("GameplayView::checkForGameAction() pNewSection=" + pNewSection + "   pCurrSection=" + pCurrSection,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(pNewSection == "gameplay" && pCurrSection != "gameplay")
      {
         if(this._gameplayContainerMc.returnToGameHandler)
         {
            this._gameplayContainerMc.returnToGameHandler(this._returnToGameCounter);
         }
         if(this._returnToGameCounter == 0 && !com.poptropica.models.PopModelConst.gameplayMC.popupClip && !com.poptropica.models.PopModelConst.gameplayMC.globalScene && com.poptropica.models.PopModelConst.gameplayMC.island != "Home")
         {
            com.poptropica.controllers.AdController.getInstance().retrieveAdAutoCard();
         }
         this._returnToGameCounter = this._returnToGameCounter + 1;
      }
      if(pNewSection != "gameplay" && pCurrSection == "gameplay" || pNewSection != "gameplay" && pCurrSection == undefined)
      {
         if(this._gameplayContainerMc.leaveGameHandler)
         {
            this._gameplayContainerMc.leaveGameHandler(this._leaveGameCounter);
         }
         this._leaveGameCounter = this._leaveGameCounter + 1;
      }
   }
   function clear()
   {
      com.poptropica.util.Debug.trace("GameplayView::clear()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._model.removeObserver(this);
   }
}
