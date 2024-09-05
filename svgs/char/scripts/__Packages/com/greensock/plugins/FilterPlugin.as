class com.greensock.plugins.FilterPlugin extends com.greensock.plugins.TweenPlugin
{
   var _target;
   var _index;
   var _type;
   var _filter;
   var _remove;
   var onComplete;
   var _tweens;
   var propName;
   static var VERSION = 2.03;
   static var API = 1;
   function FilterPlugin()
   {
      super();
   }
   function initFilter(props, defaultFilter, propNames)
   {
      var _loc6_ = this._target.filters;
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc7_ = !(props instanceof flash.filters.BitmapFilter) ? props : {};
      this._index = -1;
      if(_loc7_.index != undefined)
      {
         this._index = _loc7_.index;
      }
      else
      {
         _loc3_ = _loc6_.length;
         while(_loc3_--)
         {
            if(_loc6_[_loc3_] instanceof this._type)
            {
               this._index = _loc3_;
               break;
            }
         }
      }
      if(this._index == -1 || _loc6_[this._index] == undefined || _loc7_.addFilter == true)
      {
         this._index = _loc7_.index == undefined ? _loc6_.length : _loc7_.index;
         _loc6_[this._index] = defaultFilter;
         this._target.filters = _loc6_;
      }
      this._filter = _loc6_[this._index];
      if(_loc7_.remove == true)
      {
         this._remove = true;
         this.onComplete = this.onCompleteTween;
      }
      _loc3_ = propNames.length;
      while(_loc3_--)
      {
         _loc2_ = propNames[_loc3_];
         if(props[_loc2_] != undefined && this._filter[_loc2_] != props[_loc2_])
         {
            if(_loc2_ == "color" || _loc2_ == "highlightColor" || _loc2_ == "shadowColor")
            {
               _loc5_ = new com.greensock.plugins.HexColorsPlugin();
               _loc5_.initColor(this._filter,_loc2_,this._filter[_loc2_],props[_loc2_]);
               this._tweens[this._tweens.length] = new com.greensock.core.PropTween(_loc5_,"changeFactor",0,1,this.propName);
            }
            else if(_loc2_ == "quality" || _loc2_ == "inner" || _loc2_ == "knockout" || _loc2_ == "hideObject")
            {
               this._filter[_loc2_] = props[_loc2_];
            }
            else
            {
               this.addTween(this._filter,_loc2_,this._filter[_loc2_],props[_loc2_],this.propName);
            }
         }
      }
   }
   function onCompleteTween()
   {
      if(this._remove)
      {
         var _loc3_ = this._target.filters;
         if(!(_loc3_[this._index] instanceof this._type))
         {
            var _loc2_ = _loc3_.length;
            while(_loc2_--)
            {
               if(_loc3_[_loc2_] instanceof this._type)
               {
                  _loc3_.splice(_loc2_,1);
                  break;
               }
            }
         }
         else
         {
            _loc3_.splice(this._index,1);
         }
         this._target.filters = _loc3_;
      }
   }
   function set changeFactor(n)
   {
      var _loc2_ = this._tweens.length;
      var _loc3_ = undefined;
      var _loc4_ = this._target.filters;
      while(_loc2_--)
      {
         _loc3_ = this._tweens[_loc2_];
         _loc3_.target[_loc3_.property] = _loc3_.start + _loc3_.change * n;
      }
      if(!(_loc4_[this._index] instanceof this._type))
      {
         var _loc0_ = null;
         _loc2_ = this._index = _loc4_.length;
         while(_loc2_--)
         {
            if(_loc4_[_loc2_] instanceof this._type)
            {
               this._index = _loc2_;
               break;
            }
         }
      }
      _loc4_[this._index] = this._filter;
      this._target.filters = _loc4_;
   }
}
