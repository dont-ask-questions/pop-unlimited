onClipEvent(load){
   function bitmapCard()
   {
      var _loc2_ = new flash.geom.Matrix();
      var _loc3_ = new flash.display.BitmapData(280,400,false,16777215);
      _loc2_.translate(140,200);
      _loc3_.draw(this.backVector,_loc2_);
      this.back.attachBitmap(_loc3_,this.getNextHighestDepth());
      this.back._x -= 140;
      this.back._y -= 200;
      this.backVector._visible = false;
   }
}
