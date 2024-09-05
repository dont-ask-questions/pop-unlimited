class com.poptropica.models.vo.profile.StatusItemVO
{
   var _id;
   var _msg;
   function StatusItemVO(id, msg)
   {
      this._id = id;
      this._msg = msg;
   }
   function get id()
   {
      return this._id;
   }
   function get msg()
   {
      return this._msg;
   }
}
