class com.poptropica.sections.Home extends com.poptropica.sections.AbstractSection
{
   var _popModel;
   var _popController;
   var _homeView;
   function Home(pTarget)
   {
      super(pTarget);
      com.poptropica.util.Debug.trace("Home::() " + pTarget,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._popModel = com.poptropica.models.PopModel.getInstance();
      this._popController = new com.poptropica.controllers.PopController(this._popModel);
      this._homeView = new com.poptropica.views.HomeView(this._popModel,this._popController,pTarget,0);
      this._popModel.addObserver(this._homeView);
   }
   function destroy()
   {
      this._homeView.destroy();
   }
   function onUnloadHandler()
   {
      com.poptropica.util.Debug.trace("Home::onUnloadHandler() ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._homeView.clear();
   }
}
