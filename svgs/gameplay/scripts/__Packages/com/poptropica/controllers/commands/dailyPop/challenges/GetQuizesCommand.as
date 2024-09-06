class com.poptropica.controllers.commands.dailyPop.challenges.GetQuizesCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _popModel;
   var _popController;
   var _quizCollectionType;
   function GetQuizesCommand()
   {
      super();
      com.poptropica.util.Debug.trace("GetQuizesCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = com.poptropica.controllers.PopController.getInstance(this._popModel);
   }
   function exec(pQuantity, pOffset, pType, pChallengeQuizId)
   {
      com.poptropica.util.Debug.trace("GetQuizesCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc4_ = this._popModel.getChallengesVO().quizesCollectionHolder.getQuizeCollectionByType(pType);
      var _loc3_ = !_loc4_.isThisNumberOfElementsInCollection(pOffset,pQuantity);
      if(_loc3_ == true)
      {
         this._quizCollectionType = pType;
         this.loadQuizes(pQuantity,pOffset,pType,pChallengeQuizId);
      }
      else
      {
         this._popModel.notifyQuizesWithResultsLoaded();
      }
   }
   function loadQuizes(pQuantity, pOffset, pType, pChallengeQuizId)
   {
      var _loc2_ = new com.poptropica.models.proxy.dailyPop.challenges.GetQuizesProxy();
      _loc2_.loadData(com.poptropica.util.EventDelegate.create(this,this.onQuizesDataLoaded),pQuantity,pOffset,pType,pChallengeQuizId);
   }
   function getQuizesResult(qc)
   {
      var _loc4_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < qc.arrayOfQuizes.length)
      {
         _loc4_.push(com.poptropica.models.vo.dailyPopVO.challenges.QuizeVO(qc.arrayOfQuizes[_loc2_]).id);
         _loc2_ = _loc2_ + 1;
      }
      var _loc5_ = new com.poptropica.models.proxy.dailyPop.challenges.QuizResultProxy();
      _loc5_.loadData(com.poptropica.util.EventDelegate.create(this,this.onQuizResultsLoaded),_loc4_);
   }
   function onQuizResultsLoaded(pData)
   {
      var _loc2_ = this._popModel.getChallengesVO().quizesCollectionHolder.getQuizeCollectionByType(this._quizCollectionType);
      _loc2_.setResultCollection(pData);
      this._popModel.notifyQuizesWithResultsLoaded();
   }
   function onQuizesDataLoaded(pData)
   {
      var _loc2_ = this._popModel.getChallengesVO().quizesCollectionHolder.getQuizeCollectionByType(this._quizCollectionType);
      _loc2_.setCollection(pData);
      this.getQuizesResult(_loc2_);
   }
}
