class com.poptropica.models.AdCampaignType
{
   static var MAIN_STREET = "Main Street";
   static var BILLBOARD = "Billboard";
   static var WRAPPER = "Wrapper";
   static var AUTOCARD = "AutoCard";
   static var HOME_CAROUSEL = "Home Page Carousel";
   static var HOME_SMALL_PROMO = "Home Page Small Promo";
   static var COMICS_INDEX = "Comics Index";
   static var COMICS_VIEWER = "Comics Viewer";
   static var GAMES_INDEX = "Games Index";
   static var LOGOUT = "Logout";
   static var NPC_FRIEND = "NPC Friend";
   static var VENDOR_CART = "Vendor Cart";
   function AdCampaignType()
   {
   }
   static function all()
   {
      return [com.poptropica.models.AdCampaignType.MAIN_STREET,com.poptropica.models.AdCampaignType.BILLBOARD,com.poptropica.models.AdCampaignType.WRAPPER,com.poptropica.models.AdCampaignType.AUTOCARD,com.poptropica.models.AdCampaignType.HOME_SMALL_PROMO,com.poptropica.models.AdCampaignType.HOME_CAROUSEL,com.poptropica.models.AdCampaignType.COMICS_INDEX,com.poptropica.models.AdCampaignType.COMICS_VIEWER,com.poptropica.models.AdCampaignType.GAMES_INDEX,com.poptropica.models.AdCampaignType.LOGOUT,com.poptropica.models.AdCampaignType.NPC_FRIEND,com.poptropica.models.AdCampaignType.VENDOR_CART];
   }
}
