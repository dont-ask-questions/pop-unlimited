class com.poptropica.models.vo.ComicViewerVO
{
   var _comicStreamName;
   var _id;
   var _listComicStrip;
   function ComicViewerVO(comicStreamName, id)
   {
      this._comicStreamName = comicStreamName;
      this._id = id;
      this._listComicStrip = new Array();
   }
   function get comicStreamName()
   {
      return this._comicStreamName;
   }
   function get listComicStrip()
   {
      return this._listComicStrip;
   }
   function set listComicStrip(value)
   {
      this._listComicStrip = value;
   }
   function get id()
   {
      return this._id;
   }
}
