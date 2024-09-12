class com.poptropica.events.LoaderEvent
{
   var type;
   static var LOAD_COMPLETE = "load complete";
   static var LOAD_INIT = "load init";
   static var LOAD_PROGRESS = "load progress";
   static var LOAD_ERROR = "load error";
   function LoaderEvent(pType)
   {
      this.type = pType;
   }
}
