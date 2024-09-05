class fx.Snow
{
   var mScope;
   var mWidth;
   var mHeight;
   var mSnow;
   var mNumberOfFlakes;
   var mFlakes;
   var SNOW_COLOR = 16382457;
   var SNOW_BASE_SIZE = 5;
   var SNOW_BASE_ALPHA = 100;
   var SNOW_LINE_SIZE = 0.25;
   var SNOW_MAX_ALPHA = 100;
   var SNOW_MIN_ALPHA = 75;
   var SNOW_MAX_SCALE = 150;
   var SNOW_MIN_SCALE = 50;
   var SNOW_FADE_IN_TIME = 2;
   var mXPos = 0;
   var mYPos = 0;
   var mPadding = 0;
   var mMovementThreshold = 10;
   var mFastMovement = false;
   function Snow(scope, numberOfFlakes, padding)
   {
      this.mScope = scope;
      this.mWidth = this.mScope._width;
      this.mHeight = this.mScope._height;
      this.mYPos = this.mScope._y;
      this.mXPos = this.mScope._x;
      if(padding)
      {
         this.mPadding = padding;
      }
      this.mSnow = this.mScope.createEmptyMovieClip("snow",this.mScope.getNextHighestDepth());
      this.mNumberOfFlakes = numberOfFlakes;
      this.mSnow._alpha = 0;
      this.create();
   }
   function destroy()
   {
      this.mSnow.removeMovieClip();
   }
   function create()
   {
      this.mFlakes = new Array();
      var _loc2_ = 0;
      while(_loc2_ < this.mNumberOfFlakes)
      {
         this.mFlakes.push(this.drawFlake(_loc2_));
         _loc2_ = _loc2_ + 1;
      }
      caurina.transitions.Tweener.addTween(this.mSnow,{_alpha:100,transition:"linear",time:this.SNOW_FADE_IN_TIME});
   }
   function update(xOffSet, yOffSet)
   {
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
      while(_loc3_ < this.mFlakes.length)
      {
         _loc2_ = this.mFlakes[_loc3_];
         _loc2_.rad += _loc2_.k / 180 * 3.141592653589793;
         _loc2_._x -= Math.cos(_loc2_.rad);
         _loc2_._y += _loc2_.i;
         _loc2_._x -= xOffSet;
         _loc2_._y -= yOffSet;
         if(_loc2_._y <= this.mYPos - this.mPadding || _loc2_._y >= this.mHeight + this.mPadding || _loc2_._x >= this.mWidth + this.mPadding || _loc2_._x <= this.mXPos - this.mPadding)
         {
            this.setFlakeProperties(_loc2_,true);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function getMC()
   {
      return this.mSnow;
   }
   function setFlakeProperties(nextFlake, reset)
   {
      nextFlake._xscale = nextFlake._yscale = this.getRandomNumber(this.SNOW_MIN_SCALE,this.SNOW_MAX_SCALE);
      nextFlake._alpha = this.getRandomNumber(this.SNOW_MIN_ALPHA,this.SNOW_MAX_ALPHA);
      nextFlake._x = this.getRandomNumber(this.mXPos - this.mPadding,this.mWidth + this.mPadding);
      if(reset)
      {
         if(this.mFastMovement)
         {
            nextFlake._y = this.getRandomNumber(this.mYPos - this.mPadding,this.mHeight + this.mPadding);
         }
         else
         {
            nextFlake._y = this.getRandomNumber(this.mYPos - this.mPadding,this.mYPos);
         }
      }
      else
      {
         nextFlake._y = this.getRandomNumber(this.mYPos - this.mPadding,this.mHeight + this.mPadding);
      }
      nextFlake.i = this.getRandomNumber(1,2);
      nextFlake.k = this.getRandomNumber(-3.141592653589793,3.141592653589793);
      nextFlake.rad = 0;
   }
   function drawFlake(id)
   {
      var _loc3_ = this.mSnow.getNextHighestDepth();
      var _loc2_ = this.mSnow.createEmptyMovieClip("flake" + _loc3_,_loc3_);
      _loc2_.lineStyle(this.SNOW_BASE_SIZE,this.SNOW_COLOR,this.SNOW_BASE_ALPHA);
      _loc2_.lineTo(this.SNOW_LINE_SIZE,this.SNOW_LINE_SIZE);
      this.setFlakeProperties(_loc2_);
      return _loc2_;
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
