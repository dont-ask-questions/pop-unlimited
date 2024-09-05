class com.poptropica.models.vo.badges.BadgeVO
{
   var _id;
   var _completed;
   var _name;
   function BadgeVO(id, completed, name)
   {
      this._id = id;
      this._completed = completed;
      this._name = name;
   }
   function get id()
   {
      return this._id;
   }
   function get completed()
   {
      return this._completed;
   }
   function get name()
   {
      return this._name;
   }
}
