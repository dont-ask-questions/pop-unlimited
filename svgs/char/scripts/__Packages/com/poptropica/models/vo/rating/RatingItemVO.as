class com.poptropica.models.vo.rating.RatingItemVO
{
   var _id;
   var _rating;
   function RatingItemVO(pId, pRating)
   {
      this._id = pId;
      this._rating = pRating;
   }
   function get id()
   {
      return this._id;
   }
   function get rating()
   {
      return this._rating;
   }
}
