class com.poptropica.models.vo.badges.SetsVO
{
   var _id;
   var _name;
   var _listBadge;
   function SetsVO(id, name, jsonListBadge)
   {
      this._id = id;
      this._name = name;
      this.initListBadge(jsonListBadge);
   }
   function initListBadge(jsonData)
   {
      this._listBadge = new Array();
      var _loc2_ = 0;
      while(_loc2_ < jsonData.length)
      {
         this._listBadge.push(new com.poptropica.models.vo.badges.BadgeVO(jsonData[_loc2_].id,jsonData[_loc2_].completed));
         _loc2_ = _loc2_ + 1;
      }
   }
   function get id()
   {
      return this._id;
   }
   function get name()
   {
      return this._name;
   }
   function get listBadge()
   {
      return this._listBadge;
   }
}
