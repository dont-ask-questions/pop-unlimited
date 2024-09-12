class com.poptropica.models.vo.dailyPopVO.GameVO
{
   var _id;
   var _name;
   var _thumbPath;
   var _swfPath;
   var _gameCode;
   var _partner;
   var _width;
   var _height;
   function GameVO(pId, pName, pImgPath, pSwfPath, pGameCode, pPartner, pWidth, pHeight)
   {
      this._id = pId;
      this._name = pName;
      this._thumbPath = pImgPath;
      this._swfPath = pSwfPath;
      this._gameCode = pGameCode;
      this._partner = pPartner;
      this._width = pWidth;
      this._height = pHeight;
   }
   function get id()
   {
      return this._id;
   }
   function get name()
   {
      return this._name;
   }
   function get swfPath()
   {
      return this._swfPath;
   }
   function get thumbPath()
   {
      return this._thumbPath;
   }
   function get gameCode()
   {
      return this._gameCode;
   }
   function get partner()
   {
      return this._partner;
   }
   function get width()
   {
      return this._width;
   }
   function get height()
   {
      return this._height;
   }
}
