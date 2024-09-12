class com.poptropica.models.vo.dailyPopVO.GameDetailsVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _personal;
   var _jsonObject;
   var _today;
   var _week;
   var _month;
   var _year;
   var _all_time;
   function GameDetailsVO(pJsonData)
   {
      super(pJsonData);
   }
   function parseData()
   {
      this._personal = new com.poptropica.models.vo.dailyPopVO.HighscoreVO(Number(this._jsonObject.personal_highscore.highscore),undefined,undefined);
      this._today = new com.poptropica.models.vo.dailyPopVO.HighscoreVO(Number(this._jsonObject.daily_highscore.highscore),String(this._jsonObject.daily_highscore.name),String(this._jsonObject.daily_highscore.look).split(","));
      this._week = new com.poptropica.models.vo.dailyPopVO.HighscoreVO(Number(this._jsonObject.weekly_highscore.highscore),String(this._jsonObject.weekly_highscore.name),String(this._jsonObject.weekly_highscore.look).split(","));
      this._month = new com.poptropica.models.vo.dailyPopVO.HighscoreVO(Number(this._jsonObject.monthly_highscore.highscore),String(this._jsonObject.monthly_highscore.name),String(this._jsonObject.monthly_highscore.look).split(","));
      this._year = new com.poptropica.models.vo.dailyPopVO.HighscoreVO(Number(this._jsonObject.yearly_highscore.highscore),String(this._jsonObject.yearly_highscore.name),String(this._jsonObject.yearly_highscore.look).split(","));
      this._all_time = new com.poptropica.models.vo.dailyPopVO.HighscoreVO(Number(this._jsonObject.all_time_highscore.highscore),String(this._jsonObject.all_time_highscore.name),String(this._jsonObject.all_time_highscore.look).split(","));
   }
   function get personal()
   {
      return this._personal;
   }
   function get today()
   {
      return this._today;
   }
   function get week()
   {
      return this._week;
   }
   function get month()
   {
      return this._month;
   }
   function get year()
   {
      return this._year;
   }
   function get all_time()
   {
      return this._all_time;
   }
   function set personal(value)
   {
      this._personal = value;
   }
   function set today(value)
   {
      this._today = value;
   }
   function set week(value)
   {
      this._week = value;
   }
   function set month(value)
   {
      this._month = value;
   }
   function set all_time(value)
   {
      this._all_time = value;
   }
   function set year(value)
   {
      this._year = value;
   }
}
