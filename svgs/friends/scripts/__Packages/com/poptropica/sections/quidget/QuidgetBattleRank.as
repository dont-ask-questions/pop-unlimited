class com.poptropica.sections.quidget.QuidgetBattleRank extends com.poptropica.sections.quidget.QuidgetBase
{
   var _rank;
   var _asset;
   function QuidgetBattleRank()
   {
      super();
      trace("[QuidgetBattleRank] Constructor");
   }
   function init(d)
   {
      var _loc3_ = com.poptropica.models.PopModelConst.gameplayMC.getUserInfo();
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this._rank = _root.getUserInfo().ranking;
      }
      else
      {
         this._rank = d.ranking;
      }
      trace("QuidgetBattleRank... rank:" + this._rank);
      this.loadQuidgetSwf();
      this.setEditable(false);
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetBattleRank] onPopQuizLoadInit. ");
      this._asset.contentContainer.content.attachMovie("battlerankQuidgetAsset","quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      var _loc2_ = this._asset.contentContainer.content.quidgetAsset.mcStars;
      var _loc3_ = Math.round(Math.max(1,this._rank * _loc2_._totalframes / 100));
      _loc2_.gotoAndStop(_loc3_);
      this.dispatchLoadComplete();
   }
   function createRolloverIcons()
   {
   }
   function onAssetClick()
   {
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
      return "battlerank";
   }
   function get rolloverString()
   {
      var _loc2_ = "";
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson + " has a battle ranking of \n" : "Battle Rank: \n";
      _loc2_ += String(Math.round(this._rank / 20 * 10) / 10);
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? "." : "\nChallenge players in a common room to improve it!";
      return _loc2_;
   }
}
