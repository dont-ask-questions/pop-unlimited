class com.poptropica.models.vo.rating.RatingVO extends com.poptropica.models.vo.supportClasses.VOBase
{
   var _arrayOfRatings;
   var _jsonObject;
   function RatingVO(pJsonData)
   {
      super(pJsonData);
   }
   function parseData()
   {
      this._arrayOfRatings = new Array();
      for(var _loc2_ in this._jsonObject)
      {
         this._arrayOfRatings.push(new com.poptropica.models.vo.rating.RatingItemVO(_loc2_,this._jsonObject[_loc2_]));
      }
   }
   function get arrayOfRatings()
   {
      return this._arrayOfRatings;
   }
}
