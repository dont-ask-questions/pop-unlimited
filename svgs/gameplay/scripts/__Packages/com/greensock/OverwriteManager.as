class com.greensock.OverwriteManager
{
   static var mode;
   static var enabled;
   static var version = 6.02;
   static var NONE = 0;
   static var ALL_IMMEDIATE = 1;
   static var AUTO = 2;
   static var CONCURRENT = 3;
   static var ALL_ONSTART = 4;
   static var PREEXISTING = 5;
   function OverwriteManager()
   {
   }
   static function init(defaultMode)
   {
      if(com.greensock.TweenLite.version < 11.1)
      {
         trace("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
      }
      com.greensock.TweenLite.overwriteManager = com.greensock.OverwriteManager;
      com.greensock.OverwriteManager.mode = defaultMode != undefined ? defaultMode : 2;
      com.greensock.OverwriteManager.enabled = true;
      return com.greensock.OverwriteManager.mode;
   }
   static function manageOverwrites(tween, props, targetTweens, mode)
   {
      var _loc3_ = undefined;
      var _loc9_ = undefined;
      var _loc1_ = undefined;
      if(mode >= 4)
      {
         var _loc17_ = targetTweens.length;
         _loc3_ = 0;
         while(_loc3_ < _loc17_)
         {
            _loc1_ = targetTweens[_loc3_];
            if(_loc1_ != tween)
            {
               if(_loc1_.setEnabled(false,false))
               {
                  _loc9_ = true;
               }
            }
            else if(mode == 5)
            {
               break;
            }
            _loc3_ = _loc3_ + 1;
         }
         return _loc9_;
      }
      var _loc7_ = tween.cachedStartTime + 1e-10;
      var _loc8_ = [];
      var _loc13_ = [];
      var _loc15_ = 0;
      var _loc12_ = 0;
      _loc3_ = targetTweens.length;
      while((_loc3_ = _loc3_ - 1) > -1)
      {
         _loc1_ = targetTweens[_loc3_];
         if(!(_loc1_ == tween || _loc1_.gc))
         {
            if(_loc1_.timeline != tween.timeline)
            {
               if(!com.greensock.OverwriteManager.getGlobalPaused(_loc1_))
               {
                  _loc13_[_loc15_++] = _loc1_;
               }
            }
            else if(_loc1_.cachedStartTime <= _loc7_ && _loc1_.cachedStartTime + _loc1_.totalDuration + 1e-10 > _loc7_ && !com.greensock.OverwriteManager.getGlobalPaused(_loc1_))
            {
               _loc8_[_loc12_++] = _loc1_;
            }
         }
      }
      if(_loc15_ != 0)
      {
         var _loc5_ = tween.cachedTimeScale;
         var _loc6_ = _loc7_;
         var _loc4_ = undefined;
         var _loc11_ = undefined;
         var _loc2_ = undefined;
         _loc2_ = tween.timeline;
         while(_loc2_)
         {
            _loc5_ *= _loc2_.cachedTimeScale;
            _loc6_ += _loc2_.cachedStartTime;
            _loc2_ = _loc2_.timeline;
         }
         _loc7_ = _loc5_ * _loc6_;
         _loc3_ = _loc15_;
         while((_loc3_ = _loc3_ - 1) > -1)
         {
            _loc4_ = _loc13_[_loc3_];
            _loc5_ = _loc4_.cachedTimeScale;
            _loc6_ = _loc4_.cachedStartTime;
            _loc2_ = _loc4_.timeline;
            while(_loc2_)
            {
               _loc5_ *= _loc2_.cachedTimeScale;
               _loc6_ += _loc2_.cachedStartTime;
               _loc2_ = _loc2_.timeline;
            }
            _loc11_ = _loc5_ * _loc6_;
            if(_loc11_ <= _loc7_ && (_loc11_ + _loc4_.totalDuration * _loc5_ + 1e-10 > _loc7_ || _loc4_.cachedDuration == 0))
            {
               _loc8_[_loc12_++] = _loc4_;
            }
         }
      }
      if(_loc12_ == 0)
      {
         return _loc9_;
      }
      _loc3_ = _loc12_;
      if(mode == 2)
      {
         while((_loc3_ = _loc3_ - 1) > -1)
         {
            _loc1_ = _loc8_[_loc3_];
            if(_loc1_.killVars(props))
            {
               _loc9_ = true;
            }
            if(_loc1_.cachedPT1 == undefined && _loc1_.initted)
            {
               _loc1_.setEnabled(false,false);
            }
         }
      }
      else
      {
         while((_loc3_ = _loc3_ - 1) > -1)
         {
            if(_loc8_[_loc3_].setEnabled(false,false))
            {
               _loc9_ = true;
            }
         }
      }
      return _loc9_;
   }
   static function getGlobalPaused(tween)
   {
      while(tween)
      {
         if(tween.cachedPaused)
         {
            return true;
         }
         tween = tween.timeline;
      }
      return false;
   }
}
