class com.poptropica.models.vo.badges.AlbumsVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _listAlbum;
   var _completedSets;
   var _jsonObject;
   var _totalBadgesEarned;
   function AlbumsVO(jsonData)
   {
      super(jsonData);
   }
   function parseData()
   {
      this._listAlbum = new Array();
      this._completedSets = this._jsonObject.completed_sets;
      this._totalBadgesEarned = this._jsonObject.total_badges_earned;
      var _loc3_ = this._jsonObject.albums;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this._listAlbum.push(new com.poptropica.models.vo.badges.AlbumsItemVO(_loc3_[_loc2_].id,_loc3_[_loc2_].name,_loc3_[_loc2_].badges_earned));
         _loc2_ = _loc2_ + 1;
      }
   }
   function get completedSets()
   {
      return this._completedSets;
   }
   function get listAlbum()
   {
      return this._listAlbum;
   }
   function get totalBadgesEarned()
   {
      return this._totalBadgesEarned;
   }
}
