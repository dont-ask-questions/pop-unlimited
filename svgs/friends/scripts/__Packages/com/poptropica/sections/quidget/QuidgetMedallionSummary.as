class com.poptropica.sections.quidget.QuidgetMedallionSummary extends com.poptropica.sections.quidget.QuidgetBase
{
   var _numMedals;
   var _islandsCompleted;
   var _json;
   var _asset;
   var _popup;
   var _phpResults;
   var _medallionSummaryDisplay;
   var DELAY_AFTER_CHOICE_MADE = 0.1;
   var X_SPACING = 70;
   var Y_SPACING = 70;
   var MEDALS_PER_ROW = 10;
   var BASE_SCALE = 50;
   var BIG_SCALE = 65;
   function QuidgetMedallionSummary()
   {
      super();
      trace("[QuidgetMedallionSummary] Constructor");
   }
   function init(quidgetData)
   {
      var _loc4_ = com.poptropica.models.PopModelConst.avatar.checkItem(1035,"Carrot_as3");
      trace("here are the island names and completions:");
      for(var _loc3_ in quidgetData.islands)
      {
         trace(_loc3_ + " completed " + quidgetData.islands[_loc3_] + " times");
      }
      this._numMedals = quidgetData.total;
      this._islandsCompleted = quidgetData.islands;
      this._json = new JSON();
      this.loadQuidgetSwf("medallion_quidget_assets.swf");
   }
   function Xinit(o)
   {
      this._numMedals = o.total;
      this._islandsCompleted = o.islands;
      this._json = new JSON();
      trace("QuidgetMedallionSummary::init(): data=" + this._json.stringify(o));
      this._numMedals = 0;
      var _loc3_ = [];
      for(var _loc8_ in o.islands)
      {
         _loc3_.push(_loc8_);
      }
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(-1 < _loc3_[_loc4_].indexOf("_as3"))
         {
            var _loc6_ = this.convertIslandToAS2Format(_loc3_[_loc4_]);
            var _loc5_ = false;
            var _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               if(_loc3_[_loc2_] == _loc6_)
               {
                  _loc5_ = true;
                  break;
               }
               _loc2_ = _loc2_ + 1;
            }
            if(!_loc5_)
            {
               this._numMedals = this._numMedals + 1;
            }
         }
         else
         {
            this._numMedals = this._numMedals + 1;
         }
         _loc4_ = _loc4_ + 1;
      }
      this.loadQuidgetSwf("medallion_quidget_assets.swf");
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetMedallionSummary] onPopQuizLoadInit. ");
      if(this._numMedals > 0)
      {
         this.setEditable(true);
      }
      this.draw();
      this.dispatchLoadComplete();
   }
   function draw()
   {
      trace("[QuidgetMedallionSummary] draw. ");
      var _loc2_ = this._asset.contentContainer.content.attachMovie("medallionQuidgetAsset","quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      _loc2_.mcNumberBox._visible = false;
      _loc2_.medalContainer.attachMovie("summaryMedal","summaryMedal",_loc2_.medalContainer.getNextHighestDepth());
      _loc2_.medalContainer.summaryMedal.tf.text = this._numMedals;
   }
   function onAssetClick()
   {
      this._popup = com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("medallionsPopup",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/medallion_quidget_assets.swf");
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
   }
   function onPopupReady(e)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      this._popup.tf.text = this._numMedals;
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().islandNames == undefined)
      {
         this.loadIslandNames();
      }
      else
      {
         this.drawPopup();
      }
   }
   function loadIslandNames()
   {
      var _loc2_ = new LoadVars();
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc2_);
      this._phpResults = new LoadVars();
      this._phpResults.onLoad = Delegate.create(this,this.onGetIslandsComplete);
      var _loc3_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/get_island_names.php";
      _loc2_.sendAndLoad(_loc3_,this._phpResults,"POST");
   }
   function onGetIslandsComplete()
   {
      var _loc2_ = Array(this._json.parse(this._phpResults.json))[0];
      trace("[QuidgetMedallionSummary] onGetIslandsComplete ");
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().islandNames = Array(this._json.parse(this._phpResults.json))[0];
      this.drawPopup();
   }
   function drawPopup()
   {
      this._popup.mcLoading._visible = false;
      this._medallionSummaryDisplay = new com.poptropica.sections.quidget.MedallionSummaryDisplay();
      this._medallionSummaryDisplay.init(this._popup.medalContainer,this._islandsCompleted);
   }
   function convertIslandToAS2Format(island)
   {
      trace("AS3 Embassy : converting island to as2 format : " + island);
      if(island.indexOf("_as3") > -1)
      {
         island = island.slice(0,island.length - 4);
      }
      return island.substr(0,1).toUpperCase() + island.substr(1);
   }
   function xdrawPopup()
   {
      this._popup.mcLoading._visible = false;
      var _loc2_ = undefined;
      var _loc8_ = undefined;
      var _loc7_ = undefined;
      var _loc6_ = undefined;
      var _loc3_ = undefined;
      var _loc4_ = 0;
      while(_loc4_ < com.poptropica.sections.friendsHub.FriendsModel.getInstance().islandNames.length)
      {
         _loc3_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().islandNames[_loc4_];
         if(_loc3_.name.indexOf("_as3") > -1)
         {
            _loc3_.name = this.convertIslandToAS2Format(_loc3_.name);
         }
         _loc7_ = _loc3_.name + "Medal";
         _loc8_ = "medal" + _loc4_;
         _loc2_ = this._popup.medalContainer.attachMovie("medalContainerForPopup","medal" + _loc4_,this._popup.medalContainer.getNextHighestDepth());
         _loc2_.container.attachMovie(_loc7_,"asset",1);
         if(_loc2_ == undefined)
         {
            trace("ERROR XXXXXXXXXXXX: medal undefined. className:" + _loc7_);
         }
         if(this._islandsCompleted[_loc3_.name])
         {
            _loc6_ = this._islandsCompleted[_loc3_.name];
            if(_loc6_ > 1)
            {
               var _loc5_ = _loc2_.attachMovie("textBubble","textBubble",_loc2_.getNextHighestDepth());
               _loc5_.tf.text = String(_loc6_);
               _loc5_._x = 56;
               _loc5_._y = 90;
            }
         }
         else
         {
            _loc2_.gotoAndStop(2);
         }
         _loc2_._x = _loc4_ % this.MEDALS_PER_ROW * this.X_SPACING;
         _loc2_._y = Math.floor(_loc4_ / this.MEDALS_PER_ROW) * this.Y_SPACING;
         _loc2_.origX = _loc2_._x;
         _loc2_.origY = _loc2_._y;
         _loc2_._xscale = _loc2_._yscale = this.BASE_SCALE;
         _loc2_.island_name = _loc3_.name;
         _loc2_.island_full_name = _loc3_.island_full_name;
         _loc4_ = _loc4_ + 1;
      }
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
   }
   function createRolloverIcons()
   {
   }
   function onPopupClose(callingObj)
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      this.makeIconFlash();
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
      return "medallionSummary";
   }
   function get rolloverString()
   {
      var _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
      _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " has completed " : " have completed ";
      _loc2_ += String(this._numMedals) + " island" + (this._numMedals != 1 ? "s." : ".");
      return _loc2_;
   }
}
