class fx.Lightning
{
   var mScope;
   var mOffset;
   var mClips;
   var mContainer = null;
   var LINE_THICKNESS = 7;
   var LINE_ALPHA = 100;
   var TOTAL_GENERATIONS = 10;
   var DEGRADE_RATE = 0.75;
   var SIZE_FACTOR = 250;
   var X_OFFSET_MIN = -0.3 * fx.Lightning.prototype.SIZE_FACTOR;
   var X_OFFSET_MAX = 0.3 * fx.Lightning.prototype.SIZE_FACTOR;
   var Y_OFFSET_MIN = 0.3 * fx.Lightning.prototype.SIZE_FACTOR;
   var Y_OFFSET_MAX = fx.Lightning.prototype.SIZE_FACTOR;
   var MIN_CHILDREN = 2;
   var MAX_CHILDREN = 4;
   var FILTER_QUALITY = 1;
   var GLOW_OFFSET = 17;
   var GLOW_STRENGTH = 7;
   function Lightning(scope)
   {
      this.mScope = scope;
      this.mContainer = this.mScope.createEmptyMovieClip("lightningClips",this.mScope.getNextHighestDepth());
      this.mOffset = new Object();
      this.mOffset.x = 0;
      this.mOffset.y = 0;
      this.mClips = new Array();
   }
   function destroy()
   {
      this.clear();
      this.mScope = null;
   }
   function clear()
   {
      this.mContainer.removeMovieClip();
      this.mContainer = null;
      this.mClips = new Array();
   }
   function create(x, y, fadeTime, delay)
   {
      var _loc3_ = this.mContainer.getNextHighestDepth();
      var _loc2_ = this.mContainer.createEmptyMovieClip("lightning" + _loc3_,_loc3_);
      this.createInternal(_loc2_,x,y,1);
      if(fadeTime != undefined)
      {
         caurina.transitions.Tweener.addTween(_loc2_,{_alpha:0,delay:delay,time:fadeTime,transition:"linear",onComplete:mx.utils.Delegate.create(this,this.removeClip),onCompleteParams:[_loc2_]});
      }
      this.mClips.push(_loc2_);
   }
   function updatePosition(x, y)
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.mClips.length)
      {
         _loc3_ = this.mClips[_loc2_];
         _loc3_._x += x;
         _loc3_._y += y;
         _loc2_ = _loc2_ + 1;
      }
   }
   function createInternal(container, x, y, generation)
   {
      var _loc11_ = container.getNextHighestDepth();
      var _loc7_ = container.createEmptyMovieClip("bolt" + _loc11_,_loc11_);
      var _loc14_ = (this.TOTAL_GENERATIONS - generation - 1) / this.TOTAL_GENERATIONS;
      var _loc3_ = (this.TOTAL_GENERATIONS - generation) / this.TOTAL_GENERATIONS;
      var _loc12_ = (_loc14_ + _loc3_) * 0.5;
      var _loc5_ = x + utils.Utils.getRandomNumber(this.X_OFFSET_MIN * _loc3_,this.X_OFFSET_MAX * _loc3_);
      var _loc4_ = y + utils.Utils.getRandomNumber(this.Y_OFFSET_MIN * _loc3_,this.Y_OFFSET_MAX * _loc3_);
      var _loc13_ = new flash.filters.GlowFilter(16777215,this.LINE_ALPHA * _loc3_,this.GLOW_OFFSET * _loc3_,this.GLOW_OFFSET * _loc3_,this.GLOW_STRENGTH * _loc3_,this.FILTER_QUALITY,false,false);
      var _loc15_ = new flash.geom.Point(x,y);
      var _loc16_ = new flash.geom.Point(_loc5_,_loc4_);
      var _loc10_ = flash.geom.Point.interpolate(_loc15_,_loc16_,0.5);
      _loc7_.lineStyle(this.LINE_THICKNESS * _loc3_,16777215,this.LINE_ALPHA * _loc3_);
      _loc7_.moveTo(x,y);
      _loc7_.lineTo(_loc10_.x,_loc10_.y);
      _loc7_.lineStyle(this.LINE_THICKNESS * _loc12_,16777215,this.LINE_ALPHA * _loc12_);
      _loc7_.moveTo(_loc10_.x,_loc10_.y);
      _loc7_.lineTo(_loc5_,_loc4_);
      _loc7_.filters = [_loc13_];
      if(generation < this.TOTAL_GENERATIONS)
      {
         var _loc8_ = utils.Utils.getRandomNumber(this.MIN_CHILDREN * _loc3_,this.MAX_CHILDREN * _loc3_,Math.floor);
         var _loc2_ = 0;
         while(_loc2_ < _loc8_)
         {
            this.createInternal(container,_loc5_,_loc4_,generation + 1);
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function getClip()
   {
      return this.mContainer;
   }
   function removeClip(clip)
   {
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.mClips.length)
      {
         _loc3_ = this.mClips[_loc2_];
         if(_loc3_ == clip)
         {
            this.mClips.splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
      clip.removeMovieClip();
   }
}
