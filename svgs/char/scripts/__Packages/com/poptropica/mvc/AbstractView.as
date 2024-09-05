class com.poptropica.mvc.AbstractView implements com.poptropica.mvc.IView, com.poptropica.util.Observer
{
   var _model;
   var _controller;
   function AbstractView(m, c)
   {
      this.setModel(m);
      if(c !== undefined)
      {
         this.setController(c);
      }
   }
   function defaultController(model)
   {
      return null;
   }
   function setModel(m)
   {
      this._model = m;
   }
   function getModel()
   {
      return this._model;
   }
   function setController(c)
   {
      this._controller = c;
      this.getController().setView(this);
   }
   function getController()
   {
      if(this._controller === undefined)
      {
         this.setController(this.defaultController(this.getModel()));
      }
      return this._controller;
   }
   function update(o, infoObj)
   {
   }
   function clear(o, infoObj)
   {
   }
   function destroy(o, infoObj)
   {
   }
}
