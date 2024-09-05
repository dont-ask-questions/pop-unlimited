class com.poptropica.models.vo.profile.PrivacyVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _currentId;
   var _listItem;
   var _jsonObject;
   function PrivacyVO(jsonData)
   {
      super(jsonData);
   }
   function get currentId()
   {
      return this._currentId;
   }
   function get listItem()
   {
      return this._listItem;
   }
   function parseData()
   {
      this._currentId = this._jsonObject.now;
      this._listItem = new Array();
      var _loc3_ = this._jsonObject.list;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this._listItem.push(new com.poptropica.models.vo.profile.PrivacyItemVO(_loc3_[_loc2_].id,_loc3_[_loc2_].name));
         _loc2_ = _loc2_ + 1;
      }
   }
}
