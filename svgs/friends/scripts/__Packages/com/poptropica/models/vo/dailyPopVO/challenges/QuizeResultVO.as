class com.poptropica.models.vo.dailyPopVO.challenges.QuizeResultVO
{
   var _id;
   var _score;
   var _result;
   var _time;
   function QuizeResultVO(id, qscore, qresult, time)
   {
      this._id = id;
      this._score = qscore;
      this._result = qresult;
      this._time = time;
   }
   function get id()
   {
      return this._id;
   }
   function get quizScore()
   {
      return this._score;
   }
   function get quizResult()
   {
      return this._result;
   }
   function get time()
   {
      return this._time;
   }
}
