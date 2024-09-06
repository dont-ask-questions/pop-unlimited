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
      var _loc2_ = _loc1_.poptropica_user;
      var _loc11_ = _loc2_.gender;
      var _loc9_ = _loc2_.language;
      var _loc13_ = _loc2_.grade;
      var _loc12_ = !_loc1_.isActiveMember() ? "N" : "Y";
      var _loc10_ = _loc1_.poptropica_user.login;
      var _loc6_ = undefined;
      var _loc8_ = undefined;
      if(trackScene)
      {
         _loc6_ = _loc1_.roomName;
         _loc8_ = String(_loc1_.getIslandProperty(_loc1_.island,"cluster_name"));
      }
      else
      {
         _loc6_ = scene;
         _loc8_ = cluster;
      }
      var _loc3_ = "/brain/track.php?cluster=" + escape(_loc8_) + "&scene=" + escape(_loc6_) + "&campaign=" + escape(CampaignName) + "&event=" + escape(EventToTrack) + "&grade=" + _loc13_ + "&gender=" + _loc11_ + "&lang=" + _loc9_ + (!ChoiceName ? "" : "&choice=" + escape(ChoiceName)) + (!SubChoiceName ? "" : "&subchoice=" + escape(SubChoiceName)) + "&brain=Poptropica&randomNumber=" + random(10000) + "&member=" + _loc12_ + "&login=" + _loc10_;
      trace("[TrackCommand] :exec str:" + _loc3_);
      loadVariablesNum(_loc3_,0);
   }
}
