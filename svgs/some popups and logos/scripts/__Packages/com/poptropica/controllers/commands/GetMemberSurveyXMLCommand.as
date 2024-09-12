class com.poptropica.controllers.commands.GetMemberSurveyXMLCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var startDate;
   var endDate;
   var _path = "framework/data/sections/home/memberSurveyDateRange.xml";
   function GetMemberSurveyXMLCommand()
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
            me.parse(configXML);
            me.notifyCommandComplete();
         }
         else
         {
            this.notifyCommandError();
         }
      };
      var _loc2_ = com.poptropica.util.PopUtils.getFlashPrefixFromLocalConnection() + this._path;
      configXML.load(_loc2_);
   }
   function parse(pXML)
   {
      com.poptropica.util.Debug.trace("GetConfigXMLCommand:: parseConfig()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc4_ = new Array();
      if(pXML.firstChild.hasChildNodes())
      {
         var _loc2_ = pXML.firstChild.firstChild;
         while(_loc2_ != null)
         {
            if(_loc2_.nodeName == "start")
            {
               this.startDate = _loc2_.firstChild.nodeValue;
            }
            else if(_loc2_.nodeName == "end")
            {
               this.endDate = _loc2_.firstChild.nodeValue;
            }
            _loc2_ = _loc2_.nextSibling;
         }
         com.poptropica.models.PopModel.getInstance().islandData = _loc4_;
      }
      else
      {
         this.notifyCommandError();
      }
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
