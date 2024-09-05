class com.poptropica.sections.friendsHub.FriendsViewCounter
{
   function FriendsViewCounter()
   {
   }
   static function startNewCounter(name)
   {
      var _loc1_ = SharedObject.getLocal("Char","/");
      _loc1_.data[name] = 0;
      _loc1_.flush();
      false;
   }
   static function incrementCounter(name)
   {
      var _loc1_ = SharedObject.getLocal("Char","/");
      var _loc2_ = int(_loc1_.data[name]);
      _loc1_.data[name] = _loc2_ + 1;
      _loc1_.flush();
      false;
   }
   static function sendCounterToServer(name, _login, _pass, _dbid)
   {
      if(name != "hub" && name != "friend_profile")
      {
         trace("This is not a valid view_type");
         return undefined;
      }
      var _loc3_ = SharedObject.getLocal("Char","/");
      var _loc2_ = int(_loc3_.data[name]);
      var _loc1_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            com.poptropica.sections.friendsHub.FriendsViewCounter.startNewCounter(name);
         }
      };
      _loc1_.login = _login;
      _loc1_.pass_hash = _pass;
      _loc1_.dbid = _dbid;
      _loc1_.view_type = name;
      _loc1_.view_count = _loc2_;
      if(_loc2_ > 0)
      {
         _loc1_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/views/add_view_count.php",receiver,"POST");
      }
   }
}
