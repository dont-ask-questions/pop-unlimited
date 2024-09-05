class com.poptropica.models.vo.dailyPopVO.SneakPeeksVO
{
   var _id;
   var _creatorId;
   var _creatorClipTypeId;
   var _xmlPath;
   function SneakPeeksVO(pId, pCreatorId, pCreatorClipTypeId, pXmlPath)
   {
      this._id = pId;
      this._creatorId = pCreatorId;
      this._creatorClipTypeId = pCreatorClipTypeId;
      this._xmlPath = pXmlPath;
   }
   function get id()
   {
      return this._id;
   }
   function get xmlPath()
   {
      return this._xmlPath;
   }
   function get creatorId()
   {
      return this._creatorId;
   }
   function get creatorClipTypeId()
   {
      return this._creatorClipTypeId;
   }
}
