class utils.ImageUtils
{
   static var DEFAULT_MAX_BOUNCE_SCALE = 150;
   function ImageUtils()
   {
      trace("ImageUtils is a static class and should not be instantiated.");
   }
   static function makeBitmap(clip, scope, isChar)
   {
      if(scope == undefined)
      {
         scope = clip._parent;
      }
      var _loc5_ = scope.getNextHighestDepth();
      var _loc1_ = scope.createEmptyMovieClip("bmapContainer" + _loc5_,_loc5_);
      var _loc2_ = undefined;
      if(isChar)
      {
         var _loc3_ = 200;
         var _loc7_ = _loc3_ / 2;
         var _loc6_ = _loc3_ - 40;
         _loc2_ = new flash.display.BitmapData(_loc3_,_loc3_,true,16777215);
         var _loc4_ = new flash.geom.Matrix();
         _loc4_.translate(_loc7_,_loc6_);
         _loc2_.draw(clip,_loc4_);
         _loc1_._x = clip._x - _loc7_;
         _loc1_._y = clip._y - _loc6_;
      }
      else
      {
         _loc2_ = new flash.display.BitmapData(clip._width,clip._height,true,16777215);
         _loc2_.draw(clip);
         _loc1_._x = clip._x;
         _loc1_._y = clip._y;
      }
      _loc1_.attachBitmap(_loc2_,_loc1_.getNextHighestDepth());
      return {clip:_loc1_,bitmap:_loc2_};
   }
   static function generateClipFromBitmap(container, bitmapData, x, y, useSmoothing)
   {
      var _loc2_ = container.getNextHighestDepth();
      var _loc1_ = container.createEmptyMovieClip("bitmap_" + _loc2_,_loc2_);
      if(x == undefined)
      {
         x = 0;
      }
      if(y == undefined)
      {
         y = 0;
      }
      _loc1_._x = x;
      _loc1_._y = y;
      _loc1_.attachBitmap(bitmapData,1,"false",useSmoothing);
      return _loc1_;
   }
   static function convertToBitmap(vectorArt, useSmoothing)
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
      _loc2_.bitmapClip.attachBitmap(_loc4_,1,false,useSmoothing);
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
      return _loc4_;
   }
   static function convertToTiledBitmap(source_mc, container, mc_width, mc_height, transparent, fill, scale, keepOriginal)
   {
      var _loc12_ = new Array();
      var _loc18_ = source_mc._name;
      var _loc19_ = source_mc._rotation;
      var _loc21_ = source_mc._xscale;
      var _loc20_ = source_mc._yscale;
      if(scale == undefined)
      {
         scale = 1;
      }
      if(fill == undefined)
      {
         fill = 16777215;
      }
      if(transparent == undefined)
      {
         transparent = true;
      }
      if(mc_width == undefined)
      {
         mc_width = source_mc._width;
      }
      if(mc_height == undefined)
      {
         mc_height = source_mc._height;
      }
      trace("size : " + mc_width + "/" + mc_height + " source_mc: " + source_mc);
      if(container == undefined)
      {
         container = source_mc._parent.createEmptyMovieClip(_loc18_,source_mc._parent.getNextHighestDepth());
         container._x = source_mc._x;
         container._y = source_mc._y;
         source_mc._name += "_vector";
         container._name = _loc18_;
      }
      var _loc9_ = Math.ceil(mc_width / 2800);
      var _loc11_ = Math.ceil(mc_height / 2800);
      var _loc6_ = Math.ceil(mc_width / _loc9_);
      var _loc7_ = Math.ceil(mc_height / _loc11_);
      var _loc5_ = new flash.geom.Matrix();
      _loc5_.scale(scale,scale);
      var _loc3_ = undefined;
      var _loc4_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc9_)
      {
         var _loc1_ = 0;
         while(_loc1_ < _loc11_)
         {
            _loc3_ = new flash.display.BitmapData(_loc6_,_loc7_,transparent,fill);
            _loc4_ = container.createEmptyMovieClip("mc" + _loc2_ + "_" + _loc1_,_loc2_ + _loc1_ * _loc9_);
            _loc4_.attachBitmap(_loc3_,1);
            _loc5_.tx = (- _loc2_) * _loc6_;
            _loc5_.ty = (- _loc1_) * _loc7_;
            _loc3_.draw(source_mc,_loc5_);
            _loc4_._x = _loc2_ * _loc6_;
            _loc4_._y = _loc1_ * _loc7_;
            _loc12_.push(_loc3_);
            _loc1_ = _loc1_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      source_mc._visible = false;
      if(!keepOriginal)
      {
         source_mc.removeMovieClip();
      }
      return _loc12_;
   }
   static function loadIcon(targetMC, resource, containerMC, loadCompleteCallback, loadCompleteParams, padding, donotFit, fadeIn)
   {
      trace("ImageUtils :: loading icon : " + resource + " into " + targetMC);
      var fadeTime = 0.5;
      if(resource == undefined || resource == "")
      {
         return undefined;
      }
      var _loc4_ = targetMC;
      if(containerMC != undefined && containerMC != "")
      {
         _loc4_ = containerMC;
      }
      var tileWidth = _loc4_._width;
      var tileHeight = _loc4_._height;
      var iconPadding = 10;
      if(padding != undefined)
      {
         iconPadding = padding;
      }
      if(targetMC.iconMC)
      {
         targetMC.iconMC.removeMovieClip();
      }
      var _loc7_ = targetMC.createEmptyMovieClip("iconMC",targetMC.getNextHighestDepth());
      var iconClipLoader = new MovieClipLoader();
      var iconClipLoaderListener = new Object();
      iconClipLoaderListener.onLoadInit = function(target_mc)
      {
         trace("ImageUtils :: icon loaded : " + arguments);
         if(!donotFit)
         {
            utils.ImageUtils.fitContentToTile(target_mc,tileWidth,tileHeight,iconPadding);
         }
         if(undefined != loadCompleteParams)
         {
            loadCompleteParams.unshift(target_mc);
            loadCompleteCallback.apply(this,loadCompleteParams);
         }
         else if(undefined != loadCompleteCallback)
         {
            loadCompleteCallback.apply(this,[target_mc]);
         }
         if(fadeIn)
         {
            target_mc._alpha = 0;
            caurina.transitions.Tweener.removeTweens(target_mc);
            caurina.transitions.Tweener.addTween(target_mc,{_alpha:100,time:fadeTime,transition:"linear"});
         }
         loadCompleteCallback = null;
         loadCompleteParams = null;
         iconClipLoaderListener = null;
         iconClipLoader = null;
      };
      iconClipLoaderListener.onLoadError = function()
      {
         trace("ImageUtils :: icon load error : " + arguments);
      };
      iconClipLoader.addListener(iconClipLoaderListener);
      iconClipLoader.loadClip(resource,_loc7_);
   }
   static function unloadIcon(targetMC)
   {
      if(targetMC.iconMC)
      {
         targetMC.iconMC.removeMovieClip();
      }
   }
   static function fitContentToTile(elementMC, tileWidth, tileHeight, padding)
   {
      elementMC._width = tileWidth - padding;
      elementMC._height = tileHeight - padding;
      if(elementMC._xscale > elementMC._yscale)
      {
         elementMC._xscale = elementMC._yscale;
      }
      else
      {
         elementMC._yscale = elementMC._xscale;
      }
      if(elementMC._width < tileWidth)
      {
         var _loc2_ = tileWidth - elementMC._width;
         elementMC._x = _loc2_ * 0.5;
      }
      if(elementMC._height < tileHeight)
      {
         var _loc5_ = tileHeight - elementMC._height;
         elementMC._y = _loc5_ * 0.5;
      }
   }
   static function animationContract(targetMC, finalScale)
   {
      if(!finalScale)
      {
         finalScale = 100;
      }
      caurina.transitions.Tweener.removeTweens(targetMC);
      caurina.transitions.Tweener.addTween(targetMC,{_yscale:finalScale,_xscale:finalScale,time:0.15,transition:"linear"});
   }
   static function customBounceTransition(targetMC, maxScale, totalTime, finalScale, lockAxis, callback)
   {
      caurina.transitions.Tweener.removeTweens(targetMC);
      if(totalTime == undefined)
      {
         totalTime = 0.45;
      }
      if(maxScale == undefined)
      {
         maxScale = utils.ImageUtils.DEFAULT_MAX_BOUNCE_SCALE;
      }
      if(finalScale == undefined)
      {
         finalScale = 100;
      }
      var _loc5_ = finalScale / 100;
      if(finalScale == 0)
      {
         _loc5_ = 1;
      }
      var _loc2_ = [maxScale * _loc5_,90 * _loc5_,105 * _loc5_,finalScale];
      var _loc8_ = 0.45;
      var _loc7_ = 1;
      var _loc3_ = 0.15;
      var _loc1_ = 0.1;
      if(_loc8_ > totalTime)
      {
         _loc7_ = totalTime / _loc8_;
         _loc3_ *= _loc7_;
         _loc1_ *= _loc7_;
      }
      if(lockAxis.x)
      {
         caurina.transitions.Tweener.addTween(targetMC,{delay:0,_yscale:_loc2_[0],time:_loc3_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_,_yscale:_loc2_[1],time:_loc1_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_ + _loc1_,_yscale:_loc2_[2],time:_loc1_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_ + _loc1_ * 2,_yscale:_loc2_[3],time:_loc1_,transition:"linear",onComplete:callback});
      }
      else if(lockAxis.y)
      {
         caurina.transitions.Tweener.addTween(targetMC,{delay:0,_xscale:_loc2_[0],time:_loc3_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_,_xscale:_loc2_[1],time:_loc1_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_ + _loc1_,_xscale:_loc2_[2],time:_loc1_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_ + _loc1_ * 2,_xscale:_loc2_[3],time:_loc1_,transition:"linear",onComplete:callback});
      }
      else
      {
         caurina.transitions.Tweener.addTween(targetMC,{delay:0,_yscale:_loc2_[0],_xscale:_loc2_[0],time:_loc3_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_,_yscale:_loc2_[1],_xscale:_loc2_[1],time:_loc1_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_ + _loc1_,_yscale:_loc2_[2],_xscale:_loc2_[2],time:_loc1_,transition:"linear"});
         caurina.transitions.Tweener.addTween(targetMC,{delay:_loc3_ + _loc1_ * 2,_yscale:_loc2_[3],_xscale:_loc2_[3],time:_loc1_,transition:"linear",onComplete:callback});
      }
   }
}
