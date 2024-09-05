class utils.Utils
{
   static var dispatchEvent;
   function Utils()
   {
      trace("Utils is a static class and should not be instantiated.");
   }
   static function getRandomNumber(minVal, maxVal, op)
   {
      var _loc1_ = minVal + Math.random() * (maxVal - minVal);
      if(op != undefined)
      {
         _loc1_ = op.apply(null,[_loc1_]);
      }
      return _loc1_;
   }
   static function getRandomCharge()
   {
      if(Math.random() * 2 > 1)
      {
         return 1;
      }
      return -1;
   }
   static function pickRandomNumber(vals)
   {
      return vals[utils.Utils.getRandomNumber(0,vals.length,Math.floor)];
   }
   static function pickRandomElement(vals)
   {
      return vals[utils.Utils.getRandomNumber(0,vals.length,Math.floor)];
   }
   static function pickRandomElements(vals, total)
   {
      if(vals.length > total)
      {
         var _loc2_ = vals.slice();
         var _loc4_ = new Array();
         var _loc3_ = undefined;
         var _loc1_ = 0;
         while(_loc1_ < total)
         {
            _loc3_ = utils.Utils.getRandomNumber(0,_loc2_.length,Math.floor);
            _loc4_.push(_loc2_[_loc3_]);
            _loc2_.splice(_loc3_,1);
            _loc1_ = _loc1_ + 1;
         }
         return _loc4_;
      }
      return vals;
   }
   static function showBanner(target, label, time, fade, kill, fontSize, font, fontColor, borderColor, fontBold)
   {
      var _loc4_ = target.getNextHighestDepth();
      var _loc1_ = target.createTextField("banner" + _loc4_,_loc4_,0,0,640,480);
      if(fontSize == undefined)
      {
         fontSize = 60;
      }
      if(font == undefined)
      {
         font = "CreativeBlock BB";
      }
      if(fontColor == undefined)
      {
         fontColor = 16777215;
      }
      if(borderColor == undefined)
      {
         borderColor = 1286141;
      }
      if(fontBold == undefined)
      {
         fontBold = false;
      }
      _loc1_.text = label;
      _loc1_.selectable = false;
      _loc1_.wordWrap = true;
      _loc1_.multiline = true;
      _loc1_.autoSize = true;
      _loc1_.antiAliasType = "normal";
      _loc1_.embedFonts = true;
      var _loc3_ = new TextFormat();
      _loc3_.size = fontSize;
      _loc3_.color = fontColor;
      _loc3_.font = font;
      _loc3_.align = "center";
      _loc3_.bold = fontBold;
      _loc1_.setTextFormat(_loc3_);
      var _loc7_ = new flash.filters.GlowFilter(borderColor,100,4,4,999,1,false,false);
      _loc1_.filters = [_loc7_];
      _loc1_._y += 240 - _loc1_.textHeight * 0.5;
      var _loc2_ = new Object();
      _loc2_.time = time;
      if(kill)
      {
         _loc2_.onComplete = Delegate.create(utils.Utils,utils.Utils.bannerDone);
         _loc2_.onCompleteParams = [_loc1_];
      }
      if(fade)
      {
         _loc2_.delay = time * 0.5;
         _loc2_.time = time * 0.5;
         _loc2_._alpha = 0;
      }
      _loc2_.transition = "linear";
      caurina.transitions.Tweener.addTween(_loc1_,_loc2_);
   }
   static function bannerDone(clip)
   {
      clip.removeTextField();
   }
   static function isNull(value)
   {
      if(value == undefined || String(value).toLowerCase() == "undefined" || utils.Utils.onlySpaces(value) || value == null || String(value).toLowerCase() == "null" || String(value).toLowerCase() == "nan" || value.length < 1)
      {
         return true;
      }
      return false;
   }
   static function removeSpaces(input)
   {
      var _loc3_ = "";
      var _loc1_ = 0;
      while(_loc1_ < input.length)
      {
         if(input.charAt(_loc1_) != " ")
         {
            _loc3_ += input.charAt(_loc1_);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function onlySpaces(stringToCheck)
   {
      var _loc1_ = stringToCheck.split(" ");
      var _loc2_ = _loc1_.join("");
      if(length(_loc2_) == 0)
      {
         return true;
      }
      return false;
   }
   static function outOfBounds(x, y, width, height, padding)
   {
      if(padding == undefined)
      {
         padding = 0;
      }
      return x > width + padding || x < - padding || y > height + padding || y < - padding;
   }
   static function roundToKiloBytes(bytes)
   {
      var _loc2_ = bytes / 1024;
      var _loc1_ = 10240;
      if(_loc2_ < 10240)
      {
         _loc1_ = 1024;
         if(_loc2_ < 1024)
         {
            _loc1_ = 512;
            if(_loc2_ < 512)
            {
               _loc1_ = 128;
               if(_loc2_ < 128)
               {
                  _loc1_ = 32;
                  if(_loc2_ < 32)
                  {
                     _loc1_ = 10;
                     if(_loc2_ < 10)
                     {
                        _loc1_ = 0;
                     }
                  }
               }
            }
         }
      }
      return _loc1_;
   }
   static function stringReplace(block, find, replace)
   {
      return block.split(find).join(replace);
   }
   static function init()
   {
      mx.events.EventDispatcher.initialize(utils.Utils);
   }
   static function distance(x1, y1, x2, y2)
   {
      var _loc2_ = x2 - x1;
      var _loc1_ = y2 - y1;
      return Math.sqrt(_loc2_ * _loc2_ + _loc1_ * _loc1_);
   }
   static function popup(scope, popupName, showCloseButton)
   {
      if(!scope.camera.scene.pausedGame)
      {
         scope.pauseGame();
      }
      scope.popupBack.btnClose._visible = showCloseButton;
      scope.popupClose._visible = showCloseButton;
      scope.popupBack._visible = true;
      scope.createEmptyMovieClip("popupClip",scope.popupDepth);
      var _loc3_ = new MovieClipLoader();
      var _loc2_ = new Object();
      _loc2_.onLoadInit = function(target)
      {
         utils.Utils.dispatchEvent({type:"PopupLoadComplete",target:target});
      };
      _loc2_.onLoadError = function(target)
      {
         utils.Utils.dispatchEvent({type:"PopupLoadError",target:target});
      };
      _loc3_.addListener(_loc2_);
      _loc3_.loadClip("popups/" + popupName,scope.popupClip);
      scope.turnOffWardrobe();
   }
   static function copyObject(source)
   {
      var _loc2_ = new Object();
      for(var _loc3_ in source)
      {
         if(source[_loc3_] instanceof Array)
         {
            _loc2_[_loc3_] = utils.Utils.copyArray(source[_loc3_]);
         }
         else if(source[_loc3_] instanceof Object)
         {
            _loc2_[_loc3_] = utils.Utils.copyObject(source[_loc3_]);
         }
         else
         {
            _loc2_[_loc3_] = source[_loc3_];
         }
      }
      return _loc2_;
   }
   static function copyArray(source)
   {
      var _loc3_ = [];
      var _loc4_ = source.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc4_)
      {
         if(source[_loc1_] instanceof Array)
         {
            _loc3_[_loc1_] = utils.Utils.copyArray[source[_loc1_]];
         }
         else if(source[_loc1_] instanceof Object)
         {
            _loc3_[_loc1_] = utils.Utils.copyObject(source[_loc1_]);
         }
         else
         {
            _loc3_[_loc1_] = source[_loc1_];
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function addLineBreaks(str)
   {
      var _loc2_ = str.split(" ");
      var _loc5_ = 20;
      var _loc3_ = 0;
      var _loc4_ = "";
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         if(_loc3_ + _loc2_[_loc1_].length + 1 > _loc5_)
         {
            _loc4_ += "\n";
            _loc3_ = 0;
         }
         _loc4_ += _loc2_[_loc1_] + " ";
         _loc3_ += _loc2_[_loc1_].length + 1;
         _loc1_ = _loc1_ + 1;
      }
      return _loc4_;
   }
   static function reverseString(str)
   {
      var _loc3_ = "";
      var _loc1_ = str.length - 1;
      while(_loc1_ >= 0)
      {
         _loc3_ += str.charAt(_loc1_);
         _loc1_ = _loc1_ - 1;
      }
      return _loc3_;
   }
   static function checkDateRange(target, startRange, endRange)
   {
      if(target[0] >= startRange[0] && target[0] <= endRange[0])
      {
         if(target[0] == endRange[0])
         {
            if(!(startRange[0] == endRange[0] && (target[1] >= startRange[1] && target[1] <= endRange[1]) || startRange[0] < endRange[0] && target[1] <= endRange[1]))
            {
               return false;
            }
            if(target[1] == endRange[1])
            {
               if(!(startRange[1] == endRange[1] && (target[2] >= startRange[2] && target[2] <= endRange[2]) || startRange[1] < endRange[1] && target[2] <= endRange[2]))
               {
                  return false;
               }
            }
         }
         return true;
      }
   }
}
