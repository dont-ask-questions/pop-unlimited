class com.poptropica.controllers.commands.PassVarsToFrameworkCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _popModel;
   var _popController;
   var _rt_target;
   function PassVarsToFrameworkCommand()
   {
      super();
      com.poptropica.util.Debug.trace("PassVarsToFrameworkCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = com.poptropica.controllers.PopController.getInstance(this._popModel);
      this._rt_target = this._popModel.rt_mc;
   }
   function exec(pOldSectionName, pNewSectionName)
   {
      com.poptropica.util.Debug.trace("PassVarsToFrameworkCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      _root.cfPainting = com.poptropica.models.PopModelConst.gameplayMC.cfPainting;
      _root.pickedItem = com.poptropica.models.PopModelConst.gameplayMC.pickedItem;
      _root.navBar = com.poptropica.models.PopModelConst.gameplayMC.navBar;
      var popC = this._popController;
      _root.popupClip = {};
      _root.popupClip.removeMovieClip = function()
      {
         com.poptropica.util.Debug.trace("OVERWRITTEN  _root.popupClip.removeMovieClip");
         popC.setPath("gameplay");
      };
   }
}
