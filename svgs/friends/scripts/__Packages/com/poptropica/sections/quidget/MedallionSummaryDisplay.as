class com.poptropica.sections.quidget.MedallionSummaryDisplay extends Object
{
   var _islandsCompleted;
   var _container;
   var _medallionWidth;
   var _totalWidth;
   var _centerX;
   var _centerY;
   var damp;
   var medallionsArray;
   var numMedallions;
   var islandNames;
   var basePadding;
   var maxPadding;
   var minPadding;
   var uncollectedMedalFilters;
   var selectedMedallion;
   function MedallionSummaryDisplay()
   {
      super();
   }
   function init(__mc, __islandsCompleted)
   {
      var _loc2_ = com.poptropica.sections.friendsHub.Quilt.getInstance();
      trace("[MedallionSummaryDisplay] init :: _islandsCompleted before " + _loc2_.countProps(this._islandsCompleted));
      com.poptropica.models.PopModelConst.avatar.updateIslandData("Carrot_as3",Delegate.create(this,this.setup,__mc,__islandsCompleted));
      trace("[MedallionSummaryDisplay] init :: _islandsCompleted after " + _loc2_.countProps(this._islandsCompleted));
   }
   function setup(mc, completions)
   {
      trace("[MedallionSummaryDisplay] setup :: _islandsCompleted before " + com.poptropica.sections.friendsHub.Quilt.getInstance().countProps(this._islandsCompleted));
      this._container = mc;
      this.updateIslandLists(completions);
      this._medallionWidth = 100;
      this._totalWidth = 600;
      this._centerX = 0;
      this._centerY = 0;
      this.damp = 0.8;
      this.medallionsArray = new Array();
      this.numMedallions = this.islandNames.length;
      this.basePadding = this._totalWidth / (this.numMedallions - 1);
      this.maxPadding = this._medallionWidth * 2 - 20;
      this.minPadding = (this._totalWidth - this.maxPadding) / (this.numMedallions - 1);
      this.addMedallions();
      this.positionMedallions();
      this._container.onEnterFrame = Delegate.create(this,this.positionMedallions);
      this._container.filterClip._visible = false;
      this.uncollectedMedalFilters = this._container.filterClip.filters;
      trace("uncollectedMedalFilters:" + this.uncollectedMedalFilters);
   }
   function updateIslandLists(completions)
   {
      var _loc3_ = "_as3";
      this._islandsCompleted = completions;
      this.islandNames = com.poptropica.sections.friendsHub.FriendsModel.getInstance().islandNames.concat();
      this.islandNames.push({id:"5",name:"Carrot",island_full_name:"24 Carrot Island"});
      var _loc4_ = this.extractNames(this.islandNames);
      var _loc5_ = 0;
      var _loc8_ = this._islandsCompleted.hasOwnProperty("Carrot_as3");
      for(var _loc6_ in this._islandsCompleted)
      {
         var _loc2_ = -1 == utils.ArrayUtils.getIndex(_loc6_,_loc4_);
         if(_loc2_)
         {
            if("Carrot" == _loc6_)
            {
               _loc5_ = this._islandsCompleted.Carrot;
            }
            if("Carrot" != _loc6_)
            {
               this._islandsCompleted[_loc6_ + _loc3_] = 0;
            }
            this._islandsCompleted[_loc6_ + _loc3_] += this._islandsCompleted[_loc6_];
         }
      }
      if(_loc8_)
      {
         var _loc7_ = this._islandsCompleted.Carrot_as3;
         if(_loc7_ > 1)
         {
            trace("WARNING: unexpected number of completions for \'Carrot_as3\', got " + _loc7_ + ", but only expected one");
            this._islandsCompleted.Carrot_as3 = 1;
         }
      }
      else
      {
         var _loc9_ = this.findIslandIndex("Carrot_as3");
         this.islandNames.splice(_loc9_,1);
      }
   }
   function Xsetup(__mc, __islandsCompleted)
   {
      this._container = __mc;
      this.islandNames = com.poptropica.sections.friendsHub.FriendsModel.getInstance().islandNames.concat();
      this._islandsCompleted = __islandsCompleted;
      var _loc11_ = false;
      trace("[MedallionSummaryDisplay] AS3Embassy :: Displaying medallionsv5 : " + this._islandsCompleted);
      for(var _loc12_ in this._islandsCompleted)
      {
         trace("island " + _loc12_ + " has " + this._islandsCompleted[_loc12_] + " completions");
      }
      if(com.poptropica.models.PopModelConst.avatar.checkItem(1035,"Carrot_as3"))
      {
         this._islandsCompleted.push({name:"Carrot_as3"});
         trace("[MedallionSummaryDisplay] AS3Embassy :: CarrotBeta completed!");
         _loc11_ = true;
      }
      var _loc7_ = this.extractNames(this.islandNames);
      trace("here are the names of all the islands");
      var _loc6_ = 0;
      while(_loc6_ < _loc7_.length)
      {
         trace(_loc7_[_loc6_]);
         _loc6_ = _loc6_ + 1;
      }
      var _loc4_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this.islandNames.length)
      {
         _loc4_ = this.islandNames[_loc2_].name;
         trace("[MedallionSummaryDisplay] AS3Embassy :: Checking island name : " + _loc4_ + " completions: " + this._islandsCompleted[_loc4_]);
         if(_loc4_ == "Carrot_as3")
         {
            if(!_loc11_)
            {
               trace("[MedallionSummaryDisplay] AS3Embassy :: CarrotBeta not complete, removing medallion.");
               this.islandNames.splice(_loc2_,1);
            }
         }
         else if(_loc4_.indexOf("_as3") > -1)
         {
            var _loc5_ = this.convertIslandToAS2Format(this.islandNames[_loc2_].name);
            var _loc8_ = utils.ArrayUtils.getIndex(_loc5_,_loc7_);
            if(-1 == _loc8_)
            {
               this.islandNames[_loc2_].name = _loc5_;
               this._islandsCompleted[_loc5_] = this._islandsCompleted[_loc4_];
               trace("[MedallionSummaryDisplay] AS3Embassy :: switching to as2 island name : " + _loc4_);
            }
            else
            {
               trace("twin found, AS3 completions=" + this._islandsCompleted[_loc4_] + ", AS2 completions=" + this._islandsCompleted[_loc5_]);
               this._islandsCompleted[_loc5_] += this._islandsCompleted[_loc4_];
               this.islandNames.splice(_loc2_,1);
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc3_ = 0;
      while(_loc3_ < this._islandsCompleted.length)
      {
         trace("&^&^&^&^&^&^&^& this never shows, does it? because this code block is insane in the membrane!");
         trace("[MedallionSummaryDisplay] AS3Embassy :: Checking island completed name : " + this._islandsCompleted[_loc3_].name);
         if(this._islandsCompleted[_loc3_].name.indexOf("_as3") > -1)
         {
            if(this._islandsCompleted[_loc3_].name != "Carrot_as3")
            {
               this._islandsCompleted[_loc3_].name = this.convertIslandToAS2Format(this._islandsCompleted[_loc3_].name);
               trace("[MedallionSummaryDisplay] AS3Embassy :: switching island completed to as2 island name : " + this._islandsCompleted[_loc3_].name);
            }
         }
         _loc3_ = _loc3_ + 1;
      }
      var _loc10_ = [];
      var _loc9_ = [];
      _loc2_ = 0;
      while(_loc2_ < this.islandNames.length)
      {
         _loc10_.push(this.islandNames[_loc2_].name);
         if(this._islandsCompleted[this.islandNames[_loc2_].name])
         {
            _loc9_.push(this.islandNames[_loc2_].name + "=" + this._islandsCompleted[this.islandNames[_loc2_].name]);
         }
         _loc2_ = _loc2_ + 1;
      }
      trace(_loc10_.length + " in the island list: " + _loc10_);
      trace(_loc9_.length + " in the completed list: " + _loc9_);
      this._medallionWidth = 100;
      this._totalWidth = 600;
      this._centerX = 0;
      this._centerY = 0;
      this.damp = 0.8;
      this.medallionsArray = new Array();
      this.numMedallions = this.islandNames.length;
      this.basePadding = this._totalWidth / (this.numMedallions - 1);
      this.maxPadding = this._medallionWidth * 2 - 20;
      this.minPadding = (this._totalWidth - this.maxPadding) / (this.numMedallions - 1);
      this.addMedallions();
      this.positionMedallions();
      this._container.onEnterFrame = Delegate.create(this,this.positionMedallions);
      this._container.filterClip._visible = false;
      this.uncollectedMedalFilters = this._container.filterClip.filters;
      trace("uncollectedMedalFilters:" + this.uncollectedMedalFilters);
   }
   function extractNames(a)
   {
      var _loc3_ = [];
      var _loc4_ = a.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc4_)
      {
         if(a[_loc1_].hasOwnProperty("name"))
         {
            _loc3_.push(a[_loc1_].name);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   function findIslandIndex(nameToFind)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.islandNames.length)
      {
         if(this.islandNames[_loc2_].name == nameToFind)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function convertIslandToAS2Format(island)
   {
      trace("AS3 Embassy : converting island to as2 format : " + island);
      if(island.indexOf("_as3") > -1)
      {
         island = island.slice(0,island.length - 4);
      }
      return island.substr(0,1).toUpperCase() + island.substr(1);
   }
   function convertToBitmap(vectorArt, useSmoothing)
   {
      if(useSmoothing == undefined)
      {
         useSmoothing = false;
      }
      var _loc6_ = vectorArt._name;
      var _loc8_ = vectorArt._rotation;
      var _loc10_ = vectorArt._xscale;
      var _loc9_ = vectorArt._yscale;
      var _loc3_ = 2;
      vectorArt._rotation = 0;
      vectorArt._xscale = vectorArt._yscale = 100;
      vectorArt._name += "VectorArt";
      var _loc5_ = new flash.geom.Matrix();
      _loc5_.translate(_loc3_,_loc3_);
      var _loc4_ = new flash.display.BitmapData(vectorArt._width + _loc3_ * 2,vectorArt._height + _loc3_ * 2,true,16777215);
      var _loc2_ = vectorArt._parent.createEmptyMovieClip(_loc6_,vectorArt._parent.getNextHighestDepth());
      _loc2_.createEmptyMovieClip("bitmapClip",_loc2_.getNextHighestDepth());
      _loc2_.bitmapClip.attachBitmap(_loc4_,1,"auto",useSmoothing);
      _loc2_.bitmapClip._x = - _loc3_;
      _loc2_.bitmapClip._y = - _loc3_;
      _loc4_.draw(vectorArt,_loc5_);
      _loc2_._x = vectorArt._x;
      _loc2_._y = vectorArt._y;
      _loc2_._rotation = _loc8_;
      _loc2_._xscale = _loc10_;
      _loc2_._yscale = _loc9_;
      _loc2_.swapDepths(vectorArt);
      vectorArt._visible = false;
      vectorArt.removeMovieClip();
   }
   function addMedallions()
   {
      var _loc8_ = this._container.createEmptyMovieClip("medallions",1);
      _loc8_._x = this._centerX;
      _loc8_._y = this._centerY;
      var _loc2_ = undefined;
      var _loc5_ = 0;
      while(_loc5_ < this.islandNames.length)
      {
         this.islandNames[_loc5_].id = parseInt(this.islandNames[_loc5_].id);
         _loc5_ = _loc5_ + 1;
      }
      this.islandNames.sortOn("id",Array.NUMERIC);
      _loc5_ = 0;
      while(_loc5_ < this.numMedallions)
      {
         var _loc3_ = this.islandNames[_loc5_];
         var _loc6_ = _loc8_.attachMovie("Medallion","medallion" + _loc5_,_loc5_);
         _loc2_ = _loc6_.mc;
         _loc2_.onRollOver = com.poptropica.util.EventDelegate.create(this,this.onMedalRollover,_loc2_);
         _loc2_.onRollOut = com.poptropica.util.EventDelegate.create(this,this.onMedalRollout,_loc2_);
         this.medallionsArray.push(_loc2_);
         _loc2_.padding = this.minPadding;
         _loc2_.ax = 0;
         _loc2_.vx = 0;
         var _loc4_ = _loc3_.name;
         if(-1 < _loc4_.indexOf("_as3"))
         {
            if("Carrot_as3" != _loc4_)
            {
               _loc4_ = _loc4_.slice(0,-4);
            }
         }
         var _loc7_ = _loc2_.face.attachMovie(_loc4_ + "Medal","medalArt",1);
         if(_loc7_ == undefined)
         {
            trace("XXXXXXXXX ERROR: couldn\'t find medal: " + _loc3_.name);
         }
         _loc2_.face.medalArt._width = _loc2_.face.medalArt._height = this._medallionWidth;
         _loc2_.face.medalArt._x = (- this._medallionWidth) / 2;
         _loc2_.face.medalArt._y = (- this._medallionWidth) / 2;
         this.convertToBitmap(_loc2_.face.medalArt,true);
         _loc2_.side._width = _loc2_.side._height = this._medallionWidth;
         _loc2_.shading._width = _loc2_.shading._height = this._medallionWidth;
         _loc2_.side.cacheAsBitmap = true;
         _loc2_.shading.cacheAsBitmap = true;
         _loc2_.fullName = _loc3_.island_full_name;
         if(!this._islandsCompleted[_loc3_.name])
         {
            _loc6_.gotoAndStop(2);
            _loc2_.count = 0;
         }
         else
         {
            _loc2_.count = Number(this._islandsCompleted[_loc3_.name]);
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function onMedalRollover(mc)
   {
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().enable();
      var _loc1_ = mc.fullName;
      switch(mc.count)
      {
         case 0:
            _loc1_ += " not yet completed.";
            break;
         case 1:
            _loc1_ += " completed.";
            break;
         case 2:
            _loc1_ += " completed 2X.";
            break;
         default:
            _loc1_ += " completed " + mc.count + "X.";
      }
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().setMessage(mc,_loc1_,new flash.geom.Point(0,-50));
   }
   function onMedalRollout(mc)
   {
      com.poptropica.sections.quidget.ToolTipMessageManager.getInstance().objRollout(mc);
   }
   function positionMedallions()
   {
      var _loc6_ = 1000;
      var _loc2_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < this.medallionsArray.length)
      {
         _loc2_ = this.medallionsArray[_loc3_];
         var _loc4_ = Math.abs(this._container.medallions._xmouse - _loc2_._x);
         if(_loc4_ < _loc6_)
         {
            _loc6_ = _loc4_;
            this.selectedMedallion = _loc2_;
         }
         _loc3_ = _loc3_ + 1;
      }
      var _loc5_ = (- this._totalWidth) / 2;
      _loc3_ = 0;
      while(_loc3_ < this.medallionsArray.length)
      {
         _loc2_ = this.medallionsArray[_loc3_];
         if(this.selectedMedallion == _loc2_)
         {
            _loc2_.padding = this.maxPadding;
         }
         else
         {
            _loc2_.padding = this.minPadding;
         }
         _loc5_ += _loc2_.padding / 2;
         _loc2_.ax = (_loc5_ - _loc2_._x) / 20;
         _loc2_.vx += _loc2_.ax;
         _loc2_.vx *= this.damp;
         _loc2_._x += _loc2_.vx;
         _loc5_ += _loc2_.padding / 2;
         _loc2_.targetScale = 50 + 50 * (_loc2_.padding - this.minPadding) / (this.maxPadding - this.minPadding);
         _loc2_._xscale += (_loc2_.targetScale - _loc2_._xscale) / 6;
         _loc2_.side._x = (- (100 - _loc2_._xscale)) / 7;
         _loc2_.face._x = _loc2_.shading._x = - _loc2_.side._x;
         _loc2_.shading._alpha = 100 - _loc2_._xscale;
         _loc3_ = _loc3_ + 1;
      }
   }
}
