class com.poptropica.controllers.commands.GetConfigXMLCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var _config_xml_path = "framework/data/config.xml";
   function GetConfigXMLCommand()
   {
      super();
      com.poptropica.util.Debug.trace("GetConfigXMLCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function exec()
   {
      com.poptropica.util.Debug.trace("GetConfigXMLCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var me = this;
      var configXML = new XML();
      configXML.ignoreWhite = true;
      configXML.onLoad = function(success)
      {
         if(success)
         {
            me.parseConfig(configXML);
            me.notifyCommandComplete();
         }
         else
         {
            this.notifyCommandError();
         }
      };
      var _loc2_ = com.poptropica.util.PopUtils.getFlashPrefixFromLocalConnection() + this._config_xml_path;
      configXML.load(_loc2_);
   }
   function parseConfig(pXML)
   {
      com.poptropica.util.Debug.trace("GetConfigXMLCommand:: parseConfig()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc5_ = new Array();
      if(pXML.firstChild.hasChildNodes())
      {
         var _loc3_ = pXML.firstChild.firstChild;
         while(_loc3_ != null)
         {
            if(_loc3_.nodeName == "islands")
            {
               var _loc2_ = _loc3_.firstChild;
               while(_loc2_ != null)
               {
                  var _loc4_ = this.extractIsland(_loc2_);
                  _loc5_.push(_loc4_);
                  _loc2_ = _loc2_.nextSibling;
               }
            }
            _loc3_ = _loc3_.nextSibling;
         }
         com.poptropica.models.PopModel.getInstance().islandData = _loc5_;
      }
      else
      {
         this.notifyCommandError();
      }
   }
   function extractIsland(pXML)
   {
      com.poptropica.util.Debug.trace("GetConfigXMLCommand:: extractIsland()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc11_ = undefined;
      var _loc5_ = undefined;
      var _loc9_ = undefined;
      var _loc8_ = undefined;
      var _loc6_ = undefined;
      var _loc7_ = undefined;
      var _loc1_ = pXML.firstChild;
      while(_loc1_ != null)
      {
         if(_loc1_.nodeName == "name")
         {
            _loc5_ = _loc1_.firstChild.nodeValue;
         }
         if(_loc1_.nodeName == "islandMain")
         {
            _loc8_ = _loc1_.firstChild.nodeValue;
         }
         if(_loc1_.nodeName == "clusterName")
         {
            _loc9_ = _loc1_.firstChild.nodeValue;
         }
         if(_loc1_.nodeName == "medallion")
         {
            _loc6_ = Number(_loc1_.firstChild.nodeValue);
         }
         if(_loc1_.nodeName == "init_coords")
         {
            var _loc2_ = _loc1_.firstChild.nodeValue.split(",");
            _loc7_ = {x:Number(_loc2_[0]),y:Number(_loc2_[1])};
         }
         _loc1_ = _loc1_.nextSibling;
      }
      _loc11_ = new com.poptropica.models.vo.IslandVO(_loc5_,_loc9_,_loc8_,_loc6_,_loc7_);
      return _loc11_;
   }
   function notifyCommandError()
   {
      com.poptropica.util.Debug.trace("GetConfigXMLCommand:: notifyCommandError()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_ERROR);
      this.dispatchEvent(_loc2_);
   }
   function notifyCommandComplete()
   {
      com.poptropica.util.Debug.trace("GetConfigXMLCommand:: notifyCommandComplete()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE);
      this.dispatchEvent(_loc2_);
   }
}
