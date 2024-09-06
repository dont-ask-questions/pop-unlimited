class com.poptropica.controllers.commands.GetLocalAdDataCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _xmlLoader;
   var _path = "localCampaigns.xml";
   function GetLocalAdDataCommand()
   {
      super();
      this._xmlLoader = new com.poptropica.util.XmlLoader();
      this._xmlLoader.addEventListener("Loaded",Delegate.create(this,this.loaded));
   }
   function exec()
   {
      this._xmlLoader.load(this._path);
   }
   function loaded(event)
   {
      this.parse();
      this.dispatchEvent({type:"Loaded"});
   }
   function parse()
   {
      var _loc5_ = this._xmlLoader.xml;
      var _loc2_ = _loc5_.firstChild.childNodes;
      var _loc3_ = undefined;
      for(var _loc4_ in _loc2_)
      {
         _loc3_ = _loc2_[_loc4_];
         this.addCampaign(_loc3_);
      }
   }
   function addCampaign(campaign)
   {
      var _loc5_ = campaign.childNodes;
      var _loc3_ = undefined;
      var _loc4_ = undefined;
      var _loc6_ = undefined;
      var _loc11_ = undefined;
      var _loc1_ = new Object();
      for(var _loc8_ in _loc5_)
      {
         _loc3_ = _loc5_[_loc8_];
         _loc1_[_loc3_.nodeName] = _loc3_.firstChild.nodeValue;
      }
      if(_loc1_.type == com.poptropica.models.AdCampaignType.WRAPPER)
      {
         _loc1_.file1 = "images/" + _loc1_.file1;
         _loc1_.file2 = "images/" + _loc1_.file2;
      }
      else if(_loc1_.type == com.poptropica.models.AdCampaignType.MAIN_STREET || _loc1_.type == com.poptropica.models.AdCampaignType.BILLBOARD)
      {
         _loc1_.file1 = "ads/" + _loc1_.file1;
      }
      var _loc7_ = SharedObject.getLocal("Char","/");
      var _loc10_ = true;
      if(!utils.Utils.isNull(_loc7_.data.age) && !utils.Utils.isNull(_loc7_.data.gender))
      {
         if(_loc7_.data.age < _loc1_.minAge || _loc7_.data.age > _loc1_.maxAge)
         {
            _loc10_ = false;
         }
         if(_loc7_.data.gender == 0 && _loc1_.gender == "male" || _loc7_.data.gender == 1 && _loc1_.gender == "female")
         {
            _loc10_ = false;
         }
      }
      if(_loc10_)
      {
         _loc11_ = String(_loc1_.islands);
         _loc11_ = utils.Utils.removeSpaces(_loc11_);
         _loc6_ = _loc11_.split(",");
         for(var _loc9_ in _loc6_)
         {
            _loc4_ = new com.poptropica.models.vo.AdvertisementVO(_loc1_.name,_loc1_.clickURL,_loc1_.impressionURL,_loc1_.file1,_loc1_.file2);
            var _loc2_ = Number(_loc1_.onMain);
            if(_loc2_ == 0)
            {
               _loc2_ = 1;
            }
            else
            {
               _loc2_ = 0;
            }
            com.poptropica.models.PopModel.getInstance().saveCampaignInfo(_loc4_,String(_loc1_.type),String(_loc6_[_loc9_]),_loc2_);
         }
      }
   }
}
