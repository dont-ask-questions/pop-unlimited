class fx.Asteroids
{
   var mScope;
   var mTotal;
   var mWidth;
   var mHeight;
   var mScene;
   var mBase;
   var mClips;
   var CLIP_MAX_SCALE = 120;
   var CLIP_MIN_SCALE = 20;
   var FADE_IN_TIME = 2;
   var mAsteroidAsset = "externalAssets/asteroid.swf";
   var mExplosionAsset = "externalAssets/explosion.swf";
   var mXPos = 0;
   var mYPos = 0;
   var mPadding = 0;
   var mMovementThreshold = 10;
   var mFastMovement = false;
   var mAllowExplosions = true;
   var mAllowTrail = true;
   var mTotalClipsLoaded = 0;
   var mClipsReady = false;
   function Asteroids(scope, total, padding, scene, asset)
   {
      trace("new Asteroids(" + arguments + ")");
      this.mScope = scope;
      this.mTotal = total;
      this.mWidth = this.mScope._width;
      this.mHeight = this.mScope._height;
      this.mYPos = this.mScope._y - padding;
      this.mXPos = this.mScope._x;
      this.mScene = scene;
      if(asset != undefined)
      {
         this.mAsteroidAsset = asset;
      }
      if(padding)
      {
         this.mPadding = padding;
      }
      this.mBase = this.mScope.createEmptyMovieClip("clips",this.mScope.getNextHighestDepth());
      this.mTotal = total;
      this.create();
   }
   function destroy()
   {
      this.mBase.removeMovieClip();
   }
   function create()
   {
      this.mClips = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this.mTotal)
      {
         this.mClips.push(this.drawClip(_loc2_));
         _loc2_ = _loc2_ + 1;
      }
   }
   function update(xOffSet, yOffSet)
   {
      if(!this.mClipsReady)
      {
         return undefined;
      }
      if(Math.abs(xOffSet) > this.mMovementThreshold || Math.abs(yOffSet) > this.mMovementThreshold)
      {
         this.mFastMovement = true;
      }
      else
      {
         this.mFastMovement = false;
      }
      var _loc2_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this.mClips.length)
      {
         _loc2_ = this.mClips[_loc3_];
         var _loc4_ = Math.abs(this.mScene._parent._y) + _loc2_._y;
         var _loc5_ = this.mScene.baseGround;
         if(_loc4_ >= _loc5_ - _loc2_.rock._height)
         {
            if(this.mAllowExplosions)
            {
               this.showExplosion(_loc2_);
            }
            this.setClipProperties(_loc2_,true);
         }
         else
         {
            _loc2_._y += _loc2_.veloc;
            _loc2_._x -= _loc2_.veloc * 0.5;
            _loc2_.veloc += _loc2_.accel;
            _loc2_._x -= xOffSet;
            _loc2_._y -= yOffSet;
            _loc2_.rock._rotation += _loc2_.rot;
         }
         if(_loc2_._y <= this.mYPos - this.mHeight || _loc2_._y >= this.mHeight + this.mPadding || _loc2_._x >= this.mWidth + this.mPadding || _loc2_._x <= this.mXPos - this.mPadding)
         {
            this.setClipProperties(_loc2_,true);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function getMC()
   {
      return this.mBase;
   }
   function setAsteroidAsset(asset)
   {
      this.mAsteroidAsset = asset;
   }
   function allowExplosions(allow)
   {
      if(allow == undefined)
      {
         allow = true;
      }
      this.mAllowExplosions = allow;
   }
   function allowTrail(allow)
   {
      if(allow == undefined)
      {
         allow = true;
      }
      this.mAllowTrail = allow;
   }
   function setClipProperties(nextClip, reset)
   {
      nextClip._xscale = nextClip._yscale = this.getRandomNumber(this.CLIP_MIN_SCALE,this.CLIP_MAX_SCALE);
      nextClip._x = this.getRandomNumber(this.mXPos - this.mPadding,this.mWidth + this.mPadding);
      if(reset)
      {
         if(this.mFastMovement)
         {
            nextClip._y = this.getRandomNumber(this.mYPos - this.mPadding,this.mHeight + this.mPadding);
         }
         else
         {
            nextClip._y = this.getRandomNumber(this.mYPos - this.mHeight,this.mYPos);
         }
      }
      else
      {
         nextClip._y = this.getRandomNumber(this.mYPos - this.mPadding * 10,this.mYPos);
      }
      nextClip.veloc = this.getRandomNumber(10,30);
      nextClip.rot = this.getRandomNumber(-10,10);
      nextClip.accel = this.getRandomNumber(0.5,1.75);
   }
   function onLoadInit(mc)
   {
      this.mTotalClipsLoaded = this.mTotalClipsLoaded + 1;
      mc._visible = false;
      if(this.mTotalClipsLoaded == this.mTotal)
      {
         this.clipsReady();
      }
   }
   function clipsReady()
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.mClips.length)
      {
         _loc3_ = this.mClips[_loc2_];
         _loc3_._visible = true;
         if(this.mAllowTrail)
         {
            this.drawSubClips(_loc3_);
         }
         this.setClipProperties(_loc3_);
         _loc2_ = _loc2_ + 1;
      }
      this.mClipsReady = true;
   }
   function showExplosion(targetClip)
   {
      var _loc4_ = this.mBase.getNextHighestDepth();
      var nextClip = this.mBase.createEmptyMovieClip("explosion" + _loc4_,_loc4_);
      var _loc5_ = new MovieClipLoader();
      nextClip._x = targetClip._x + targetClip._width * 0.5;
      nextClip._y = targetClip._y + targetClip._height * 0.5;
      nextClip._xscale = nextClip._yscale = targetClip._xscale;
      _loc5_.loadClip(this.mExplosionAsset,nextClip);
      var _loc6_ = function()
      {
         nextClip.removeMovieClip();
      };
      _global.setTimeout(_loc6_,1000);
   }
   function drawClip(id)
   {
      var _loc4_ = this.mBase.getNextHighestDepth();
      var _loc3_ = this.mBase.createEmptyMovieClip("clip" + _loc4_,_loc4_);
      var _loc2_ = new MovieClipLoader();
      var _loc5_ = new Object();
      _loc2_.addListener(this);
      _loc2_.loadClip(this.mAsteroidAsset,_loc3_);
      return _loc3_;
   }
   function drawSubClips(targetClip)
   {
      var _loc9_ = 3;
      var _loc6_ = undefined;
      var _loc3_ = undefined;
      var _loc4_ = targetClip.createEmptyMovieClip("subclips",targetClip.getNextHighestDepth());
      var _loc8_ = new MovieClipLoader();
      var _loc11_ = [60,40,20,10];
      var _loc10_ = [80,60,40,20];
      var _loc5_ = [40,70,100,140];
      _loc4_.swapDepths(targetClip.rock);
      var _loc2_ = 0;
      while(_loc2_ < _loc9_)
      {
         _loc6_ = _loc4_.getNextHighestDepth();
         _loc3_ = _loc4_.createEmptyMovieClip("subclip" + _loc2_,_loc6_);
         var _loc7_ = 25 * (_loc2_ + 1);
         _loc3_._x += _loc5_[_loc2_];
         _loc3_._y -= _loc5_[_loc2_];
         _loc3_._alpha = _loc11_[_loc2_];
         _loc3_._xscale = _loc3_._yscale = _loc10_[_loc2_];
         _loc8_.loadClip(this.mAsteroidAsset,_loc3_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function getRandomNumber(minVal, maxVal, round)
   {
      var _loc1_ = minVal + Math.random() * (maxVal - minVal);
      if(round != undefined)
      {
         if(round == "round")
         {
            _loc1_ = Math.round(_loc1_);
         }
         else if(round == "ciel")
         {
            _loc1_ = Math.ceil(_loc1_);
         }
         else if(round == "floor")
         {
            _loc1_ = Math.floor(_loc1_);
         }
      }
      return _loc1_;
   }
}
