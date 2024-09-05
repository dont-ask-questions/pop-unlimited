function addFruit()
{
   var _loc1_ = scene.getNextHighestDepth();
   var _loc2_ = "gobstopperFruit" + _loc1_;
   gUsedNames.push(_loc2_);
   b = scene.createEmptyMovieClip(bubbleName,_loc1_);
   ld.loadClip("externalAssets/fruit.swf",b);
}
function positionBubble(mc)
{
   var _loc2_ = Math.floor(Math.random() * 40);
   mc._x = char._x - char.charScale / 100 * char.dir * (avatar._x + aScale * (- avatar.head._x - avatar.head.mouth._x) + 10 + mc._width / 2) + char.speed + char._xscale / char.charScale * (_loc2_ - 20);
   mc._y = char._y + char.charScale / 100 * (avatar._y + aScale * (avatar.head._y + avatar.head.mouth._y)) - char.charScale / 100 * 75;
}
function growBubble()
{
   this._xscale = this._yscale += 20;
   if(this._xscale > this.tScale)
   {
      this.ax = Math.random() * 0.01;
      if(this._x < _root.camera.scene.char._x)
      {
         this.ax *= -1;
      }
      this.ay = (- Math.random()) * 0.005 - 0.005;
      this.vx = 0;
      this.vy = 0;
      this.alphaAcceleration = 0.125;
      this.velocityAlpha = 0;
      this.onEnterFrame = function()
      {
         this.vx += this.ax;
         this.vy += this.ay;
         this._x += this.vx;
         this._y += this.vy;
         this.velocityAlpha += this.alphaAcceleration;
         this._alpha -= this.velocityAlpha;
         if(this._alpha <= 0)
         {
            delete this.onEnterFrame;
            removeUsedName(this._name);
            this.removeMovieClip();
         }
      };
   }
}
var avatar = _parent._parent._parent;
var char = _parent._parent._parent._parent;
var scene = _parent._parent._parent._parent._parent;
var aScale = 0.36;
var gClipLoader = new MovieClipLoader();
var gClipLoaderListener;
var gUsedNames = new Array();
gClipLoaderListener = new Object();
gClipLoader.addListener(gClipLoaderListener);
if(this == _root.camera.scene.char.avatar.head.mouth.active_obj && !_root.camera.scene.fruitEmitter)
{
   _root.camera.scene.createEmptyMovieClip("fruitEmitter",_root.camera.scene.getNextHighestDepth());
   _root.camera.scene.fruitEmitter.fruitCounter = 70;
   _root.camera.scene.fruitEmitter.onEnterFrame = function()
   {
      _root.camera.scene.fruitCounter--;
      if(_root.camera.scene.fruitCounter <= 0)
      {
         _root.camera.scene.char.avatar.head.mouth.active_obj.addFruit();
         _root.camera.scene.fruitCounter = 70;
      }
   };
}
else
{
   _root.camera.scene.fruitCounter = 70;
}
var ld = new MovieClipLoader();
ld.addListener(this);
this.onLoadInit = function(mc)
{
   var _loc2_ = Math.floor(Math.random() * 4) + 1;
   mc.gotoAndStop(_loc2_);
   mc._xscale = mc._yscale = 0;
   mc.tScale = Math.random() * 50 + 75;
   positionBubble(mc);
   mc.onEnterFrame = growBubble;
};
