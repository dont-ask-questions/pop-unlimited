class com.poptropica.components.tab.TabBase extends MovieClip
{
   var _asset;
   function TabBase(mc)
   {
      super();
      this._asset = mc;
      mx.events.EventDispatcher.initialize(this);
   }
   function dispatchEvent()
   {
   }
   function addEventListener(pEventType, callingObj)
   {
   }
   function removeEventListener(pEventType, callingObj)
   {
   }
   function hide()
   {
      this._asset._visible = false;
   }
   function show()
   {
      this._asset._visible = true;
   }
   function init()
   {
   }
}
