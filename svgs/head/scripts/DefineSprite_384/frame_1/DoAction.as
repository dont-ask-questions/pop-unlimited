function startup(bubbleNumber)
{
   gClipLoaderListener = new Object();
   gClipLoader.addListener(gClipLoaderListener);
}
function action()
{
   if(char != _root.camera.scene.char)
   {
      return undefined;
   }
   if(char.jumping || _root.takeClick._visible)
   {
      return undefined;
   }
   if(!_root.camera.scene.helioGumPauseContainer)
   {
      _root.camera.scene.createEmptyMovieClip("helioGumPauseContainer",scene.getNextHighestDepth());
   }
   if(!_root.camera.scene.helioGumControlCheckContainer)
   {
      _root.camera.scene.createEmptyMovieClip("helioGumControlCheckContainer",scene.getNextHighestDepth());
      _root.camera.scene.helioGumControlCheckContainer.falling = false;
      _root.camera.scene.helioGumControlCheckContainer.onEnterFrame = function()
      {
         if(!_root.camera.scene.helioGumControlCheckContainer.falling)
         {
            return undefined;
         }
         if(_root.camera.scene.char._y > _root.camera.scene.helioGumControlCheckContainer.startY - 10)
         {
            _root.camera.scene.helioGumControlCheckContainer.falling = false;
            _root.camera.scene.char.canDrop = false;
            _root.camera.scene.char.targetX = _root.camera.scene.char._x;
            _root.camera.scene.char.hitTests = _root.camera.scene.char.avatar.head.mouth.savedCharHitTests;
            _root.takeClick._visible = false;
         }
      };
   }
   _root.takeClick._visible = true;
   char.mouseFollow = false;
   char.speed = 0;
   scene.helioGumPauseContainer.pauseCounter = 10;
   scene.helioGumPauseContainer.onEnterFrame = pauseBeforeBubble;
}
function pauseBeforeBubble()
{
   scene.helioGumPauseContainer.pauseCounter--;
   if(scene.helioGumPauseContainer.pauseCounter <= 0)
   {
      delete scene.helioGumPauseContainer.onEnterFrame;
      addBubble();
   }
}
function addBubble()
{
   gotoAndStop("blow");
   play();
   var _loc2_ = scene.getNextHighestDepth();
   var _loc1_ = "bubbleGum" + _loc2_;
   gUsedNames.push(_loc1_);
   b = scene.createEmptyMovieClip(_loc1_,_loc2_);
   ld.loadClip("externalAssets/bubblegum.swf",b);
}
function positionBubble(mc)
{
   mc._x = char._x - char.charScale / 100 * char.dir * (avatar._x + aScale * (- avatar.head._x - avatar.head.mouth._x) + 10 + mc._width / 2) + char.speed;
   mc._y = char._y + char.charScale / 100 * (avatar._y + aScale * (avatar.head._y + avatar.head.mouth._y));
}
function pickRandomColor(mc)
{
   var _loc3_ = [12076612,6824864,15300159,2657598,1471460,16566607];
   var _loc1_ = utils.Utils.pickRandomElement(_loc3_);
   if(mc.num == 5)
   {
      char.paintChar(_loc1_);
   }
   mc.gColor = _loc1_;
   utils.ColorUtils.setClipColor(mc.bubble.color,utils.ColorUtils.convertHexToRGB(_loc1_));
}
function growBubble()
{
   positionBubble(this);
   this._xscale = this._yscale += 10;
   if(this._xscale > this.tScale)
   {
      scene.helioGumControlCheckContainer.startY = char._y;
      char.canDrop = true;
      avatar.head.mouth.savedCharHitTests = char.hitTests;
      delete char.hitTests;
      savedCharOnEnterFrame = char.onEnterFrame;
      delete char.onEnterFrame;
      this.ax = Math.random() * 0.1 - 0.05;
      this.ay = (- Math.random()) * 0.1 - 0.1;
      this.vx = 0;
      this.vy = 0;
      this.t = 0;
      this.maxTime = 45 + Math.random() * 30;
      this.onEnterFrame = function()
      {
         this.vx += this.ax;
         this.vy += this.ay;
         this._x += this.vx;
         this._y += this.vy;
         this.t += 1;
         char._x += this.vx;
         char._y += this.vy;
         if(this.t > this.maxTime)
         {
            _root.camera.scene.char.speed = 0;
            _root.camera.scene.char.vSpeed = 0;
            _root.camera.scene.char.airControl = false;
            char.onEnterFrame = savedCharOnEnterFrame;
            this.explode();
            avatar.head.mouth.active_obj.gotoAndPlay(2);
            delete this.onEnterFrame;
            removeUsedName(this._name);
            scene.helioGumControlCheckContainer.falling = true;
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
var savedCharHitTests;
var savedCharOnEnterFrame;
var ld = new MovieClipLoader();
ld.addListener(this);
this.onLoadInit = function(mc)
{
   mc.gotoAndStop(11);
   mc._xscale = mc._yscale = 0;
   mc.tScale = Math.random() * 50 + 75;
   positionBubble(mc);
   mc.onEnterFrame = growBubble;
};
