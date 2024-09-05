camera.cameraFlash._alpha = 100;
camera.cameraFlash.onEnterFrame = function()
{
   this._alpha -= 10;
   if(this._alpha < 0)
   {
      delete this.onEnterFrame;
   }
};
