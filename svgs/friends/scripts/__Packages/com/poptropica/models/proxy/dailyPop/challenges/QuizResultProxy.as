class com.poptropica.models.proxy.dailyPop.challenges.QuizResultProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function QuizResultProxy()
   {
      super();
      this._errorMessage = "QuizResultProxy::(), ERROR LOADING QUIZES RESULT";
   }
   function loadData(pCallBackFunction, pArrayQuizIDs)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.username = this._model.poptropica_user.login;
      this._sender.passhash = this._model.password_hash;
      this._sender.dbid = this._model.db_id;
      var _loc3_ = 0;
      while(_loc3_ < pArrayQuizIDs.length)
      {
         this._sender["quizids[" + _loc3_ + "]"] = pArrayQuizIDs[_loc3_];
         _loc3_ = _loc3_ + 1;
      }
      super.doConnect("quizzes/get_user_quiz_results.php");
   }
}
