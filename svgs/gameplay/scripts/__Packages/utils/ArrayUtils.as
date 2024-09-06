class utils.ArrayUtils
{
   function ArrayUtils()
   {
      trace("ArrayUtils is a static class and should not be instantiated.");
   }
   static function copy2DArray(sourceArray)
   {
      var _loc3_ = [];
      var _loc1_ = 0;
      while(_loc1_ < sourceArray.length)
      {
         _loc3_[_loc1_] = sourceArray[_loc1_].slice();
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function shuffleArray(targetArray)
   {
      var _loc6_ = targetArray[targetArray.length - 1];
      var _loc2_ = 0;
      while(_loc2_ < targetArray.length)
      {
         var _loc4_ = targetArray[_loc2_];
         var _loc3_ = Math.floor(Math.random() * targetArray.length);
         targetArray[_loc2_] = targetArray[_loc3_];
         targetArray[_loc3_] = _loc4_;
         _loc2_ = _loc2_ + 1;
      }
      if(targetArray[0] == _loc6_)
      {
         var _loc7_ = targetArray[0];
         var _loc5_ = Math.ceil(Math.random() * (targetArray.length - 1));
         targetArray[0] = targetArray[_loc5_];
         targetArray[_loc5_] = _loc7_;
      }
   }
   static function removeElement(element, targetArray)
   {
      var _loc1_ = 0;
      while(_loc1_ < targetArray.length)
      {
         if(targetArray[_loc1_] == element)
         {
            targetArray.splice(_loc1_,1);
         }
         else
         {
            _loc1_ = _loc1_ + 1;
         }
      }
   }
   static function removePoint(point, targetArray)
   {
      var _loc1_ = 0;
      while(_loc1_ < targetArray.length)
      {
         if(targetArray[_loc1_].x == point.x && targetArray[_loc1_].y == point.y)
         {
            targetArray.splice(_loc1_,1);
         }
         else
         {
            _loc1_ = _loc1_ + 1;
         }
      }
   }
   static function removeElements(elements, targetArray)
   {
      var _loc2_ = 0;
      while(_loc2_ < elements.length)
      {
         var _loc1_ = 0;
         while(_loc1_ < targetArray.length)
         {
            if(targetArray[_loc1_] == elements[_loc2_])
            {
               targetArray.splice(_loc1_,1);
               _loc1_ = _loc1_ - 1;
            }
            _loc1_ = _loc1_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   static function searchArray(element, targetArray)
   {
      var _loc1_ = 0;
      while(_loc1_ < targetArray.length)
      {
         if(targetArray[_loc1_] == element)
         {
            return true;
         }
         _loc1_ = _loc1_ + 1;
      }
      return false;
   }
   static function findElements(elements, targetArray, dupes)
   {
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < elements.length)
      {
         var _loc1_ = 0;
         while(_loc1_ < targetArray.length)
         {
            if(targetArray[_loc1_] == elements[_loc4_])
            {
               if(dupes)
               {
                  _loc3_.push(targetArray[_loc1_]);
               }
               else if(!utils.ArrayUtils.searchArray(targetArray[_loc1_],_loc3_))
               {
                  _loc3_.push(targetArray[_loc1_]);
               }
            }
            _loc1_ = _loc1_ + 1;
         }
         _loc4_ = _loc4_ + 1;
      }
      return _loc3_;
   }
   static function removeDupes(targetArray)
   {
      var _loc3_ = new Array();
      var _loc1_ = 0;
      targetArray = targetArray.sort();
      while(targetArray.length > _loc1_)
      {
         if(!utils.ArrayUtils.searchArray(targetArray[_loc1_],targetArray.slice(_loc1_ + 1)))
         {
            _loc3_.push(targetArray[_loc1_]);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   static function getIndex(element, targetArray)
   {
      var _loc1_ = 0;
      while(_loc1_ < targetArray.length)
      {
         if(targetArray[_loc1_] == element)
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return -1;
   }
   static function rotate2DArray(array)
   {
      var _loc3_ = array.length;
      var _loc7_ = array[0].length;
      var _loc6_ = new Array(_loc7_);
      var _loc2_ = 0;
      while(_loc2_ < _loc7_)
      {
         var _loc4_ = new Array(_loc3_);
         var _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc4_[_loc1_] = array[_loc3_ - 1 - _loc1_][_loc2_];
            _loc1_ = _loc1_ + 1;
         }
         _loc6_[_loc2_] = _loc4_;
         _loc2_ = _loc2_ + 1;
      }
      return _loc6_;
   }
   static function trace2DArray(array)
   {
      var _loc2_ = "[";
      var _loc1_ = 0;
      while(_loc1_ < array.length)
      {
         if(_loc1_ != 0)
         {
            _loc2_ += " ";
         }
         _loc2_ += "[" + array[_loc1_].join(",") + "]";
         if(_loc1_ != array.length - 1)
         {
            _loc2_ += ",\n";
         }
         _loc1_ = _loc1_ + 1;
      }
      trace(_loc2_ + "]");
   }
   static function convertArrayToURLEncoding(sourceArray, targetArrayName, targetObject)
   {
      var _loc1_ = 0;
      while(_loc1_ < sourceArray.length)
      {
         targetObject[targetArrayName + "[" + _loc1_ + "]"] = sourceArray[_loc1_];
         _loc1_ = _loc1_ + 1;
      }
   }
   static function convertAssociativeArrayToURLEncoding(sourceArray, targetArrayName, targetObject)
   {
      for(var _loc3_ in sourceArray)
      {
         targetObject[targetArrayName + "[" + _loc3_ + "]"] = sourceArray[_loc3_];
      }
   }
   static function fillArray(sourceArray, fillElement, total)
   {
      if(total == undefined)
      {
         total = sourceArray.length;
      }
      else
      {
         sourceArray = new Array(total);
      }
      var _loc1_ = 0;
      while(_loc1_ < total)
      {
         sourceArray[_loc1_] = fillElement;
         _loc1_ = _loc1_ + 1;
      }
   }
   static function reverse(sourceArray)
   {
      var _loc3_ = undefined;
      var _loc1_ = 0;
      while(_loc1_ < Math.floor(sourceArray.length * 0.5))
      {
         _loc3_ = sourceArray[_loc1_];
         sourceArray[_loc1_] = sourceArray[sourceArray.length - _loc1_ - 1];
         sourceArray[sourceArray.length - _loc1_ - 1] = _loc3_;
         _loc1_ = _loc1_ + 1;
      }
   }
}
