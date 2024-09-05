function enterFrameEvent()
{
   if(gBubbleNumber == 5)
   {
      if(gBubbleTimer < 0)
      {
         gBubbleTimer = utils.Utils.getRandomNumber(55,240);
         this.gotoAndPlay("blow");
         addBubbleToScene();
      }
      else
      {
         gBubbleTimer--;
      }
   }
}
function startup(bubbleNumber)
{
   gBubbleNumber = bubbleNumber;
   gClipLoaderListener = new Object();
   trace("bubbleNumber : " + bubbleNumber);
   if(gBubbleNumber == 3)
   {
      gClipLoaderListener.onLoadInit = setupFlake;
   }
   else if(gBubbleNumber == 4 || gBubbleNumber == 9)
   {
      gTrailTarget = scene.createEmptyMovieClip("trailTarget",scene.getNextHighestDepth());
      gClipLoaderListener.onLoadInit = setupSkull;
   }
   else if(gBubbleNumber == 5)
   {
      startBubbleTimer();
   }
   else if(gBubbleNumber == 6)
   {
      gTrailTarget = scene.createEmptyMovieClip("trailTarget",scene.getNextHighestDepth());
      gClipLoaderListener.onLoadInit = setupHippie;
   }
   else if(gBubbleNumber == 10)
   {
      gTrailTarget = scene.createEmptyMovieClip("trailTarget",scene.getNextHighestDepth());
      gClipLoaderListener.onLoadInit = setupShamrock;
   }
   gClipLoader.addListener(gClipLoaderListener);
   this.onEnterFrame = enterFrameEvent;
}
function action()
{
   gotoAndStop("blow");
   play();
   addBubbleToScene();
}
function addBubbleToScene()
{
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
      this.ax = Math.random() * 0.1 - 0.05;
      this.ay = (- Math.random()) * 0.1 - 0.1;
      this.vx = 0;
      this.vy = 0;
      this.t = 0;
      this.maxTime = 45 + Math.random() * 30;
      if(gBubbleNumber == 3)
      {
         this.maxTime = 55 + Math.random() * 10;
      }
      else if(gBubbleNumber == 4 || gBubbleNumber == 9 || gBubbleNumber == 6 || gBubbleNumber == 10)
      {
         this.maxTime = 35 + Math.random() * 10;
      }
      this.onEnterFrame = function()
      {
         this.vx += this.ax;
         this.vy += this.ay;
         this._x += this.vx;
         this._y += this.vy;
         this.t += 1;
         if(this.t > this.maxTime)
         {
            gLastBurstBubblePosition.x = this._x;
            gLastBurstBubblePosition.y = this._y;
            delete this.onEnterFrame;
            this.explode();
            if(gBubbleNumber == 4 || gBubbleNumber == 9)
            {
               var _loc3_ = "externalAssets/skull.swf";
               if(gBubbleNumber == 9)
               {
                  TRAIL_COLOR = 12255232;
                  INIT_TRAIL_COLOR = 10027008;
                  TRAIL_BASE_SIZE = 8;
                  _loc3_ = "externalAssets/bat.swf";
               }
               var _loc2_ = 0;
               while(_loc2_ < 4)
               {
                  createSkulls(_loc3_);
                  _loc2_ = _loc2_ + 1;
               }
            }
            else if(gBubbleNumber == 6)
            {
               gCurrentHippieBubbleColor = this.gColor;
               _loc2_ = 0;
               while(_loc2_ < 4)
               {
                  createHippies(_loc2_);
                  _loc2_ = _loc2_ + 1;
               }
            }
            else if(gBubbleNumber == 10)
            {
               _loc2_ = 0;
               while(_loc2_ < SHAMROCKS_PER_POP)
               {
                  createShamrocks();
                  _loc2_ = _loc2_ + 1;
               }
            }
            removeUsedName(this._name);
         }
         if(gBubbleNumber == 3)
         {
            createFlakes();
         }
      };
   }
}
function setupFlake(mc)
{
   var _loc2_ = pickRandomBubble(mc);
   mc._x = _loc2_._x - 20;
   mc._y = _loc2_._y - 20;
   mc.tStep = -0.1 + Math.random() * 0.1;
   mc.t = mc.tStep;
   mc.vy = 1 + Math.random() * 2;
   mc.art._xscale = mc.art._yscale = 0;
   mc.life = 45 + Math.floor(Math.random() * 15);
   mc.maxScale = 50 + 50 * Math.random();
   mc.onEnterFrame = updateFlake;
}
function updateFlake()
{
   this._y += this.vy;
   this._x += 1.2 * Math.sin(this.t);
   this.t += this.tStep;
   this.art._rotation += this.tStep * 40;
   this.life = this.life - 1;
   if(this.art._xscale < this.maxScale)
   {
      this.art._xscale = this.art._yscale += 5;
   }
   if(this.life < 0)
   {
      this._alpha -= 2;
      if(this._alpha <= 0)
      {
         this.onEnterFrame = null;
         this.removeMovieClip();
      }
   }
}
function createFlakes()
{
   gFlakeCounter--;
   if(gFlakeCounter <= 0)
   {
      gFlakeCounter = 5 + Math.floor(Math.random() * 5);
      var _loc1_ = scene.getNextHighestDepth();
      var _loc2_ = scene.createEmptyMovieClip("flake" + _loc1_,_loc1_);
      gClipLoader.loadClip("externalAssets/flake.swf",_loc2_);
   }
}
function setupSkull(mc)
{
   mc.art.stop();
   mc.trailCounter = 0;
   mc.trailColor = TRAIL_COLOR;
   if(Math.random() > 0.5)
   {
      mc.trailColor = INIT_TRAIL_COLOR;
   }
   mc._x = gLastBurstBubblePosition.x - 20;
   mc._y = gLastBurstBubblePosition.y - 20;
   mc.tStep = -0.1 + Math.random() * 0.1;
   mc.t = mc.tStep;
   mc.vy = -5 + Math.random() * 8;
   mc.vx = 5 + Math.random() * -8;
   mc.art._xscale = mc.art._yscale = 0;
   mc.life = 60 + Math.floor(Math.random() * 20);
   mc.maxScale = 25 + 40 * Math.random();
   if(mc.vx < 0)
   {
      mc.maxScale = - mc.maxScale;
   }
   mc.onEnterFrame = updateSkull;
}
function updateSkull()
{
   this._x += this.vx + 2 * Math.sin(this.t);
   this._y += this.vy;
   this.t += this.tStep;
   if(this.vx < 0)
   {
   }
   this.life = this.life - 1;
   if(this.maxScale > 0 && this.art._xscale < this.maxScale)
   {
      this.art._xscale = this.art._yscale += 5;
   }
   else if(this.maxScale < 0 && this.art._xscale > this.maxScale)
   {
      this.art._xscale -= 5;
      this.art._yscale += 5;
   }
   if(this._alpha > 40)
   {
      if(this.trailCounter == 3 && this._alpha > 40)
      {
         drawTrail(this);
         this.trailCounter = 0;
      }
      else
      {
         this.trailCounter = this.trailCounter + 1;
      }
   }
   if(this.life < 0)
   {
      this._alpha -= 2;
      if(this._alpha <= 0)
      {
         if(gTotalSkulls > 0)
         {
            gTotalSkulls--;
         }
         this.onEnterFrame = null;
         this.removeMovieClip();
      }
   }
}
function createSkulls(asset)
{
   if(gTotalSkulls < MAX_SKULLS)
   {
      gTotalSkulls++;
      var _loc1_ = scene.getNextHighestDepth();
      var _loc2_ = scene.createEmptyMovieClip("skull" + _loc1_,_loc1_);
      gClipLoader.loadClip(asset,_loc2_);
   }
}
function setupHippie(mc)
{
   mc.trailCounter = 0;
   mc.trailColor = gCurrentHippieBubbleColor;
   mc._x = gLastBurstBubblePosition.x - 20;
   mc._y = gLastBurstBubblePosition.y - 20;
   mc.tStep = -0.1 + Math.random() * 0.1;
   mc.t = mc.tStep;
   mc.vy = -5 + Math.random() * 8;
   mc.vx = 5 + Math.random() * -8;
   mc.art._xscale = mc.art._yscale = 0;
   mc.life = 60 + Math.floor(Math.random() * 20);
   mc.maxScale = 25 + 40 * Math.random();
   if(mc.vx < 0)
   {
      mc.maxScale = - mc.maxScale;
   }
   mc.onEnterFrame = updateHippie;
}
function updateHippie()
{
   this._x += this.vx + 2 * Math.sin(this.t);
   this._y += this.vy;
   this.t += this.tStep;
   this.life = this.life - 1;
   if(this.maxScale > 0 && this.art._xscale < this.maxScale)
   {
      this.art._xscale = this.art._yscale += 5;
   }
   else if(this.maxScale < 0 && this.art._xscale > this.maxScale)
   {
      this.art._xscale -= 5;
      this.art._yscale += 5;
   }
   if(this._alpha > 40)
   {
      if(this.trailCounter == 3 && this._alpha > 40)
      {
         drawTrail(this);
         this.trailCounter = 0;
      }
      else
      {
         this.trailCounter = this.trailCounter + 1;
      }
   }
   if(this.life < 0)
   {
      this._alpha -= 2;
      if(this._alpha <= 0)
      {
         if(gTotalHippies > 0)
         {
            gTotalHippies--;
         }
         this.onEnterFrame = null;
         this.removeMovieClip();
      }
   }
}
function createHippies(symbolType)
{
   if(gTotalHippies < MAX_HIPPIES)
   {
      gTotalHippies++;
      var _loc1_ = scene.getNextHighestDepth();
      var _loc2_ = undefined;
      switch(symbolType)
      {
         case 0:
            _loc2_ = scene.createEmptyMovieClip("psychedelicSmile" + _loc1_,_loc1_);
            gClipLoader.loadClip("externalAssets/psychedelicSmile.swf",_loc2_);
            break;
         case 1:
            _loc2_ = scene.createEmptyMovieClip("psychedelicRainbow" + _loc1_,_loc1_);
            gClipLoader.loadClip("externalAssets/psychedelicRainbow.swf",_loc2_);
            break;
         case 2:
            _loc2_ = scene.createEmptyMovieClip("psychedelicFlower" + _loc1_,_loc1_);
            gClipLoader.loadClip("externalAssets/psychedelicFlower.swf",_loc2_);
            break;
         case 3:
            _loc2_ = scene.createEmptyMovieClip("psychedelicPeace" + _loc1_,_loc1_);
            gClipLoader.loadClip("externalAssets/psychedelicPeace.swf",_loc2_);
      }
   }
}
function setupShamrock(mc)
{
   mc.art.stop();
   mc.art.gotoAndStop(Math.ceil(Math.random() * mc.art._totalframes));
   mc._rotation += - SHAMROCK_ROTATION_RANGE + Math.random() * (SHAMROCK_ROTATION_RANGE * 2);
   mc._x = gLastBurstBubblePosition.x - 20;
   mc._y = gLastBurstBubblePosition.y - 20;
   mc.tStep = -0.1 + Math.random() * 0.1;
   mc.t = mc.tStep;
   mc.vy = SHAMROCK_INITIAL_YVEL_MIN + Math.random() * SHAMROCK_INITIAL_YVEL_VARIANT;
   mc.vx = - SHAMROCK_INITIAL_XVEL_MIN + Math.random() * (SHAMROCK_INITIAL_XVEL_MIN * 2);
   mc.art._xscale = mc.art._yscale = 0;
   mc.life = SHAMROCK_LIFE_MIN + Math.floor(Math.random() * SHAMROCK_LIFE_VARIANT);
   mc.maxScale = SHAMROCK_SCALE_MIN + SHAMROCK_SCALE_VARIANT * Math.random();
   mc.onEnterFrame = updateShamrock;
}
function updateShamrock()
{
   this.t += this.tStep;
   this.vy += SHAMROCK_GRAVITY;
   this._x += this.vx;
   this._y += this.vy;
   this.art._rotation += this.tStep * SHAMROCK_ROTATION_STEP;
   this.life = this.life - 1;
   if(this.art._xscale < this.maxScale)
   {
      this.art._xscale = this.art._yscale += SHAMROCK_SCALE_CHANGE;
   }
   if(this.life < 0)
   {
      this._alpha -= SHAMROCK_ALPHA_CHANGE;
      this.art._xscale -= SHAMROCK_SCALE_CHANGE;
      this.art._yscale -= SHAMROCK_SCALE_CHANGE;
      if(this._alpha <= 0 || this.art._xscale <= 0)
      {
         if(gTotalShamrocks > 0)
         {
            gTotalShamrocks--;
         }
         this.onEnterFrame = null;
         this.removeMovieClip();
      }
   }
}
function createShamrocks()
{
   if(gTotalShamrocks < MAX_SHAMROCKS)
   {
      gTotalShamrocks++;
      var _loc1_ = scene.getNextHighestDepth();
      var _loc2_ = scene.createEmptyMovieClip("shamrock" + _loc1_,_loc1_);
      gClipLoader.loadClip("externalAssets/shamrock.swf",_loc2_);
   }
}
function removeUsedName(bubName)
{
   var _loc2_ = undefined;
   var _loc1_ = 0;
   while(_loc1_ < gUsedNames.length)
   {
      _loc2_ = gUsedNames[_loc1_];
      if(bubName == _loc2_)
      {
         gUsedNames.splice(_loc1_,1);
      }
      _loc1_ = _loc1_ + 1;
   }
}
function drawTrail(clip)
{
   var _loc2_ = gTrailTarget.getNextHighestDepth();
   var nextTrail = gTrailTarget.createEmptyMovieClip("trail" + _loc2_,_loc2_);
   var _loc3_ = {x:clip._x + clip.art._x,y:clip._y + clip.art._y};
   nextTrail._x = _loc3_.x + (7 + Math.random() * -7);
   nextTrail._y = _loc3_.y + (7 + Math.random() * -7);
   nextTrail.lineStyle(TRAIL_BASE_SIZE,clip.trailColor,100);
   nextTrail.lineTo(TRAIL_LINE_SIZE,TRAIL_LINE_SIZE);
   nextTrail.onEnterFrame = function()
   {
      nextTrail._alpha -= 4;
      nextTrail._xscale -= 2;
      nextTrail._yscale -= 2;
      if(nextTrail._alpha < 0)
      {
         delete nextTrail.onEnterFrame;
         nextTrail.removeMovieClip();
      }
   };
}
function removeTrail(clip)
{
   clip.onEnterFrame = null;
}
function removeClip(clip)
{
   clip.removeMovieClip();
}
function pickRandomBubble(mc)
{
   var _loc2_ = 1 + Math.floor(Math.random() * mc._totalframes);
   mc.gotoAndStop(_loc2_);
   var _loc1_ = gUsedNames[Math.floor(Math.random() * gUsedNames.length)];
   var _loc3_ = scene[_loc1_];
   return _loc3_;
}
var avatar = _parent._parent._parent;
var char = _parent._parent._parent._parent;
var scene = _parent._parent._parent._parent._parent;
var aScale = 0.36;
var gClipLoader = new MovieClipLoader();
var gUsedNames = new Array();
var gClipLoaderListener;
var gBubbleNumber;
var gTrailTarget;
var gLastBurstBubblePosition = new Object();
var TRAIL_LINE_SIZE = 0.25;
var TRAIL_BASE_SIZE = 20;
var INIT_TRAIL_COLOR = 9797119;
var TRAIL_COLOR = 65280;
var gBubbleTimer = 31;
var MAX_HIPPIES = 20;
var gTotalHippies = 0;
var gCurrentHippieBubbleColor;
var MAX_SKULLS = 20;
var gTotalSkulls = 0;
var gFlakeCounter = 0;
var MAX_SHAMROCKS = 20;
var SHAMROCKS_PER_POP = 5;
var SHAMROCK_INITIAL_YVEL_MIN = -18;
var SHAMROCK_INITIAL_YVEL_VARIANT = 5;
var SHAMROCK_INITIAL_XVEL_MIN = 5;
var SHAMROCK_GRAVITY = 0.9;
var SHAMROCK_ROTATION_RANGE = 80;
var SHAMROCK_ROTATION_STEP = 20;
var SHAMROCK_SCALE_CHANGE = 5;
var SHAMROCK_LIFE_MIN = 20;
var SHAMROCK_LIFE_VARIANT = 4;
var SHAMROCK_SCALE_MIN = 40;
var SHAMROCK_SCALE_VARIANT = 20;
var SHAMROCK_ALPHA_CHANGE = 5;
var gTotalShamrocks = 0;
var ld = new MovieClipLoader();
ld.addListener(this);
this.onLoadInit = function(mc)
{
   mc.num = gBubbleNumber;
   mc.gotoAndStop(mc.num);
   mc._xscale = mc._yscale = 0;
   mc.tScale = Math.random() * 50 + 75;
   positionBubble(mc);
   if(gBubbleNumber == 5 || gBubbleNumber == 6)
   {
      pickRandomColor(mc);
   }
   else if(gBubbleNumber == 7)
   {
      mc.gColor = 5317341;
      utils.ColorUtils.setClipColor(mc.bubble.color,5317341);
   }
   mc.onEnterFrame = growBubble;
};
