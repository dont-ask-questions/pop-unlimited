class com.poptropica.models.vo.PromoCodeResponseVO
{
   var _activated;
   var _errorCode;
   var _errorMessage;
   var _credits;
   var _items;
   var _itemCategories;
   function PromoCodeResponseVO(pActivated, pErrorCode, pErrorMessage, pCredits, pItems, pItemCategories)
   {
      this._activated = pActivated;
      this._errorCode = pErrorCode;
      this._errorMessage = pErrorMessage;
      this._credits = pCredits;
      this._items = pItems;
      this._itemCategories = pItemCategories;
   }
   function get activated()
   {
      return this._activated;
   }
   function get errorCode()
   {
      return this._errorCode;
   }
   function get errorMessage()
   {
      return this._errorMessage;
   }
   function get credits()
   {
      return this._credits;
   }
   function get items()
   {
      return this._items;
   }
   function get itemCategories()
   {
      return this._itemCategories;
   }
}
