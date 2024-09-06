class com.greensock.plugins.BezierPlugin extends com.greensock.plugins.TweenPlugin
{
   var propName;
   var overwriteProps;
   var _future;
   var _target;
   var _orientData;
   var _orient;
   var _beziers;
   var round;
   static var API = 1;
   static var _RAD2DEG = 57.29577951308232;
   function BezierPlugin()
   {
      super();
      this.propName = "bezier";
      this.overwriteProps = [];
      this._future = {};
   }
   function onInitTween(target, value, tween)
   {
      if(!(value instanceof Array))
      {
         return false;
      }
      this.init(tween,[value][0],false);
      return true;
   }
   function init(tween, beziers, through)
   {
      this._target = tween.target;
      var _loc7_ = tween.vars;
      if(_loc7_.orientToBezier == true)
      {
         this._orientData = [["_x","_y","_rotation",0,0.01]];
         this._orient = true;
      }
      else if(_loc7_.orientToBezier instanceof Array)
      {
         this._orientData = _loc7_.orientToBezier;
         this._orient = true;
      }
      var _loc3_ = {};
      var _loc4_ = undefined;
      var _loc2_ = undefined;
      var _loc8_ = undefined;
      _loc4_ = 0;
      while(_loc4_ < beziers.length)
      {
         for(_loc2_ in beziers[_loc4_])
         {
            if(_loc3_[_loc2_] == undefined)
            {
               _loc3_[_loc2_] = [tween.target[_loc2_]];
            }
            if(typeof beziers[_loc4_][_loc2_] == "number")
            {
               _loc3_[_loc2_].push(beziers[_loc4_][_loc2_]);
            }
            else
            {
               _loc3_[_loc2_].push(tween.target[_loc2_] + Number(beziers[_loc4_][_loc2_]));
            }
         }
         _loc4_ = _loc4_ + 1;
      }
      for(_loc2_ in _loc3_)
      {
         this.overwriteProps[this.overwriteProps.length] = _loc2_;
         if(_loc7_[_loc2_] != undefined)
         {
            if(typeof _loc7_[_loc2_] == "number")
            {
               _loc3_[_loc2_].push(_loc7_[_loc2_]);
            }
            else
            {
               _loc3_[_loc2_].push(tween.target[_loc2_] + Number(_loc7_[_loc2_]));
            }
            _loc8_ = {};
            _loc8_[_loc2_] = true;
            tween.killVars(_loc8_,false);
            delete _loc7_[_loc2_];
         }
      }
      this._beziers = com.greensock.plugins.BezierPlugin.parseBeziers(_loc3_,through);
   }
   static function parseBeziers(props, through)
   {
      var _loc2_ = undefined;
      var _loc1_ = undefined;
      var _loc3_ = undefined;
      var _loc4_ = undefined;
      var _loc6_ = {};
      if(through == true)
      {
         for(_loc4_ in props)
         {
            _loc1_ = props[_loc4_];
            _loc6_[_loc4_] = _loc3_ = [];
            if(_loc1_.length > 2)
            {
               _loc3_[_loc3_.length] = [_loc1_[0],_loc1_[1] - (_loc1_[2] - _loc1_[0]) / 4,_loc1_[1]];
               _loc2_ = 1;
               while(_loc2_ < _loc1_.length - 1)
               {
                  _loc3_[_loc3_.length] = [_loc1_[_loc2_],_loc1_[_loc2_] + (_loc1_[_loc2_] - _loc3_[_loc2_ - 1][1]),_loc1_[_loc2_ + 1]];
                  _loc2_ = _loc2_ + 1;
               }
            }
            else
            {
               _loc3_[_loc3_.length] = [_loc1_[0],(_loc1_[0] + _loc1_[1]) / 2,_loc1_[1]];
            }
         }
      }
      else
      {
         for(_loc4_ in props)
         {
            _loc1_ = props[_loc4_];
            _loc6_[_loc4_] = _loc3_ = [];
            if(_loc1_.length > 3)
            {
               _loc3_[_loc3_.length] = [_loc1_[0],_loc1_[1],(_loc1_[1] + _loc1_[2]) / 2];
               _loc2_ = 2;
               while(_loc2_ < _loc1_.length - 2)
               {
                  _loc3_[_loc3_.length] = [_loc3_[_loc2_ - 2][2],_loc1_[_loc2_],(_loc1_[_loc2_] + _loc1_[_loc2_ + 1]) / 2];
                  _loc2_ = _loc2_ + 1;
               }
               _loc3_[_loc3_.length] = [_loc3_[_loc3_.length - 1][2],_loc1_[_loc1_.length - 2],_loc1_[_loc1_.length - 1]];
            }
            else if(_loc1_.length == 3)
            {
               _loc3_[_loc3_.length] = [_loc1_[0],_loc1_[1],_loc1_[2]];
            }
            else if(_loc1_.length == 2)
            {
               _loc3_[_loc3_.length] = [_loc1_[0],(_loc1_[0] + _loc1_[1]) / 2,_loc1_[1]];
            }
         }
      }
      return _loc6_;
   }
   function killProps(lookup)
   {
      for(var _loc4_ in this._beziers)
      {
         if(lookup[_loc4_] != undefined)
         {
            delete this._beziers[_loc4_];
         }
      }
      super.killProps(lookup);
   }
   function set changeFactor(n)
   {
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc6_ = undefined;
      var _loc7_ = undefined;
      var _loc15_ = undefined;
      var _loc16_ = undefined;
      if(n == 1)
      {
         for(_loc5_ in this._beziers)
         {
            _loc3_ = this._beziers[_loc5_].length - 1;
            this._target[_loc5_] = this._beziers[_loc5_][_loc3_][2];
         }
      }
      else
      {
         for(_loc5_ in this._beziers)
         {
            _loc7_ = this._beziers[_loc5_].length;
            if(n < 0)
            {
               _loc3_ = 0;
            }
            else if(n >= 1)
            {
               _loc3_ = _loc7_ - 1;
            }
            else
            {
               _loc3_ = _loc7_ * n >> 0;
            }
            _loc6_ = (n - _loc3_ * (1 / _loc7_)) * _loc7_;
            _loc4_ = this._beziers[_loc5_][_loc3_];
            if(this.round)
            {
               this._target[_loc5_] = Math.round(_loc4_[0] + _loc6_ * (2 * (1 - _loc6_) * (_loc4_[1] - _loc4_[0]) + _loc6_ * (_loc4_[2] - _loc4_[0])));
            }
            else
            {
               this._target[_loc5_] = _loc4_[0] + _loc6_ * (2 * (1 - _loc6_) * (_loc4_[1] - _loc4_[0]) + _loc6_ * (_loc4_[2] - _loc4_[0]));
            }
         }
      }
      if(this._orient == true)
      {
         _loc3_ = this._orientData.length;
         var _loc9_ = {};
         var _loc11_ = undefined;
         var _loc10_ = undefined;
         var _loc2_ = undefined;
         var _loc12_ = undefined;
         while(_loc3_-- > 0)
         {
            _loc2_ = this._orientData[_loc3_];
            _loc9_[_loc2_[0]] = this._target[_loc2_[0]];
            _loc9_[_loc2_[1]] = this._target[_loc2_[1]];
         }
         var _loc13_ = this._target;
         var _loc14_ = this.round;
         this._target = this._future;
         this.round = false;
         this._orient = false;
         _loc3_ = this._orientData.length;
         while(_loc3_-- > 0)
         {
            _loc2_ = this._orientData[_loc3_];
            this.changeFactor = n + (_loc2_[4] || 0.01);
            _loc12_ = _loc2_[3] || 0;
            _loc11_ = this._future[_loc2_[0]] - _loc9_[_loc2_[0]];
            _loc10_ = this._future[_loc2_[1]] - _loc9_[_loc2_[1]];
            _loc13_[_loc2_[2]] = Math.atan2(_loc10_,_loc11_) * com.greensock.plugins.BezierPlugin._RAD2DEG + _loc12_;
         }
         this._target = _loc13_;
         this.round = _loc14_;
         this._orient = true;
      }
   }
}
