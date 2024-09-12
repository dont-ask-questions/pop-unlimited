class com.poptropica.models.vo.badges.BadgeSetVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _listBadge;
   var _albumName;
   var _jsonObject;
   var _name;
   var _description;
   var _soFar;
   var _needed;
   function BadgeSetVO(jsonData)
   {
      super(jsonData);
   }
   function parseData()
   {
      this._listBadge = new Array();
      this._albumName = this._jsonObject.album_name;
      this._name = this._jsonObject.name;
      this._description = this._jsonObject.description;
      this._soFar = this._jsonObject.so_far;
      this._needed = this._jsonObject.needed;
      var _loc3_ = this._jsonObject.badges;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this._listBadge.push(new com.poptropica.models.vo.badges.BadgeVO(_loc3_[_loc2_].id,_loc3_[_loc2_].completed,_loc3_[_loc2_].name));
         _loc2_ = _loc2_ + 1;
      }
   }
   function get albumName()
   {
      return this._albumName;
   }
   function get name()
   {
      return this._name;
   }
   function get description()
   {
      return this._description;
   }
   function get soFar()
   {
      return this._soFar;
   }
   function get needed()
   {
      return this._needed;
   }
   function get listBadge()
   {
      return this._listBadge;
   }
}
