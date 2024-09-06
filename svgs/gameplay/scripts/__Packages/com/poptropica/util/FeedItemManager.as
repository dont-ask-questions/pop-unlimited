class com.poptropica.util.FeedItemManager
{
   static var instance;
   function FeedItemManager()
   {
      com.poptropica.util.FeedItemManager.instance = this;
      flash.external.ExternalInterface.call("console.log","Feed Item Manager:");
   }
   static function getInstance()
   {
      if(com.poptropica.util.FeedItemManager.instance == undefined)
      {
         com.poptropica.util.FeedItemManager.instance = new com.poptropica.util.FeedItemManager();
      }
      return com.poptropica.util.FeedItemManager.instance;
   }
   function saveFeedItem(itemNum)
   {
      var _loc2_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
         }
      };
      if(itemNum)
      {
         var _loc3_ = com.poptropica.models.PopModel.getInstance();
         var _loc4_ = _root.scene.char.avatar.getLook();
         _loc2_.login = _loc3_.poptropica_user.login;
         _loc2_.pass_hash = _loc3_.poptropica_user.password_hash;
         _loc2_.dbid = parseInt(_loc3_.db_id);
         _loc2_.look = _loc4_;
         _loc2_.look_item_id = itemNum;
         _loc2_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/feed/save_feed_item.php",receiver,"POST");
      }
      else
      {
         flash.external.ExternalInterface.call("console.log","ERROR Saving Feed Item: You must pass an item number.");
      }
   }
}
