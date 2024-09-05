class com.poptropica.models.proxy.dailyPop.challenges.SubmitQuizProxy extends com.poptropica.models.proxy.supportClasses.ProxyBase
{
   var _errorMessage;
   var _callBackFunction;
   var _sender;
   var _model;
   function SubmitQuizProxy()
   {
      super();
      this._errorMessage = "SubmitQuiz::(), ERROR SUBMITING QUIZ RESULTS";
   }
   function sendData(pCallBackFunction, pQuizId, pScore, pWinLoss, pTime, pPersonalHighScore)
   {
      this._callBackFunction = pCallBackFunction;
      this._sender.username = this._model.poptropica_user.login;
      this._sender.passhash = this._model.poptropica_user.password_hash;
      this._sender.dbid = this._model.db_id;
      this._sender.quizid = pQuizId;
      this._sender.quiz_score = pScore;
      this._sender.win = pWinLoss;
      if(pPersonalHighScore)
      {
         this._sender.personal_high_score = pPersonalHighScore;
      }
      if(pTime)
      {
         this._sender.quiz_time = pTime;
      }
      super.doConnect("quizzes/submit_quiz.php");
   }
}
