class com.poptropica.util.XmlLoader
{
   var _xml;
   var dispatchEvent;
   function XmlLoader()
   {
      this._xml = new XML();
      this._xml.ignoreWhite = true;
      this._xml.onLoad = Delegate.create(this,this.loaded);
      mx.events.EventDispatcher.initialize(this);
   }
   function load(path)
   {
      trace("XmlLoader load path : " + path);
      this._xml.load(path);
   }
   function loaded(success)
   {
      trace("XmlLoader result : " + success);
      this.dispatchEvent({type:"Loaded",result:success});
   }
   function get xml()
   {
      return this._xml;
   }
}
