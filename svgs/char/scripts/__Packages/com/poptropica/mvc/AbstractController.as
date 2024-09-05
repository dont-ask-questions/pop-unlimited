class com.poptropica.mvc.AbstractController implements com.poptropica.mvc.IController
{
   var _model;
   var _view;
   function AbstractController(m)
   {
      this.setModel(m);
   }
   function setModel(m)
   {
      this._model = m;
   }
   function getModel()
   {
      return this._model;
   }
   function setView(v)
   {
      this._view = v;
   }
   function getView()
   {
      return this._view;
   }
}
