class com.poptropica.models.vo.dailyPopVO.challenges.QuizeVO
{
   var _id;
   var _typeID;
   var _xmlPath;
   function QuizeVO(pId, pTypeId, pXmlPath)
   {
      this._id = pId;
      this._typeID = pTypeId;
      this._xmlPath = pXmlPath;
   }
   function get id()
   {
      return this._id;
   }
   function get typeID()
   {
      return this._typeID;
   }
   function get xmlPath()
   {
      return this._xmlPath;
   }
}
