class com.poptropica.controllers.commands.GetAdCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _testDataPath;
   var _override_island;
   var _override_offmain;
   var _island;
   var _cappedAds;
   var _type = "Standard";
   var _version = 2;
   static var local = false;
   function GetAdCommand()
   {
      super();
      com.poptropica.util.Debug.trace("GetAdCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function get type()
   {
      return this._type;
   }
   function set type(p)
   {
      this._type = p;
   }
   function get version()
   {
      return this._version;
   }
   function set version(p)
   {
      this._version = p;
   }
   function get testDataPath()
   {
      return this._testDataPath;
   }
   function set testDataPath(p)
   {
      this._testDataPath = p;
   }
   function get override_island()
   {
      return this._override_island;
   }
   function set override_island(p)
   {
      this._override_island = p;
   }
   function get override_offmain()
   {
      return this._override_offmain;
   }
   function set override_offmain(p)
   {
      this._override_offmain = p;
   }
   function exec(offMainVal)
   {
      com.poptropica.util.Debug.trace("GetAdCommand::exec() type : " + this._type,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc3_ = com.poptropica.models.PopModel.getInstance();
      this._island = _loc3_.island;
      if(this._override_island != undefined)
      {
         this._island = this._override_island;
      }
      if(this._island.indexOf("Common") != -1)
      {
         this._island = _loc3_.camera.scene.char.avatar.FunBrain_so.data.lastIsland;
      }
      var _loc7_ = _loc3_.roomName;
      var _loc4_ = _loc7_ != "Main Street" ? 1 : 0;
      if(this._override_offmain != undefined)
      {
         _loc4_ = this._override_offmain;
      }
      if(offMainVal != undefined)
      {
         trace("wrapper forced to offmain: " + offMainVal);
         _loc4_ = offMainVal;
      }
      if(this._island == "Home" || this._island == "Friends" || this._island == "Party" && this._type != "Wrapper")
      {
         var _loc6_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR);
         _loc6_._message = "Error retrieving campaign : Invalid Island";
         this.dispatchEvent(_loc6_);
         return undefined;
      }
      var _loc5_ = _loc3_.getCampaignInfo(this._type,this._island,_loc4_);
      var _loc2_ = SharedObject.getLocal("campaignData","/");
      com.poptropica.util.Debug.trace("GetAdCommand checking saved data : " + _loc5_ + " args : " + [this._type,this._island,_loc4_],com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._cappedAds = this.getCappedCampaigns();
      if(_loc5_ != null)
      {
         this.notifyCommandComplete(_loc5_);
      }
      else if(!com.poptropica.controllers.commands.GetAdCommand.local)
      {
         if(_loc2_.data.islands[this._island] == undefined)
         {
            if(_loc2_.data.islands == undefined)
            {
               _loc2_.data.islands = [];
            }
            _loc2_.data.islands[this._island] = true;
            _loc2_.flush();
         }
         this.loadAd();
      }
      else
      {
         _loc6_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR);
         _loc6_._message = "Error retrieving campaign : Invalid campaign data";
         this.dispatchEvent(_loc6_);
      }
   }
   function getCappedCampaigns()
   {
      var _loc12_ = SharedObject.getLocal("campaignData","/");
      var _loc7_ = [];
      var _loc9_ = [];
      var _loc8_ = _loc12_.data.campaigns;
      var _loc13_ = _loc8_.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc13_)
      {
         if(_loc8_[_loc3_].type == "caps")
         {
            if(_loc8_[_loc3_].oldtype == this._type || this._type == "All")
            {
               _loc7_.push(_loc8_[_loc3_].campaign.campaign_name);
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      if(_loc7_.length != 0)
      {
         trace("GetAdCommand:: The following " + this._type + " ads have reached their caps: " + _loc7_);
      }
      _loc3_ = 0;
      while(_loc3_ < _loc13_)
      {
         if(_loc8_[_loc3_].type == this._type || this._type == "All")
         {
            var _loc2_ = _loc8_[_loc3_].campaign;
            if(_loc2_.frequency_cap_count != null && _loc2_.frequency_cap_count != undefined)
            {
               if(_loc2_.frequency_cap_num_visits == _loc2_.frequency_cap_count)
               {
                  var _loc10_ = false;
                  for(var _loc5_ in _loc7_)
                  {
                     if(_loc7_[_loc5_] == _loc2_.campaign_name)
                     {
                        _loc10_ = true;
                        break;
                     }
                  }
                  var _loc11_ = false;
                  for(_loc5_ in _loc9_)
                  {
                     if(_loc9_[_loc5_] == _loc2_.campaign_name)
                     {
                        _loc11_ = true;
                        break;
                     }
                  }
                  if(!_loc10_ && !_loc11_)
                  {
                     var _loc4_ = new Object();
                     _loc4_.campaign_name = _loc2_.campaign_name;
                     _loc4_.frequency_cap_period = _loc2_.frequency_cap_period;
                     _loc4_.frequency_cap_count = _loc2_.frequency_cap_count;
                     _loc4_.frequency_cap_num_visits = _loc2_.frequency_cap_count;
                     _loc4_.frequency_cap_first_visit = _loc2_.frequency_cap_first_visit;
                     var _loc6_ = new Object();
                     _loc6_.type = "caps";
                     _loc6_.oldtype = this._type;
                     _loc6_.campaign = _loc4_;
                     _loc12_.data.campaigns.push(_loc6_);
                     _loc9_.push(_loc2_.campaign_name);
                     _loc12_.flush();
                     trace("GetAdCommand:: The following " + this._type + " ad has just reached its cap: " + _loc2_.campaign_name);
                  }
               }
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc7_;
   }
   function loadAd()
   {
      var _loc6_ = com.poptropica.models.PopModel.getInstance();
      var _loc11_ = _loc6_.poptropica_user;
      var _loc9_ = [this._type];
      var _loc10_ = "/get_campaign_list.php";
      var _loc3_ = new LoadVars();
      var _loc7_ = new LoadVars();
      var _loc5_ = _loc11_.age;
      var _loc2_ = _loc11_.gender;
      if(this._type == "All")
      {
         _loc9_ = com.poptropica.models.AdCampaignType.all();
      }
      if(_loc5_ == undefined)
      {
         var _loc8_ = SharedObject.getLocal("Char","/");
         _loc5_ = _loc8_.data.age;
         _loc2_ = _loc8_.data.gender;
      }
      if(_loc2_ == 0)
      {
         _loc2_ = "F";
      }
      if(_loc2_ == 1)
      {
         _loc2_ = "M";
      }
      com.poptropica.util.Debug.trace("GetAdCommand:: loadAd() type : " + this._type + " gender : " + _loc2_,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      _loc7_.onLoad = Delegate.create(this,this.parseAdData,_loc7_);
      utils.ArrayUtils.convertArrayToURLEncoding(_loc9_,"types",_loc3_);
      _loc3_.age = _loc5_;
      _loc3_.gender = _loc2_;
      var _loc4_ = this._island;
      if(_loc6_.desc == "GlobalAS3Embassy")
      {
         _loc4_ = _loc4_.substr(0,1).toUpperCase() + _loc4_.substr(1) + "_as3";
         trace("pulling CMS data for AS3 island: " + _loc4_);
      }
      _loc3_.island = _loc4_;
      utils.ArrayUtils.convertArrayToURLEncoding(this._cappedAds,"exclude",_loc3_);
      if(this._testDataPath != undefined && _loc6_.isTestMode)
      {
         _loc10_ = this._testDataPath;
      }
      _loc3_.sendAndLoad(_loc10_,_loc7_,"POST");
   }
   function notifyCommandComplete(pInfoObj)
   {
      com.poptropica.util.Debug.trace("GetAdCommand:: notifyCommandComplete() type : " + this._type,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE);
      _loc2_._data = pInfoObj;
      this.dispatchEvent(_loc2_);
   }
   function parseAdData(success, data)
   {
      if(success)
      {
         com.poptropica.util.Debug.trace("GetAdCommand:: data retrieved()" + data.on_main_json + " / " + data.off_main_json,com.poptropica.util.Debug.VERBOSE_MESSAGE);
         if(data.on_main_json != undefined)
         {
            this.parseJson(data.on_main_json,0);
         }
         if(data.off_main_json != undefined)
         {
            this.parseJson(data.off_main_json,1);
         }
         if(data.on_main_json == undefined && data.off_main_json == undefined)
         {
            var _loc3_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR);
            _loc3_._message = "GetAdCommand:: Error retrieving campaign : Invalid campaign data";
            this.dispatchEvent(_loc3_);
         }
         else
         {
            var _loc5_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE);
            this.dispatchEvent(_loc5_);
         }
      }
      else
      {
         var _loc4_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR);
         _loc4_._message = "GetAdCommand:: Error retrieving campaign : Failed onLoad for get campaign call";
         this.dispatchEvent(_loc4_);
      }
   }
   function saveAdData(type, data, island, offMain)
   {
      var _loc3_ = com.poptropica.models.PopModel.getInstance();
      var _loc4_ = new com.poptropica.models.vo.AdvertisementVO(data.campaign_name,data.click_through_URL,data.impression_URL,data.campaign_file1,data.campaign_file2,data.campaign_cap_count,data.campaign_cap_period,data.campaign_repeat_spacing,0,null);
      trace("GetAdCommand:: saving ad: " + type + ", " + data.campaign_name);
      _loc3_.saveCampaignInfo(_loc4_,type,island,offMain);
      if(type == this.type)
      {
         var _loc5_ = _loc3_.roomName;
         var _loc6_ = _loc5_ != "Main Street" ? 1 : 0;
         if(_loc6_ == offMain)
         {
            this.notifyCommandComplete(_loc4_);
         }
      }
   }
   function parseJson(json, offMain)
   {
      var _loc5_ = new JSON();
      var _loc2_ = _loc5_.parse(json);
      for(var _loc3_ in _loc2_)
      {
         this.saveAdData(_loc3_,_loc2_[_loc3_],this._island,offMain);
      }
   }
}
