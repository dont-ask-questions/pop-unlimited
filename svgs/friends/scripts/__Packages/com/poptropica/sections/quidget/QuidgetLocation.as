class com.poptropica.sections.quidget.QuidgetLocation extends com.poptropica.sections.quidget.QuidgetBase
{
   var _stateDataArr;
   var _stateCodeToNameHash;
   var _locationData;
   var _newLocationData;
   var _flashIconThisTime;
   var _countryCodeLoadVars;
   var _countryDataArr;
   var _countryCodeToNameHash;
   var _asset;
   var _quidgetAsset;
   var _popup;
   var _dropDown;
   var _dropDownState;
   var _phpResults;
   function QuidgetLocation()
   {
      super();
      trace("[QuidgetLocation] Constructor");
      var _loc8_ = "Alabama,AL|Alaska,AK|Arizona,AZ|Arkansas,AR|California,CA|Colorado,CO|Connecticut,CT|Delaware,DE|D.C.,DC|Florida,FL|Georgia,GA|Hawaii,HI|Idaho,ID|Illinois,IL|Indiana,IN|Iowa,IA|Kansas,KS|Kentucky,KY|Louisiana,LA|Maine,ME|Maryland,MD|Massachusetts,MA|Michigan,MI|Minnesota,MN|Mississippi,MS|Missouri,MO|Montana,MT|Nebraska,NE|Nevada,NV|New Hampshire,NH|New Jersey,NJ|New Mexico,NM|New York,NY|North Carolina,NC|North Dakota,ND|Ohio,OH|Oklahoma,OK|Oregon,OR|Pennsylvania,PA|Rhode Island,RI|South Carolina,SC|South Dakota,SD|Tennessee,TN|Texas,TX|Utah,UT|Vermont,VT|Virginia,VA|Washington,WA|West Virginia,WV|Wisconsin,WI|Wyoming,WY";
      _loc8_ += "|American Samoa,AS|Federated States of Micronesia,FM|Guam,GU|Marshall Islands,MH|Northern Mariana Islands,MP|Palau,PW|Puerto Rico,PR|U.S. Minor Outlying Islands,UM|U.S. Virgin Islands,VI";
      var _loc5_ = _loc8_.split("|");
      this._stateDataArr = [];
      this._stateCodeToNameHash = {};
      var _loc4_ = 0;
      while(_loc4_ < _loc5_.length)
      {
         var _loc3_ = _loc5_[_loc4_].split(",");
         this._stateDataArr.push({label:_loc3_[0],val:_loc3_[1]});
         this._stateCodeToNameHash[_loc3_[1]] = _loc3_[0];
         _loc4_ = _loc4_ + 1;
      }
   }
   function init(d)
   {
      var _loc3_ = _root.getPrefix() + "/images/flags/flag-index.txt";
      if(_root._url.indexOf("file://") != -1)
      {
         _loc3_ = "images/flags/flag-index.txt";
      }
      this._locationData = {countryCode:d.country_code,stateCode:d.state_code};
      this._newLocationData = {};
      this._flashIconThisTime = false;
      this._countryCodeLoadVars = new LoadVars();
      this._countryCodeLoadVars.onLoad = Delegate.create(this,this.onCountryCodeTxtLoaded);
      trace("[QuidgetLocation] flag list url:" + _loc3_);
      this._countryCodeLoadVars.load(_loc3_);
      this.loadQuidgetSwf();
   }
   function onCountryCodeTxtLoaded(success)
   {
      if(success)
      {
         var _loc7_ = unescape(this._countryCodeLoadVars.cc);
         var _loc4_ = _loc7_.split("\n");
         this._countryDataArr = [];
         this._countryCodeToNameHash = {};
         var _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            var _loc2_ = _loc4_[_loc3_].split("|");
            if(_loc2_.length == 2)
            {
               this._countryDataArr.push({label:_loc2_[0],val:_loc2_[1]});
               this._countryCodeToNameHash[_loc2_[1]] = _loc2_[0];
            }
            _loc3_ = _loc3_ + 1;
         }
         this._countryDataArr.sortOn("label");
      }
      else
      {
         trace("-------failure:");
      }
   }
   function onAssetLoadInit(mc)
   {
      trace("[QuidgetCredits] onPopQuizLoadInit. mc:" + mc + "   asset.contentContainer.content:" + this._asset.contentContainer.content);
      this._quidgetAsset = this._asset.contentContainer.content.attachMovie("locationQuidgetAsset","quidgetAsset",this._asset.contentContainer.content.getNextHighestDepth());
      if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         this.setEditable(true);
      }
      this.draw();
      this.dispatchLoadComplete();
   }
   function draw()
   {
      trace("[QuidgetLocation] draw. _locationData.countryCode == -1? " + (this._locationData.countryCode == "-1"));
      trace("[QuidgetLocation] draw. _locationData.stateCode: " + this._locationData.stateCode);
      if(this._locationData.countryCode == "HK")
      {
         this._locationData.countryCode = "CN";
      }
      if(this._locationData.countryCode == "-1" || this._locationData.countryCode == undefined)
      {
         this._quidgetAsset.mcStateBox._visible = false;
      }
      else
      {
         this._quidgetAsset.mcUnanswered._visible = false;
         var _loc2_ = new MovieClipLoader();
         var _loc3_ = this._locationData.countryCode.toLowerCase();
         var _loc4_ = "images/flags/" + _loc3_ + ".jpg";
         _loc2_.loadClip(_loc4_,this._quidgetAsset.mcFlag);
         _loc2_.onLoadInit = Delegate.create(this,this.jpgLoadComplete);
         if(this._locationData.countryCode == "US")
         {
            if(this._locationData.stateCode != -1)
            {
               this._quidgetAsset.mcStateBox._visible = true;
               this._quidgetAsset.mcStateBox.tf.text = this._locationData.stateCode;
            }
            else
            {
               this._quidgetAsset.mcStateBox._visible = false;
            }
         }
         else
         {
            this._quidgetAsset.mcStateBox._visible = false;
            this._locationData.stateCode = "-1";
         }
         this.convertToBitmap();
      }
   }
   function onAssetClick()
   {
      this.checkAsk();
   }
   function checkAsk()
   {
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("popupReady",Delegate.create(this,this.onPopupReady));
      com.poptropica.sections.quidget.PopupManager.getInstance().drawPopupFromClass("locationPopup",new flash.geom.Point(this._x + 60,this._y + 40),"framework/assets/quidgets/location_quidget_assets.swf");
   }
   function onPopupReady(e)
   {
      trace("[QuidgetLocation] popupReady!!!! " + e.popup);
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("popupReady",arguments.caller);
      this._popup = e.popup;
      this._dropDown = new com.poptropica.components.dropDown.DropDownMenu();
      this._dropDown.numVisible = 12;
      this._dropDown.setDropDownMC(this._popup.mcDropDown);
      this._dropDown.addEventListener("itemSelected",com.poptropica.util.EventDelegate.create(this,this.onDropDownItemSelected));
      this._dropDown.addEventListener("itemRollover",com.poptropica.util.EventDelegate.create(this,this.onDropDownMenuItemRollover));
      this._dropDown.initialLabel = "Choose Country...";
      this._dropDown.setData(this._countryDataArr);
      this._dropDown.setItemByValue(this._locationData.countryCode,false);
      this._dropDownState = new com.poptropica.components.dropDown.DropDownMenu();
      this._dropDownState.numVisible = 10;
      this._dropDownState.setDropDownMC(this._popup.mcDropDownState);
      this._dropDownState.addEventListener("itemSelected",com.poptropica.util.EventDelegate.create(this,this.onDropDownStateItemSelected));
      this._dropDownState.addEventListener("itemRollover",com.poptropica.util.EventDelegate.create(this,this.onDropDownStateItemRollover));
      this._dropDownState.initialLabel = "Choose State...";
      this._dropDownState.setData(this._stateDataArr);
      if(this._locationData.countryCode == "US")
      {
         this._dropDownState.setVisible(true);
         trace("[QuidgetLocation] _locationData.stateCode:" + this._locationData.stateCode);
         if(this._locationData.stateCode != undefined)
         {
            this._dropDownState.setItemByValue(this._locationData.stateCode,false);
         }
      }
      else
      {
         this._dropDownState.setVisible(false);
      }
      com.poptropica.sections.quidget.PopupManager.getInstance().addEventListener("closeComplete",Delegate.create(this,this.onPopupClose));
   }
   function onDropDownItemSelected(a)
   {
      trace("[QuidgetLocation] onDropDownItemSelected. countryCode:" + a.selectedItem.val);
      this._newLocationData.countryCode = a.selectedItem.val;
      this._newLocationData.countryName = a.selectedItem.label;
      if(this._newLocationData.countryCode == "US")
      {
         this._dropDownState.setVisible(true);
      }
      else
      {
         this._newLocationData.stateCode = "-1";
         com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
      }
   }
   function onDropDownMenuItemRollover(a)
   {
   }
   function onDropDownStateItemSelected(a)
   {
      trace("[QuidgetLocation] onDropDownItemSelected. stateCode:" + a.selectedItem.val);
      this._newLocationData.stateName = a.selectedItem.label;
      this._newLocationData.stateCode = a.selectedItem.val;
      com.poptropica.sections.quidget.PopupManager.getInstance().closePopup();
   }
   function onDropDownStateItemRollover(a)
   {
   }
   function onPopupClose(callingObj)
   {
      trace("[QuidgetLocation] onPopupClose.");
      com.poptropica.sections.quidget.PopupManager.getInstance().removeEventListener("closeComplete",arguments.caller);
      for(var _loc3_ in this._locationData)
      {
         trace("[QuidgetLocation]  onPopupClose   locationdata." + _loc3_ + " = " + this._locationData[_loc3_]);
      }
      for(_loc3_ in this._newLocationData)
      {
         trace("[QuidgetLocation] onPopupClose     newlocationData." + _loc3_ + " = " + this._newLocationData[_loc3_]);
      }
      if(this._newLocationData.countryCode != undefined || this._newLocationData.stateCode != undefined)
      {
         trace("[QuidgetLocation]     uhhhhhhhhhhh _newLocationData.stateCode != _locationData.stateCode:" + (this._newLocationData.stateCode != this._locationData.stateCode));
         if(this._newLocationData.countryCode != this._locationData.countryCode || this._newLocationData.stateCode != this._locationData.stateCode)
         {
            if(this._newLocationData.countryCode != undefined)
            {
               this._locationData.countryCode = this._newLocationData.countryCode;
               this._locationData.countryName = this._newLocationData.countryName;
            }
            if(this._newLocationData.stateCode != undefined)
            {
               this._locationData.stateCode = this._newLocationData.stateCode;
               this._locationData.stateName = this._newLocationData.stateName;
            }
            this.draw();
            this.saveLocationToServer();
            this._flashIconThisTime = true;
            com.poptropica.sections.friendsHub.Quilt.getInstance().clearCurrentUserCache();
         }
      }
   }
   function saveLocationToServer()
   {
      var _loc4_ = SharedObject.getLocal("Char","/");
      _loc4_.data.countryCode = this._locationData.countryCode;
      _loc4_.data.stateCode = this._locationData.stateCode;
      _loc4_.flush();
      this._phpResults = new LoadVars();
      this._phpResults.onLoad = Delegate.create(this,this.onPhpComplete);
      var _loc5_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/set_user_location.php";
      var _loc2_ = new LoadVars();
      _loc2_.country = this._locationData.countryCode;
      _loc2_.state = this._locationData.stateCode;
      trace("[QuidgetLocation] ------------- set_user_location.php ----------------");
      for(var _loc3_ in _loc2_)
      {
         trace("         [QuidgetLocation]         " + _loc3_ + " :: " + _loc2_[_loc3_]);
      }
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc2_);
      _loc2_.sendAndLoad(_loc5_,this._phpResults,"POST");
   }
   function onPhpComplete()
   {
      trace("[QuidgetLocation] onPhpComplete");
      var _loc2_ = "";
      if(this._locationData.stateCode != -1 && this._locationData.stateCode != undefined)
      {
         _loc2_ = this._locationData.stateCode;
      }
      com.poptropica.controllers.PopController.getInstance().track("Friends","QuidgetAnswered",this._locationData.countryCode,_loc2_,false,"Hub","Location");
   }
   function jpgLoadComplete(target)
   {
      target.forceSmoothing = true;
      var _loc3_ = new flash.display.BitmapData(119,81,true,16777215);
      var _loc2_ = new flash.geom.Matrix();
      _loc2_.scale(0.476,0.525974025974026);
      if(this._flashIconThisTime)
      {
         com.greensock.TweenMax.delayedCall(0.03,this.makeIconFlash,null,this);
      }
      this.convertToBitmap();
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
      return "location";
   }
   function get rolloverString()
   {
      var _loc2_ = undefined;
      if(this._locationData.countryCode != "-1")
      {
         var _loc3_ = "";
         if(this._locationData.countryCode == "US")
         {
            _loc3_ = this._stateCodeToNameHash[this._locationData.stateCode] + ", ";
         }
         _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson;
         _loc2_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? " lives in " : " live in ";
         if(this._locationData.stateCode != "-1")
         {
            _loc2_ += _loc3_;
         }
         _loc2_ += this._countryCodeToNameHash[this._locationData.countryCode];
         _loc2_ += ".";
      }
      else if(com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf)
      {
         _loc2_ = "Where do you live?";
      }
      else
      {
         _loc2_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().identityString1stPerson + " has not set a location yet.";
      }
      return _loc2_;
   }
   function countryCodeToFullName(s)
   {
   }
}
