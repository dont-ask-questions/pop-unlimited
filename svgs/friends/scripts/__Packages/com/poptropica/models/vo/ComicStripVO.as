class com.poptropica.models.vo.ComicStripVO
{
   var _id;
   var _path;
   function ComicStripVO(id, path)
   {
      this._id = id;
      this._path = path;
   }
   function get id()
   {
      return this._id;
   }
   function get path()
   {
      return this._path;
   }
}
