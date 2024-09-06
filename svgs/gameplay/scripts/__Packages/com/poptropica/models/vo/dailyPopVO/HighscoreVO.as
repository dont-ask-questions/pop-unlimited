class com.poptropica.models.vo.dailyPopVO.HighscoreVO
{
   var _highscore;
   var _name;
   var _look;
   function HighscoreVO(pHighscore, pName, pLook)
   {
      this._highscore = pHighscore;
      this._name = pName;
      this._look = pLook;
   }
   function get highscore()
   {
      return this._highscore;
   }
   function get name()
   {
      return this._name;
   }
   function get look()
   {
      return this._look;
   }
}
