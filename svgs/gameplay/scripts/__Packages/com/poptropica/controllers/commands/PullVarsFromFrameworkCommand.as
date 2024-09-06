class com.poptropica.controllers.commands.PullVarsFromFrameworkCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _popModel;
   var _popController;
   var _rt_target;
   function PullVarsFromFrameworkCommand()
   {
      super();
      com.poptropica.util.Debug.trace("PullVarsFromFrameworkCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = com.poptropica.controllers.PopController.getInstance(this._popModel);
      this._rt_target = this._popModel.rt_mc;
   }
   function exec(pOldSectionName, pNewSectionName)
   {
      com.poptropica.util.Debug.trace("PullVarsFromFrameworkCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModelConst.gameplayMC.cfPainting = _root.cfPainting;
      com.poptropica.models.PopModelConst.gameplayMC.FrootLoopsChoice = _root.FrootLoopsChoice;
      com.poptropica.models.PopModelConst.gameplayMC.FrootLoopsColor = _root.FrootLoopsColor;
      com.poptropica.models.PopModelConst.gameplayMC.game = _root.game;
      com.poptropica.models.PopModelConst.gameplayMC.gSelectedFace = _root.gSelectedFace;
      com.poptropica.models.PopModelConst.gameplayMC.isModel = _root.isModel;
      com.poptropica.models.PopModelConst.gameplayMC.modelLook = _root.modelLook;
      com.poptropica.models.PopModelConst.gameplayMC.sprinklesCharColors = _root.sprinklesCharColors;
      com.poptropica.models.PopModelConst.gameplayMC.sprinklesColors = _root.sprinklesColors;
      com.poptropica.models.PopModelConst.gameplayMC.usePinkPainter = _root.usePinkPainter;
      com.poptropica.models.PopModelConst.gameplayMC.useSelectCharacter = _root.useSelectCharacter;
      com.poptropica.models.PopModelConst.gameplayMC.useWardrobe = _root.useWardrobe;
      com.poptropica.models.PopModelConst.gameplayMC.giveTarget = _root.giveTarget;
      com.poptropica.models.PopModelConst.gameplayMC.loops = _root.loops;
      com.poptropica.models.PopModelConst.gameplayMC.run = _root.run;
      com.poptropica.models.PopModelConst.gameplayMC.pickedItem = _root.pickedItem;
      com.poptropica.models.PopModelConst.gameplayMC.selectedCharacter = _root.selectedCharacter;
      com.poptropica.models.PopModelConst.gameplayMC.yogos = _root.selectedCharacter;
      com.poptropica.models.PopModelConst.gameplayMC.makeFLSprinkles = _root.makeFLSprinkles;
      com.poptropica.models.PopModelConst.gameplayMC.selectCharacter = _root.selectCharacter;
   }
}
