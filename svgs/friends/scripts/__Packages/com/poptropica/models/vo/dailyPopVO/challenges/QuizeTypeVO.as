class com.poptropica.models.vo.dailyPopVO.challenges.QuizeTypeVO
{
   var _id;
   var _name;
   var _thumbnailPath;
   var _enginePath;
   var _totalCount;
   function QuizeTypeVO(pId, pName, pThumbnailPath, pEnginePath, pTotalCount)
   {
      this._id = pId;
      this._name = pName;
      this._thumbnailPath = pThumbnailPath;
      this._enginePath = pEnginePath;
      this._totalCount = Number(pTotalCount);
   }
   function get id()
   {
      return this._id;
   }
   function get name()
   {
      return this._name;
   }
   function get thumbnailPath()
   {
      return this._thumbnailPath;
   }
   function get enginePath()
   {
      return this._enginePath;
   }
   function get totalCount()
   {
      return this._totalCount;
   }
}
