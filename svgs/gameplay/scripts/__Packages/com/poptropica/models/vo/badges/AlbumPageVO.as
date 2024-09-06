class com.poptropica.models.vo.badges.AlbumPageVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _listSets;
   var _albumName;
   var _jsonObject;
   var _totalSets;
   function AlbumPageVO(jsonData)
   {
      super(jsonData);
   }
   function parseData()
   {
      this._listSets = new Array();
      this._albumName = this._jsonObject.album_name;
      this._totalSets = this._jsonObject.total_sets;
      var _loc3_ = this._jsonObject.sets;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this._listSets.push(new com.poptropica.models.vo.badges.SetsVO(_loc3_[_loc2_].id,_loc3_[_loc2_].name,_loc3_[_loc2_].badges));
         _loc2_ = _loc2_ + 1;
      }
   }
   function get albumName()
   {
      return this._albumName;
   }
   function get totalSets()
   {
      return this._totalSets;
   }
   function get listSets()
   {
      return this._listSets;
   }
}
