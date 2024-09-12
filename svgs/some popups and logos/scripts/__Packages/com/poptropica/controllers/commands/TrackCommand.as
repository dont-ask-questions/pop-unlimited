class com.poptropica.controllers.commands.TrackCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   function TrackCommand()
   {
      super();
      com.poptropica.util.Debug.trace("TrackCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function exec(CampaignName, EventToTrack, ChoiceName, SubChoiceName, trackScene, cluster, scene)
   {
      com.poptropica.util.Debug.trace("TrackCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(trackScene == undefined || trackScene == null)
      {
         trackScene = false;
      }
      if(cluster == undefined || cluster == null)
      {
         cluster = "";
      }
      if(scene == undefined || scene == null)
      {
         scene = "";
      }
      var _loc1_ = com.poptropica.models.PopModel.getInstance();
      var _loc4_ = _loc1_.poptropica_user;
      var _loc12_ = _loc4_.gender;
      var _loc10_ = _loc4_.language;
      var _loc15_ = _loc4_.grade;
      var _loc13_ = !_loc1_.isActiveMember() ? "N" : "Y";
      var _loc11_ = _loc1_.poptropica_user.login;
      var _loc2_ = undefined;
      var _loc9_ = undefined;
      if(trackScene)
      {
         _loc2_ = _loc1_.roomName;
         _loc9_ = String(_loc1_.getIslandProperty(_loc1_.island,"cluster_name"));
      }
      else
      {
         _loc2_ = scene;
         _loc9_ = cluster;
      }
      if(SubChoiceName == "offMain")
      {
         var _loc3_ = com.poptropica.models.PopModelConst.gameplayMC._gameplayView.getWrapperSection();
         if(_loc3_ != "gameplay" && _loc3_ != "")
         {
            switch(_loc3_)
            {
               case "stats":
                  _loc2_ = "store";
                  break;
               case "dailypop":
                  _loc2_ = "comics";
                  break;
               default:
                  _loc2_ = _loc3_;
            }
         }
      }
      var _loc5_ = "/brain/track.php?cluster=" + escape(_loc9_) + "&scene=" + escape(_loc2_) + "&campaign=" + escape(CampaignName) + "&event=" + escape(EventToTrack) + "&grade=" + _loc15_ + "&gender=" + _loc12_ + "&lang=" + _loc10_ + (!ChoiceName ? "" : "&choice=" + escape(ChoiceName)) + (!SubChoiceName ? "" : "&subchoice=" + escape(SubChoiceName)) + "&brain=Poptropica&randomNumber=" + random(10000) + "&member=" + _loc13_ + "&login=" + _loc11_;
      trace("[TrackCommand] :exec str:" + _loc5_);
      loadVariablesNum(_loc5_,0);
   }
}
