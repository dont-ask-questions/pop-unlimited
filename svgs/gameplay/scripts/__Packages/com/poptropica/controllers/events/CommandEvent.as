class com.poptropica.controllers.events.CommandEvent
{
   var type;
   static var COMMAND_COMPLETE = "command complete";
   static var COMMAND_PROGRESS = "command progress";
   static var COMMAND_ERROR = "command error";
   function CommandEvent($type)
   {
      this.type = $type;
   }
   function toString()
   {
      return "[Event type=" + this.type + "]";
   }
   function clone()
   {
      return new com.poptropica.controllers.events.CommandEvent(this.type);
   }
}
