class com.poptropica.controllers.commands.RetrofittingWorkaroundsCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _rt_target;
   var _popModel;
   var _popController;
   function RetrofittingWorkaroundsCommand(pMvClip)
   {
      super();
      com.poptropica.util.Debug.trace("RetrofittingWorkaroundsCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._rt_target = pMvClip;
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = com.poptropica.controllers.PopController.getInstance(this._popModel);
   }
   function exec()
   {
      com.poptropica.util.Debug.trace("RetrofittingWorkaroundsCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._rt_target.island = this._popModel.island;
      this._rt_target.desc = this._popModel.desc;
      this._rt_target.globalScene = this._rt_target.globalScene;
      this._rt_target.ClusterName = String(this._popModel.getIslandProperty(this._popModel.island,"cluster_name"));
      this._rt_target.camera = this._popModel.camera;
      this._rt_target.avatar = this._popModel.avatar;
      this._rt_target.char = this._popModel.camera.scene.char;
      this._rt_target.takeClick = com.poptropica.models.PopModelConst.gameplayMC.takeClick;
      this._rt_target.popupClip = com.poptropica.models.PopModelConst.gameplayMC.popupClip;
      this._rt_target.popupBack = com.poptropica.models.PopModelConst.gameplayMC.popupBack;
      this._rt_target.visitPartyRoom = com.poptropica.models.PopModelConst.gameplayMC.visitPartyRoom;
      this._rt_target.manualSay = com.poptropica.models.PopModelConst.gameplayMC.manualSay;
      this._rt_target.unPauseGame = com.poptropica.models.PopModelConst.gameplayMC.unPauseGame;
      this._rt_target.popup = com.poptropica.models.PopModelConst.gameplayMC.popup;
      this._rt_target.getUserInfo = com.poptropica.models.PopModelConst.gameplayMC.getUserInfo;
      this._rt_target.checkBossesBeat = com.poptropica.models.PopModelConst.gameplayMC.checkBossesBeat;
      this._rt_target.sceneIsVisible = com.poptropica.models.PopModelConst.gameplayMC.sceneIsVisible;
      this._rt_target.setClipColor = com.poptropica.models.PopModelConst.gameplayMC.setClipColor;
      this._rt_target.useArrow = function()
      {
         this._popController.setPointerDisplay("click");
      };
      this._rt_target.isActiveMember = function()
      {
         return this._popModel.isActiveMember();
      };
      this._rt_target.trackCampaign = function(CampaignName, EventToTrack, ChoiceName, SubChoiseName)
      {
         this._popController.track(CampaignName,EventToTrack,ChoiceName,SubChoiseName);
      };
      this._rt_target.trackEvent = function(EventToTrack)
      {
         this._popController.track("",EventToTrack);
      };
      this._rt_target.getPrefix = function()
      {
         return com.poptropica.models.PopModelConst.prefix;
      };
      this._rt_target.trc = function(pStr)
      {
         com.poptropica.util.Debug.trace("Gameplay::trace() " + pStr,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      };
   }
}
