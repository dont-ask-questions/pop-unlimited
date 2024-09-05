class com.poptropica.controllers.commands.dailyPop.challenges.GetUCRCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _popModel;
   var _popController;
   function GetUCRCommand()
   {
      super();
      com.poptropica.util.Debug.trace("GetUserChallengesResult::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = com.poptropica.controllers.PopController.getInstance(this._popModel);
   }
   function exec(pChallengeQuizId)
   {
      com.poptropica.util.Debug.trace("GetUserChallengesResult::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(!this._popModel.getChallengesVO().challengeOfTheDayResult)
      {
         this.load(pChallengeQuizId);
      }
      else
      {
         this._popModel.notifyUserChallengesResultsLoaded();
      }
   }
   function load(pChallengeQuizId)
   {
      var _loc2_ = new com.poptropica.models.proxy.dailyPop.challenges.GetUserChallengeResultProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onDataLoaded),pChallengeQuizId);
   }
   function onDataLoaded(pData)
   {
      this._popModel.getChallengesVO().setUserChallengesResultData(pData);
      this._popModel.notifyUserChallengesResultsLoaded();
   }
}
