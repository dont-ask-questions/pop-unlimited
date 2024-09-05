class utils.ColorUtils
{
   static var COLOR_BLACK = 1052688;
   static var COLOR_WHITE = 15461355;
   static var COLOR_GREY = 9868950;
   static var COLOR_LTGREY = 13158600;
   static var COLOR_BROWN = 9392128;
   static var COLOR_PINK = 13709904;
   static var COLOR_RED = 13709904;
   static var COLOR_YELLOW = 13529879;
   static var COLOR_GREEN = 41291;
   static var COLOR_BLUE = 4737228;
   static var COLOR_PURPLE = 7043307;
   static var COLOR_DKBLUE = 3027391;
   function ColorUtils()
   {
      trace("ColorUtils is a static class and should not be instantiated.");
   }
   static function setClipColor(target_mc, color, alpha)
   {
      if(typeof color == "object")
      {
         var _loc4_ = color[0] * 255;
         var _loc7_ = color[1] * 255;
         var _loc5_ = color[2] * 255;
         var _loc1_ = target_mc.transform.colorTransform;
         var _loc2_ = new flash.geom.ColorTransform();
         _loc2_.redOffset = _loc1_.redOffset * -1 + _loc4_;
         _loc2_.greenOffset = _loc1_.greenOffset * -1 + _loc7_;
         _loc2_.blueOffset = _loc1_.blueOffset * -1 + _loc5_;
         if(alpha)
         {
            _loc2_.alphaMultiplier = alpha;
         }
         _loc1_.concat(_loc2_);
         target_mc.transform.colorTransform = _loc1_;
      }
      else
      {
         var _loc8_ = new Color(target_mc);
         _loc8_.setRGB(color);
      }
   }
   static function removeClipColor(target_mc)
   {
      var _loc1_ = target_mc.transform.colorTransform;
      var _loc2_ = new flash.geom.ColorTransform();
      _loc2_.redOffset = _loc1_.redOffset * -1;
      _loc2_.greenOffset = _loc1_.greenOffset * -1;
      _loc2_.blueOffset = _loc1_.blueOffset * -1;
      _loc1_.concat(_loc2_);
      target_mc.transform.colorTransform = _loc1_;
   }
   static function convertHexToRGB(hex)
   {
      var _loc3_ = (hex >> 16 & 0xFF) / 255;
      var _loc4_ = (hex >> 8 & 0xFF) / 255;
      var _loc2_ = (hex & 0xFF) / 255;
      return [_loc3_,_loc4_,_loc2_];
   }
   static function multiplyHex(aHex, aMult)
   {
      var _loc2_ = utils.ColorUtils.convertHexToRGB(aHex);
      var _loc1_ = 0;
      while(_loc1_ != 3)
      {
         _loc2_[_loc1_] = Math.round(255 * _loc2_[_loc1_] * aMult[_loc1_]);
         if(_loc2_[_loc1_] > 255)
         {
            _loc2_[_loc1_] = 255;
         }
         else if(_loc2_[_loc1_] < 0)
         {
            _loc2_[_loc1_] = 0;
         }
         _loc1_ = _loc1_ + 1;
      }
      return (_loc2_[0] << 16) + (_loc2_[1] << 8) + _loc2_[2];
   }
   static function convertRGBtoHSV(rgb)
   {
      var _loc4_ = rgb[0];
      var _loc5_ = rgb[1];
      var _loc6_ = rgb[2];
      var _loc2_ = undefined;
      var _loc7_ = undefined;
      var _loc13_ = undefined;
      var _loc1_ = Math.max(Math.max(_loc4_,_loc5_),_loc6_);
      var _loc12_ = Math.min(Math.min(_loc4_,_loc5_),_loc6_);
      var _loc3_ = _loc1_ - _loc12_;
      _loc13_ = _loc1_;
      if(_loc3_ == 0)
      {
         _loc2_ = 0;
         _loc7_ = 0;
      }
      else
      {
         _loc7_ = _loc3_ / _loc1_;
         var _loc10_ = 60 * (_loc1_ - _loc4_) / _loc3_ + 180;
         var _loc8_ = 60 * (_loc1_ - _loc5_) / _loc3_ + 180;
         var _loc9_ = 60 * (_loc1_ - _loc6_) / _loc3_ + 180;
         if(_loc1_ == _loc4_)
         {
            _loc2_ = _loc9_ - _loc8_;
         }
         else if(_loc1_ == _loc5_)
         {
            _loc2_ = 120 + _loc10_ - _loc9_;
         }
         else
         {
            _loc2_ = 240 + _loc8_ - _loc10_;
         }
         if(_loc2_ < 0)
         {
            _loc2_ += 360;
         }
         else if(_loc2_ >= 360)
         {
            _loc2_ -= 360;
         }
      }
      return [_loc2_,_loc7_,_loc13_];
   }
   static function convertHSVtoRGB(hsv)
   {
      var _loc9_ = hsv[0];
      var _loc6_ = hsv[1];
      var _loc1_ = hsv[2];
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc2_ = undefined;
      var _loc10_ = Math.floor(_loc9_ / 60);
      var _loc11_ = _loc9_ / 60 - _loc10_;
      var _loc4_ = _loc1_ * (1 - _loc6_);
      var _loc8_ = _loc1_ * (1 - _loc11_ * _loc6_);
      var _loc7_ = _loc1_ * (1 - (1 - _loc11_) * _loc6_);
      switch(_loc10_ % 6)
      {
         case 0:
            _loc3_ = _loc1_;
            _loc5_ = _loc7_;
            _loc2_ = _loc4_;
            break;
         case 1:
            _loc3_ = _loc8_;
            _loc5_ = _loc1_;
            _loc2_ = _loc4_;
            break;
         case 2:
            _loc3_ = _loc4_;
            _loc5_ = _loc1_;
            _loc2_ = _loc7_;
            break;
         case 3:
            _loc3_ = _loc4_;
            _loc5_ = _loc8_;
            _loc2_ = _loc1_;
            break;
         case 4:
            _loc3_ = _loc7_;
            _loc5_ = _loc4_;
            _loc2_ = _loc1_;
            break;
         case 5:
            _loc3_ = _loc1_;
            _loc5_ = _loc4_;
            _loc2_ = _loc8_;
      }
      return [_loc3_,_loc5_,_loc2_];
   }
   static function convertRGBtoHSL(rgb)
   {
      var _loc4_ = rgb[0];
      var _loc5_ = rgb[1];
      var _loc6_ = rgb[2];
      var _loc1_ = undefined;
      var _loc7_ = undefined;
      var _loc10_ = undefined;
      var _loc2_ = Math.max(Math.max(_loc4_,_loc5_),_loc6_);
      var _loc13_ = Math.min(Math.min(_loc4_,_loc5_),_loc6_);
      var _loc3_ = _loc2_ - _loc13_;
      var _loc8_ = _loc2_ + _loc13_;
      _loc10_ = _loc8_ * 0.5;
      if(_loc3_ == 0)
      {
         _loc1_ = 0;
         _loc7_ = 0;
      }
      else
      {
         if(_loc10_ <= 0.5)
         {
            _loc7_ = _loc3_ / _loc8_;
         }
         else
         {
            _loc7_ = _loc3_ / (2 - _loc8_);
         }
         var _loc12_ = 60 * (_loc2_ - _loc4_) / _loc3_ + 180;
         var _loc9_ = 60 * (_loc2_ - _loc5_) / _loc3_ + 180;
         var _loc11_ = 60 * (_loc2_ - _loc6_) / _loc3_ + 180;
         if(_loc2_ == _loc4_)
         {
            _loc1_ = _loc11_ - _loc9_;
         }
         else if(_loc2_ == _loc5_)
         {
            _loc1_ = 120 + _loc12_ - _loc11_;
         }
         else
         {
            _loc1_ = 240 + _loc9_ - _loc12_;
         }
         if(_loc1_ < 0)
         {
            _loc1_ += 360;
         }
         else if(_loc1_ >= 360)
         {
            _loc1_ -= 360;
         }
      }
      return [_loc1_,_loc7_,_loc10_];
   }
   static function convertHSLtoRGB(hsl)
   {
      var _loc14_ = hsl[0];
      var _loc8_ = hsl[1];
      var _loc7_ = hsl[2];
      var _loc3_ = [0,0,0];
      var _loc5_ = undefined;
      if(_loc7_ < 0.5)
      {
         _loc5_ = _loc7_ * (1 + _loc8_);
      }
      else
      {
         _loc5_ = _loc7_ + _loc8_ - _loc7_ * _loc8_;
      }
      var _loc4_ = 2 * _loc7_ - _loc5_;
      var _loc9_ = _loc14_ / 360;
      var _loc13_ = _loc9_ + 0.3333333333333333;
      var _loc11_ = _loc9_;
      var _loc12_ = _loc9_ - 0.3333333333333333;
      var _loc6_ = [_loc13_,_loc11_,_loc12_];
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         var _loc1_ = _loc6_[_loc2_];
         if(_loc1_ < 0)
         {
            _loc1_ += 1;
         }
         if(_loc1_ > 1)
         {
            _loc1_ -= 1;
         }
         if(_loc1_ < 0.16666666666666666)
         {
            _loc3_[_loc2_] = _loc4_ + (_loc5_ - _loc4_) * 6 * _loc1_;
         }
         else if(_loc1_ < 0.5)
         {
            _loc3_[_loc2_] = _loc5_;
         }
         else if(_loc1_ < 0.6666666666666666)
         {
            _loc3_[_loc2_] = _loc4_ + (_loc5_ - _loc4_) * 6 * (0.6666666666666666 - _loc1_);
         }
         else
         {
            _loc3_[_loc2_] = _loc4_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
}
