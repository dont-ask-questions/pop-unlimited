class com.poptropica.sections.quidget.QuidgetFriends extends com.poptropica.sections.quidget.QuidgetBase
{
   var _numFriends;
   var _asset;
   var TIERS = [100,500,1000,999999999];
   function QuidgetFriends()
   {
      super();
      trace("[QuidgetFriends] Constructor");
      this.loadQuidgetSwf();
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().addEventListener("numFriendsLoaded",Delegate.create(this,this.onNumFriendsChanged));
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().addEventListener("numFriendsChanged",Delegate.create(this,this.onNumFriendsChanged));
   }
   function init(d)
   {
      this._numFriends = d.count;
      this.checkGetNumFriendsFromLso();
   }
   function checkGetNumFriendsFromLso()
   {
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         var _loc2_ = SharedObject.getLocal("Char","/");
         if(_loc2_.data.numFriends != undefined)
         {
            this._numFriends = _loc2_.data.numFriends;
         }
      }
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetFriends] onAssetLoadInit. _numFriends?:" + this._numFriends);
      this.draw();
   }
   function draw()
   {
      var _loc2_ = 0;
      while(this._numFriends >= this.TIERS[_loc2_])
      {
         _loc2_ = _loc2_ + 1;
      }
      var _loc4_ = "friendsQuidgetAsset" + _loc2_;
      var _loc3_ = this._asset.contentContainer.content.attachMovie(_loc4_,"quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      _loc3_.tf.text = this._numFriends;
      this.setEditable(false);
      this.dispatchLoadComplete();
   }
   function isAccomplishment()
   {
      return false;
   }
   function isPersonality()
   {
      return true;
   }
   function get name()
   {
      return "friends";
   }
   function onNumFriendsChanged(e)
   {
      trace("[QuidgetFriend] onNumFriendsChanged. e.count:" + e.count);
      this.checkGetNumFriendsFromLso();
      this.draw();
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " has " : " have ";
      _loc2_ += this._numFriends + " friend";
      if(this._numFriends != 1)
      {
         _loc2_ += "s";
      }
      _loc2_ += ".";
      return _loc2_;
   }
}
