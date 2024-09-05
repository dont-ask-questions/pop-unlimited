onClipEvent(enterFrame){
   if(_root.camera.scene.char._xscale > 0)
   {
      this.bottle.gotoAndStop(2);
      this._rotation = _root.camera.scene.fireangle;
   }
   else
   {
      this.bottle.gotoAndStop(1);
      this._rotation = - _root.camera.scene.fireangle;
   }
}
