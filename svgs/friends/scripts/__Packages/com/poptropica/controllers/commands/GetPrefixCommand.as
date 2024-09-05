class com.poptropica.controllers.commands.GetPrefixCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   var prefix;
   var increment = 0;
   function GetPrefixCommand()
   {
      super();
      com.poptropica.util.Debug.trace("GetPrefixCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function exec()
   {
      com.poptropica.util.Debug.trace("GetPrefixCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc4_ = com.poptropica.models.LSOManager.getInstance().getPrefix();
      var _loc5_ = com.poptropica.models.LSOManager.getInstance().getLastPrefixUpdate();
      if(_loc4_)
      {
         var _loc3_ = new Date() - _loc5_;
         if(isNaN(_loc3_) || _loc3_ > 1800000)
         {
            this.loadPrefix();
         }
         else
         {
            _global.setTimeout(this.loadPrefix,1800000 - _loc3_);
            this.dispatchEvent(new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE));
         }
      }
      else
      {
         this.loadPrefix();
      }
   }
   function loadPrefix()
   {
      com.poptropica.util.Debug.trace("GetPrefixCommand:: loadPrefix()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var me = this;
      var _loc5_ = new LoadVars();
      var _loc4_ = new LoadVars();
      _loc4_.onLoad = function()
      {
         if(this.prefix != undefined)
         {
            var _loc3_ = new Date();
            com.poptropica.models.PopModelConst.prefix = this.prefix;
            com.poptropica.models.PopModelConst.lastPrefixUpdate = _loc3_;
            com.poptropica.models.LSOManager.getInstance().setPrefix(this.prefix);
            com.poptropica.models.LSOManager.getInstance().setLastPrefixUpdate(_loc3_);
         }
         else
         {
            com.poptropica.models.PopModelConst.prefix = "";
         }
         _global.setTimeout(this.loadPrefix,1800000);
         me.increment = me.increment + 1;
         if(me.increment == 1)
         {
            me.notifyCommandComplete();
         }
      };
      _loc5_.sendAndLoad("/getPrefix.php",_loc4_,"POST");
   }
   function notifyCommandComplete()
   {
      com.poptropica.util.Debug.trace("GetPrefixCommand:: notifyCommandComplete()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this.dispatchEvent(new com.poptropica.controllers.events.CommandEvent(com.poptropica.controllers.events.CommandEvent.COMMAND_COMPLETE));
   }
}
