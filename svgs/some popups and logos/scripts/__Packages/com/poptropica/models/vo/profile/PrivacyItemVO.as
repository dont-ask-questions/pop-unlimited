class com.poptropica.models.vo.profile.PrivacyItemVO
{
   var _id;
   var _name;
   function PrivacyItemVO(id, name)
   {
      this._id = id;
      this._name = name;
   }
   function get id()
   {
      return this._id;
   }
   function get name()
   {
      return this._name;
   }
}
