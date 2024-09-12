class com.poptropica.sections.AbstractSection
{
   var _sectionMC;
   function AbstractSection(pTarget)
   {
      com.poptropica.util.Debug.trace("AbstractSection::() " + pTarget,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._sectionMC = pTarget;
      this._sectionMC.onUnload = com.poptropica.util.EventDelegate.create(this,this.onUnloadHandler);
   }
   function destroy()
   {
   }
   function onUnloadHandler()
   {
      com.poptropica.util.Debug.trace("AbstractSection::onUnloadHandler() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
}
