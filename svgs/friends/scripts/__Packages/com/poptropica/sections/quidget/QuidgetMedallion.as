class com.poptropica.sections.quidget.QuidgetMedallion extends com.poptropica.sections.quidget.QuidgetBase
{
   var _medalName;
   var _medalFullName;
   var _timesCompleted;
   var _rank;
   var _asset;
   function QuidgetMedallion()
   {
      super();
   }
   function init(o)
   {
      trace(o);
      this._medalName = o.island_name;
      this._medalFullName = o.island_full_name;
      if(this._medalName == "Carrot" && o.id == 1035)
      {
         this._medalName = "Carrot_as3";
         this._medalFullName = "24 Carrot Island Beta";
      }
      trace("medalname: " + this._medalName);
      trace("rank: " + o.rank);
      trace("count: " + o.count);
      if(o.count)
      {
         this._timesCompleted = o.count;
      }
      else
      {
         this._timesCompleted = 1;
         if(this._medalName.indexOf("_as3") == -1)
         {
            this.sendIslandCompleteCall(this._medalName);
         }
      }
      if(o.rank)
      {
         this._rank = o.rank;
      }
      this.loadQuidgetSwf();
   }
   function sendIslandCompleteCall(island)
   {
      com.poptropica.models.PopModelConst._avatar.sendFinishedIsland(island);
   }
   function onAssetLoadInit(mc)
   {
      this.setEditable(false);
      this.draw();
      this.dispatchLoadComplete();
   }
   function draw()
   {
      var _loc2_ = undefined;
      if(this._rank && this._medalName == "virusHunter" && this._rank < 1001)
      {
         _loc2_ = this._asset.contentContainer.content.attachMovie("medallionTopFinishersQuidgetAsset","medallionQuidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      }
      else
      {
         _loc2_ = this._asset.contentContainer.content.attachMovie("medallionQuidgetAsset","medallionQuidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      }
      if(_loc2_ == undefined)
      {
         trace("[QuidgetMedallion] ERROR: symbol medallionQuidgetAsset not found in medaalion_quidget_assets!!!");
      }
      else
      {
         var _loc4_ = this._medalName + "Medal";
         var _loc3_ = _loc2_.medalContainer.attachMovie(_loc4_,"medal",_loc2_.medalContainer.getNextHighestDepth());
         _loc3_.gotoAndStop(2);
         if(this._rank && this._medalName == "virusHunter" && this._rank < 1001)
         {
            _loc2_.mcNumberBox.tf.text = "#" + this._rank;
         }
         else
         {
            _loc2_.mcNumberBox._visible = this._timesCompleted >= 2;
            _loc2_.mcNumberBox.tf.text = this._timesCompleted != "undefined" ? String(this._timesCompleted) : "1";
         }
         if(_loc3_ == undefined)
         {
            trace("[QuidgetMedallion] ERROR: medallion " + _loc4_ + " not found in medallion_quidget_assets.swf");
         }
         _loc3_._xscale = _loc3_._yscale = 83.76068376068376;
      }
   }
   function isAccomplishment()
   {
      return true;
   }
   function isPersonality()
   {
      return false;
   }
   function get name()
   {
      return "medallion";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      if(this._rank && this._medalName == "virusHunter" && this._rank < 1001)
      {
         _loc2_ += " finished " + this._medalFullName + " #" + this._rank + " overall.";
      }
      else
      {
         _loc2_ += " completed " + this._medalFullName;
         if(this._timesCompleted > 1)
         {
            _loc2_ += " " + this._timesCompleted + " times";
         }
         _loc2_ += ".";
      }
      return _loc2_;
   }
}
