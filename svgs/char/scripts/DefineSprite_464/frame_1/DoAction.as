function getNewSO(s, d)
{
   if(SharedObject.MainSO == null)
   {
      var _loc1_ = SharedObject.getLocal(s,d);
      SharedObject.MainSO = _loc1_;
      return _loc1_;
   }
   return SharedObject.MainSO;
}
function InitSO()
{
   var _loc2_ = SharedObject.MainSO;
   if(_loc2_.data.crypt == null)
   {
      _loc2_.data.crypt = new Object();
   }
   var _loc1_ = _loc2_.data;
   cryptProp("age",_loc1_,"var");
   cryptProp("firstName",_loc1_,"var");
   cryptProp("lastName",_loc1_,"var");
   cryptProp("gender",_loc1_,"var");
   cryptProp("skinColor",_loc1_,"var");
   cryptProp("hairColor",_loc1_,"var");
   cryptProp("lineColor",_loc1_,"var");
   cryptProp("eyesFrame",_loc1_,"var");
   cryptProp("pantsFrame",_loc1_,"var");
   cryptProp("lineWidth",_loc1_,"var");
   cryptProp("shirtFrame",_loc1_,"var");
   cryptProp("hairFrame",_loc1_,"var");
   cryptProp("mouthFrame",_loc1_,"var");
   cryptProp("marksFrame",_loc1_,"var");
   cryptProp("itemFrame",_loc1_,"var");
   cryptProp("packFrame",_loc1_,"var");
   cryptProp("facialFrame",_loc1_,"var");
   cryptProp("overshirtFrame",_loc1_,"var");
   cryptProp("overpantsFrame",_loc1_,"var");
   cryptInv(_loc1_);
}
function cryptInv(obj)
{
   function getInv()
   {
      return obj[cp];
   }
   function setInv(v)
   {
      obj[cp] = v;
      v.crypt = new Object();
      cryptProp("Wimpy",v,"var");
      cryptProp("West",v,"var");
      cryptProp("Cryptid",v,"var");
      cryptProp("Peanuts",v,"var");
      cryptProp("Steam",v,"var");
      cryptProp("Trade",v,"var");
      cryptProp("Myth",v,"var");
      cryptProp("Reality",v,"var");
      cryptProp("Counter",v,"var");
      cryptProp("Astro",v,"var");
      cryptProp("BigNate",v,"var");
      cryptProp("Carrot",v,"var");
      cryptProp("Early",v,"var");
      cryptProp("Haunted",v,"var");
      cryptProp("Nabooti",v,"var");
      cryptProp("Shark",v,"var");
      cryptProp("Spy",v,"var");
      cryptProp("Store",v,"var");
      cryptProp("Super",v,"var");
      cryptProp("Time",v,"var");
   }
   obj.addProperty("inventory",getInv,setInv);
   var cp = crypt_str("inventory");
}
function cryptProp(p, obj, t)
{
   function getProp()
   {
      return decrypt_str(this.crypt[cp]);
   }
   function setProp(v)
   {
      this.crypt[cp] = crypt_str(v);
   }
   var cp = crypt_str(p);
   obj.addProperty(p,getProp,setProp);
}
function crypt_str(m)
{
   var _loc4_ = undefined;
   var _loc2_ = 0;
   var _loc7_ = pad_keys.length;
   if(typeof m == "number")
   {
      m = m.toString(10);
   }
   var _loc3_ = "";
   var _loc6_ = m.length;
   var _loc1_ = 0;
   while(_loc1_ < _loc6_)
   {
      _loc4_ = m.charCodeAt(_loc1_) + pad_keys[_loc2_] ^ XOR_KEY;
      _loc2_ = _loc2_++ % _loc7_;
      _loc3_ += String.fromCharCode(_loc4_);
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
}
function decrypt_str(c)
{
   var _loc4_ = undefined;
   var _loc2_ = 0;
   var _loc6_ = pad_keys.length;
   var _loc3_ = "";
   var _loc5_ = c.length;
   var _loc1_ = 0;
   while(_loc1_ < _loc5_)
   {
      _loc4_ = (c.charCodeAt(_loc1_) ^ XOR_KEY) - pad_keys[_loc2_];
      _loc2_ = _loc2_++ % _loc6_;
      _loc3_ += String.fromCharCode(_loc4_);
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
}
function crypt_obj(o)
{
   var _loc2_ = new Object();
   var _loc1_ = undefined;
   for(var _loc4_ in o)
   {
      _loc1_ = o[_loc4_];
      if(_loc1_ instanceof Array)
      {
         _loc2_[crypt_str(_loc4_)] = crypt_arr(_loc1_);
      }
      else if(_loc1_ instanceof Object)
      {
         _loc2_[crypt_str(_loc4_)] = crypt_obj(_loc1_);
      }
      else
      {
         _loc2_[crypt_str(_loc4_)] = crypt_str(_loc1_);
      }
   }
   return _loc2_;
}
function decrypt_obj(c)
{
   var _loc2_ = new Object();
   for(var _loc4_ in c)
   {
      var _loc1_ = c[_loc4_];
      if(_loc1_ instanceof Array)
      {
         _loc2_[decrypt_str(_loc4_)] = decrypt_arr(_loc1_);
      }
      else if(_loc1_ instanceof Object)
      {
         _loc2_[decrypt_str(_loc4_)] = decrypt_obj(_loc1_);
      }
      else
      {
         _loc2_[decrypt_str(_loc4_)] = decrypt_str(_loc1_);
      }
   }
   return _loc2_;
}
function crypt_arr(a)
{
   return [1,2,3];
}
function decrypt_arr(c)
{
   var _loc4_ = c.length;
   var _loc3_ = new Array(_loc4_);
   var _loc2_ = undefined;
   var _loc1_ = 0;
   while(_loc1_ < _loc4_)
   {
      _loc2_ = c[_loc1_];
      if(_loc2_ instanceof Array)
      {
         _loc3_[_loc1_] = decrypt_arr(_loc2_);
      }
      else if(_loc2_ instanceof Object)
      {
         _loc3_[_loc1_] = decrypt_obj(_loc2_);
      }
      else
      {
         _loc3_[_loc1_] = decrypt_str(_loc2_);
      }
      _loc1_ = _loc1_ + 1;
   }
   return _loc3_;
}
function cacheKeys()
{
   var _loc3_ = "letusgothenyouandi";
   var _loc2_ = _loc3_.length;
   pad_keys = new Array(_loc2_);
   var _loc1_ = 0;
   while(_loc1_ < _loc2_)
   {
      pad_keys[_loc1_] = _loc3_.charCodeAt(_loc1_);
      _loc1_ = _loc1_ + 1;
   }
}
function setupParts(forceReload)
{
   if(body.pants == undefined)
   {
      body.createEmptyMovieClip("pants",body.getNextHighestDepth());
   }
   if(body.shirt == undefined)
   {
      body.createEmptyMovieClip("shirt",body.getNextHighestDepth());
   }
   else if(body.pants.getDepth() >= body.shirt.getDepth())
   {
      body.shirt.swapDepths(body.getNextHighestDepth());
   }
   if(body.overpants == undefined)
   {
      body.createEmptyMovieClip("overpants",body.getNextHighestDepth());
   }
   else if(body.shirt.getDepth() >= body.overpants.getDepth())
   {
      body.overpants.swapDepths(body.getNextHighestDepth());
   }
   if(body.overshirt == undefined)
   {
      body.createEmptyMovieClip("overshirt",body.getNextHighestDepth());
   }
   else if(body.overpants.getDepth() >= body.overshirt.getDepth())
   {
      body.overshirt.swapDepths(body.getNextHighestDepth());
   }
   loadPart(hair,hairFrame,undefined,forceReload);
   loadPart(head.marks,marksFrame,undefined,forceReload);
   loadPart(body.shirt,shirtFrame,undefined,forceReload);
   loadPart(body.pants,pantsFrame,undefined,forceReload);
   loadPart(item,itemFrame,undefined,forceReload);
   loadPart(pack,packFrame,undefined,forceReload);
   loadPart(head.facial,facialFrame,undefined,forceReload);
   loadPart(body.overshirt,overshirtFrame,undefined,forceReload);
   loadPart(body.overpants,overpantsFrame,undefined,forceReload);
}
function loadPart(target, part, callback, forceReload, keepHidden)
{
   if(typeof target != "movieclip")
   {
      var _loc8_ = convertToPartClip(target);
      if(_loc8_ == null)
      {
         trace("loadPart :: Invalid part to load : " + target);
         return undefined;
      }
      target = _loc8_;
   }
   if(utils.Utils.isNull(part) || Number(part) == 0)
   {
      part = "1";
   }
   else
   {
      part = replacePartFrameNumber(target._name,part);
      if(typeof part == "string")
      {
         part = String(part).toLowerCase();
         part = utils.Utils.removeSpaces(part);
      }
   }
   if(target._name == "eyes" || target._name == "mouth")
   {
      target.gotoAndStop(part);
      partLoaded(target,part,callback,keepHidden);
      return undefined;
   }
   switch(target._name)
   {
      case "shirt":
         body.undershirt._visible = true;
         break;
      case "pants":
         body.underpants._visible = true;
   }
   if(gLoadedParts[target._name] != part || forceReload)
   {
      var _loc9_ = new MovieClipLoader();
      var _loc6_ = new Object();
      var _loc7_ = "avatarParts/" + target._name + "/avatar_" + target._name + "_" + part + ".swf";
      if(_parent.LOAD_PATH != undefined)
      {
         _loc7_ = _parent.LOAD_PATH + _loc7_;
      }
      _loc6_.onLoadStart = Delegate.create(this,partLoadStart,part);
      _loc6_.onLoadInit = Delegate.create(this,partLoaded,part,callback,keepHidden);
      _loc6_.onLoadError = Delegate.create(this,partLoadError,part);
      _loc9_.addListener(_loc6_);
      partsLoading++;
      var _loc5_ = "next" + target._name;
      if(this[_loc5_] != null && this[_loc5_] != part)
      {
         this[_loc5_] = part;
         return undefined;
      }
      this[_loc5_] = part;
      _loc9_.loadClip(_loc7_,target);
   }
   else
   {
      partLoaded(target,part,callback,keepHidden);
   }
}
function doDelayedHide(clip, time)
{
   partsLoading++;
   delete clip.onEnterFrame;
   clip.wait = time;
   clip.onEnterFrame = function()
   {
      if(clip.wait <= 0)
      {
         clip._visible = false;
         partsLoading--;
         trace("partsloading" + partsLoading + " | " + target._name);
         if(partsLoading == 0)
         {
            trace("partsloading0" + this._parent._parent._parent._name);
         }
         delete clip.onEnterFrame;
      }
      else
      {
         clip.wait--;
      }
   };
}
function partLoaded(target, part, callback, keepHidden)
{
   var _loc4_ = "next" + target._name;
   if(this[_loc4_] != null && this[_loc4_] != part)
   {
      loadPart(target,this[_loc4_],callback,false,keepHidden);
      return undefined;
   }
   delete this[_loc4_];
   if(callback != undefined)
   {
      callback();
   }
   if(!target.action && !(_root.island == "LegendarySwords" && target._name == "item"))
   {
      target.action = function()
      {
         target.active_obj.action();
      };
   }
   gLoadedParts[target._name] = part;
   if(body.overshirt.hidePants || body.overpants.hidePants || body.shirt.hidePants)
   {
      body.pants._visible = false;
      leg1._visible = true;
      leg2._visible = true;
      foot1._visible = true;
      foot2._visible = true;
   }
   else if(target._name == "pants" && part != "1")
   {
      body.pants._visible = true;
      if(!body.pants.hideLegs)
      {
         leg1._visible = true;
         leg2._visible = true;
         foot1._visible = true;
         foot2._visible = true;
      }
   }
   else if(target._name == "overshirt" && part == "1" && this._parent._name == "char")
   {
      if(!body.overshirt.hidePants && !body.overpants.hidePants && !body.shirt.hidePants)
      {
         body.pants._visible = true;
      }
      if(!body.pants.hideLegs)
      {
         leg1._visible = true;
         leg2._visible = true;
      }
      foot1._visible = true;
      foot2._visible = true;
   }
   if(eyesFrame == "mannequin" || body.overshirt.hideLegsAndFeet)
   {
      leg1._visible = false;
      leg2._visible = false;
      foot1._visible = false;
      foot2._visible = false;
   }
   if(body.overshirt.hideShirt || body.overpants.hideShirt || body.shirt.hideShirt || target.hideShirt)
   {
      body.shirt._visible = false;
   }
   else if(!keepHidden)
   {
      body.shirt._visible = true;
   }
   if(head.facial.hideHair == true || head.marks.hideHair == true || target.hideHair)
   {
      hair._visible = false;
   }
   else if(!keepHidden)
   {
      hair._visible = true;
   }
   if(head.facial.hideArms == true)
   {
      arm1._visible = false;
      arm2._visible = false;
      hand1._visible = false;
      hand2._visible = false;
   }
   else
   {
      arm1._visible = true;
      arm2._visible = true;
      hand1._visible = true;
      hand2._visible = true;
   }
   switch(target._name)
   {
      case "hair":
         follow(hair,head,11,-10,3.5,0.35);
         colorHair(hair);
         colorSkin(hair);
         break;
      case "pack":
         follow(pack,body,15,-10,1.3,0.6);
         colorHair(pack);
         colorSkin(pack);
         break;
      case "head":
         follow(head,neck,-17,-72,1.4,0.4);
         head.action = function()
         {
            head.marks.action();
            head.facial.action();
            head.mouth.action();
         };
         colorSkin(head.headSkin);
         colorSkin(head.eyes.eyelids);
         colorHair(head.marks);
         colorSkin(head.marks);
         colorHair(head.facial);
         colorSkin(head.facial);
         break;
      case "item":
         item.stageWidth = com.poptropica.models.PopModelConst.gameplayWidth;
         item.stageHeight = com.poptropica.models.PopModelConst.gameplayHeight;
         follow(item,hand1,-4,-4,1.5,0.35,item.doRotation);
         break;
      case "shirt":
         colorSkin(body.shirt);
         doDelayedHide(body.undershirt,10);
         break;
      case "overshirt":
         colorSkin(body.overshirt);
         break;
      case "overpants":
         break;
      case "pants":
         doDelayedHide(body.underpants,10);
         colorHair(body.pants);
         if(body.pants.pantsColor != null && body.pants._visible)
         {
            colorPants = true;
            pantsColor = body.pants.pantsColor;
         }
         else if(overpantsFrame == "chameleon")
         {
            colorPants = true;
            pantsColor = 3355443;
         }
         else
         {
            colorPants = false;
         }
         break;
      case "marks":
      case "facial":
         colorHair(target);
         colorSkin(target);
   }
   if(partsLoading > 0)
   {
      partsLoading--;
      trace("partsloading" + partsLoading + " | " + target._name);
      if(partsLoading == 0)
      {
         trace("partsloading0" + this._parent._parent._parent._name);
      }
   }
   checkPartExpired(target);
   if(facialFrame == "24_beta" && target._name == "facial")
   {
      replacePartWithDefault(target._name,true);
   }
   else if(overshirtFrame == "24_beta" && target._name == "overshirt")
   {
      replacePartWithDefault(target._name,true);
   }
}
function partLoadStart(target, part)
{
   switch(target._name)
   {
      case "pants":
         setupPants();
         break;
      case "overpants":
         setupOverPants();
   }
}
function partLoadError(target, part)
{
   trace("loadPart :: error : " + arguments);
   if(partsLoading > 0)
   {
      partsLoading--;
      trace("partsloading" + partsLoading + " | " + target._name);
      if(partsLoading == 0)
      {
         trace("partsloading0" + this._parent._parent._parent._name);
      }
   }
}
function convertToPartClip(partName)
{
   switch(partName)
   {
      case "hair":
         return hair;
      case "pack":
         return pack;
      case "head":
         return head;
      case "item":
         return item;
      case "shirt":
         return body.shirt;
      case "overshirt":
         return body.overshirt;
      case "pants":
         return body.pants;
      case "overpants":
         return body.overpants;
      case "marks":
         return head.marks;
      case "facial":
         return head.facial;
      case "eyes":
         return head.eyes;
      case "mouth":
         return head.mouth;
      default:
         return null;
   }
}
function setupPants()
{
   var _loc2_ = body.pants;
   _loc2_.avatar = this;
   _loc2_.char = this._parent;
   _loc2_.setDress = Delegate.create(this,setDress);
   _loc2_.xAverageStart = 18.36;
   _loc2_.yAverageStart = 24.7;
   _loc2_.dressRotation = 0;
   _loc2_.minXscale = 0;
   _loc2_.maxXscale = 100;
   _loc2_.minYscale = 0;
   _loc2_.maxYscale = 0;
}
function setupOverPants()
{
   overpants.avatar = this;
   overpants.char = this._parent;
   overpants.dangleRotation = 0;
   overpants.setDangle = Delegate.create(this,setDangle);
}
function setDangle(dangleClip, curdangleRotation, curMinXscale, curMaxXscale, curMinYscale, curMaxYscale)
{
   overpants.dangleRotation = curdangleRotation;
   dangleClip.onEnterFrame = Delegate.create(this,dangleMove);
}
function dangleMove()
{
   if(overpants.char.speed == 0)
   {
      this._rotation = 0;
   }
   else
   {
      this._rotation = - Math.abs(overpants.char.speed * overpants.dangleRotation);
   }
}
function setDress(dressClip, curDressRotation, curMinXscale, curMaxXscale, curMinYscale, curMaxYscale)
{
   var _loc3_ = body.pants;
   if(_loc3_._visible)
   {
      _loc3_.dressRotation = curDressRotation;
      dressClip.startXscale = dressClip._xscale;
      dressClip.startYscale = dressClip._yscale;
      _loc3_.minXscale = dressClip.startXscale;
      _loc3_.maxXscale = dressClip.startXscale * 1.05;
      _loc3_.minYscale = dressClip.startYscale * 0.6;
      _loc3_.maxYscale = dressClip.startYscale;
      leg1._visible = false;
      leg2._visible = false;
      _loc3_.hideLegs = true;
      dressClip.onEnterFrame = Delegate.create(this,dressMove,dressClip);
   }
}
function dressMove(clip)
{
   var _loc1_ = body.pants;
   _loc1_.x1 = Math.abs(foot1._x - foot2._x) * 0.36;
   _loc1_.x2 = Math.abs(foot2._x - foot1._x) * 0.36;
   _loc1_.xAverage = Math.max(_loc1_.x1,_loc1_.x2);
   _loc1_.newXscale = _loc1_.xAverage / _loc1_.xAverageStart * clip.startXscale;
   if(_loc1_.newXscale < _loc1_.maxXscale && _loc1_.newXscale > _loc1_.minXscale)
   {
      clip._xscale = _loc1_.newXscale;
   }
   else if(_loc1_.newXscale >= _loc1_.maxXscale)
   {
      clip._xscale = _loc1_.maxXscale;
   }
   else if(_loc1_.newXscale <= _loc1_.minXscale)
   {
      clip._xscale = _loc1_.minXscale;
   }
   else
   {
      clip._xscale = _loc1_.newXscale;
   }
   _loc1_.y1 = Math.abs(foot1._y - leg1._y) * 0.36;
   _loc1_.y2 = Math.abs(foot2._y - leg2._y) * 0.36;
   _loc1_.yAverage = Math.max(_loc1_.y1,_loc1_.y2);
   _loc1_.newYscale = _loc1_.yAverage / _loc1_.yAverageStart * clip.startYscale;
   if(_loc1_.newYscale < _loc1_.maxYscale && _loc1_.newYscale > _loc1_.minYscale)
   {
      clip._yscale = _loc1_.newYscale;
   }
   else if(_loc1_.newYscale >= _loc1_.maxYscale)
   {
      clip._yscale = _loc1_.maxYscale;
   }
   else if(_loc1_.newYscale <= _loc1_.minYscale)
   {
      clip._yscale = _loc1_.minYscale;
   }
   else
   {
      clip._yscale = _loc1_.newYscale;
   }
   if(_loc1_._parent._yscale > 100 && clip._yscale > _loc1_.maxYscale - (_loc1_._parent._yscale - 100) * (_loc1_.maxYscale / 100))
   {
      clip._yscale = _loc1_.maxYscale - (_loc1_._parent._yscale - 100) * (_loc1_.maxYscale / 100);
   }
   if(_loc1_.char.speed == 0)
   {
      clip._rotation = 0;
   }
   else
   {
      clip._rotation = - Math.abs(_loc1_.char.speed * _loc1_.dressRotation);
   }
}
function replacePartFrameNumber(partType, part)
{
   if(!isNaN(part))
   {
      if(_partFrameLabels[partType][part] != undefined)
      {
         return _partFrameLabels[partType][part];
      }
   }
   return part;
}
function checkPartsNotPrintable()
{
   var _loc1_ = 0;
   if(body.shirt.notPrintable)
   {
      if(body.shirt.hidePants)
      {
         body.pants._visible = true;
         replacePartWithDefault("pants");
      }
      replacePartWithDefault("shirt");
      _loc1_ = _loc1_ + 1;
   }
   if(head.marks.notPrintable)
   {
      replacePartWithDefault("marks");
      _loc1_ = _loc1_ + 1;
   }
   if(body.pants.notPrintable)
   {
      replacePartWithDefault("pants");
      _loc1_ = _loc1_ + 1;
   }
   if(head.facial.notPrintable)
   {
      replacePartWithDefault("facial");
      _loc1_ = _loc1_ + 1;
   }
   if(hair.notPrintable)
   {
      replacePartWithDefault("hair");
      _loc1_ = _loc1_ + 1;
   }
   if(pack.notPrintable)
   {
      replacePartWithDefault("pack");
      _loc1_ = _loc1_ + 1;
   }
   if(item.notPrintable)
   {
      replacePartWithDefault("item");
      _loc1_ = _loc1_ + 1;
   }
   if(body.overshirt.notPrintable)
   {
      if(body.overshirt.hidePants || body.overshirt.campaignItemID == 2279)
      {
         body.pants._visible = true;
         replacePartWithDefault("pants");
      }
      replacePartWithDefault("overshirt");
      _loc1_ = _loc1_ + 1;
   }
   if(body.overpants.notPrintable)
   {
      if(body.overpants.hidePants)
      {
         body.pants._visible = true;
         replacePartWithDefault("pants");
      }
      replacePartWithDefault("overpants");
      _loc1_ = _loc1_ + 1;
   }
   return _loc1_;
}
function checkAllPartsExpired()
{
   vExpiredStatus = false;
   checkPartExpired(head.marks);
   checkPartExpired(head.facial);
   checkPartExpired(hair);
   checkPartExpired(body.shirt);
   checkPartExpired(body.pants);
   checkPartExpired(pack);
   checkPartExpired(item);
   checkPartExpired(body.overshirt);
   checkPartExpired(body.overpants);
   trace("Expiring parts status: " + vExpiredStatus);
   return vExpiredStatus;
}
function checkPartExpired(target)
{
   if(target.campaignItemID)
   {
      trace("Expiring part: checking: " + target._name + " | campaign item ID: " + target.campaignItemID);
      if(!campaignItemActive(target.campaignItemID))
      {
         vExpiredStatus = true;
         replacePartWithDefault(target._name,true);
      }
   }
}
function replacePartWithDefault(partName, saveLookString)
{
   var _loc3_ = gender != 1 ? default_girl : default_boy;
   switch(partName)
   {
      case "hair":
         loadPart(hair,_loc3_.hair,null,true);
         hairFrame = _loc3_.hair;
         break;
      case "pack":
         loadPart(pack,_loc3_.pack,null,true);
         packFrame = _loc3_.pack;
         pack._visible = false;
         break;
      case "item":
         loadPart(item,_loc3_.item,null,true);
         itemFrame = _loc3_.item;
         item._visible = false;
         break;
      case "shirt":
         if(shirtFrame.toLowerCase() == "sponsor_adventuretime_finnshirt")
         {
            partsLoading--;
         }
         if(defaultShirtExceptions[shirtFrame])
         {
            loadPart(body.shirt,defaultShirtExceptions[shirtFrame],null,true);
            shirtFrame = defaultShirtExceptions[shirtFrame];
         }
         else
         {
            loadPart(body.shirt,_loc3_.shirt,null,true);
            shirtFrame = _loc3_.shirt;
         }
         break;
      case "overshirt":
         loadPart(body.overshirt,_loc3_.overshirt,null,true);
         overshirtFrame = _loc3_.overshirt;
         if(body.pants._visible == false)
         {
            body.pants._visible = true;
            loadPart(body.pants,pantsFrame,null,true);
         }
         break;
      case "pants":
         if(defaultPantsExceptions[pantsFrame])
         {
            loadPart(body.pants,defaultPantsExceptions[pantsFrame],null,true);
            pantsFrame = defaultPantsExceptions[pantsFrame];
         }
         else
         {
            loadPart(body.pants,_loc3_.pants,null,true);
            pantsFrame = _loc3_.pants;
         }
         break;
      case "overpants":
         loadPart(body.overpants,_loc3_.overpants,null,true);
         overpantsFrame = _loc3_.overpants;
         break;
      case "marks":
         loadPart(head.marks,_loc3_.marks,null,true);
         head.marks._visible = false;
         marksFrame = _loc3_.marks;
         break;
      case "facial":
         if(defaultFacialExceptions[facialFrame])
         {
            loadPart(head.facial,defaultFacialExceptions[facialFrame],null,true);
            facialFrame = defaultFacialExceptions[facialFrame];
         }
         else
         {
            loadPart(head.facial,_loc3_.facial,null,true);
            facialFrame = _loc3_.facial;
         }
   }
   if(saveLookString && this._parent._name == "char" && !this._parent.charLoadAssets)
   {
      switch(partName)
      {
         case "hair":
            FunBrain_so.data.hairFrame = _loc3_.hair;
            break;
         case "pack":
            FunBrain_so.data.packFrame = _loc3_.pack;
            break;
         case "item":
            FunBrain_so.data.itemFrame = _loc3_.item;
            break;
         case "shirt":
            if(defaultShirtExceptions[shirtFrame])
            {
               FunBrain_so.data.shirtFrame = defaultShirtExceptions[shirtFrame];
            }
            else
            {
               FunBrain_so.data.shirtFrame = _loc3_.shirt;
            }
            break;
         case "overshirt":
            FunBrain_so.data.overshirtFrame = _loc3_.overshirt;
            break;
         case "pants":
            if(defaultPantsExceptions[pantsFrame])
            {
               FunBrain_so.data.pantsFrame = defaultPantsExceptions[pantsFrame];
            }
            else
            {
               FunBrain_so.data.pantsFrame = _loc3_.pants;
            }
            break;
         case "overpants":
            FunBrain_so.data.overpantsFrame = _loc3_.overpants;
            break;
         case "marks":
            FunBrain_so.data.marksFrame = _loc3_.marks;
            break;
         case "facial":
            if(defaultFacialExceptions[facialFrame])
            {
               FunBrain_so.data.facialFrame = defaultFacialExceptions[facialFrame];
            }
            else
            {
               FunBrain_so.data.facialFrame = _loc3_.facial;
            }
      }
      FunBrain_so.flush();
      _root.saveChangedLook();
   }
}
function checkCurrentCampaigns()
{
   var _loc1_ = SharedObject.getLocal("Char","/");
   if(!_loc1_.data.currentcampaigns)
   {
      getCurrentCampaigns();
   }
}
function getCurrentCampaigns()
{
   var _loc2_ = new LoadVars();
   var receiver = new LoadVars();
   receiver.onLoad = function(success)
   {
      if(receiver.answer == "ok")
      {
         var _loc1_ = new asLib.JSON();
         var _loc3_ = undefined;
         try
         {
            _loc3_ = _loc1_.parse(receiver.json);
            var _loc2_ = SharedObject.getLocal("Char","/");
            _loc2_.data.currentcampaigns = _loc3_;
            checkAllPartsExpired();
         }
         catch(error:Object)
         {
            trace("JSON Parse Error :: " + error);
         }
      }
   };
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _loc2_.promo_code = code;
      _loc2_.sendAndLoad(_root.getPrefix() + "/time_limited_is_active.php",receiver,"POST");
   }
}
function campaignItemActive(itemID)
{
   if(itemID == 0)
   {
      return false;
   }
   trace("function: campaignItemActive");
   var _loc4_ = SharedObject.getLocal("Char","/");
   if(_loc4_.data.currentcampaigns)
   {
      var _loc2_ = String(_loc4_.data.currentcampaigns).split(",");
      trace("num campaigns" + _loc2_.length);
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         trace(_loc1_ + ": " + itemID + "|" + _loc2_[_loc1_]);
         if(Number(_loc2_[_loc1_]) == itemID)
         {
            trace("Expiring part: item still active");
            return true;
         }
         _loc1_ = _loc1_ + 1;
      }
      trace("Expiring part: item expired");
      return false;
   }
   trace("Expiring part: campaign data not yet loaded");
   return true;
}
function restoreFromLSO()
{
   gender = FunBrain_so.data.gender;
   skinColor = FunBrain_so.data.skinColor;
   hairColor = FunBrain_so.data.hairColor;
   lineColor = FunBrain_so.data.lineColor;
   eyelidsPos = FunBrain_so.data.eyelidsPos;
   eyesFrame = FunBrain_so.data.eyesFrame;
   pantsFrame = FunBrain_so.data.pantsFrame;
   lineWidth = FunBrain_so.data.lineWidth;
   shirtFrame = FunBrain_so.data.shirtFrame;
   hairFrame = FunBrain_so.data.hairFrame;
   mouthFrame = FunBrain_so.data.mouthFrame;
   marksFrame = FunBrain_so.data.marksFrame;
   itemFrame = FunBrain_so.data.itemFrame;
   packFrame = FunBrain_so.data.packFrame;
   facialFrame = FunBrain_so.data.facialFrame;
   overshirtFrame = FunBrain_so.data.overshirtFrame;
   overpantsFrame = FunBrain_so.data.overpantsFrame;
   specialAbility = FunBrain_so.data.specialAbility;
   specialAbilityParams = FunBrain_so.data.specialAbilityParams;
   doColors();
   setParts();
}
function hexToRgb(val)
{
   var _loc1_ = {};
   _loc1_.red = val >> 16 & 0xFF;
   _loc1_.green = val >> 8 & 0xFF;
   _loc1_.blue = val & 0xFF;
   return _loc1_;
}
function rgbToHex(r, g, b)
{
   return r << 16 | g << 8 | b;
}
function createRandomParts(newGender, norm)
{
   if(newGender == undefined)
   {
      gender = Math.round(Math.random());
   }
   else
   {
      gender = newGender;
   }
   gender != 1 ? (genderString = "girl") : (genderString = "boy");
   skinColor = normalSkinColors[Math.floor(Math.random() * normalSkinColors.length)];
   hairColor = normalHairColors[Math.floor(Math.random() * normalHairColors.length)];
   rgb = hexToRgb(skinColor);
   red = rgb.red * 0.8;
   green = rgb.green * 0.8;
   blue = rgb.blue * 0.8;
   lineColor = rgbToHex(red,green,blue);
   eyelidsPos = - Math.round(Math.random() * 40 - 80);
   eyesFrame = Math.ceil(Math.random() * 3);
   lineWidth = 4;
   overshirtFrame = 1;
   overpantsFrame = 1;
   var _loc1_ = "normal";
   if(norm == "normal" || norm == "rad" || norm == "both")
   {
      if(norm == "both")
      {
         _loc1_ = ["normal","rad"];
      }
      else
      {
         _loc1_ = norm;
      }
   }
   pantsFrame = getRandomPart("pants",genderString,_loc1_);
   shirtFrame = getRandomPart("shirt",genderString,_loc1_);
   hairFrame = getRandomPart("hair",genderString,_loc1_);
   mouthFrame = getRandomPart("mouth",genderString,_loc1_);
   marksFrame = getRandomPart("marks",genderString,_loc1_);
   itemFrame = getRandomPart("item",genderString,_loc1_);
   packFrame = getRandomPart("pack",genderString,_loc1_);
   facialFrame = getRandomPart("facial",genderString,_loc1_);
   overpantsFrame = getRandomPart("overpants",genderString,_loc1_);
   overshirtFrame = getRandomPart("overshirt",genderString,_loc1_);
   if(specialAbility)
   {
      specialAbility = "none";
      specialAbilityParams = null;
   }
   trace("createRandomParts :: gender : " + genderString + " types : " + _loc1_ + " res : " + [pantsFrame,shirtFrame,hairFrame,mouthFrame,marksFrame,itemFrame,packFrame,facialFrame,overpantsFrame,overshirtFrame]);
}
function getRandomPart(part, gender, types)
{
   var targetArray = new Array();
   if(typeof types == "string")
   {
      if(types == "monster")
      {
         gender = "";
      }
      targetArray = eval(types + gender + part);
   }
   else
   {
      var n = 0;
      while(n < types.length)
      {
         if(types[n] == "monster")
         {
            gender = "";
         }
         targetArray = targetArray.concat(eval(types[n] + gender + part));
         n++;
      }
   }
   return utils.Utils.pickRandomElement(targetArray);
}
function createMonster(newGender)
{
   gender = newGender;
   if(gender == undefined)
   {
      gender = utils.Utils.pickRandomElement(["boy","girl"]);
   }
   skinColor = monsterSkinColors[Math.floor(Math.random() * normalSkinColors.length)];
   hairColor = monsterHairColors[Math.floor(Math.random() * normalHairColors.length)];
   rgb = hexToRgb(skinColor);
   red = rgb.red * 0.8;
   green = rgb.green * 0.8;
   blue = rgb.blue * 0.8;
   lineColor = rgbToHex(red,green,blue);
   eyelidsPos = - Math.round(Math.random() * 40 - 80);
   eyesFrame = Math.ceil(Math.random() * 3);
   lineWidth = 4;
   overshirtFrame = 1;
   overpantsFrame = 1;
   itemFrame = 1;
   facialFrame = 1;
   var _loc1_ = "monster";
   pantsFrame = getRandomPart("pants",gender,_loc1_);
   shirtFrame = getRandomPart("shirt",gender,_loc1_);
   hairFrame = getRandomPart("hair",gender,_loc1_);
   mouthFrame = getRandomPart("mouth",gender,_loc1_);
   marksFrame = getRandomPart("marks",gender,_loc1_);
   packFrame = getRandomPart("pack",gender,_loc1_);
}
function createSpecificParts(gend, norm, skinCol, hairCol, eyesF, mouthF, marksF, facialF, hairF, shirtF, pantsF, packF, itemF, overshirtF, overpantsF)
{
   if(gend == undefined)
   {
      gender = Math.round(Math.random());
   }
   else
   {
      gender = gend;
   }
   gender != 1 ? (arrGend = "Girl") : (arrGend = "Boy");
   skinColor = skinCol;
   hairColor = hairCol;
   rgb = hexToRgb(skinColor);
   red = rgb.red * 0.8;
   green = rgb.green * 0.8;
   blue = rgb.blue * 0.8;
   lineColor = rgbToHex(red,green,blue);
   lineWidth = 4;
   eyelidsPos = - Math.round(Math.random() * 40 - 80);
   eyesFrame = eyesF;
   pantsFrame = pantsF;
   shirtFrame = shirtF;
   hairFrame = hairF;
   mouthFrame = mouthF;
   marksFrame = marksF;
   itemFrame = itemF;
   packFrame = packF;
   facialFrame = facialF;
   overshirtFrame = overshirtF;
   overpantsFrame = overpantsF;
}
function savePartsToSO()
{
   var _loc2_ = false;
   if(skinColor != 5878232 && skinColor != 13617610)
   {
      FunBrain_so.data.skinColor = skinColor;
   }
   else
   {
      _loc2_ = true;
   }
   if(lineColor != 4689324 && lineColor != 10854561)
   {
      FunBrain_so.data.lineColor = lineColor;
   }
   FunBrain_so.data.gender = gender;
   FunBrain_so.data.hairColor = hairColor;
   FunBrain_so.data.eyelidsPos = eyelidsPos;
   FunBrain_so.data.eyesFrame = eyesFrame;
   FunBrain_so.data.pantsFrame = pantsFrame;
   FunBrain_so.data.lineWidth = lineWidth;
   FunBrain_so.data.shirtFrame = shirtFrame;
   FunBrain_so.data.hairFrame = hairFrame;
   FunBrain_so.data.mouthFrame = mouthFrame;
   FunBrain_so.data.marksFrame = marksFrame;
   FunBrain_so.data.itemFrame = itemFrame;
   FunBrain_so.data.packFrame = packFrame;
   FunBrain_so.data.facialFrame = facialFrame;
   FunBrain_so.data.overshirtFrame = overshirtFrame;
   FunBrain_so.data.overpantsFrame = overpantsFrame;
   FunBrain_so.data.specialAbility = specialAbility;
   FunBrain_so.data.specialAbilityParams = specialAbilityParams;
   if(_loc2_ && hairFrame.indexOf("smurfs") == -1)
   {
      changeSkinColor(FunBrain_so.data.skinColor);
      setColors();
   }
   checkLSOStoreResult(FunBrain_so.flush(),"SaveParts");
   _root.saveChangedLook();
}
function checkLSOStoreResult(result, type)
{
   trace("FunBrain_so.getSize() : " + FunBrain_so.getSize() + " type : " + type);
   if(result != true)
   {
      var _loc2_ = utils.Utils.roundToKiloBytes(FunBrain_so.getSize());
      trace("LSO write failed for part save : " + result + " : " + _loc2_);
      if(result == "" || result == null)
      {
         result = false;
      }
      sendLSOStoreResultTracking(result,type,_loc2_);
   }
}
function sendLSOStoreResultTracking(result, type, size)
{
   if(type != undefined)
   {
      trace("tracking LSO store event : " + arguments);
      _root.trackCampaign("Debugging","LSO Write fail in " + type,result,size);
   }
}
function loadPartsFromSO()
{
   verifyUserData();
   gender = FunBrain_so.data.gender;
   skinColor = FunBrain_so.data.skinColor;
   hairColor = FunBrain_so.data.hairColor;
   lineColor = FunBrain_so.data.lineColor;
   eyelidsPos = FunBrain_so.data.eyelidsPos;
   eyesFrame = FunBrain_so.data.eyesFrame;
   marksFrame = FunBrain_so.data.marksFrame;
   pantsFrame = FunBrain_so.data.pantsFrame;
   lineWidth = FunBrain_so.data.lineWidth;
   shirtFrame = FunBrain_so.data.shirtFrame;
   hairFrame = FunBrain_so.data.hairFrame;
   mouthFrame = FunBrain_so.data.mouthFrame;
   itemFrame = FunBrain_so.data.itemFrame;
   packFrame = FunBrain_so.data.packFrame;
   facialFrame = FunBrain_so.data.facialFrame;
   overshirtFrame = FunBrain_so.data.overshirtFrame;
   overpantsFrame = FunBrain_so.data.overpantsFrame;
   specialAbility = FunBrain_so.data.specialAbility != undefined ? FunBrain_so.data.specialAbility : "none";
   specialAbilityParams = FunBrain_so.data.specialAbilityParams;
   if(mouthFrame == "undefined" || mouthFrame == undefined)
   {
      mouthFrame = 5;
      savePartsToSO();
   }
}
function resetFace()
{
   head.eyes.gotoAndStop(eyesFrame);
   head.headSkin.red._alpha = 0;
   head.eyes.eyelids.red._alpha = 0;
   head.eyelashes.gotoAndStop(1);
   if(!_parent.talking)
   {
      head.mouth.gotoAndStop(mouthFrame);
      head.eyes.pupils.gotoAndStop(1);
   }
}
function setParts(forceReload)
{
   partsLoading = 0;
   if(_parent.isChar)
   {
      if(packFrame == "jet" && _root.island != "Early")
      {
         packFrame = 1;
         savePartsToSO();
      }
      if(packFrame == "glider" && _root.island != "Time")
      {
         packFrame = 1;
         savePartsToSO();
      }
      if(overshirtFrame == "grappleTie" && _root.island != "Spy")
      {
         overshirtFrame = 1;
         savePartsToSO();
      }
      if(facialFrame == "chameleon" && _root.island != "Spy")
      {
         facialFrame = 1;
         overpantsFrame = 1;
         savePartsToSO();
      }
      if(mouthFrame == "talk")
      {
         mouthFrame = 1;
         savePartsToSO();
      }
   }
   if(packFrame == "jet")
   {
      _parent.flying = true;
   }
   else
   {
      _parent.flying = false;
   }
   if(packFrame == "glider")
   {
      _parent.gliding = true;
   }
   else
   {
      _parent.gliding = false;
   }
   if(facialFrame == "sponsorAJ")
   {
      _parent.speedFactor = 1.3;
   }
   else if(!_parent.speeding)
   {
      _parent.speedFactor = 1;
   }
   if(_parent.isChar)
   {
      if(overshirtFrame == "grappleTie" && _root.island == "Spy" && !_root.camera.scene.common)
      {
         _root.navBar.btnGrapple._visible = true;
      }
      else
      {
         _root.navBar.btnGrapple._visible = false;
      }
   }
   if(facialFrame == "chameleon" && overpantsFrame != "chameleon")
   {
      facialFrame = 1;
   }
   else if(overpantsFrame == "chameleon" && facialFrame != "chameleon")
   {
      overpantsFrame = 1;
   }
   foot1._visible = foot1._visible = true;
   if(shirtFrame.indexOf("fm") > -1)
   {
      body.bellyDots._visible = false;
   }
   if(facialFrame == "chameleon")
   {
      head.eyes.eyelids.overlay._visible = true;
   }
   else
   {
      head.eyes.eyelids.overlay._visible = false;
   }
   if(eyesFrame == "mannequin" || eyesFrame == 27)
   {
      if(_parent.isChar)
      {
         eyesFrame = 1;
         savePartsToSO();
      }
      else
      {
         _parent.interaction = "costume";
         body.bellyDots.nextFrame();
         head.headSkin.nextFrame();
         head.mouth._visible = false;
         arm1._visible = arm2._visible = hand1._visible = hand2._visible = leg1._visible = leg2._visible = foot1._visible = foot2._visible = false;
         gotoAndStop("mannequin");
         _parent.charState = "action";
      }
   }
   if(!_parent.talking)
   {
      head.mouth.gotoAndStop(mouthFrame);
   }
   setupParts(forceReload);
   head.eyes.gotoAndStop(eyesFrame);
   if(gender == 1)
   {
      head.eyelashes._visible = false;
   }
   else
   {
      head.eyelashes._visible = true;
      head.eyelashes.gotoAndStop(1);
   }
   head.headSkin.red._alpha = 0;
   head.eyes.eyelids.red._alpha = 0;
   setColors();
   if(activeAbilities.length > 0)
   {
      removeActiveSpecialAbilities();
   }
   activeAbilities = [];
   var _loc3_ = 0;
   while(_loc3_ < specialAbility.length)
   {
      activeAbilities.push(specialAbility[_loc3_]);
      switch(specialAbility[_loc3_])
      {
         case "electrified":
            _parent.electrify(specialAbilityParams[_loc3_][0]);
            break;
         case "phantomed":
            _parent.phantom(specialAbilityParams[_loc3_][0]);
            break;
         case "ballooned":
            _parent.showBalloon(specialAbilityParams[_loc3_][0]);
            break;
         case "torched":
            _parent.torch();
            break;
         case "followed":
            _parent.showFollower(specialAbilityParams[_loc3_][0]);
            break;
         case "shrunk":
            _parent.shrink();
            break;
         case "bobbled":
            _parent.bobbleHead();
            break;
         case "heartPotion":
            _parent.floatParticle(specialAbilityParams[_loc3_][0]);
            break;
         case "cheeseTouch":
            removeSpecialAbility("cheeseTouch");
            break;
         case "atomPower":
            _parent.atomPower();
            break;
         case "grow":
            _parent.grow();
            break;
         case "starPower":
            _parent.starPower();
            break;
         case "sparklePower":
            _parent.sparklePower();
            break;
         case "crispy":
            _parent.crispy(specialAbilityParams[_loc3_][0]);
            break;
         case "clone":
            _parent.clone();
      }
      _loc3_ = _loc3_ + 1;
   }
   if(_root.island == "Counter" && _parent._name == "char" && _parent._parent._name == "scene" && FunBrain_so.data.counterBalloonFrame)
   {
      _parent.showCounterBalloon();
   }
}
function removeAllSpecialAbilities()
{
   _parent.unElectrify();
   _parent.unPhantom();
   _parent.hideBalloon();
   _parent.unTorch();
   _parent.hideFollower();
   _parent.unShrink();
   _parent.unBobbleHead();
   _parent.unFloatParticle();
   _parent.unCheeseTouch();
   _parent.unAtomPower();
   _parent.unStarPower();
   _parent.unSparklePower();
   _parent.unCrispy();
   _parent.unClone();
}
function removeActiveSpecialAbilities()
{
   var _loc2_ = 0;
   while(_loc2_ < activeAbilities.length)
   {
      switch(activeAbilities[_loc2_])
      {
         case "electrified":
            _parent.unElectrify();
            break;
         case "phantomed":
            _parent.unPhantom();
            break;
         case "ballooned":
            _parent.hideBalloon();
            break;
         case "torched":
            _parent.unTorch();
            break;
         case "followed":
            _parent.hideFollower();
            break;
         case "shrunk":
            _parent.unShrink();
            break;
         case "bobbled":
            _parent.unBobbleHead();
            break;
         case "heartPotion":
            _parent.unFloatParticle();
            break;
         case "cheeseTouch":
            _parent.unCheeseTouch();
            break;
         case "atomPower":
            _parent.unAtomPower();
            break;
         case "grow":
            _parent.unGrow();
            break;
         case "starPower":
            _parent.unStarPower();
            break;
         case "sparklePower":
            _parent.unSparklePower();
            break;
         case "crispy":
            _parent.unCrispy();
            break;
         case "clone":
            _parent.unClone();
      }
      _loc2_ = _loc2_ + 1;
   }
}
function addSpecialAbility(abilityName, abilityParams)
{
   removeSpecialAbility(abilityName);
   if(specialAbility == "none" || !specialAbility || typeof specialAbility == "string")
   {
      specialAbility = new Array();
      specialAbilityParams = new Array();
   }
   specialAbility.push(abilityName);
   specialAbilityParams.push(abilityParams);
}
function removeSpecialAbility(abilityName)
{
   if(abilityName == "crispy")
   {
      _parent.unCrispy();
   }
   if(specialAbility != "none" && specialAbility)
   {
      var _loc2_ = 0;
      while(_loc2_ < specialAbility.length)
      {
         if(specialAbility[_loc2_] == abilityName)
         {
            specialAbility.splice(_loc2_,1);
            specialAbilityParams.splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
function checkSpecialAbility(abilityName)
{
   var _loc1_ = 0;
   while(_loc1_ < specialAbility.length)
   {
      if(specialAbility[_loc1_] == abilityName)
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function doColors()
{
   colorSkin(hand1);
   colorSkin(hand2);
   colorSkin(foot1.inner);
   colorSkin(foot2.inner);
   colorSkin(head.headSkin);
   colorSkin(body);
   if(!checkSpecialAbility("crispy"))
   {
      colorSkin(head.eyes.eyelids);
   }
}
function setColors()
{
   if(skinColor == undefined || skinColor == null)
   {
      skinColor = lineColor = 16777215;
   }
   doColors();
   colorSetter.onEnterFrame = function()
   {
      doColors();
      delete this.onEnterFrame;
   };
}
function colorSkin(clip)
{
   setColor = new Color(clip.skinShape);
   setColor.setRGB(skinColor);
}
function colorHair(clip)
{
   setColor = new Color(clip.hairShape);
   setColor.setRGB(hairColor);
}
function follow(clip, target, delX, delY, k, damp, doRotation)
{
   clip.vx = 0;
   clip.vy = 0;
   clip.ax = 0;
   clip.ay = 0;
   clip.delX = delX;
   clip.delY = delY;
   clip.k = k;
   clip.damp = damp;
   clip.doRotation = doRotation;
   clip.target = target;
   clip.onEnterFrame = function()
   {
      this.ax = (this.target._x + this.delX - this._x) * this.k;
      this.ay = (this.target._y + this.delY - this._y) * this.k;
      this.vx += this.ax;
      this.vy += this.ay;
      this.vx *= this.damp;
      this.vy *= this.damp;
      this._x += this.vx;
      this._y += this.vy;
      if(this._name == "pack")
      {
         this._rotation += (this.target._rotation - this._rotation) / 2;
      }
      else if(this.doRotation)
      {
         this._rotation = this.vy / 2;
      }
      else
      {
         this._rotation = 180 + this.target.radians2 * 180 / 3.141592653589793 * 0.8;
      }
   };
}
function swing(clip, joint)
{
   clip.onEnterFrame = function()
   {
      clip.delX = clip._x - joint._x;
      clip.delY = clip._y - joint._y;
      clip.radians2 = Math.atan(clip.delY / clip.delX);
      if(clip.delX < 0)
      {
         clip.radians2 = 6.283185307179586 + clip.radians2;
      }
      else
      {
         clip.radians2 = 3.141592653589793 + clip.radians2;
      }
      clip.distance = Math.sqrt(clip.delX * clip.delX + clip.delY * clip.delY);
      if(_parent.isCreature)
      {
         clip.maxD = 60;
      }
      else
      {
         clip.maxD = 80;
      }
      if(clip.distance < clip.maxD)
      {
         clip.radians2 += -1.5707963267948966 * ((clip.maxD - clip.distance) / clip.maxD);
      }
      clip.bendX = -40 * Math.cos(clip.radians2);
      clip.bendY = -40 * Math.sin(clip.radians2);
      joint.clear();
      joint.lineStyle(lineWidth,lineColor,lineAlpha);
      joint.moveTo(0,0);
      joint.curveTo(clip.bendX,clip.bendY,clip.delX,clip.delY);
   };
}
function walk(clip, joint)
{
   clip.onEnterFrame = function()
   {
      clip.delX = clip._x - joint._x;
      clip.delY = clip._y - joint._y;
      clip.radians2 = Math.atan(clip.delY / clip.delX);
      if(clip.delX < 0)
      {
         clip.radians2 = 6.283185307179586 + clip.radians2;
      }
      else
      {
         clip.radians2 = 3.141592653589793 + clip.radians2;
      }
      clip.distance = Math.sqrt(clip.delX * clip.delX + clip.delY * clip.delY);
      if(_parent.isCreature)
      {
         clip.maxD = 60;
      }
      else
      {
         clip.maxD = 80;
      }
      if(clip.distance < clip.maxD)
      {
         clip.radians2 += 1.5707963267948966 * ((clip.maxD - clip.distance) / clip.maxD);
      }
      clip.bendX = -40 * Math.cos(clip.radians2);
      clip.bendY = -40 * Math.sin(clip.radians2);
      joint.clear();
      if(colorPants)
      {
         joint.lineStyle(lineWidth,pantsColor,lineAlpha);
      }
      else
      {
         joint.lineStyle(lineWidth,lineColor,lineAlpha);
      }
      joint.moveTo(0,0);
      joint.curveTo(clip.bendX,clip.bendY,clip.delX,clip.delY);
   };
}
function particles(clip, xOffset, yOffset, xVel1, xVel2, yVel1, yVel2, alphaStart, alphaStep, scaleStart, scaleStep, gravity, damp)
{
   var _loc2_ = clip.attachMovie("Particle","particle" + clip.getNextHighestDepth(),clip.getNextHighestDepth());
   _loc2_.xVel = Math.random() * (xVel2 - xVel1) + xVel1;
   _loc2_.yVel = Math.random() * (yVel2 - yVel1) + yVel1;
   _loc2_._x = xOffset;
   _loc2_._y = yOffset;
   _loc2_._alpha = alphaStart;
   _loc2_._xscale = _loc2_._yscale = scaleStart;
   _loc2_.onEnterFrame = function()
   {
      this.yVel += gravity;
      this.xVel *= damp;
      this.yVel *= damp;
      this._x += this.xVel;
      this._y += this.yVel;
      this._alpha -= alphaStep;
      this._xscale = this._yscale += scaleStep;
      if(this._y > 300 || this._alpha < 0)
      {
         this.removeMovieClip();
      }
   };
}
function saveGames(games)
{
   FunBrain_so.data.games = games;
   if(FunBrain_so.data.games.charAt(0) == ",")
   {
      FunBrain_so.data.games = FunBrain_so.data.games.substr(1,FunBrain_so.data.games.length);
   }
   if(FunBrain_so.data.games == undefined)
   {
      FunBrain_so.data.games = "";
   }
}
function loadGames()
{
   return FunBrain_so.data.games;
}
function getGame(game)
{
   var _loc2_ = FunBrain_so.data.games;
   if(_loc2_ == undefined)
   {
      _loc2_ = "";
   }
   var _loc4_ = _loc2_.split(",");
   _loc2_ = "," + _loc2_ + ",";
   if(_loc2_.indexOf("," + game.toString() + ",") == -1)
   {
      _loc4_.push(game.toString());
      saveGames(_loc4_.toString());
      if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
      {
         var _loc3_ = new LoadVars();
         var _loc5_ = new LoadVars();
         _loc5_.onLoad = function(success)
         {
         };
         _loc3_.name = FunBrain_so.data.login;
         _loc3_.pass_hash = FunBrain_so.data.password;
         _loc3_.dbid = FunBrain_so.data.dbid;
         _loc3_.games = FunBrain_so.data.games;
         _loc3_.sendAndLoad(_root.getPrefix() + "/save_games.php",_loc5_,"POST");
      }
   }
}
function updateIslandData(island, dataReadyCallback)
{
   if(FunBrain_so.data.login == "" || !FunBrain_so.data.Registred || island == undefined)
   {
      if(dataReadyCallback)
      {
         dataReadyCallback();
      }
      return undefined;
   }
   checkNameAllowed();
   checkCurrentCampaigns();
   var islandsToUpdate = new Array();
   var currentIsland;
   var currentIslandInventory;
   var _loc14_ = undefined;
   var removedItems;
   var fullIslandInventory;
   if(FunBrain_so.data.inventory == undefined)
   {
      FunBrain_so.data.inventory = new Object();
   }
   if(FunBrain_so.data.removedItems == undefined)
   {
      FunBrain_so.data.removedItems = new Object();
   }
   if(FunBrain_so.data.completedEvents == undefined)
   {
      FunBrain_so.data.completedEvents = new Object();
   }
   if(typeof island == "string")
   {
      island = new Array(island);
   }
   var _loc2_ = 0;
   while(_loc2_ < island.length)
   {
      currentIsland = island[_loc2_];
      if(!FunBrain_so.data.updatedIslands[currentIsland])
      {
         islandsToUpdate.push(currentIsland);
      }
      if(FunBrain_so.data.inventory[currentIsland] == undefined)
      {
         FunBrain_so.data.inventory[currentIsland] = new Array();
      }
      if(FunBrain_so.data.completedEvents[currentIsland] == undefined)
      {
         FunBrain_so.data.completedEvents[currentIsland] = new Array();
      }
      _loc2_ = _loc2_ + 1;
   }
   if(islandsToUpdate.length > 0)
   {
      var _loc11_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(receiver.answer == "ok")
         {
            if(receiver.json != undefined)
            {
               var _loc9_ = new asLib.JSON();
               var _loc3_ = undefined;
               try
               {
                  _loc3_ = _loc9_.parse(receiver.json);
               }
               catch(error:Object)
               {
                  trace("JSON Parse Error :: " + error);
               }
               var _loc6_ = _loc3_.fields;
               var _loc8_ = FunBrain_so.data.userData;
               if(_loc8_ == null)
               {
                  var _loc0_ = null;
                  _loc8_ = FunBrain_so.data.userData = {};
               }
               for(var _loc10_ in _loc6_)
               {
                  try
                  {
                     _loc8_[_loc10_] = _loc9_.parse(_loc6_[_loc10_]);
                  }
                  catch(error:Object)
                  {
                     trace("JSON Parse Error :: " + error);
                  }
               }
               var _loc4_ = new Array();
               var _loc2_ = 0;
               while(_loc2_ < islandsToUpdate.length)
               {
                  currentIsland = islandsToUpdate[_loc2_];
                  fullIslandInventory = _loc3_.items[currentIsland];
                  currentIslandInventory = new Array();
                  removedItems = new Array();
                  for(var _loc7_ in fullIslandInventory)
                  {
                     if(Number(fullIslandInventory[_loc7_]) == 0)
                     {
                        removedItems.push(_loc7_);
                     }
                     else
                     {
                        currentIslandInventory.push(_loc7_);
                     }
                  }
                  if(FunBrain_so.data.updatedIslands == undefined)
                  {
                     FunBrain_so.data.updatedIslands = new Object();
                  }
                  FunBrain_so.data.updatedIslands[currentIsland] = true;
                  FunBrain_so.data.inventory[currentIsland] = currentIslandInventory;
                  FunBrain_so.data.removedItems[currentIsland] = removedItems;
                  if(_loc3_.event[currentIsland])
                  {
                     FunBrain_so.data.completedEvents[currentIsland] = _loc3_.event[currentIsland];
                  }
                  trace("avatar.as - " + currentIsland + " | " + _root.island);
                  var _loc5_ = _loc3_.photos[currentIsland];
                  trace("avatar.as - islandarray" + _loc5_.length);
                  _loc4_ = _loc4_.concat(_loc5_);
                  trace("avatar.as - photoarray" + _loc4_.length);
                  _loc2_ = _loc2_ + 1;
               }
               var _loc11_ = _loc3_.photos.Global;
               trace("avatar.as - globalarray" + _loc11_.length);
               _loc4_ = _loc4_.concat(_loc11_);
               trace("avatar.as - photoarray" + _loc4_.length);
               com.poptropica.util.ScenePhotoManager.getInstance().updateIslandPhotos(_loc4_);
               FunBrain_so.flush();
               if(dataReadyCallback)
               {
                  dataReadyCallback();
               }
            }
         }
         else if(receiver.answer == "noIslandInfo")
         {
            if(dataReadyCallback)
            {
               dataReadyCallback();
            }
         }
      };
      _loc11_.login = FunBrain_so.data.login;
      _loc11_.pass_hash = FunBrain_so.data.password;
      _loc11_.dbid = FunBrain_so.data.dbid;
      utils.ArrayUtils.convertArrayToURLEncoding(islandsToUpdate,"island_names",_loc11_);
      _loc11_.sendAndLoad(_root.getPrefix() + "/get_island_info.php",receiver,"POST");
   }
   else if(dataReadyCallback)
   {
      dataReadyCallback();
   }
}
function getItem(item, island, onlyLocal)
{
   com.poptropica.util.ScenePhotoManager.getInstance().checkItemForPhoto(item);
   if(utils.Utils.isNull(island))
   {
      island = _root.island;
   }
   if(!FunBrain_so.data.inventory)
   {
      FunBrain_so.data.inventory = new Object();
   }
   if(!FunBrain_so.data.inventory[island])
   {
      FunBrain_so.data.inventory[island] = new Array();
   }
   FunBrain_so.data.inventory[island].push(item);
   FunBrain_so.flush();
   if(!onlyLocal)
   {
      var _loc4_ = new LoadVars();
      var _loc6_ = new LoadVars();
      _loc6_.onLoad = function(success)
      {
         _root.trackCampaign("","ObjectCollected",this.desc);
         _root.gWaitingOnServer = false;
         if(_root.gServerOperationComplete != null)
         {
            _root.gServerOperationComplete();
            _root.gServerOperationComplete = null;
         }
      };
      if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
      {
         _loc4_.name = FunBrain_so.data.login;
         _loc4_.pass_hash = FunBrain_so.data.password;
         _loc4_.dbid = FunBrain_so.data.dbid;
         _loc4_.item_id = item;
         _loc4_.sendAndLoad(_root.getPrefix() + "/add_item.php",_loc6_,"POST");
      }
      else
      {
         _loc4_.item_id = item;
         _loc4_.sendAndLoad(_root.getPrefix() + "/get_item_desc.php",_loc6_,"POST");
      }
      _root.gWaitingOnServer = true;
      _root.sendSceneVisit();
   }
   if(getIslandMedallionID(island) == item)
   {
      sendFinishedIsland(island);
      if(FunBrain_so.data.islandCompletions == undefined)
      {
         FunBrain_so.data.islandCompletions = new Object();
      }
      if(FunBrain_so.data.islandCompletions[island] == undefined)
      {
         FunBrain_so.data.islandCompletions[island] = 0;
      }
      FunBrain_so.data.islandCompletions[island] = Number(FunBrain_so.data.islandCompletions[island]) + 1;
      FunBrain_so.flush();
   }
}
function sendFinishedIsland(island)
{
   _root.trackCampaign("IslandEvent","IslandFinished",island);
   trace("GA :: Logging IslandFinished (sendFinishedIsland() for " + island + ")");
   flash.external.ExternalInterface.call("console.log","GA :: Logging IslandFinished");
   flash.external.ExternalInterface.call("GATrackEvent","IslandFinished",_root.island);
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _root.gWaitingOnServer = true;
      var _loc2_ = new LoadVars();
      var _loc5_ = new LoadVars();
      _loc5_.onLoad = function(success)
      {
         _root.gWaitingOnServer = false;
         if(_root.gServerOperationComplete != null)
         {
            _root.gServerOperationComplete();
            _root.gServerOperationComplete = null;
         }
      };
      _loc2_.login = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      var _loc4_ = new Object();
      _loc4_[island] = 0;
      utils.ArrayUtils.convertAssociativeArrayToURLEncoding(_loc4_,"islands",_loc2_);
      _loc2_.sendAndLoad(_root.getPrefix() + "/finished_islands.php",_loc5_,"POST");
   }
   else
   {
      if(FunBrain_so.data.islandTimes == undefined)
      {
         FunBrain_so.data.islandTimes = new Object();
      }
      if(FunBrain_so.data.islandTimes[island] == undefined)
      {
         FunBrain_so.data.islandTimes[island] = new Object();
      }
      var _loc6_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         for(var _loc1_ in receiver)
         {
            if(typeof receiver[_loc1_] != "function")
            {
               FunBrain_so.data.islandTimes[island].end = _loc1_;
            }
         }
      };
      _loc6_.sendAndLoad(_root.getPrefix() + "/time.php",receiver,"POST");
   }
}
function sendStartedIsland(island)
{
   _root.trackCampaign("IslandEvent","IslandStarted",island);
   trace("GA :: Logging IslandStarted |" + island + "| (sendStartedIsland)");
   flash.external.ExternalInterface.call("console.log","GA :: Logging IslandStarted");
   flash.external.ExternalInterface.call("GATrackEvent","IslandEvent","IslandStarted","IslandName",_root.island);
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _root.gWaitingOnServer = true;
      var _loc2_ = new LoadVars();
      var _loc5_ = new LoadVars();
      _loc5_.onLoad = function(success)
      {
         var _loc2_ = island.toLowerCase() + "_started";
         if(shouldCompleteStart(island))
         {
            completeEvent(_loc2_,island);
         }
         _root.gWaitingOnServer = false;
         if(_root.gServerOperationComplete != null)
         {
            _root.gServerOperationComplete();
            _root.gServerOperationComplete = null;
         }
      };
      _loc2_.login = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      var _loc4_ = new Object();
      _loc4_[island] = 0;
      utils.ArrayUtils.convertAssociativeArrayToURLEncoding(_loc4_,"islands",_loc2_);
      _loc2_.sendAndLoad(_root.getPrefix() + "/started_islands.php",_loc5_,"POST");
   }
   else
   {
      if(FunBrain_so.data.islandTimes == undefined)
      {
         FunBrain_so.data.islandTimes = new Object();
      }
      if(FunBrain_so.data.islandTimes[island] == undefined)
      {
         FunBrain_so.data.islandTimes[island] = new Object();
      }
      var _loc6_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         for(var _loc1_ in receiver)
         {
            if(typeof receiver[_loc1_] != "function")
            {
               FunBrain_so.data.islandTimes[island].start = _loc1_;
            }
         }
      };
      _loc6_.sendAndLoad(_root.getPrefix() + "/time.php",receiver,"POST");
   }
}
function rentItem(item)
{
   if(!FunBrain_so.data.inventory)
   {
      FunBrain_so.data.inventory = new Object();
   }
   if(!FunBrain_so.data.inventory.Rental)
   {
      FunBrain_so.data.inventory.Rental = new Array();
   }
   FunBrain_so.data.inventory.Rental.push(item);
   FunBrain_so.flush();
   var _loc2_ = new LoadVars();
   var _loc3_ = new LoadVars();
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _loc2_.login = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      _loc2_.item_id = item;
      _loc2_.sendAndLoad(_root.getPrefix() + "/rent_item.php",_loc3_,"POST");
   }
   else
   {
      _loc2_.item_id = item;
      _loc2_.sendAndLoad(_root.getPrefix() + "/get_item_desc.php",_loc3_,"POST");
   }
}
function getItemForIslands(item, islands)
{
   getItem(item);
   var _loc2_ = undefined;
   if(islands == undefined)
   {
      islands = getIslandNames();
   }
   var _loc3_ = 0;
   while(_loc3_ < islands.length)
   {
      _loc2_ = islands[_loc3_];
      if(_loc2_ != _root.island)
      {
         if(FunBrain_so.data.inventory[_loc2_] == undefined)
         {
            FunBrain_so.data.inventory[_loc2_] = new Array();
         }
         FunBrain_so.data.inventory[_loc2_].push(item);
      }
      _loc3_ = _loc3_ + 1;
   }
   FunBrain_so.flush();
}
function getIslandMedallionID(island)
{
   var _loc1_ = com.poptropica.models.PopModel.getInstance();
   return Number(_loc1_.getIslandProperty(island,"medallion"));
}
function resetIslandData(island, noRestart)
{
   _root.takeClick._visible = true;
   var _loc2_ = new LoadVars();
   var receiver = new LoadVars();
   receiver.onLoad = function(success)
   {
      if(receiver.answer == "ok" && !noRestart)
      {
         islandResetComplete(island,receiver.map);
      }
   };
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _loc2_.login = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      _loc2_.island = island;
      _loc2_.sendAndLoad(_root.getPrefix() + "/reset_island.php",receiver,"POST");
   }
   else if(!noRestart)
   {
      islandResetComplete(island);
   }
}
function islandResetComplete(island, map)
{
   resetIslandSpecificParts(island);
   var _loc3_ = FunBrain_so.data.photos;
   _root.trackCampaign("IslandEvent","IslandReset",island);
   var _loc2_ = FunBrain_so.data.login;
   var _loc4_ = FunBrain_so.data.password;
   FunBrain_so.clear();
   FunBrain_so.data.enteringNewIsland = true;
   FunBrain_so.data.photos = _loc3_;
   FunBrain_so.flush();
   _root.tryLogin(_loc2_,_loc4_);
}
function resetIslandSpecificParts(island, reset)
{
   var _loc1_ = false;
   switch(island)
   {
      case "Early":
         if(packFrame == "jet")
         {
            packFrame = 1;
         }
         if(itemFrame == 2 || itemFrame == "glowStick")
         {
            itemFrame = 1;
         }
         break;
      case "Shark":
         if(overpantsFrame == "grass")
         {
            overpantsFrame = 1;
         }
         break;
      case "Time":
         if(packFrame == "glider")
         {
            packFrame = 1;
         }
         if(facialFrame == "aztecMask")
         {
            facialFrame = 1;
         }
         break;
      case "Carrot":
         if(facialFrame == "rabbitCon2")
         {
            facialFrame = 1;
         }
         break;
      case "Spy":
         if(overshirtFrame == "grappleTie")
         {
            overshirtFrame = 1;
         }
         if(facialFrame == "chameleon")
         {
            facialFrame = 1;
            overpantsFrame = 1;
         }
         if(facialFrame == "chefBAD" || facialFrame == "laserVision")
         {
            facialFrame = 1;
         }
         break;
      case "Nabooti":
         if(facialFrame == "miner1" || facialFrame == "egyptDigger")
         {
            facialFrame = 1;
         }
         break;
      case "BigNate":
         if(facialFrame == "scuba2")
         {
            facialFrame = 1;
         }
         break;
      case "Myth":
         if(itemFrame == "poseidon")
         {
            itemFrame = 1;
         }
         if(hairFrame == "hades" || hairFrame == "hades2")
         {
            hairFrame = 1;
         }
         break;
      case "Trade":
         _loc1_ = true;
         delete FunBrain_so.data.userData.Skull;
         delete FunBrain_so.data.skullData;
         FunBrain_so.flush();
         break;
      case "Peanuts":
         if(facialFrame == "peanutsMask")
         {
            facialFrame = 1;
         }
         break;
      case "West":
         if(overshirtFrame == "wwBadge")
         {
            overshirtFrame = 1;
         }
         break;
      case "Japan":
         if(shirtFrame == "MTHkimono01" || shirtFrame == "MTHkimono02" || shirtFrame == "MTHkimono03" || shirtFrame == "MTHninjaBlue" || shirtFrame == "MTHninjaWhite")
         {
            shirtFrame = 1;
            pantsFrame = 1;
            overpantsFrame = 1;
            facialFrame = 1;
         }
         break;
      case "Train":
         if(facialFrame == "mtPorter")
         {
            facialFrame = 1;
         }
         break;
      case "Vampire":
         if(itemFrame == "VCcrossbow")
         {
            itemFrame = 1;
         }
         break;
      case "Villain":
         if(itemFrame == "sv_sprayer" || itemFrame == "sv_watch")
         {
            itemFrame = 1;
         }
         break;
      case "Zombie":
         if(itemFrame == "flashlight")
         {
            itemFrame = 1;
         }
         break;
      default:
         _loc1_ = true;
   }
   if(!_loc1_)
   {
      savePartsToSO();
   }
}
function returnToInitScene(island)
{
   var _loc2_ = com.poptropica.models.PopModel.getInstance();
   var _loc3_ = String(_loc2_.getIslandProperty(island,"island_main"));
   var _loc5_ = _loc2_.getIslandProperty(island,"init_coords");
   _root.char.loadScene(_loc3_,coords[0],coords[1],island);
}
function getInitScene(island)
{
   var _loc1_ = com.poptropica.models.PopModel.getInstance();
   return String(_loc1_.getIslandProperty(island,"island_main"));
}
function checkForNewIslandStart(island, scene)
{
   if("GlobalAS3Embassy" == scene)
   {
      trace("no need to do AS3 starts any more");
      return undefined;
   }
   trace("Perf checking for started island : " + arguments);
   Debug.trace("Perf checking for started island : " + arguments + " getinitscene " + getInitScene(island),Debug.VERBOSE_MESSAGE);
   if(getInitScene(island) == scene)
   {
      var _loc3_ = island.toLowerCase() + "_started";
      Debug.trace("Perf checking for started island : " + _loc3_ + " event : " + checkEvent(_loc3_,island),Debug.VERBOSE_MESSAGE);
      if(!checkEvent(_loc3_,island))
      {
         if(shouldCompleteStart(island))
         {
            completeEvent(_loc3_,island);
         }
         sendStartedIsland(island);
      }
   }
}
function shouldCompleteStart(islandName)
{
   var _loc5_ = islandName + "_as3";
   var _loc1_ = islandName.toLowerCase() + "_as3_started";
   var _loc2_ = utils.ArrayUtils.searchArray(_loc1_,FunBrain_so.data.completedEvents[islandName]);
   var _loc3_ = utils.ArrayUtils.searchArray(_loc1_,FunBrain_so.data.completedEvents[_loc5_]);
   return !(_loc2_ || _loc3_);
}
function updateIslandCompletions(dataReadyCallback)
{
   FunBrain_so.data.islandCompletions = new Object();
   var _loc3_ = new LoadVars();
   var receiver = new LoadVars();
   receiver.onLoad = function(success)
   {
      if(receiver.answer == "ok")
      {
         var _loc3_ = new asLib.JSON();
         var _loc1_ = _loc3_.parse(receiver.islands_json);
         trace("Island completions : " + _loc1_);
         for(var _loc2_ in _loc1_)
         {
            FunBrain_so.data.islandCompletions[_loc2_] = _loc1_[_loc2_];
            trace("Adding island completion : " + _loc2_ + " : " + _loc1_[_loc2_]);
         }
         FunBrain_so.flush();
      }
      if(dataReadyCallback)
      {
         dataReadyCallback();
      }
   };
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _loc3_.login = FunBrain_so.data.login;
      _loc3_.pass_hash = FunBrain_so.data.password;
      _loc3_.dbid = FunBrain_so.data.dbid;
      _loc3_.sendAndLoad(_root.getPrefix() + "/list_finished_islands.php",receiver,"POST");
   }
   else if(dataReadyCallback)
   {
      dataReadyCallback();
   }
}
function getIslandCompletions(island)
{
   var _loc1_ = FunBrain_so.data.islandCompletions[island];
   if(_loc1_ == undefined || _loc1_ == " " || _loc1_ == null || _loc1_ == "undefined")
   {
      _loc1_ = 0;
   }
   return _loc1_;
}
function sendFinishedIslands()
{
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      var _loc2_ = null;
      var _loc3_ = null;
      if(FunBrain_so.data.islandTimes != undefined)
      {
         for(var _loc5_ in FunBrain_so.data.islandTimes)
         {
            if(FunBrain_so.data.islandTimes[_loc5_].start != undefined)
            {
               if(_loc2_ == null)
               {
                  _loc2_ = new Object();
               }
               _loc2_[_loc5_] = FunBrain_so.data.islandTimes[_loc5_].start;
               if(FunBrain_so.data.islandTimes[_loc5_].end != undefined)
               {
                  if(_loc3_ == null)
                  {
                     _loc3_ = new Object();
                  }
                  _loc3_[_loc5_] = FunBrain_so.data.islandTimes[_loc5_].end;
               }
            }
         }
         if(_loc2_ != null)
         {
            var _loc4_ = new LoadVars();
            _loc4_.login = FunBrain_so.data.login;
            _loc4_.pass_hash = FunBrain_so.data.password;
            _loc4_.dbid = FunBrain_so.data.dbid;
            utils.ArrayUtils.convertAssociativeArrayToURLEncoding(_loc2_,"islands",_loc4_);
            _loc4_.sendAndLoad(_root.getPrefix() + "/started_islands.php",{},"POST");
            if(_loc3_ != null)
            {
               _loc4_ = new LoadVars();
               _loc4_.login = FunBrain_so.data.login;
               _loc4_.pass_hash = FunBrain_so.data.password;
               _loc4_.dbid = FunBrain_so.data.dbid;
               utils.ArrayUtils.convertAssociativeArrayToURLEncoding(_loc3_,"islands",_loc4_);
               _loc4_.sendAndLoad(_root.getPrefix() + "/finished_islands.php",{},"POST");
            }
         }
      }
   }
}
function deleteItem(item, island)
{
   if(island == undefined)
   {
      island = _root.island;
   }
   utils.ArrayUtils.removeElement(item,FunBrain_so.data.inventory[island]);
   if(FunBrain_so.data.removedItems == undefined)
   {
      FunBrain_so.data.removedItems = new Object();
   }
   if(FunBrain_so.data.removedItems[island] == undefined)
   {
      FunBrain_so.data.removedItems[island] = new Array();
   }
   FunBrain_so.data.removedItems[island].push(item);
   FunBrain_so.flush();
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      var _loc2_ = new LoadVars();
      var _loc4_ = new LoadVars();
      _loc4_.onLoad = function(success)
      {
         _root.gWaitingOnServer = false;
         if(_root.gServerOperationComplete != null)
         {
            _root.gServerOperationComplete();
            _root.gServerOperationComplete = null;
         }
      };
      _loc2_.name = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      _loc2_.item_id = item;
      _root.gWaitingOnServer = true;
      _loc2_.sendAndLoad(_root.getPrefix() + "/remove_item.php",_loc4_,"POST");
   }
   _root.sendSceneVisit();
}
function deleteItemFromIslands(item, islands)
{
   deleteItem(item);
   if(islands == undefined)
   {
      islands = getIslandNames();
   }
   var _loc3_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < islands.length)
   {
      _loc3_ = islands[_loc2_];
      if(_loc3_ != _root.island)
      {
         if(FunBrain_so.data.inventory[_loc3_] != undefined)
         {
            utils.ArrayUtils.removeElement(item,FunBrain_so.data.inventory[_loc3_]);
         }
      }
      _loc2_ = _loc2_ + 1;
   }
   FunBrain_so.flush();
}
function getIslandDescriptiveNames()
{
   var _loc1_ = com.poptropica.models.PopModel.getInstance();
   return _loc1_.getArrayOfDescriptiveIslandNames();
}
function getIslandNames()
{
   var _loc1_ = com.poptropica.models.PopModel.getInstance();
   return _loc1_.getArrayOfIslandNames();
}
function loadInventory(island)
{
   var _loc1_ = FunBrain_so.data.inventory[island];
   if(_loc1_ == undefined)
   {
      _loc1_ = new Array();
   }
   return _loc1_;
}
function loadFullInventory(onlyLocal, dataReadyCallback)
{
   if(!onlyLocal && (FunBrain_so.data.login == "" || !FunBrain_so.data.Registred))
   {
      onlyLocal = true;
   }
   var _loc4_ = getIslandNames();
   _loc4_.push("Store");
   _loc4_.push("Rental");
   var _loc1_ = undefined;
   if(onlyLocal)
   {
      var _loc5_ = new Array();
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc1_ = _loc4_[_loc2_];
         if(FunBrain_so.data.inventory[_loc1_] != undefined && FunBrain_so.data.inventory[_loc1_].length > 0 && typeof FunBrain_so.data.inventory[_loc1_] == "object")
         {
            _loc5_ = _loc5_.concat(FunBrain_so.data.inventory[_loc1_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      if(dataReadyCallback)
      {
         dataReadyCallback();
      }
      return _loc5_;
   }
   var _loc6_ = new Array();
   var _loc3_ = 0;
   while(_loc3_ < _loc4_.length)
   {
      _loc1_ = _loc4_[_loc3_];
      if(!FunBrain_so.data.updatedIslands[_loc1_])
      {
         _loc6_.push(_loc1_);
      }
      _loc3_ = _loc3_ + 1;
   }
   if(_loc6_.length > 0)
   {
      updateIslandData(_loc6_,dataReadyCallback);
   }
   else if(dataReadyCallback)
   {
      dataReadyCallback();
   }
}
function loadFullEvents()
{
   var _loc3_ = new Array();
   var _loc4_ = getIslandNames();
   var _loc1_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < _loc4_.length)
   {
      _loc1_ = _loc4_[_loc2_];
      if(FunBrain_so.data.completedEvents[_loc1_] != undefined && FunBrain_so.data.completedEvents[_loc1_].length > 0 && typeof FunBrain_so.data.completedEvents[_loc1_] == "object")
      {
         _loc3_ = _loc3_.concat(FunBrain_so.data.completedEvents[_loc1_]);
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc3_;
}
function loadFullRemovedItems()
{
   var _loc3_ = new Array();
   var _loc4_ = getIslandNames();
   var _loc1_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < _loc4_.length)
   {
      _loc1_ = _loc4_[_loc2_];
      if(FunBrain_so.data.removedItems[_loc1_] != undefined && FunBrain_so.data.removedItems[_loc1_].length > 0 && typeof FunBrain_so.data.removedItems[_loc1_] == "object")
      {
         _loc3_ = _loc3_.concat(FunBrain_so.data.removedItems[_loc1_]);
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc3_;
}
function checkGame(game)
{
   var _loc1_ = "," + loadGames() + ",";
   var _loc2_ = _loc1_.indexOf("," + game.toString() + ",");
   if(_loc2_ > -1)
   {
      return true;
   }
   return false;
}
function checkItem(item, island)
{
   var _loc1_ = undefined;
   if(island != undefined)
   {
      _loc1_ = FunBrain_so.data.inventory[island];
      return utils.ArrayUtils.searchArray(item,_loc1_);
   }
   for(var _loc3_ in FunBrain_so.data.inventory)
   {
      if(FunBrain_so.data.inventory[_loc3_] != undefined && FunBrain_so.data.inventory[_loc3_].length > 0)
      {
         _loc1_ = FunBrain_so.data.inventory[_loc3_];
         if(utils.ArrayUtils.searchArray(item,_loc1_))
         {
            return true;
         }
      }
   }
   return false;
}
function hideObtainedItems()
{
   var _loc9_ = FunBrain_so.data.inventory[_root.island].slice();
   var _loc8_ = FunBrain_so.data.removedItems[_root.island].slice();
   var _loc7_ = _loc9_.concat(_loc8_);
   if(_loc9_ == undefined && _loc8_ == undefined)
   {
      return undefined;
   }
   if(_loc9_ == undefined)
   {
      _loc7_ = _loc8_;
   }
   else if(_loc8_ == undefined)
   {
      _loc7_ = _loc9_;
   }
   var _loc4_ = undefined;
   var _loc5_ = undefined;
   var _loc6_ = undefined;
   var _loc2_ = null;
   var _loc3_ = 0;
   while(_loc3_ < _loc7_.length)
   {
      _loc4_ = _loc7_[_loc3_];
      _loc5_ = _root.camera.scene["_item" + _loc4_];
      _loc6_ = _root.camera.scene["item" + _loc4_];
      if(_loc5_)
      {
         _loc2_ = _loc5_;
      }
      else if(_loc6_)
      {
         _loc2_ = _loc6_;
      }
      if(_loc2_ != null)
      {
         _loc2_.swapDepths(_root.camera.scene.getNextHighestDepth());
         _loc2_.removeMovieClip();
         _loc2_._width = _loc2_._height = 0;
         _loc2_ = null;
      }
      _loc3_ = _loc3_ + 1;
   }
}
function checkItemType(item)
{
   var _loc2_ = FunBrain_so.data.inventory.Store;
   var _loc1_ = FunBrain_so.data.inventory.Rental;
   if(utils.ArrayUtils.searchArray(item,_loc2_))
   {
      return "purchased";
   }
   if(utils.ArrayUtils.searchArray(item,_loc1_))
   {
      return "rental";
   }
   return "none";
}
function completeEvent(eventName, island, callBack)
{
   com.poptropica.util.ScenePhotoManager.getInstance().checkEventForPhoto(eventName);
   _root.trc(callBack);
   if(island == undefined)
   {
      island = _root.island;
   }
   if(checkEvent(eventName,island))
   {
      return undefined;
   }
   if(FunBrain_so.data.completedEvents == undefined || typeof FunBrain_so.data.completedEvents != "object")
   {
      FunBrain_so.data.completedEvents = new Object();
   }
   if(FunBrain_so.data.completedEvents[island] == undefined || typeof FunBrain_so.data.completedEvents[island] != "object")
   {
      FunBrain_so.data.completedEvents[island] = new Array();
   }
   FunBrain_so.data.completedEvents[island].push(eventName);
   FunBrain_so.flush();
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      var _loc3_ = new LoadVars();
      var _loc6_ = new LoadVars();
      var owner = this;
      _loc6_.onLoad = function(success)
      {
         owner.callBack();
         _root.gWaitingOnServer = false;
         if(_root.gServerOperationComplete != null)
         {
            _root.gServerOperationComplete();
            _root.gServerOperationComplete = null;
         }
      };
      _loc3_.login = FunBrain_so.data.login;
      _loc3_.pass_hash = FunBrain_so.data.password;
      _loc3_.dbid = FunBrain_so.data.dbid;
      _loc3_.event_name = eventName;
      _loc3_.sendAndLoad(_root.getPrefix() + "/save_event.php",_loc6_,"POST");
      _root.gWaitingOnServer = true;
   }
   _root.sendSceneVisit();
   _root.trackCampaign("","EventCompleted",eventName);
}
function checkEvent(eventName, island)
{
   if(island == undefined)
   {
      island = _root.island;
   }
   return utils.ArrayUtils.searchArray(eventName,FunBrain_so.data.completedEvents[island]);
}
function deleteEvent(events, island)
{
   if(island == undefined)
   {
      island = _root.island;
   }
   var _loc3_ = new Array();
   if(typeof events == "string")
   {
      _loc3_ = [events];
   }
   else
   {
      _loc3_ = events;
   }
   utils.ArrayUtils.removeElements(_loc3_,FunBrain_so.data.completedEvents[island]);
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      var _loc2_ = new LoadVars();
      var _loc5_ = new LoadVars();
      _loc5_.onLoad = function(success)
      {
         _root.gWaitingOnServer = false;
         if(_root.gServerOperationComplete != null)
         {
            _root.gServerOperationComplete();
            _root.gServerOperationComplete = null;
         }
      };
      _loc2_.login = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      _loc2_.island = island;
      utils.ArrayUtils.convertArrayToURLEncoding(_loc3_,"events",_loc2_);
      _root.gWaitingOnServer = true;
      _loc2_.sendAndLoad(_root.getPrefix() + "/delete_user_events.php",_loc5_,"POST");
   }
}
function generateName()
{
   var _loc1_ = new Object();
   _loc1_.first = utils.Utils.pickRandomElement(FirstName);
   _loc1_.last = utils.Utils.pickRandomElement(LastName);
   saveName(_loc1_.first,_loc1_.last);
   return _loc1_;
}
function saveName(firstName, lastName)
{
   FunBrain_so.data.firstName = firstName;
   FunBrain_so.data.lastName = lastName;
   FunBrain_so.flush();
}
function loadName()
{
   if(utils.Utils.isNull(FunBrain_so.data.firstName))
   {
      FunBrain_so.data.firstName = FirstName[0];
   }
   if(utils.Utils.isNull(FunBrain_so.data.lastName))
   {
      FunBrain_so.data.lastName = LastName[0];
   }
   return FunBrain_so.data.firstName + " " + FunBrain_so.data.lastName;
}
function checkNameAllowed()
{
   if(!utils.ArrayUtils.searchArray(FunBrain_so.data.firstName,FirstName) && !utils.ArrayUtils.searchArray(FunBrain_so.data.firstName,FirstNameCustom))
   {
      FunBrain_so.data.firstName.indexOf("GUEST;") < 0 ? (FunBrain_so.data.firstName = "Poptropican") : (FunBrain_so.data.firstName = "Guest");
   }
   if(!utils.ArrayUtils.searchArray(FunBrain_so.data.lastName,LastName) && !utils.ArrayUtils.searchArray(FunBrain_so.data.lastName,LastNameCustom))
   {
      FunBrain_so.data.firstName.indexOf("GUEST;") < 0 ? (FunBrain_so.data.lastName = "") : (FunBrain_so.data.lastName = "Poptropican");
   }
   FunBrain_so.flush();
}
function saveCredits(credits)
{
   FunBrain_so.data.credits = !isNaN(credits) ? credits : 0;
}
function loadCredits()
{
   return !isNaN(FunBrain_so.data.credits) ? FunBrain_so.data.credits : 0;
}
function saveCreditChange(creditChanges)
{
   if(creditChanges == undefined || creditChanges == "")
   {
      return undefined;
   }
   var _loc3_ = creditChanges.split(";");
   var _loc7_ = new Array();
   var _loc1_ = 0;
   while(_loc1_ < _loc3_.length)
   {
      var _loc2_ = _loc3_[_loc1_].split("|");
      _loc7_.push(new Object({id:_loc2_[0],txt:_loc2_[1],sort_date:_loc2_[2]}));
      _loc1_ = _loc1_ + 1;
   }
   if(FunBrain_so.data.credit_change)
   {
      FunBrain_so.data.credit_change = FunBrain_so.data.credit_change.concat(_loc7_);
   }
   else
   {
      FunBrain_so.data.credit_change = _loc7_;
   }
   FunBrain_so.data.credit_change.sortOn("sort_date",Array.DESCENDING);
}
function loadCreditChange()
{
   return FunBrain_so.data.credit_change.length <= 0 ? new Array() : FunBrain_so.data.credit_change;
}
function saveRecent(recent)
{
   if(recent == undefined || recent == "")
   {
      return undefined;
   }
   var _loc4_ = recent.split(";");
   var _loc8_ = new Array();
   var _loc3_ = 0;
   while(_loc3_ < _loc4_.length)
   {
      var _loc2_ = _loc4_[_loc3_].split("|");
      var _loc1_ = _loc2_[1].split("-");
      var _loc5_ = new Date(parseInt(_loc1_[0]),parseInt(_loc1_[1]) - 1,parseInt(_loc1_[2]));
      _loc8_.push(new Object({action:_loc2_[0],sort_date:_loc2_[1],date:_loc5_.getMonth() + 1 + "/" + (_loc5_.getDate() <= 9 ? "0" + _loc5_.getDate() : _loc5_.getDate())}));
      _loc3_ = _loc3_ + 1;
   }
   FunBrain_so.data.recent = _loc8_;
   FunBrain_so.data.recent.sortOn("sort_date",Array.DESCENDING);
   FunBrain_so.data.recent.splice(7,FunBrain_so.data.recent.length);
}
function loadRecent()
{
   return FunBrain_so.data.recent.length <= 0 ? new Array() : FunBrain_so.data.recent;
}
function isRegistred()
{
   return !FunBrain_so.data.Registred ? false : true;
}
function saveLogin(login)
{
   var _loc1_ = SharedObject.getLocal("Char","/");
   _loc1_.data.login = login;
   _loc1_.flush();
}
function loadLogin()
{
   var _loc1_ = SharedObject.getLocal("Char","/");
   trace("AS3Embassy :: Getting login : " + _loc1_.data.login);
   return _loc1_.data.login;
}
function setLook(look)
{
   gender = look[0];
   skinColor = look[1];
   hairColor = look[2];
   lineColor = look[3];
   eyelidsPos = look[4];
   eyesFrame = look[5];
   marksFrame = look[6];
   pantsFrame = look[7];
   lineWidth = look[8];
   shirtFrame = look[9];
   hairFrame = look[10];
   mouthFrame = look[11];
   itemFrame = look[12];
   packFrame = look[13];
   facialFrame = look[14];
   overshirtFrame = look[15] != undefined ? look[15] : 1;
   overpantsFrame = look[16] != undefined ? look[16] : 1;
   var _loc2_ = look[17].split("^");
   if(_loc2_.length > 0)
   {
      specialAbility = new Array();
      specialAbilityParams = new Array();
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         specialAbility.push(_loc2_[_loc1_].split(":")[0]);
         specialAbilityParams.push(_loc2_[_loc1_].split(":")[1].split(";"));
         _loc1_ = _loc1_ + 1;
      }
   }
   else
   {
      specialAbility = "none";
      specialAbilityParams = null;
   }
}
function getLook()
{
   var _loc2_ = new Array();
   _loc2_.push(gender);
   _loc2_.push(skinColor);
   _loc2_.push(hairColor);
   _loc2_.push(lineColor);
   _loc2_.push(eyelidsPos);
   _loc2_.push(eyesFrame);
   _loc2_.push(marksFrame);
   _loc2_.push(pantsFrame);
   _loc2_.push(lineWidth);
   _loc2_.push(shirtFrame);
   _loc2_.push(hairFrame);
   _loc2_.push(mouthFrame);
   _loc2_.push(itemFrame);
   _loc2_.push(packFrame);
   _loc2_.push(facialFrame);
   _loc2_.push(overshirtFrame != undefined ? overshirtFrame : 1);
   _loc2_.push(overpantsFrame != undefined ? overpantsFrame : 1);
   if(specialAbility && specialAbility != "none")
   {
      var _loc3_ = new Array();
      var _loc1_ = 0;
      while(_loc1_ < specialAbility.length)
      {
         _loc3_.push(specialAbility[_loc1_] + ":" + specialAbilityParams[_loc1_].join(";"));
         _loc1_ = _loc1_ + 1;
      }
      _loc2_.push(_loc3_.join("^"));
   }
   else
   {
      _loc2_.push("none:");
   }
   return _loc2_.toString();
}
function saveLook(look)
{
   FunBrain_so.data.gender = look[0];
   FunBrain_so.data.skinColor = look[1];
   FunBrain_so.data.hairColor = look[2];
   FunBrain_so.data.lineColor = look[3];
   FunBrain_so.data.eyelidsPos = look[4];
   FunBrain_so.data.eyesFrame = look[5];
   FunBrain_so.data.marksFrame = look[6];
   FunBrain_so.data.pantsFrame = look[7];
   FunBrain_so.data.lineWidth = look[8];
   FunBrain_so.data.shirtFrame = look[9];
   FunBrain_so.data.hairFrame = look[10];
   FunBrain_so.data.mouthFrame = look[11];
   FunBrain_so.data.itemFrame = look[12];
   FunBrain_so.data.packFrame = look[13];
   FunBrain_so.data.facialFrame = look[14];
   FunBrain_so.data.overshirtFrame = look[15] != undefined ? look[15] : 1;
   FunBrain_so.data.overpantsFrame = look[16] != undefined ? look[16] : 1;
   var _loc2_ = look[17].split("^");
   if(_loc2_.length > 0)
   {
      FunBrain_so.data.specialAbility = new Array();
      FunBrain_so.data.specialAbilityParams = new Array();
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         FunBrain_so.data.specialAbility.push(_loc2_[_loc1_].split(":")[0]);
         FunBrain_so.data.specialAbilityParams.push(_loc2_[_loc1_].split(":")[1].split(";"));
         _loc1_ = _loc1_ + 1;
      }
   }
   else
   {
      FunBrain_so.data.specialAbility = "none";
      FunBrain_so.data.specialAbilityParams = null;
   }
   FunBrain_so.flush();
}
function verifyUserData()
{
   if(FunBrain_so.data.gender != 0 && FunBrain_so.data.gender != 1 && !_root.restoringUserData)
   {
      if(!FunBrain_so.data.Registred)
      {
         _root.trackCampaign("","Debugging","User Data Lost",FunBrain_so.data.Registred);
         _root.popup("lostlook.swf",true);
         return undefined;
      }
      _root.restoringUserData = true;
      _root.trackCampaign("","Debugging","Attempting User Data Recovery",FunBrain_so.data.Registred);
      var _loc2_ = SharedObject.getLocal("Backup","/");
      if(!utils.Utils.isNull(_loc2_.data.login) && !utils.Utils.isNull(_loc2_.data.password))
      {
         if(!com.poptropica.models.PopModelConst.gameplayMC.popupClip)
         {
            com.poptropica.models.PopModelConst.gameplayMC.createEmptyMovieClip("popupClip",com.poptropica.models.PopModelConst.gameplayMC.getNextHighestDepth());
         }
         var _loc3_ = new LSOWarningManager(com.poptropica.models.PopModelConst.gameplayMC,com.poptropica.models.PopModelConst.gameplayMC.popupClip,com.poptropica.models.PopModelConst.gameplayWidth,com.poptropica.models.PopModelConst.gameplayHeight);
         var _loc4_ = _loc3_.flush(90000,Delegate.create(_root,retrieveLostData));
         if(_loc4_ == true)
         {
            retrieveLostData();
            _root.trackCampaign("","Debugging","User Data Recovered",FunBrain_so.data.Registred);
         }
      }
      else
      {
         _root.trackCampaign("","Debugging","User Data Lost",FunBrain_so.data.Registred);
         _root.popup("lostlook.swf",true);
      }
   }
}
function retrieveLostData()
{
   _root.sendSceneVisit();
   var _loc2_ = SharedObject.getLocal("Backup","/");
   FunBrain_so.data.enteringNewIsland = true;
   FunBrain_so.data.doingLogin = true;
   FunBrain_so.flush();
   _root.tryLogin(_loc2_.data.login,_loc2_.data.password);
}
function restoreUserData()
{
   var _loc1_ = SharedObject.getLocal("Backup","/");
   if(FunBrain_so.data.login == undefined)
   {
      FunBrain_so.data.login = _loc1_.data.login;
   }
   if(FunBrain_so.data.password == undefined)
   {
      FunBrain_so.data.password = _loc1_.data.password;
   }
   FunBrain_so.data.gender = _loc1_.data.gender;
   FunBrain_so.data.skinColor = _loc1_.data.skinColor;
   FunBrain_so.data.hairColor = _loc1_.data.hairColor;
   FunBrain_so.data.lineColor = _loc1_.data.lineColor;
   FunBrain_so.data.eyelidsPos = _loc1_.data.eyelidsPos;
   FunBrain_so.data.eyesFrame = _loc1_.data.eyesFrame;
   FunBrain_so.data.marksFrame = _loc1_.data.marksFrame;
   FunBrain_so.data.pantsFrame = _loc1_.data.pantsFrame;
   FunBrain_so.data.lineWidth = _loc1_.data.lineWidth;
   FunBrain_so.data.shirtFrame = _loc1_.data.shirtFrame;
   FunBrain_so.data.hairFrame = _loc1_.data.hairFrame;
   FunBrain_so.data.mouthFrame = _loc1_.data.mouthFrame;
   FunBrain_so.data.itemFrame = _loc1_.data.itemFrame;
   FunBrain_so.data.packFrame = _loc1_.data.packFrame;
   FunBrain_so.data.facialFrame = _loc1_.data.facialFrame;
   FunBrain_so.data.overshirtFrame = _loc1_.data.overshirtFrame;
   FunBrain_so.data.overpantsFrame = _loc1_.data.overpantsFrame;
   FunBrain_so.data.specialAbility = _loc1_.data.specialAbility;
   FunBrain_so.data.specialAbilityParams = _loc1_.data.specialAbilityParams;
   FunBrain_so.flush();
}
function loadLook()
{
   var _loc2_ = new Array();
   _loc2_.push(FunBrain_so.data.gender);
   _loc2_.push(FunBrain_so.data.skinColor);
   _loc2_.push(FunBrain_so.data.hairColor);
   _loc2_.push(FunBrain_so.data.lineColor);
   _loc2_.push(FunBrain_so.data.eyelidsPos);
   _loc2_.push(FunBrain_so.data.eyesFrame);
   _loc2_.push(FunBrain_so.data.marksFrame);
   _loc2_.push(FunBrain_so.data.pantsFrame);
   _loc2_.push(FunBrain_so.data.lineWidth);
   _loc2_.push(FunBrain_so.data.shirtFrame);
   _loc2_.push(FunBrain_so.data.hairFrame);
   _loc2_.push(FunBrain_so.data.mouthFrame);
   _loc2_.push(FunBrain_so.data.itemFrame);
   _loc2_.push(FunBrain_so.data.packFrame);
   _loc2_.push(FunBrain_so.data.facialFrame);
   _loc2_.push(FunBrain_so.data.overshirtFrame != undefined ? FunBrain_so.data.overshirtFrame : 1);
   _loc2_.push(FunBrain_so.data.overpantsFrame != undefined ? FunBrain_so.data.overpantsFrame : 1);
   if(FunBrain_so.data.specialAbility && FunBrain_so.data.specialAbility != "none")
   {
      var _loc3_ = new Array();
      var _loc1_ = 0;
      while(_loc1_ < FunBrain_so.data.specialAbility.length)
      {
         _loc3_.push(FunBrain_so.data.specialAbility[_loc1_] + ":" + FunBrain_so.data.specialAbilityParams[_loc1_].join(";"));
         _loc1_ = _loc1_ + 1;
      }
      _loc2_.push(_loc3_.join("^"));
   }
   else
   {
      _loc2_.push("none:");
   }
   return _loc2_.toString();
}
function saveVisited(rooms)
{
   FunBrain_so.data.visited = rooms.split("undefined").join("0");
}
function loadVisited()
{
   return FunBrain_so.data.visited.split("undefined").join("0");
}
function changeSkinColor(newColor)
{
   skinColor = newColor;
   rgb = hexToRgb(skinColor);
   red = rgb.red * 0.8;
   green = rgb.green * 0.8;
   blue = rgb.blue * 0.8;
   lineColor = rgbToHex(red,green,blue);
}
function setUserField(fld, val)
{
   var _loc4_ = new asLib.JSON();
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      var _loc2_ = new LoadVars();
      var _loc3_ = new LoadVars();
      _loc3_.onLoad = function(success)
      {
      };
      _loc2_.login = FunBrain_so.data.login;
      _loc2_.pass_hash = FunBrain_so.data.password;
      _loc2_.dbid = FunBrain_so.data.dbid;
      _loc2_.field = fld;
      _loc2_.value = _loc4_.stringify(val);
      _loc2_.sendAndLoad(_root.getPrefix() + "/set_user_field.php",_loc3_,"POST");
   }
}
function trunc(s, c)
{
   if(s.charAt(0) == c)
   {
      s = s.substr(1,s.length);
   }
   if(s.charAt(s.length - 1) == c)
   {
      s = s.substr(0,s.length - 1);
   }
   return s;
}
function meanEyes()
{
   head.eyes.eyelids.skinShape.nextFrame();
   head.eyes.eyelids.skinLine.nextFrame();
}
function medallionDataCurrent()
{
   return FunBrain_so.data.medallionDataCurrent;
}
function setMedallionDataCurrent(isCurrent)
{
   if(isCurrent == undefined)
   {
      isCurrent = true;
   }
   FunBrain_so.data.medallionDataCurrent = isCurrent;
   FunBrain_so.flush();
}
function getPromoCodeUses(code, dataReadyCallback)
{
   var _loc2_ = new LoadVars();
   var receiver = new LoadVars();
   receiver.onLoad = function(success)
   {
      if(receiver.answer == "ok")
      {
         dataReadyCallback(receiver.uses);
      }
      else if(dataReadyCallback)
      {
         dataReadyCallback(0);
      }
   };
   if(FunBrain_so.data.login != "" && FunBrain_so.data.Registred)
   {
      _loc2_.promo_code = code;
      _loc2_.sendAndLoad(_root.getPrefix() + "/get_promo_code_uses.php",receiver,"POST");
   }
   else if(dataReadyCallback)
   {
      dataReadyCallback(0);
   }
}
stop();
var pad_keys;
var XOR_KEY = 3482;
var FirstName = ["Red","Blue","White","Green","Orange","Invisible","Spotted","Fast","Speedy","Happy","Sneaky","Short","Scary","Shiny","Muddy","Slippery","Cool","Curious","Sleepy","Hungry","Quick","Speedy","Jumpy","Nervous","Grumpy","Big","Young","Noisy","Brave","Skinny","Shifty","Crazy","Serious","Angry","Calm","Creepy","Bony","Busy","Happy","Hyper","Moody","Silly","Thirsty","Purple","Maroon","Yellow","Grey","Golden","Silver","Striped","Shaky","Shy","Quiet","Beefy","Giant","","Shoeless","Bendy","Sporty","Barefoot","Bronze","Chilly","Dangerous","Fierce","Fearless","Friendly","Funny","Little","Lone","Loud","Lucky","Mad","Magic","Mighty","Messy","Perfect","Small","Smart","Super","Tall","Tough","Trusty","Wild","Prickly","Squeezy","Zippy","Bashful","Cheerful","Clean","Comical","Cuddly","Dizzy","Friendly","Gentle","Greedy","Icy","Incredible","Lazy","Massive","Neat","Nice","Popular","Rough","Shaggy","Sticky","Strange","Zany"];
var LastName = ["Lizard","Whale","Penguin","Hawk","Shark","Ghost","Bird","Eagle","Bear","Skunk","Leopard","Eel","Wolf","Hippo","Hammer","Octopus","Sneeze","Tooth","Eye","Fang","Leaf","Dragon","Belly","Bean","Bee","Spider","Fish","Foot","Coyote","Bird","Pelican","Tiger","Lion","Crumb","Peanut","Cheetah","Speck","Bite","Ant","Bug","Feather","Glove","Boot","Hero","Onion","Pear","Grape","Crown","Sun","Moon","Star","Starfish","Raptor","Claw","Dragon","Monster","Club","Rock","Melon","Thunder","Lightning","Cloud","Sky","Paw","Mosquito","Storm","Tornado","Clown","Wing","Shadow","Noodle","Typhoon","Snowball","Icicle","Ice","Catfish","Ring","Socks","Toes","Skull","Bones","Scorpion","Beetle","Tomato","Carrot","Sword","Axe","","Heart","Brain","Lobster","Crab","Cactus","Horse","Kid","Seal","Panda","Seagull","Dolphin","Goose","Turtle","Fire","Flame","Owl","Fox","Boa","Burger","Sponge","Bubbles","Chicken","Comet","Fly","Berry","Plug","Crush","Shell","Hamburger","Knuckle","Tummy","Biker","Drummer","Flipper","Flyer","Gamer","Hopper","Joker","Jumper","Popper","Rider","Runner","Singer","Sinker","Spinner","Stomper","Walker"];
var FirstNameCustom = ["Cosmoe","Tiny","Shark","Shark Boy","Dr.","Dr. Hare","Vlad the","Hazmat","Captain","Black","Binary","Comic","Director","Fact","Hades","Master","Diamond","Laser","Warrior","Hero Of","Ned","The","Unknown","Wimpy"];
var LastNameCustom = ["Crush","Boy","Shark Boy","Hare","Dr. Hare","Viking","Hermit","Crawfish","Widow","Bard","Kid","D","Monster","Hades","Mime","Ninja","Shield","Diamond","Warrior","Businessman","Carnival","Chief","Coder","Diver","Hook","Hurricane","Jaguar","Jester","Knight","Laser","Ocean","Player","Noodlehead"];
var _partFrameLabels = new Object();
_partFrameLabels.facial = new Object();
_partFrameLabels.hair = new Object();
_partFrameLabels.item = new Object();
_partFrameLabels.marks = new Object();
_partFrameLabels.overpants = new Object();
_partFrameLabels.overshirt = new Object();
_partFrameLabels.pack = new Object();
_partFrameLabels.pants = new Object();
_partFrameLabels.shirt = new Object();
_partFrameLabels.shirt["8"] = "bare";
_partFrameLabels.shirt["28"] = "greekWarrior";
_partFrameLabels.shirt["29"] = "aztecWoman";
_partFrameLabels.shirt["30"] = "aztecQueen";
_partFrameLabels.shirt["31"] = "aztecSlave";
_partFrameLabels.shirt["32"] = "aztecWomanSlave";
_partFrameLabels.shirt["33"] = "chineseWarrior";
_partFrameLabels.shirt["34"] = "chineseWiseGuy";
_partFrameLabels.shirt["35"] = "chineseArtist";
_partFrameLabels.shirt["36"] = "chinesePeasant";
_partFrameLabels.shirt["37"] = "leo";
_partFrameLabels.shirt["38"] = "bartholdi";
_partFrameLabels.shirt["39"] = "eiffel";
_partFrameLabels.shirt["40"] = "frenchman1";
_partFrameLabels.shirt["41"] = "frenchman2";
_partFrameLabels.shirt["42"] = "edison";
_partFrameLabels.shirt["43"] = "edworker1";
_partFrameLabels.shirt["44"] = "edworker2";
_partFrameLabels.shirt["45"] = "van";
_partFrameLabels.shirt["46"] = "rat";
_partFrameLabels.shirt["47"] = "explorer";
_partFrameLabels.shirt["48"] = "finVendor";
_partFrameLabels.shirt["49"] = "hulaLady";
_partFrameLabels.shirt["50"] = "fisherman";
_partFrameLabels.shirt["51"] = "distressedMom";
_partFrameLabels.shirt["52"] = "vendor";
_partFrameLabels.shirt["53"] = "skater";
_partFrameLabels.shirt["54"] = "scuba";
_partFrameLabels.shirt["55"] = "lewis";
_partFrameLabels.shirt["56"] = "clark";
_partFrameLabels.shirt["57"] = "york";
_partFrameLabels.shirt["58"] = "sacagawea";
_partFrameLabels.shirt["59"] = "toussaint";
_partFrameLabels.shirt["60"] = "batman";
_partFrameLabels.shirt["61"] = "tourist";
_partFrameLabels.shirt["62"] = "greekWiseGuy";
_partFrameLabels.shirt["63"] = "greekLady";
_partFrameLabels.shirt["64"] = "greekGuy";
_partFrameLabels.shirt["65"] = "oracle";
_partFrameLabels.shirt["66"] = "spanishcon";
_partFrameLabels.shirt["67"] = "aztecWiseGuy";
_partFrameLabels.shirt["68"] = "viking1";
_partFrameLabels.shirt["69"] = "viking2";
_partFrameLabels.shirt["70"] = "viking3";
_partFrameLabels.shirt["71"] = "jefferson";
_partFrameLabels.shirt["72"] = "franklin";
_partFrameLabels.shirt["73"] = "adams";
_partFrameLabels.shirt["74"] = "hillary";
_partFrameLabels.shirt["75"] = "sherpa";
_partFrameLabels.shirt["76"] = "maliGuy1";
_partFrameLabels.shirt["77"] = "maliGuy2";
_partFrameLabels.shirt["78"] = "maliLady1";
_partFrameLabels.shirt["79"] = "maliLady2";
_partFrameLabels.shirt["80"] = "leoassist";
_partFrameLabels.shirt["81"] = "shark";
_partFrameLabels.shirt["82"] = "referee";
_partFrameLabels.shirt["83"] = "gasDude";
_partFrameLabels.shirt["84"] = "dinerWaitress";
_partFrameLabels.shirt["85"] = "farmer";
_partFrameLabels.shirt["86"] = "Mayor";
_partFrameLabels.shirt["87"] = "hobo";
_partFrameLabels.shirt["88"] = "drHare";
_partFrameLabels.shirt["89"] = "radioactive";
_partFrameLabels.shirt["90"] = "policeman";
_partFrameLabels.shirt["91"] = "warden";
_partFrameLabels.shirt["92"] = "prisoner1";
_partFrameLabels.shirt["93"] = "prisoner2";
_partFrameLabels.shirt["94"] = "nerd";
_partFrameLabels.shirt["95"] = "tailor";
_partFrameLabels.shirt["96"] = "pretzelVendor";
_partFrameLabels.shirt["97"] = "hero1";
_partFrameLabels.shirt["98"] = "hero2";
_partFrameLabels.shirt["99"] = "hero3";
_partFrameLabels.shirt["100"] = "hero4";
_partFrameLabels.shirt["101"] = "hero5";
_partFrameLabels.shirt["102"] = "hero6";
_partFrameLabels.shirt["103"] = "badAgent";
_partFrameLabels.shirt["104"] = "agent1";
_partFrameLabels.shirt["105"] = "agent2";
_partFrameLabels.shirt["106"] = "camoShirt";
_partFrameLabels.shirt["107"] = "directorD";
_partFrameLabels.shirt["108"] = "tux";
_partFrameLabels.shirt["109"] = "SS";
_partFrameLabels.shirt["110"] = "promDress";
_partFrameLabels.shirt["111"] = "fm1";
_partFrameLabels.shirt["112"] = "fm2";
_partFrameLabels.shirt["113"] = "fm3";
_partFrameLabels.shirt["114"] = "fm4";
_partFrameLabels.shirt["115"] = "fm5";
_partFrameLabels.shirt["116"] = "fm6";
_partFrameLabels.shirt["117"] = "fm7";
_partFrameLabels.shirt["118"] = "Sears1";
_partFrameLabels.shirt["119"] = "Sears2";
_partFrameLabels.shirt["120"] = "Sears3";
_partFrameLabels.shirt["121"] = "Sears4";
_partFrameLabels.shirt["122"] = "Sears5";
_partFrameLabels.shirt["123"] = "Sears6";
_partFrameLabels.shirt["124"] = "Nim1";
_partFrameLabels.shirt["125"] = "Nim2";
_partFrameLabels.shirt["126"] = "legoHenchman";
_partFrameLabels.shirt["127"] = "africanLady1";
_partFrameLabels.shirt["128"] = "africanLady2";
_partFrameLabels.shirt["129"] = "africanLady3";
_partFrameLabels.shirt["130"] = "africanLady4";
_partFrameLabels.shirt["131"] = "africanGuy2";
_partFrameLabels.shirt["132"] = "africanShepherd";
_partFrameLabels.shirt["133"] = "africanLady5";
_partFrameLabels.shirt["134"] = "africanLady6";
_partFrameLabels.shirt["135"] = "egyptDigger";
_partFrameLabels.shirt["136"] = "egyptArch";
_partFrameLabels.shirt["137"] = "oldPilot";
_partFrameLabels.shirt["138"] = "miner1";
_partFrameLabels.shirt["139"] = "miner2";
_partFrameLabels.shirt["140"] = "sponsorCTC";
_partFrameLabels.shirt["141"] = "sponsorWalmartElfM";
_partFrameLabels.shirt["142"] = "sponsorWalmartElfF";
_partFrameLabels.shirt["143"] = "sponsorWallE";
_partFrameLabels.shirt["144"] = "vampire";
_partFrameLabels.shirt["145"] = "blackT";
_partFrameLabels.shirt["146"] = "pinkV";
_partFrameLabels.shirt["147"] = "boyShirt1";
_partFrameLabels.shirt["148"] = "hippie";
_partFrameLabels.shirt["149"] = "lawyer";
_partFrameLabels.shirt["150"] = "librarian";
_partFrameLabels.shirt["151"] = "basketball";
_partFrameLabels.shirt["152"] = "muiscLoverG";
_partFrameLabels.shirt["153"] = "fastFood";
_partFrameLabels.shirt["154"] = "hipHop";
_partFrameLabels.shirt["155"] = "girlScout";
_partFrameLabels.shirt["156"] = "hiker";
_partFrameLabels.shirt["157"] = "snootyGirl";
_partFrameLabels.shirt["158"] = "chef";
_partFrameLabels.shirt["159"] = "grandma";
_partFrameLabels.shirt["160"] = "biker";
_partFrameLabels.shirt["161"] = "cowGirl";
_partFrameLabels.shirt["162"] = "grandpa";
_partFrameLabels.shirt["163"] = "gothGirl";
_partFrameLabels.shirt["164"] = "geisha";
_partFrameLabels.shirt["165"] = "soccer";
_partFrameLabels.shirt["166"] = "baseball";
_partFrameLabels.shirt["167"] = "whiteCollar";
_partFrameLabels.shirt["168"] = "FLpirate1";
_partFrameLabels.shirt["169"] = "FLpirate2";
_partFrameLabels.shirt["170"] = "FLpirate3";
_partFrameLabels.shirt["171"] = "blueTie";
_partFrameLabels.shirt["172"] = "sponsorPW1";
_partFrameLabels.shirt["173"] = "sponsorPW2";
_partFrameLabels.shirt["174"] = "pKnight1";
_partFrameLabels.shirt["175"] = "pKnight2";
_partFrameLabels.shirt["176"] = "pKnight3";
_partFrameLabels.shirt["177"] = "pGeisha1";
_partFrameLabels.shirt["178"] = "pGeisha2";
_partFrameLabels.shirt["179"] = "pGeisha3";
_partFrameLabels.shirt["180"] = "pBall1";
_partFrameLabels.shirt["181"] = "pBall2";
_partFrameLabels.shirt["182"] = "pBall3";
_partFrameLabels.shirt["183"] = "pRiding1";
_partFrameLabels.shirt["184"] = "pRiding2";
_partFrameLabels.shirt["185"] = "pRiding3";
_partFrameLabels.shirt["186"] = "sponsorHSM3guy";
_partFrameLabels.shirt["187"] = "sponsorHSM3girl";
_partFrameLabels.shirt["188"] = "shirtVest1";
_partFrameLabels.shirt["189"] = "shirtVest2";
_partFrameLabels.shirt["190"] = "musicShirt1";
_partFrameLabels.shirt["191"] = "musicShirt2";
_partFrameLabels.shirt["192"] = "pRobot";
_partFrameLabels.shirt["193"] = "pRobot1b";
_partFrameLabels.shirt["194"] = "pLion";
_partFrameLabels.shirt["195"] = "pMouse";
_partFrameLabels.shirt["196"] = "pDog1";
_partFrameLabels.shirt["197"] = "pDog2";
_partFrameLabels.shirt["198"] = "pDog3";
_partFrameLabels.shirt["199"] = "pDragon1";
_partFrameLabels.shirt["200"] = "pDragon2";
_partFrameLabels.shirt["201"] = "pDragon3";
_partFrameLabels.shirt["202"] = "pRooster1";
_partFrameLabels.shirt["203"] = "pRooster2";
_partFrameLabels.shirt["204"] = "pRooster3";
_partFrameLabels.shirt["205"] = "pEgyptQ";
_partFrameLabels.shirt["206"] = "pZorro";
_partFrameLabels.shirt["207"] = "pSamurai";
_partFrameLabels.shirt["208"] = "pRockerGuy1";
_partFrameLabels.shirt["209"] = "pRockerGuy2";
_partFrameLabels.shirt["210"] = "pRockerGuy3";
_partFrameLabels.shirt["211"] = "pRockerGirl1";
_partFrameLabels.shirt["212"] = "pRockerGirl2";
_partFrameLabels.shirt["213"] = "pRockerGirl3";
_partFrameLabels.shirt["214"] = "pPopGirl1";
_partFrameLabels.shirt["215"] = "pNinja1";
_partFrameLabels.shirt["216"] = "pRobinhood1";
_partFrameLabels.shirt["217"] = "pRobinhood2";
_partFrameLabels.shirt["218"] = "pRobinhood3";
_partFrameLabels.shirt["219"] = "pRobinhood4";
_partFrameLabels.shirt["220"] = "pRobinhood5";
_partFrameLabels.shirt["221"] = "pFairy1";
_partFrameLabels.shirt["222"] = "pFairy2";
_partFrameLabels.shirt["223"] = "pFairy3";
_partFrameLabels.shirt["224"] = "sponsorPinoFairy";
_partFrameLabels.shirt["225"] = "sponsorPinoPino";
_partFrameLabels.shirt["226"] = "cyberJester";
_partFrameLabels.shirt["227"] = "astroMonk";
_partFrameLabels.shirt["228"] = "astroCult";
_partFrameLabels.shirt["229"] = "astroServant2";
_partFrameLabels.shirt["230"] = "astroChance";
_partFrameLabels.shirt["231"] = "redKnight";
_partFrameLabels.shirt["232"] = "blueKnight";
_partFrameLabels.shirt["233"] = "greenKnight";
_partFrameLabels.shirt["234"] = "astroGuard1";
_partFrameLabels.shirt["235"] = "astroPrincess";
_partFrameLabels.shirt["236"] = "astroEvilPrincess";
_partFrameLabels.shirt["237"] = "astroRoyal1";
_partFrameLabels.shirt["238"] = "astroServant1";
_partFrameLabels.shirt["239"] = "astroQueen";
_partFrameLabels.shirt["240"] = "astroKing";
_partFrameLabels.shirt["241"] = "astroVill1";
_partFrameLabels.shirt["242"] = "astroManure";
_partFrameLabels.shirt["243"] = "astroVill2";
_partFrameLabels.shirt["244"] = "astroGuard2";
_partFrameLabels.shirt["245"] = "astroFarmer";
_partFrameLabels.shirt["246"] = "sponsorFLoct";
_partFrameLabels.shirt["247"] = "sponsorFLoct2";
_partFrameLabels.shirt["248"] = "astroVill3";
_partFrameLabels.shirt["249"] = "astroVill4";
_partFrameLabels.shirt["250"] = "astroPes2";
_partFrameLabels.shirt["251"] = "astroPes1";
_partFrameLabels.shirt["252"] = "astrocurrator";
_partFrameLabels.shirt["253"] = "astroGossip1";
_partFrameLabels.shirt["254"] = "astroGossip2";
_partFrameLabels.shirt["255"] = "astroGossip3";
_partFrameLabels.shirt["256"] = "astroGossip4";
_partFrameLabels.shirt["257"] = "astroGossip5";
_partFrameLabels.shirt["258"] = "astroAlien1";
_partFrameLabels.shirt["259"] = "astroAlien2";
_partFrameLabels.shirt["260"] = "astroAlien3";
_partFrameLabels.shirt["261"] = "astroAlien4";
_partFrameLabels.shirt["262"] = "astroZone";
_partFrameLabels.shirt["263"] = "pSingerGuy1";
_partFrameLabels.shirt["264"] = "pSingerGuy2";
_partFrameLabels.shirt["265"] = "pSingerGuy3";
_partFrameLabels.shirt["266"] = "pPirateGuy1";
_partFrameLabels.shirt["267"] = "pPirateGirl1";
_partFrameLabels.shirt["268"] = "pBaseballGirl1";
_partFrameLabels.shirt["269"] = "pBaseballGirl2";
_partFrameLabels.shirt["270"] = "pBaseballGirl3";
_partFrameLabels.shirt["271"] = "pBaseballGuy1";
_partFrameLabels.shirt["272"] = "pBaseballGuy2";
_partFrameLabels.shirt["273"] = "pBaseballGuy3";
_partFrameLabels.shirt["274"] = "pCowboy1";
_partFrameLabels.shirt["275"] = "pRobot2";
_partFrameLabels.shirt["276"] = "pRobot3";
_partFrameLabels.shirt["277"] = "pRobot4_1";
_partFrameLabels.shirt["278"] = "pRobot4_2";
_partFrameLabels.shirt["279"] = "pRobot4_3";
_partFrameLabels.shirt["280"] = "pRobot5";
_partFrameLabels.shirt["281"] = "pKarateBoy1";
_partFrameLabels.shirt["282"] = "pKarateBoy2";
_partFrameLabels.shirt["283"] = "pKarateBoy3";
_partFrameLabels.shirt["284"] = "pKarateGirl1";
_partFrameLabels.shirt["285"] = "pKarateGirl2";
_partFrameLabels.shirt["286"] = "pKarateGirl3";
_partFrameLabels.shirt["287"] = "pCheerleader1";
_partFrameLabels.shirt["288"] = "pCheerleader2";
_partFrameLabels.shirt["289"] = "pCheerleader3";
_partFrameLabels.shirt["290"] = "pCheerleadeGoth";
_partFrameLabels.shirt["291"] = "sponsorWM1";
_partFrameLabels.shirt["292"] = "sponsorWM2";
_partFrameLabels.shirt["293"] = "sponsorBedB1";
_partFrameLabels.shirt["294"] = "sponsorCWMB1";
_partFrameLabels.shirt["295"] = "sponsorCWMB2";
_partFrameLabels.shirt["296"] = "pFirefighter1";
_partFrameLabels.shirt["297"] = "pClown1";
_partFrameLabels.shirt["298"] = "pNinjaLE";
_partFrameLabels.shirt["299"] = "pSheDevil";
_partFrameLabels.shirt["300"] = "pDevil1";
_partFrameLabels.shirt["301"] = "pAngel";
_partFrameLabels.shirt["302"] = "sponsorLegoBio";
_partFrameLabels.shirt["303"] = "pBiker1";
_partFrameLabels.shirt["304"] = "pDareD1";
_partFrameLabels.shirt["305"] = "pumpkin";
_partFrameLabels.shirt["306"] = "grimReaper";
_partFrameLabels.shirt["307"] = "frankenstein";
_partFrameLabels.shirt["308"] = "frankBride";
_partFrameLabels.shirt["309"] = "sponsorAstro1";
_partFrameLabels.shirt["310"] = "sponsorAstro2";
_partFrameLabels.shirt["311"] = "hyde";
_partFrameLabels.shirt["312"] = "sponsorGbCrow";
_partFrameLabels.shirt["313"] = "witch";
_partFrameLabels.shirt["314"] = "witch2";
_partFrameLabels.shirt["315"] = "vampire2";
_partFrameLabels.shirt["316"] = "sponsorTinkerbell";
_partFrameLabels.shirt["317"] = "sponsorTinkerbell3";
_partFrameLabels.shirt["318"] = "sponsorTinkerbell4";
_partFrameLabels.shirt["319"] = "sponsorFuel1";
_partFrameLabels.shirt["320"] = "sponsorFuel2";
_partFrameLabels.shirt["321"] = "sponsorEC1";
_partFrameLabels.shirt["322"] = "sponsorEC2";
_partFrameLabels.shirt["323"] = "pWolf1";
_partFrameLabels.shirt["324"] = "pWolf2";
_partFrameLabels.shirt["325"] = "pLagoon";
_partFrameLabels.shirt["326"] = "pMunster";
_partFrameLabels.shirt["327"] = "sponsorSBsanta4";
_partFrameLabels.shirt["328"] = "sponsorPFxmas";
_partFrameLabels.shirt["329"] = "sponsorNM2guard";
_partFrameLabels.shirt["330"] = "blackWidow1";
_partFrameLabels.shirt["331"] = "blackWidow2";
_partFrameLabels.shirt["332"] = "shadyCop";
_partFrameLabels.shirt["333"] = "curator";
_partFrameLabels.shirt["334"] = "tourGuide";
_partFrameLabels.shirt["335"] = "chef2";
_partFrameLabels.shirt["336"] = "conWorker1";
_partFrameLabels.shirt["337"] = "curator2";
_partFrameLabels.shirt["338"] = "securityGuard1";
_partFrameLabels.shirt["339"] = "mime";
_partFrameLabels.shirt["340"] = "patron1";
_partFrameLabels.shirt["341"] = "counterRes1";
_partFrameLabels.shirt["342"] = "counterRes2";
_partFrameLabels.shirt["343"] = "pBallerina1";
_partFrameLabels.shirt["344"] = "pBallerina2";
_partFrameLabels.shirt["345"] = "pBallerina3";
_partFrameLabels.shirt["346"] = "pTigerShark";
_partFrameLabels.shirt["347"] = "frenchPol1";
_partFrameLabels.shirt["348"] = "sponsorSpyNext";
_partFrameLabels.shirt["349"] = "momChar1";
_partFrameLabels.shirt["350"] = "dadChar1";
_partFrameLabels.shirt["351"] = "sponsorCBee";
_partFrameLabels.shirt["352"] = "shirtEarly";
_partFrameLabels.shirt["353"] = "shirtShark";
_partFrameLabels.shirt["354"] = "shirtTime";
_partFrameLabels.shirt["355"] = "shirtCarrot";
_partFrameLabels.shirt["356"] = "shirtSuper";
_partFrameLabels.shirt["357"] = "shirtSpy";
_partFrameLabels.shirt["358"] = "shirtNabooti";
_partFrameLabels.shirt["359"] = "shirtNate";
_partFrameLabels.shirt["360"] = "shirtAstro";
_partFrameLabels.shirt["361"] = "shirtCounter";
_partFrameLabels.shirt["362"] = "shirtTV";
_partFrameLabels.shirt["363"] = "buckyFan";
_partFrameLabels.shirt["364"] = "buckyLucas";
_partFrameLabels.shirt["365"] = "tvSalesman";
_partFrameLabels.shirt["366"] = "papaPetes";
_partFrameLabels.shirt["367"] = "mikesMarket";
_partFrameLabels.shirt["368"] = "motelOwner";
_partFrameLabels.shirt["369"] = "realityTeen";
_partFrameLabels.shirt["370"] = "realityBoy";
_partFrameLabels.shirt["371"] = "realityGirl";
_partFrameLabels.shirt["372"] = "sponsorWilson";
_partFrameLabels.shirt["373"] = "sponsorDitch";
_partFrameLabels.shirt["374"] = "sponsorFizzy";
_partFrameLabels.shirt["375"] = "sponsorMonkeyBall";
_partFrameLabels.shirt["376"] = "pFootball1";
_partFrameLabels.shirt["377"] = "pFootball2";
_partFrameLabels.shirt["378"] = "pFootball3";
_partFrameLabels.shirt["379"] = "pFootball4";
_partFrameLabels.shirt["380"] = "charon";
_partFrameLabels.shirt["381"] = "hades";
_partFrameLabels.shirt["382"] = "medusa";
_partFrameLabels.shirt["383"] = "zeus";
_partFrameLabels.shirt["384"] = "athena";
_partFrameLabels.shirt["385"] = "aphrodite";
_partFrameLabels.shirt["386"] = "dionysus";
_partFrameLabels.shirt["387"] = "minotaur";
_partFrameLabels.shirt["388"] = "athenaOld";
_partFrameLabels.shirt["389"] = "aeolus";
_partFrameLabels.shirt["390"] = "mythPes1";
_partFrameLabels.shirt["391"] = "mythPes2";
_partFrameLabels.shirt["392"] = "mythPes3";
_partFrameLabels.shirt["393"] = "mythPes4";
_partFrameLabels.shirt["394"] = "mythPes5";
_partFrameLabels.shirt["395"] = "mythPes6";
_partFrameLabels.shirt["396"] = "mythPes7";
_partFrameLabels.shirt["397"] = "mythTeen1";
_partFrameLabels.shirt["398"] = "mythTeen2";
_partFrameLabels.shirt["399"] = "mythBeach1";
_partFrameLabels.shirt["400"] = "mythBeach2";
_partFrameLabels.shirt["401"] = "sponsorBF5a";
_partFrameLabels.shirt["402"] = "sponsorBF5b";
_partFrameLabels.shirt["403"] = "sponsorBF5c";
_partFrameLabels.shirt["404"] = "sponsorBF5d";
_partFrameLabels.shirt["405"] = "sponsorBF5e";
_partFrameLabels.shirt["406"] = "sponsorWimpy1";
_partFrameLabels.shirt["407"] = "sponsorTSBRbuzz";
_partFrameLabels.shirt["408"] = "sponsorTSBRjess";
_partFrameLabels.shirt["409"] = "sponsorTSBRalien";
_partFrameLabels.shirt["410"] = "sponsorTSBRwoody";
_partFrameLabels.shirt["411"] = "pMagic1";
_partFrameLabels.shirt["412"] = "pPunkGuy1";
_partFrameLabels.shirt["413"] = "pPunkGuy2";
_partFrameLabels.shirt["414"] = "pPunkGuy3";
_partFrameLabels.shirt["415"] = "pPunkGuy4";
_partFrameLabels.shirt["416"] = "pPunkGuy5";
_partFrameLabels.shirt["417"] = "pPunkGirl1";
_partFrameLabels.shirt["418"] = "pPunkGirl2";
_partFrameLabels.shirt["419"] = "pPunkGirl3";
_partFrameLabels.shirt["420"] = "pPunkGirl4";
_partFrameLabels.shirt["421"] = "pPunkGirl5";
_partFrameLabels.shirt["422"] = "pDrHare_Hench";
_partFrameLabels.shirt["423"] = "pEinstein";
_partFrameLabels.shirt["424"] = "pEinstein2";
_partFrameLabels.shirt["425"] = "pEarthKnight";
_partFrameLabels.shirt["426"] = "pGirlKnight";
_partFrameLabels.shirt["427"] = "pDarkKnight_boy";
_partFrameLabels.shirt["428"] = "pDarkKnight_girl";
_partFrameLabels.shirt["429"] = "pFool";
_partFrameLabels.shirt["430"] = "sponsorGoldfish1";
_partFrameLabels.shirt["431"] = "sponsorKoiFish";
_partFrameLabels.shirt["432"] = "skullMainGuard1";
_partFrameLabels.shirt["433"] = "skullOrleansGuard";
_partFrameLabels.shirt["434"] = "fisherman3";
_partFrameLabels.shirt["435"] = "skullMainBoy";
_partFrameLabels.shirt["436"] = "captCrawfish";
_partFrameLabels.shirt["437"] = "skullMainGov";
_partFrameLabels.shirt["438"] = "skullMainServant";
_partFrameLabels.shirt["439"] = "skullMainMerch";
_partFrameLabels.shirt["440"] = "skullMainOldMan";
_partFrameLabels.shirt["441"] = "skullMainHayLady";
_partFrameLabels.shirt["442"] = "skullMainOldLady";
_partFrameLabels.shirt["443"] = "skullMainFarmLady";
_partFrameLabels.shirt["444"] = "skullMainFarmer2";
_partFrameLabels.shirt["445"] = "skullMainClerk";
_partFrameLabels.shirt["446"] = "skullMainGirl";
_partFrameLabels.shirt["447"] = "skullMainSadLady";
_partFrameLabels.shirt["448"] = "skullPirate1";
_partFrameLabels.shirt["449"] = "skullPirate2";
_partFrameLabels.shirt["450"] = "skullPirate3";
_partFrameLabels.shirt["451"] = "skullPirate4";
_partFrameLabels.shirt["452"] = "skullPirate5";
_partFrameLabels.shirt["453"] = "skullPirate6";
_partFrameLabels.shirt["454"] = "skullPirate7";
_partFrameLabels.shirt["455"] = "skullMerchant2";
_partFrameLabels.shirt["456"] = "skullMerchant3";
_partFrameLabels.shirt["457"] = "skullMerchant4";
_partFrameLabels.shirt["458"] = "skullPirate8";
_partFrameLabels.shirt["459"] = "skullPirate9";
_partFrameLabels.shirt["460"] = "skullSam";
_partFrameLabels.shirt["461"] = "skullNavigator";
_partFrameLabels.shirt["462"] = "skullInk";
_partFrameLabels.shirt["463"] = "skullElegantLady";
_partFrameLabels.shirt["464"] = "skullMerchant1";
_partFrameLabels.shirt["465"] = "skullMoroLady1";
_partFrameLabels.shirt["466"] = "skullMoroLady2";
_partFrameLabels.shirt["467"] = "skullMoroLady3";
_partFrameLabels.shirt["468"] = "skullMoroBank1";
_partFrameLabels.shirt["469"] = "skullMoroGuy1";
_partFrameLabels.shirt["470"] = "skullMoroGuy2";
_partFrameLabels.shirt["471"] = "skullMoroGuy3";
_partFrameLabels.shirt["472"] = "skullChinaGuy1";
_partFrameLabels.shirt["473"] = "skullChinaGuy2";
_partFrameLabels.shirt["474"] = "skullChinaWorker1";
_partFrameLabels.shirt["475"] = "skullChinaShipwright";
_partFrameLabels.shirt["476"] = "skullChinaWiseWoman";
_partFrameLabels.shirt["477"] = "skullChinaShipSell";
_partFrameLabels.shirt["478"] = "skullChinaMerch";
_partFrameLabels.shirt["479"] = "pEarthDay";
_partFrameLabels.shirt["480"] = "sponsorHypnotic";
_partFrameLabels.shirt["481"] = "pSkullPirate1a";
_partFrameLabels.shirt["482"] = "pSkullPirate1b";
_partFrameLabels.shirt["483"] = "pSkullPirate1c";
_partFrameLabels.shirt["484"] = "pSkullPirate1d";
_partFrameLabels.shirt["485"] = "sponsorMH_shirt1";
_partFrameLabels.shirt["486"] = "sponsorMH_shirt2";
_partFrameLabels.shirt["487"] = "sponsorMH_shirt3";
_partFrameLabels.shirt["488"] = "sponsorMH_shirt4";
_partFrameLabels.shirt["489"] = "sponsorMH_shirt5";
_partFrameLabels.shirt["490"] = "sponsorMH_shirt6";
_partFrameLabels.shirt["491"] = "sponsorMH_shirt7";
_partFrameLabels.shirt["492"] = "pDaisy";
_partFrameLabels.shirt["493"] = "pPromKing1a";
_partFrameLabels.shirt["494"] = "pPromKing1b";
_partFrameLabels.shirt["495"] = "pPromKing1c";
_partFrameLabels.shirt["496"] = "pPromKing1d";
_partFrameLabels.shirt["497"] = "pPromQueen1a";
_partFrameLabels.shirt["498"] = "pPromQueen1b";
_partFrameLabels.shirt["499"] = "pPromQueen1c";
_partFrameLabels.shirt["500"] = "pPromQueen1d";
_partFrameLabels.shirt["501"] = "pPromQueen1e";
_partFrameLabels.shirt["502"] = "sponsorAgnes";
_partFrameLabels.shirt["503"] = "sponsorEdith";
_partFrameLabels.shirt["504"] = "sponsorMargo";
_partFrameLabels.shirt["505"] = "sponsorGoldfish2";
_partFrameLabels.shirt["506"] = "sponsorPercyJackson";
_partFrameLabels.shirt["507"] = "sponsorPercyZues";
_partFrameLabels.shirt["508"] = "sponsorPercyMedusa";
_partFrameLabels.shirt["509"] = "surferDude";
_partFrameLabels.shirt["510"] = "pMythSurferZeus";
_partFrameLabels.shirt["511"] = "pMythSurferHades";
_partFrameLabels.shirt["512"] = "pMythSurferPose";
_partFrameLabels.shirt["513"] = "pGradBoy1a";
_partFrameLabels.shirt["514"] = "pGradBoy1b";
_partFrameLabels.shirt["515"] = "pGradBoy3c";
_partFrameLabels.shirt["516"] = "pGradGirl1a";
_partFrameLabels.shirt["517"] = "pGradGirl1b";
_partFrameLabels.shirt["518"] = "pGradGirl1c";
_partFrameLabels.shirt["519"] = "pSoccer1a";
_partFrameLabels.shirt["520"] = "pSoccer1b";
_partFrameLabels.shirt["521"] = "pSoccer1c";
_partFrameLabels.shirt["522"] = "pSoccer1d";
_partFrameLabels.shirt["523"] = "sponsor_SelenaG";
_partFrameLabels.shirt["524"] = "sponsor_Ramona";
_partFrameLabels.shirt["525"] = "sponsor_SpyHelmet";
_partFrameLabels.shirt["526"] = "pHammerShark";
_partFrameLabels.shirt["527"] = "steamZach";
_partFrameLabels.shirt["528"] = "steamWorker1";
_partFrameLabels.shirt["529"] = "steamMayor";
_partFrameLabels.shirt["530"] = "steamCaptain";
_partFrameLabels.shirt["531"] = "steamSully";
_partFrameLabels.shirt["532"] = "steamPilot";
_partFrameLabels.shirt["533"] = "pGamerGirl_invader";
_partFrameLabels.shirt["534"] = "pGamerGirl_stick";
_partFrameLabels.shirt["535"] = "pGamerDude_invader";
_partFrameLabels.shirt["536"] = "pGamerDude_stick";
_partFrameLabels.shirt["537"] = "pNerdBoy";
_partFrameLabels.shirt["538"] = "pNerdGirl";
_partFrameLabels.shirt["539"] = "pVampire_boy";
_partFrameLabels.shirt["540"] = "pVampire_girl01";
_partFrameLabels.shirt["541"] = "pVampire_girl02";
_partFrameLabels.shirt["542"] = "pVampire_girl03";
_partFrameLabels.shirt["543"] = "sponsorTinkBobble";
_partFrameLabels.shirt["544"] = "sponsorFarmGirl";
_partFrameLabels.shirt["545"] = "sponsorFarmKid";
_partFrameLabels.shirt["546"] = "sponsorFarmBoy";
_partFrameLabels.shirt["547"] = "sponsorCityBoy";
_partFrameLabels.shirt["548"] = "sponsorCityGirl";
_partFrameLabels.shirt["549"] = "sponsorFarmMom";
_partFrameLabels.shirt["550"] = "sponsorNannyMcPhee";
_partFrameLabels.shirt["551"] = "pMotionShirt";
_partFrameLabels.shirt["552"] = "sponsorAlphaOmega";
_partFrameLabels.shirt["553"] = "sponsorAO_Omega";
_partFrameLabels.shirt["554"] = "sponsorAO_Alpha";
_partFrameLabels.shirt["555"] = "sponsor_POK-King";
_partFrameLabels.shirt["556"] = "sponsor_POK-Mason";
_partFrameLabels.shirt["557"] = "sponsor_POK-Tarantula";
_partFrameLabels.shirt["558"] = "sponsor_Fish_Hooks";
_partFrameLabels.shirt["559"] = "sponsor_KK_Bully01";
_partFrameLabels.shirt["560"] = "sponsor_MrHan";
_partFrameLabels.shirt["561"] = "sponsor_KarateKid";
_partFrameLabels.shirt["562"] = "Birthday_3";
_partFrameLabels.shirt["563"] = "TowerPrep_boy";
_partFrameLabels.shirt["564"] = "TowerPrep_Girl";
_partFrameLabels.shirt["565"] = "sponsor_BarbiePirate";
_partFrameLabels.shirt["566"] = "sponsor_BarbieVampire";
_partFrameLabels.shirt["567"] = "sponsor_BarbieWizard";
_partFrameLabels.shirt["568"] = "sponsor_BarbieBee";
_partFrameLabels.shirt["569"] = "sponsor_BarbieB";
_partFrameLabels.shirt["570"] = "sponsor_BarbieCat";
_partFrameLabels.shirt["571"] = "sponsorBarbieGGdog1";
_partFrameLabels.shirt["572"] = "sponsorBarbieGGdog2";
_partFrameLabels.shirt["573"] = "sponsorBarbieGGdog3";
_partFrameLabels.shirt["574"] = "sponsorBarbieGGdog4";
_partFrameLabels.shirt["575"] = "sponsorBarbieGGgirl";
_partFrameLabels.shirt["576"] = "sponsorBarbieGGgirl2";
_partFrameLabels.shirt["577"] = "scottishMan";
_partFrameLabels.shirt["578"] = "rowBoatMan";
_partFrameLabels.shirt["579"] = "subGuide";
_partFrameLabels.shirt["580"] = "Nessie_tourist1";
_partFrameLabels.shirt["581"] = "Nessie_tourist2";
_partFrameLabels.shirt["582"] = "pinkTux";
_partFrameLabels.shirt["583"] = "barbiePinkShirt1";
_partFrameLabels.shirt["584"] = "pBigFoot";
_partFrameLabels.shirt["585"] = "Gulliver";
_partFrameLabels.shirt["586"] = "sponsorHNC_HoneyDefender";
_partFrameLabels.shirt["587"] = "haroldMews";
_partFrameLabels.shirt["588"] = "gretchen";
_partFrameLabels.shirt["589"] = "gardener";
_partFrameLabels.shirt["590"] = "balloonPilate01";
_partFrameLabels.shirt["591"] = "balloonPilot02";
_partFrameLabels.shirt["592"] = "gliderGirl";
_partFrameLabels.shirt["593"] = "MaintenanceMan";
_partFrameLabels.shirt["594"] = "snootyLady";
_partFrameLabels.shirt["595"] = "butler";
_partFrameLabels.shirt["596"] = "HunterGiveUp";
_partFrameLabels.shirt["597"] = "barPatron1";
_partFrameLabels.shirt["598"] = "surlyDartMan";
_partFrameLabels.shirt["599"] = "barPatron2";
_partFrameLabels.shirt["600"] = "bartenderPub";
_partFrameLabels.shirt["601"] = "farmerBoy";
_partFrameLabels.shirt["602"] = "PuertoRicoFarmer1";
_partFrameLabels.shirt["603"] = "PuertoRicanFarmersBrother";
_partFrameLabels.shirt["604"] = "PuertoRicoFarmer2";
_partFrameLabels.shirt["605"] = "oldSherpa";
_partFrameLabels.shirt["606"] = "youngSherpa";
_partFrameLabels.shirt["607"] = "monk";
_partFrameLabels.shirt["608"] = "NateG";
_partFrameLabels.shirt["609"] = "townie2";
_partFrameLabels.shirt["610"] = "townie3";
_partFrameLabels.shirt["611"] = "townie4";
_partFrameLabels.shirt["612"] = "fortuneHunter2";
_partFrameLabels.shirt["613"] = "fortuneHunter1";
_partFrameLabels.shirt["614"] = "wwSaloonGirl";
_partFrameLabels.shirt["615"] = "wwPrettyWoman";
_partFrameLabels.shirt["616"] = "pTangled_n_Lights";
_partFrameLabels.shirt["617"] = "pDisco_King";
_partFrameLabels.shirt["618"] = "pDisco_Queen";
_partFrameLabels.shirt["619"] = "sponsorRedRanger";
_partFrameLabels.shirt["620"] = "sponsorYellowRanger";
_partFrameLabels.shirt["621"] = "promoWWmemOnly";
_partFrameLabels.shirt["622"] = "sponsorGnomeo";
_partFrameLabels.shirt["623"] = "sponsorJuliet";
_partFrameLabels.shirt["624"] = "sponsorPinkRanger";
_partFrameLabels.shirt["625"] = "wwTrader";
_partFrameLabels.shirt["626"] = "wwMustachio";
_partFrameLabels.shirt["627"] = "wwMustachioB";
_partFrameLabels.shirt["628"] = "wwPonyExpress";
_partFrameLabels.shirt["629"] = "wwPonyExpressB";
_partFrameLabels.shirt["630"] = "wwRJEarl";
_partFrameLabels.shirt["631"] = "wwMarshal";
_partFrameLabels.shirt["632"] = "wwDeputy";
_partFrameLabels.shirt["633"] = "wwRuby";
_partFrameLabels.shirt["634"] = "wwGSEvil";
_partFrameLabels.shirt["635"] = "wwGambler";
_partFrameLabels.shirt["636"] = "wwAnnie";
_partFrameLabels.shirt["637"] = "wwPhoto";
_partFrameLabels.shirt["638"] = "wwBanker";
_partFrameLabels.shirt["639"] = "wwConductor";
_partFrameLabels.shirt["640"] = "wwCattledriver";
_partFrameLabels.shirt["641"] = "wwRancher";
_partFrameLabels.shirt["642"] = "wwBanditGirl";
_partFrameLabels.shirt["643"] = "wwProspector";
_partFrameLabels.shirt["644"] = "sponsor_Transformers_Op";
_partFrameLabels.shirt["645"] = "sponsor_Transformers_Meg";
_partFrameLabels.shirt["646"] = "wwIndianGirl";
_partFrameLabels.shirt["647"] = "wwMan";
_partFrameLabels.shirt["648"] = "wwCowgirl";
_partFrameLabels.shirt["649"] = "wwGenericGuy";
_partFrameLabels.shirt["650"] = "wwAnnouncer";
_partFrameLabels.shirt["651"] = "wwCasinoPatron2";
_partFrameLabels.shirt["652"] = "wwBeardLady";
_partFrameLabels.shirt["653"] = "wwYoungGun";
_partFrameLabels.shirt["654"] = "wwGenericLady";
_partFrameLabels.shirt["655"] = "wwSlouch01";
_partFrameLabels.shirt["656"] = "wwInvisible";
_partFrameLabels.shirt["657"] = "wwRough";
_partFrameLabels.shirt["658"] = "wwNoName";
_partFrameLabels.shirt["659"] = "RattleSnake";
_partFrameLabels.shirt["660"] = "sponsonrMarsNeedsMoms";
_partFrameLabels.shirt["661"] = "sponsorDOWK2";
_partFrameLabels.shirt["662"] = "paperGirl";
_partFrameLabels.shirt["663"] = "pOutlaw_boys";
_partFrameLabels.shirt["664"] = "pOutlaw_girls";
_partFrameLabels.shirt["665"] = "pLawman";
_partFrameLabels.shirt["666"] = "sponsorNoah";
_partFrameLabels.shirt["667"] = "sponsorChuck";
_partFrameLabels.shirt["668"] = "sponsorMH_swim1";
_partFrameLabels.shirt["669"] = "MTHyokozuna";
_partFrameLabels.shirt["670"] = "MTHbonsaiWoman";
_partFrameLabels.shirt["671"] = "MTHjack";
_partFrameLabels.shirt["672"] = "MTHannie";
_partFrameLabels.shirt["673"] = "MTHfisherman";
_partFrameLabels.shirt["674"] = "MTHshogunCasual";
_partFrameLabels.shirt["675"] = "MTHshogunArmor";
_partFrameLabels.shirt["676"] = "MTHbasho";
_partFrameLabels.shirt["677"] = "pNinja02";
_partFrameLabels.shirt["678"] = "MTHreferee";
_partFrameLabels.shirt["679"] = "MTHtownie01";
_partFrameLabels.shirt["680"] = "MTHtownie02";
_partFrameLabels.shirt["681"] = "MTHtownie03";
_partFrameLabels.shirt["682"] = "MTHtownie04";
_partFrameLabels.shirt["683"] = "pMTHsumo1";
_partFrameLabels.shirt["684"] = "pMTHsumo2";
_partFrameLabels.shirt["685"] = "pMTHsumo3";
_partFrameLabels.shirt["686"] = "pMTHsumo4";
_partFrameLabels.shirt["687"] = "MTHsamurai01";
_partFrameLabels.shirt["688"] = "MTHninjaBlue";
_partFrameLabels.shirt["689"] = "MTHninjaWhite";
_partFrameLabels.shirt["690"] = "MTHprisoner";
_partFrameLabels.shirt["691"] = "MTHdragonPuppeteer";
_partFrameLabels.shirt["692"] = "MTHkimono01";
_partFrameLabels.shirt["693"] = "MTHkimono02";
_partFrameLabels.shirt["694"] = "MTHkimono03";
_partFrameLabels.shirt["695"] = "MTHkimono04";
_partFrameLabels.shirt["696"] = "MTHkimono05";
_partFrameLabels.shirt["697"] = "MTHyokoAsst";
_partFrameLabels.shirt["698"] = "MTHyWoman";
_partFrameLabels.shirt["699"] = "MTHbookie";
_partFrameLabels.shirt["700"] = "MTHartist";
_partFrameLabels.shirt["701"] = "MTHforeman";
_partFrameLabels.shirt["702"] = "sponsorGoldfishBunniesShirt";
_partFrameLabels.shirt["703"] = "MTHgardener01";
_partFrameLabels.shirt["704"] = "MTHgardener02";
_partFrameLabels.shirt["705"] = "MTHgardener03";
_partFrameLabels.shirt["706"] = "MTHgardener04";
_partFrameLabels.shirt["707"] = "MTHfanDancer";
_partFrameLabels.shirt["708"] = "sponsor_LooneyTunesShow";
_partFrameLabels.shirt["709"] = "sponsorLemonadeMouth";
_partFrameLabels.shirt["710"] = "sponsorLM_Olivia";
_partFrameLabels.shirt["711"] = "sponsor_LM_Mo";
_partFrameLabels.shirt["712"] = "sponsorLM_Stella";
_partFrameLabels.shirt["713"] = "MTHfemWar";
_partFrameLabels.shirt["714"] = "sponsor_KickinIt";
_partFrameLabels.shirt["715"] = "sponsor_GnomeoBluRayBlue";
_partFrameLabels.shirt["716"] = "sponsor_GnomeoBluRayRed";
_partFrameLabels.shirt["717"] = "sponsor_GnomeoBluRayGreen";
_partFrameLabels.shirt["718"] = "sponsor_JudyMoody";
_partFrameLabels.shirt["719"] = "sponsorStink";
_partFrameLabels.shirt["720"] = "sponsorRingLeader";
_partFrameLabels.shirt["721"] = "TcamoGuy";
_partFrameLabels.shirt["722"] = "TiceSH";
_partFrameLabels.shirt["723"] = "TpirateBlue";
_partFrameLabels.shirt["724"] = "TshrkSfr";
_partFrameLabels.shirt["725"] = "TrockStar";
_partFrameLabels.shirt["726"] = "SRcj";
_partFrameLabels.shirt["727"] = "SRdad";
_partFrameLabels.shirt["728"] = "SRshady";
_partFrameLabels.shirt["729"] = "TboogaShaman";
_partFrameLabels.shirt["730"] = "sponsor_wmpy2Logo";
_partFrameLabels.shirt["731"] = "sponsorWimpy2Diper";
_partFrameLabels.shirt["732"] = "SRsilva";
_partFrameLabels.shirt["733"] = "SRgirl";
_partFrameLabels.shirt["734"] = "sponsorBeachBall";
_partFrameLabels.shirt["735"] = "sponsorSmurfs";
_partFrameLabels.shirt["736"] = "sponsorSmurfsBlueshirt";
_partFrameLabels.shirt["737"] = "Tcumulos";
_partFrameLabels.shirt["738"] = "Sponsor_AdventureTime_FinnShirt";
_partFrameLabels.shirt["739"] = "Tninja01";
_partFrameLabels.shirt["740"] = "Tsamurai";
_partFrameLabels.shirt["741"] = "mtHoundini";
_partFrameLabels.shirt["742"] = "mtTwain";
_partFrameLabels.shirt["743"] = "mtEdison";
_partFrameLabels.shirt["744"] = "mtCleveland";
_partFrameLabels.shirt["745"] = "mtSusanB";
_partFrameLabels.shirt["746"] = "mtPorter";
_partFrameLabels.shirt["747"] = "mtPinkertonThug";
_partFrameLabels.shirt["748"] = "MTtesla";
_partFrameLabels.shirt["749"] = "MTferris";
_partFrameLabels.shirt["750"] = "MTeiffel";
_partFrameLabels.shirt["751"] = "MTnyReporter";
_partFrameLabels.shirt["752"] = "MTfReporter";
_partFrameLabels.shirt["753"] = "MTtownie01";
_partFrameLabels.shirt["754"] = "MTtownie02";
_partFrameLabels.shirt["755"] = "MTtownie03";
_partFrameLabels.shirt["756"] = "Mtrich01";
_partFrameLabels.shirt["757"] = "MTrich02";
_partFrameLabels.shirt["758"] = "Mtrich03";
_partFrameLabels.shirt["759"] = "mtCookSlowShirt";
_partFrameLabels.shirt["760"] = "mtCookFastShirt";
_partFrameLabels.shirt["761"] = "mtHostess";
_partFrameLabels.shirt["762"] = "mtDancer";
_partFrameLabels.shirt["763"] = "mtPoliceman";
_partFrameLabels.shirt["764"] = "mtFeeder";
_partFrameLabels.shirt["765"] = "mtJuggler";
_partFrameLabels.shirt["766"] = "TrockKnight";
_partFrameLabels.shirt["767"] = "TdreadRocker";
_partFrameLabels.shirt["768"] = "pSherlock";
_partFrameLabels.shirt["769"] = "sponsorHasbroFGN";
_partFrameLabels.shirt["770"] = "sponsorHasbroFGN2";
_partFrameLabels.shirt["771"] = "sponsorAuntOpal";
_partFrameLabels.shirt["772"] = "sponsor_carnivalSuit";
_partFrameLabels.shirt["773"] = "sponsor_JudyShirt";
_partFrameLabels.shirt["774"] = "sponsorZookeeperGorilla";
_partFrameLabels.shirt["775"] = "sponsorZookeeper";
_partFrameLabels.shirt["776"] = "sponsor_JEttux";
_partFrameLabels.shirt["777"] = "sponsor_M17";
_partFrameLabels.shirt["778"] = "sponsor_tucker";
_partFrameLabels.shirt["779"] = "GSfactoryWorker";
_partFrameLabels.shirt["780"] = "GSdiaper";
_partFrameLabels.shirt["781"] = "sponsorPussNBoots_shirt";
_partFrameLabels.shirt["782"] = "ZombieBoy";
_partFrameLabels.shirt["783"] = "ZombieGirl";
_partFrameLabels.shirt["784"] = "sponsor_CabinFever";
_partFrameLabels.shirt["785"] = "GSrobotPromo";
_partFrameLabels.shirt["786"] = "EVile";
_partFrameLabels.shirt["787"] = "sponsorChipWrecked_shirt";
_partFrameLabels.shirt["788"] = "sponsorChipWrecked_pSailing";
_partFrameLabels.shirt["789"] = "sponsorChipWrecked_tAlvin";
_partFrameLabels.shirt["790"] = "sponsorChipWrecked_tBritney";
_partFrameLabels.shirt["791"] = "sponsorChipWrecked_Alvin";
_partFrameLabels.shirt["792"] = "sponsorChipWrecked_Brit";
_partFrameLabels.shirt["793"] = "sponsorChipWrecked_Zoe";
_partFrameLabels.shirt["794"] = "sponsorBen10_Ben";
_partFrameLabels.shirt["795"] = "sponsorBen10_Rex";
_partFrameLabels.shirt["796"] = "sponsorBen10_agentSixSuit";
_partFrameLabels.shirt["797"] = "sponsorChipWrecked_Simon";
_partFrameLabels.shirt["798"] = "sponsorChipWrecked_Jeanette";
_partFrameLabels.shirt["799"] = "Gboater";
_partFrameLabels.shirt["800"] = "Gcloaked";
_partFrameLabels.shirt["801"] = "Gcrone";
_partFrameLabels.shirt["802"] = "Ginnk";
_partFrameLabels.shirt["803"] = "Ginnkw";
_partFrameLabels.shirt["804"] = "Glodger";
_partFrameLabels.shirt["805"] = "Gtent";
_partFrameLabels.shirt["806"] = "Gtour";
_partFrameLabels.shirt["807"] = "Glighthouse";
_partFrameLabels.shirt["808"] = "Gvaliant";
_partFrameLabels.shirt["809"] = "Gtinfoil";
_partFrameLabels.shirt["810"] = "Gbaker";
_partFrameLabels.shirt["811"] = "GpromoDaphne";
_partFrameLabels.shirt["812"] = "GpromoBrownLady";
_partFrameLabels.shirt["813"] = "GpromoHeadless";
_partFrameLabels.shirt["814"] = "GpromoHunter";
_partFrameLabels.shirt["815"] = "SRishmael";
_partFrameLabels.shirt["816"] = "SRflask";
_partFrameLabels.shirt["817"] = "SRstubb";
_partFrameLabels.shirt["818"] = "SRstarbuck";
_partFrameLabels.shirt["819"] = "SRrich";
_partFrameLabels.shirt["820"] = "sponsorTreasureBuddies";
_partFrameLabels.shirt["821"] = "sponsor_Arrietty_Pod";
_partFrameLabels.shirt["822"] = "sponsor_Arrietty";
_partFrameLabels.shirt["823"] = "sponsor_Arrietty_tshirt";
_partFrameLabels.shirt["824"] = "sponsorRedRangerSS";
_partFrameLabels.shirt["825"] = "sponsorBlueRanger";
_partFrameLabels.shirt["826"] = "sponsorGoldRanger";
_partFrameLabels.shirt["827"] = "sponsorRangersMooger";
_partFrameLabels.shirt["828"] = "sponsor_GoldfishActiveQuest2";
_partFrameLabels.shirt["829"] = "sponsor_Lorax_tshirt";
_partFrameLabels.shirt["830"] = "VCvillager1";
_partFrameLabels.shirt["831"] = "VCkatyasMom";
_partFrameLabels.shirt["832"] = "VCcashier";
_partFrameLabels.shirt["833"] = "VCkatya";
_partFrameLabels.shirt["834"] = "VCgothGirl";
_partFrameLabels.shirt["835"] = "VCvillage2";
_partFrameLabels.shirt["836"] = "VCchris";
_partFrameLabels.shirt["837"] = "VCvillager3";
_partFrameLabels.shirt["838"] = "VCgothBoy";
_partFrameLabels.shirt["839"] = "sponsor_Mooney";
_partFrameLabels.shirt["840"] = "sponsorMirrorMirror_blouse";
_partFrameLabels.shirt["841"] = "sponsorUltimateSpiderman_shirt";
_partFrameLabels.shirt["842"] = "p_countessVampire";
_partFrameLabels.shirt["843"] = "p_CountVampire";
_partFrameLabels.shirt["844"] = "TT_elf1";
_partFrameLabels.shirt["845"] = "TT_elfQueen";
_partFrameLabels.shirt["846"] = "TT_boy";
_partFrameLabels.shirt["847"] = "WLgoon";
_partFrameLabels.shirt["848"] = "pLumberjerk";
_partFrameLabels.shirt["849"] = "pLeprechaun";
_partFrameLabels.shirt["850"] = "sponsorThePirates_LizShirt";
_partFrameLabels.shirt["851"] = "sponsorThePirates_CapShirt";
_partFrameLabels.shirt["852"] = "sponsor_PollyP_ssuit1";
_partFrameLabels.shirt["853"] = "sponsor_PollyP_ssuit2";
_partFrameLabels.shirt["854"] = "sponsorPollyP_suit4";
_partFrameLabels.shirt["855"] = "sponsor_Lilly";
_partFrameLabels.shirt["856"] = "sponsor_Rick";
_partFrameLabels.shirt["857"] = "sponsor_PollyPocket";
_partFrameLabels.shirt["858"] = "sponsor_PollyP_Reward";
_partFrameLabels.shirt["859"] = "Sponsor_AdventureTime_FakeFinnShirt";
_partFrameLabels.pants["15"] = "greekWarrior";
_partFrameLabels.pants["16"] = "greekLady";
_partFrameLabels.pants["17"] = "aztecWarrior";
_partFrameLabels.pants["18"] = "aztecKing";
_partFrameLabels.pants["19"] = "aztecWoman";
_partFrameLabels.pants["20"] = "aztecQueen";
_partFrameLabels.pants["21"] = "aztecSlave";
_partFrameLabels.pants["22"] = "aztecWomanSlave";
_partFrameLabels.pants["23"] = "chineseWarrior";
_partFrameLabels.pants["24"] = "chineseWiseGuy";
_partFrameLabels.pants["25"] = "chineseArtist";
_partFrameLabels.pants["26"] = "chinesePeasant";
_partFrameLabels.pants["27"] = "leo";
_partFrameLabels.pants["28"] = "viking1";
_partFrameLabels.pants["29"] = "viking2";
_partFrameLabels.pants["30"] = "jefferson";
_partFrameLabels.pants["31"] = "franklin";
_partFrameLabels.pants["32"] = "adams";
_partFrameLabels.pants["33"] = "bartholdi";
_partFrameLabels.pants["34"] = "eiffel";
_partFrameLabels.pants["35"] = "frenchman";
_partFrameLabels.pants["36"] = "edison";
_partFrameLabels.pants["37"] = "van";
_partFrameLabels.pants["38"] = "explorer";
_partFrameLabels.pants["39"] = "skater";
_partFrameLabels.pants["40"] = "scuba";
_partFrameLabels.pants["41"] = "finVendor";
_partFrameLabels.pants["42"] = "fisherman";
_partFrameLabels.pants["43"] = "distressedMom";
_partFrameLabels.pants["44"] = "fact";
_partFrameLabels.pants["45"] = "lewis";
_partFrameLabels.pants["46"] = "sacagawea";
_partFrameLabels.pants["47"] = "batman";
_partFrameLabels.pants["48"] = "hillary";
_partFrameLabels.pants["49"] = "sherpa";
_partFrameLabels.pants["50"] = "tourist";
_partFrameLabels.pants["51"] = "leoassist";
_partFrameLabels.pants["52"] = "spanishcon";
_partFrameLabels.pants["53"] = "referee";
_partFrameLabels.pants["54"] = "gasDude";
_partFrameLabels.pants["55"] = "dinerWaitress";
_partFrameLabels.pants["56"] = "bare";
_partFrameLabels.pants["57"] = "policeman";
_partFrameLabels.pants["58"] = "nerd";
_partFrameLabels.pants["59"] = "tailor";
_partFrameLabels.pants["60"] = "hero1";
_partFrameLabels.pants["61"] = "hero2";
_partFrameLabels.pants["62"] = "hero3";
_partFrameLabels.pants["63"] = "hero4";
_partFrameLabels.pants["64"] = "hero5";
_partFrameLabels.pants["65"] = "hero6";
_partFrameLabels.pants["66"] = "badAgent";
_partFrameLabels.pants["67"] = "camoPants";
_partFrameLabels.pants["68"] = "directorD";
_partFrameLabels.pants["69"] = "SS";
_partFrameLabels.pants["70"] = "Sears1";
_partFrameLabels.pants["71"] = "Sears2";
_partFrameLabels.pants["72"] = "Sears3";
_partFrameLabels.pants["73"] = "Sears4";
_partFrameLabels.pants["74"] = "Sears5";
_partFrameLabels.pants["75"] = "Sears6";
_partFrameLabels.pants["76"] = "Nim1";
_partFrameLabels.pants["77"] = "Nim2";
_partFrameLabels.pants["78"] = "sponsorLego";
_partFrameLabels.pants["79"] = "legoHenchman";
_partFrameLabels.pants["80"] = "swaziGuy1";
_partFrameLabels.pants["81"] = "zuluGuy1";
_partFrameLabels.pants["82"] = "swaziGuy2";
_partFrameLabels.pants["83"] = "africanGuy1";
_partFrameLabels.pants["84"] = "africanLady1";
_partFrameLabels.pants["85"] = "africanLady2";
_partFrameLabels.pants["86"] = "africanLady3";
_partFrameLabels.pants["87"] = "egyptArch";
_partFrameLabels.pants["88"] = "oldPilot";
_partFrameLabels.pants["89"] = "miner1";
_partFrameLabels.pants["90"] = "miner2";
_partFrameLabels.pants["91"] = "sponsorCTCgirl";
_partFrameLabels.pants["92"] = "sponsorCTCguy";
_partFrameLabels.pants["93"] = "sponsorWalmartElfM";
_partFrameLabels.pants["94"] = "sponsorWalmartElfF";
_partFrameLabels.pants["95"] = "sponsorWallE";
_partFrameLabels.pants["96"] = "pinkSkirt";
_partFrameLabels.pants["97"] = "hippie";
_partFrameLabels.pants["98"] = "basketball";
_partFrameLabels.pants["99"] = "lawyer";
_partFrameLabels.pants["100"] = "chef";
_partFrameLabels.pants["101"] = "baseball";
_partFrameLabels.pants["102"] = "hipHop";
_partFrameLabels.pants["103"] = "snootyGirl";
_partFrameLabels.pants["104"] = "soccer";
_partFrameLabels.pants["105"] = "hiker";
_partFrameLabels.pants["106"] = "musicLoverG";
_partFrameLabels.pants["107"] = "biker";
_partFrameLabels.pants["108"] = "cowGirl";
_partFrameLabels.pants["109"] = "grandpa";
_partFrameLabels.pants["110"] = "gothGirl";
_partFrameLabels.pants["111"] = "yogosBucks";
_partFrameLabels.pants["112"] = "pKnight1";
_partFrameLabels.pants["113"] = "pGeisha1";
_partFrameLabels.pants["114"] = "pGeisha2";
_partFrameLabels.pants["115"] = "pGeisha3";
_partFrameLabels.pants["116"] = "pBall1";
_partFrameLabels.pants["117"] = "pBall2";
_partFrameLabels.pants["118"] = "pBall3";
_partFrameLabels.pants["119"] = "pRiding1";
_partFrameLabels.pants["120"] = "pRiding2";
_partFrameLabels.pants["121"] = "pRiding3";
_partFrameLabels.pants["122"] = "girlSkirt1";
_partFrameLabels.pants["123"] = "girlSkirt2";
_partFrameLabels.pants["124"] = "girlSkirt3";
_partFrameLabels.pants["125"] = "girlSkirt4";
_partFrameLabels.pants["126"] = "girlSkirt5";
_partFrameLabels.pants["127"] = "pPharaoh";
_partFrameLabels.pants["128"] = "pEgyptQ";
_partFrameLabels.pants["129"] = "pZorro";
_partFrameLabels.pants["130"] = "pSamurai";
_partFrameLabels.pants["131"] = "pRockerGuy1";
_partFrameLabels.pants["132"] = "pRockerGirl1";
_partFrameLabels.pants["133"] = "pPopGirl1";
_partFrameLabels.pants["134"] = "pPopGirl2";
_partFrameLabels.pants["135"] = "pPopGirl3";
_partFrameLabels.pants["136"] = "pNinja";
_partFrameLabels.pants["137"] = "pRobinhood1";
_partFrameLabels.pants["138"] = "pFairy1";
_partFrameLabels.pants["139"] = "pFairy2";
_partFrameLabels.pants["140"] = "pFairy3";
_partFrameLabels.pants["141"] = "sponsorPinoFairy";
_partFrameLabels.pants["142"] = "cyberJester";
_partFrameLabels.pants["143"] = "astroServant2";
_partFrameLabels.pants["144"] = "astroChance";
_partFrameLabels.pants["145"] = "redKnight";
_partFrameLabels.pants["146"] = "greenKnight";
_partFrameLabels.pants["147"] = "astroGuard1";
_partFrameLabels.pants["148"] = "astroMonk";
_partFrameLabels.pants["149"] = "astroCult";
_partFrameLabels.pants["150"] = "astroPrincess";
_partFrameLabels.pants["151"] = "astroEvilPrincess";
_partFrameLabels.pants["152"] = "astroServant1";
_partFrameLabels.pants["153"] = "astroQueen";
_partFrameLabels.pants["154"] = "astroRoyal1";
_partFrameLabels.pants["155"] = "astroKing";
_partFrameLabels.pants["156"] = "astroVill1";
_partFrameLabels.pants["157"] = "astroManure";
_partFrameLabels.pants["158"] = "astroVill2";
_partFrameLabels.pants["159"] = "astroGuard2";
_partFrameLabels.pants["160"] = "astroFarmer";
_partFrameLabels.pants["161"] = "sponsorFLoct";
_partFrameLabels.pants["162"] = "sponsorFLoct2";
_partFrameLabels.pants["163"] = "astroVill3";
_partFrameLabels.pants["164"] = "astroPes2";
_partFrameLabels.pants["165"] = "astrocurrator";
_partFrameLabels.pants["166"] = "astroGossip1";
_partFrameLabels.pants["167"] = "astroGossip2";
_partFrameLabels.pants["168"] = "astroGossip3";
_partFrameLabels.pants["169"] = "astroGossip5";
_partFrameLabels.pants["170"] = "astroAlien1";
_partFrameLabels.pants["171"] = "astroAlien2";
_partFrameLabels.pants["172"] = "astroAlien3";
_partFrameLabels.pants["173"] = "astroAlien4";
_partFrameLabels.pants["174"] = "astroZone";
_partFrameLabels.pants["175"] = "pSingerGuy1";
_partFrameLabels.pants["176"] = "pSingerGuy2";
_partFrameLabels.pants["177"] = "pSingerGuy3";
_partFrameLabels.pants["178"] = "pPirateGuy1";
_partFrameLabels.pants["179"] = "pPirateGirl1";
_partFrameLabels.pants["180"] = "pBaseballGirl1";
_partFrameLabels.pants["181"] = "pBaseballGirl2";
_partFrameLabels.pants["182"] = "pBaseballGirl3";
_partFrameLabels.pants["183"] = "pBaseballGuy1";
_partFrameLabels.pants["184"] = "pBaseballGuy2";
_partFrameLabels.pants["185"] = "pBaseballGuy3";
_partFrameLabels.pants["186"] = "pCowboy1";
_partFrameLabels.pants["187"] = "pRobot2";
_partFrameLabels.pants["188"] = "pRobot3";
_partFrameLabels.pants["189"] = "pRobot4_1";
_partFrameLabels.pants["190"] = "pRobot4_2";
_partFrameLabels.pants["191"] = "pRobot4_3";
_partFrameLabels.pants["192"] = "pRobot5";
_partFrameLabels.pants["193"] = "pKarateBoy1";
_partFrameLabels.pants["194"] = "pKarateBoy2";
_partFrameLabels.pants["195"] = "pKarateBoy3";
_partFrameLabels.pants["196"] = "pKarateGirl1";
_partFrameLabels.pants["197"] = "pKarateGirl2";
_partFrameLabels.pants["198"] = "pKarateGirl3";
_partFrameLabels.pants["199"] = "pCheerleader1";
_partFrameLabels.pants["200"] = "pCheerleader2";
_partFrameLabels.pants["201"] = "pCheerleader3";
_partFrameLabels.pants["202"] = "pCheerleaderGoth";
_partFrameLabels.pants["203"] = "sponsorWM1";
_partFrameLabels.pants["204"] = "sponsorWM2";
_partFrameLabels.pants["205"] = "pAstronaut1";
_partFrameLabels.pants["206"] = "sponsorCWMB1";
_partFrameLabels.pants["207"] = "sponsorCWMB2";
_partFrameLabels.pants["208"] = "pClown1";
_partFrameLabels.pants["209"] = "pFirefighter1";
_partFrameLabels.pants["210"] = "pNinjaLE";
_partFrameLabels.pants["211"] = "pSheDevil";
_partFrameLabels.pants["212"] = "pDevil1";
_partFrameLabels.pants["213"] = "pAngel";
_partFrameLabels.pants["214"] = "pPopGirlLE";
_partFrameLabels.pants["215"] = "sponsorLegoBio";
_partFrameLabels.pants["216"] = "pBiker1";
_partFrameLabels.pants["217"] = "pDareD1";
_partFrameLabels.pants["218"] = "pumpkin";
_partFrameLabels.pants["219"] = "grimReaper";
_partFrameLabels.pants["220"] = "frankenstein";
_partFrameLabels.pants["221"] = "frankBride";
_partFrameLabels.pants["222"] = "sponsorAstro1";
_partFrameLabels.pants["223"] = "sponsorAstro2";
_partFrameLabels.pants["224"] = "hyde";
_partFrameLabels.pants["225"] = "sponsorTinkerbell";
_partFrameLabels.pants["226"] = "sponsorTinkerbell4";
_partFrameLabels.pants["227"] = "sponsorFuel1";
_partFrameLabels.pants["228"] = "sponsorFuel2";
_partFrameLabels.pants["229"] = "vampire2";
_partFrameLabels.pants["230"] = "vampire";
_partFrameLabels.pants["231"] = "sponsorIceAge";
_partFrameLabels.pants["232"] = "sponsorEC1";
_partFrameLabels.pants["233"] = "sponsorEC2";
_partFrameLabels.pants["234"] = "pWolf1";
_partFrameLabels.pants["235"] = "pWolf2";
_partFrameLabels.pants["236"] = "pMunster";
_partFrameLabels.pants["237"] = "sponsorSBsanta4";
_partFrameLabels.pants["238"] = "sponsorPFxmas";
_partFrameLabels.pants["239"] = "sponsorNM2guard";
_partFrameLabels.pants["240"] = "shadyCop";
_partFrameLabels.pants["241"] = "curator";
_partFrameLabels.pants["242"] = "tourGuide";
_partFrameLabels.pants["243"] = "chef2";
_partFrameLabels.pants["244"] = "conWorker1";
_partFrameLabels.pants["245"] = "curator2";
_partFrameLabels.pants["246"] = "securityGuard1";
_partFrameLabels.pants["247"] = "patron1";
_partFrameLabels.pants["248"] = "counterRes1";
_partFrameLabels.pants["249"] = "pBallerina1";
_partFrameLabels.pants["250"] = "pBallerina2";
_partFrameLabels.pants["251"] = "pBallerina3";
_partFrameLabels.pants["252"] = "frenchPol1";
_partFrameLabels.pants["253"] = "sponsorSpyNext";
_partFrameLabels.pants["254"] = "sponsorCBee";
_partFrameLabels.pants["255"] = "pantsEarly";
_partFrameLabels.pants["256"] = "pantsShark";
_partFrameLabels.pants["257"] = "pantsTime";
_partFrameLabels.pants["258"] = "pantsCarrot";
_partFrameLabels.pants["259"] = "pantsSuper";
_partFrameLabels.pants["260"] = "pantsSpy";
_partFrameLabels.pants["261"] = "pantsNabooti";
_partFrameLabels.pants["262"] = "pantsNate";
_partFrameLabels.pants["263"] = "pantsAstro";
_partFrameLabels.pants["264"] = "pantsCounter";
_partFrameLabels.pants["265"] = "pantsTV";
_partFrameLabels.pants["266"] = "buckyLucas";
_partFrameLabels.pants["267"] = "buckyFan";
_partFrameLabels.pants["268"] = "realityTeen";
_partFrameLabels.pants["269"] = "sponsorWilson";
_partFrameLabels.pants["270"] = "sponsorDitch";
_partFrameLabels.pants["271"] = "sponsorFizzy";
_partFrameLabels.pants["272"] = "sponsorMonkeyBall";
_partFrameLabels.pants["273"] = "pFootball1";
_partFrameLabels.pants["274"] = "pFootball2";
_partFrameLabels.pants["275"] = "pFootball3";
_partFrameLabels.pants["276"] = "pFootball4";
_partFrameLabels.pants["277"] = "sponsorFLegypt1";
_partFrameLabels.pants["278"] = "triton";
_partFrameLabels.pants["279"] = "charon";
_partFrameLabels.pants["280"] = "hades";
_partFrameLabels.pants["281"] = "medusa";
_partFrameLabels.pants["282"] = "poseidon";
_partFrameLabels.pants["283"] = "zeus";
_partFrameLabels.pants["284"] = "athena";
_partFrameLabels.pants["285"] = "aphrodite";
_partFrameLabels.pants["286"] = "dionysus";
_partFrameLabels.pants["287"] = "aeolus";
_partFrameLabels.pants["288"] = "mythPes1";
_partFrameLabels.pants["289"] = "mythPes4";
_partFrameLabels.pants["290"] = "mythPes5";
_partFrameLabels.pants["291"] = "mythPes6";
_partFrameLabels.pants["292"] = "mythPes7";
_partFrameLabels.pants["293"] = "mythTeen1";
_partFrameLabels.pants["294"] = "mythTeen2";
_partFrameLabels.pants["295"] = "mythBeach1";
_partFrameLabels.pants["296"] = "mythBeach2";
_partFrameLabels.pants["297"] = "satyr";
_partFrameLabels.pants["298"] = "sponsorBF5a";
_partFrameLabels.pants["299"] = "sponsorBF5b";
_partFrameLabels.pants["300"] = "sponsorBF5c";
_partFrameLabels.pants["301"] = "sponsorBF5d";
_partFrameLabels.pants["302"] = "sponsorBF5e";
_partFrameLabels.pants["303"] = "sponsorTSBRbuzz";
_partFrameLabels.pants["304"] = "sponsorTSBRjess";
_partFrameLabels.pants["305"] = "sponsorTSBRalien";
_partFrameLabels.pants["306"] = "pMagic1";
_partFrameLabels.pants["307"] = "pPunkGirl1";
_partFrameLabels.pants["308"] = "pPunkGirl2";
_partFrameLabels.pants["309"] = "pPunkGirl3";
_partFrameLabels.pants["310"] = "pPunkGirl4";
_partFrameLabels.pants["311"] = "pPunkGirl5";
_partFrameLabels.pants["312"] = "pDrHare_Hench";
_partFrameLabels.pants["313"] = "pEinstein";
_partFrameLabels.pants["314"] = "pEinstein2";
_partFrameLabels.pants["315"] = "pEarthKnight";
_partFrameLabels.pants["316"] = "pGirlKnight";
_partFrameLabels.pants["317"] = "pDarkKnight_boy";
_partFrameLabels.pants["318"] = "pDarkKnigt_girl";
_partFrameLabels.pants["319"] = "pFool";
_partFrameLabels.pants["320"] = "sponsorKoiFish";
_partFrameLabels.pants["321"] = "skullMainGuard1";
_partFrameLabels.pants["322"] = "skullOrleansGuard";
_partFrameLabels.pants["323"] = "skullMainGov";
_partFrameLabels.pants["324"] = "skullMainServant";
_partFrameLabels.pants["325"] = "skullMainMerch";
_partFrameLabels.pants["326"] = "skullMainOldMan";
_partFrameLabels.pants["327"] = "captCrawfish";
_partFrameLabels.pants["328"] = "skullPirate2";
_partFrameLabels.pants["329"] = "skullPirate8";
_partFrameLabels.pants["330"] = "skullSam";
_partFrameLabels.pants["331"] = "skullPirate3";
_partFrameLabels.pants["332"] = "skullPirate4";
_partFrameLabels.pants["333"] = "skullPirate5";
_partFrameLabels.pants["334"] = "skullPirate7";
_partFrameLabels.pants["335"] = "skullInk";
_partFrameLabels.pants["336"] = "skullNavigator";
_partFrameLabels.pants["337"] = "skullMainHayLady";
_partFrameLabels.pants["338"] = "skullMainFarmLady";
_partFrameLabels.pants["339"] = "skullMainOldLady";
_partFrameLabels.pants["340"] = "skullMainClerk";
_partFrameLabels.pants["341"] = "skullMainGirl";
_partFrameLabels.pants["342"] = "skullElegantLady";
_partFrameLabels.pants["343"] = "skullMoroLady1";
_partFrameLabels.pants["344"] = "skullMoroBank";
_partFrameLabels.pants["345"] = "skullMoroLady2";
_partFrameLabels.pants["346"] = "skullMoroLady3";
_partFrameLabels.pants["347"] = "skullMoroGuy1";
_partFrameLabels.pants["348"] = "skullMoroGuy2";
_partFrameLabels.pants["349"] = "skullMoroGuy3";
_partFrameLabels.pants["350"] = "skullChinaGuy1";
_partFrameLabels.pants["351"] = "skullChinaMerch";
_partFrameLabels.pants["352"] = "skullChinaShipSell";
_partFrameLabels.pants["353"] = "skullChinaWiseWoman";
_partFrameLabels.pants["354"] = "skullChinaGuy2";
_partFrameLabels.pants["355"] = "pSkullPirate1a";
_partFrameLabels.pants["356"] = "pSkullPirate1b";
_partFrameLabels.pants["357"] = "pSkullPirate1c";
_partFrameLabels.pants["358"] = "pSkullPirate1d";
_partFrameLabels.pants["359"] = "sponsorMH_skirt1";
_partFrameLabels.pants["360"] = "sponsorMH_skirt2";
_partFrameLabels.pants["361"] = "sponsorMH_skirt3";
_partFrameLabels.pants["362"] = "sponsorMH_skirt4";
_partFrameLabels.pants["363"] = "sponsorMH_skirt5";
_partFrameLabels.pants["364"] = "sponsorMH_skirt6";
_partFrameLabels.pants["365"] = "pDaisy";
_partFrameLabels.pants["366"] = "pPromKing1a";
_partFrameLabels.pants["367"] = "pPromKing1b";
_partFrameLabels.pants["368"] = "pPromKing1c";
_partFrameLabels.pants["369"] = "pPromKing1d";
_partFrameLabels.pants["370"] = "pPromQueen1a";
_partFrameLabels.pants["371"] = "pPromQueen1b";
_partFrameLabels.pants["372"] = "pPromQueen1c";
_partFrameLabels.pants["373"] = "pPromQueen1d";
_partFrameLabels.pants["374"] = "pPromQueen1e";
_partFrameLabels.pants["375"] = "sponsorMinion";
_partFrameLabels.pants["376"] = "sponsorAgnes";
_partFrameLabels.pants["377"] = "sponsorEdith";
_partFrameLabels.pants["378"] = "sponsorMargo";
_partFrameLabels.pants["379"] = "pMythSurferZeus";
_partFrameLabels.pants["380"] = "pMythSurferHades";
_partFrameLabels.pants["381"] = "pMythSurferPose";
_partFrameLabels.pants["382"] = "pSoccer1a";
_partFrameLabels.pants["383"] = "pSoccer1b";
_partFrameLabels.pants["384"] = "pSoccer1c";
_partFrameLabels.pants["385"] = "pSoccer1d";
_partFrameLabels.pants["386"] = "steamCaptain";
_partFrameLabels.pants["387"] = "steamMayor";
_partFrameLabels.pants["388"] = "sponsor_Ramona";
_partFrameLabels.pants["389"] = "pNerdBoy";
_partFrameLabels.pants["390"] = "pNerdGirl";
_partFrameLabels.pants["391"] = "pVampire_boy";
_partFrameLabels.pants["392"] = "sponsorTinkBobble";
_partFrameLabels.pants["393"] = "pVampire_girl01";
_partFrameLabels.pants["394"] = "sponsor_SpyHelmet";
_partFrameLabels.pants["395"] = "sponsor_SelenaG";
_partFrameLabels.pants["396"] = "pVampire_Girl02";
_partFrameLabels.pants["397"] = "sponsorFarmGirl";
_partFrameLabels.pants["398"] = "sponsorFarmKid";
_partFrameLabels.pants["399"] = "sponsorFarmerBoy";
_partFrameLabels.pants["400"] = "sponsorCityGirl";
_partFrameLabels.pants["401"] = "sponsorCityBoy";
_partFrameLabels.pants["402"] = "sponsorFarmMom";
_partFrameLabels.pants["403"] = "sponsorNannyMcPhee";
_partFrameLabels.pants["404"] = "sponsor_MayanWarrior";
_partFrameLabels.pants["405"] = "sponsor_POK-King";
_partFrameLabels.pants["406"] = "sponsor_POK-Mason";
_partFrameLabels.pants["407"] = "sponsor_POK-Tarantula";
_partFrameLabels.pants["408"] = "sponsor_KK_Bully01";
_partFrameLabels.pants["409"] = "sponsor_MrHan";
_partFrameLabels.pants["410"] = "sponsor_KarateKid";
_partFrameLabels.pants["411"] = "Birthday_3";
_partFrameLabels.pants["412"] = "TowerPrep_Boys";
_partFrameLabels.pants["413"] = "TowerPrep_Girls";
_partFrameLabels.pants["414"] = "sponsor_BarbiePirate";
_partFrameLabels.pants["415"] = "sponsor_BarbieVampire";
_partFrameLabels.pants["416"] = "sponsor_BarbieWizard";
_partFrameLabels.pants["417"] = "sponsor_BarbieBee";
_partFrameLabels.pants["418"] = "sponsor_BarbieB";
_partFrameLabels.pants["419"] = "pFM_pants";
_partFrameLabels.pants["420"] = "sponsorBarbieGGgirl";
_partFrameLabels.pants["421"] = "scottishMan";
_partFrameLabels.pants["422"] = "rowBoatMan";
_partFrameLabels.pants["423"] = "pinkTux";
_partFrameLabels.pants["424"] = "gulliver";
_partFrameLabels.pants["425"] = "haroldMews";
_partFrameLabels.pants["426"] = "gardener";
_partFrameLabels.pants["427"] = "balloonpilate01";
_partFrameLabels.pants["428"] = "balloonPilot02";
_partFrameLabels.pants["429"] = "gliderGirl";
_partFrameLabels.pants["430"] = "MaintenanceMan";
_partFrameLabels.pants["431"] = "butler";
_partFrameLabels.pants["432"] = "HunterGiveUp";
_partFrameLabels.pants["433"] = "farmerBoy";
_partFrameLabels.pants["434"] = "oldSherpa";
_partFrameLabels.pants["435"] = "monk";
_partFrameLabels.pants["436"] = "wwSaloonGirl";
_partFrameLabels.pants["437"] = "wwPrettyWoman";
_partFrameLabels.pants["438"] = "pTangled_n_Lights";
_partFrameLabels.pants["439"] = "sponsorOS3";
_partFrameLabels.pants["440"] = "sponsorOS3_Ursa";
_partFrameLabels.pants["441"] = "pDisco_King";
_partFrameLabels.pants["442"] = "sponsorYellowRanger";
_partFrameLabels.pants["443"] = "promoWWmemOnly";
_partFrameLabels.pants["444"] = "sponsorGnomeo";
_partFrameLabels.pants["445"] = "sponsorJuliet";
_partFrameLabels.pants["446"] = "sponsorPinkRanger";
_partFrameLabels.pants["447"] = "wwTrader";
_partFrameLabels.pants["448"] = "wwMustachio";
_partFrameLabels.pants["449"] = "wwMustachioB";
_partFrameLabels.pants["450"] = "wwPonyExpress";
_partFrameLabels.pants["451"] = "wwPonyExpressB";
_partFrameLabels.pants["452"] = "wwRJEarl";
_partFrameLabels.pants["453"] = "wwMarshal";
_partFrameLabels.pants["454"] = "wwRuby";
_partFrameLabels.pants["455"] = "wwGSEvil";
_partFrameLabels.pants["456"] = "wwGambler";
_partFrameLabels.pants["457"] = "wwPhoto";
_partFrameLabels.pants["458"] = "wwBanker";
_partFrameLabels.pants["459"] = "wwDeputy";
_partFrameLabels.pants["460"] = "wwConductor";
_partFrameLabels.pants["461"] = "wwWorker";
_partFrameLabels.pants["462"] = "wwBanditGirl";
_partFrameLabels.pants["463"] = "wwGenericGuy";
_partFrameLabels.pants["464"] = "wwAnnouncer";
_partFrameLabels.pants["465"] = "wwProspector";
_partFrameLabels.pants["466"] = "wwAnnie";
_partFrameLabels.pants["467"] = "wwCasinoPatron2";
_partFrameLabels.pants["468"] = "wwBeardLady";
_partFrameLabels.pants["469"] = "wwGenericLady";
_partFrameLabels.pants["470"] = "wwIndianGirl";
_partFrameLabels.pants["471"] = "sponsorMarsNeedsMoms";
_partFrameLabels.pants["472"] = "paperGirl";
_partFrameLabels.pants["473"] = "sponsorMH_swim1";
_partFrameLabels.pants["474"] = "MTHscaredSumo";
_partFrameLabels.pants["475"] = "MTHbonsaiWoman";
_partFrameLabels.pants["476"] = "MTHfisherman";
_partFrameLabels.pants["477"] = "MTHshogunCasual";
_partFrameLabels.pants["478"] = "MTHshogunArmor";
_partFrameLabels.pants["479"] = "MTHbasho";
_partFrameLabels.pants["480"] = "pNinja02";
_partFrameLabels.pants["481"] = "MTHreferee";
_partFrameLabels.pants["482"] = "MTHtownie01";
_partFrameLabels.pants["483"] = "MTHtownie02";
_partFrameLabels.pants["484"] = "MTHtownie03";
_partFrameLabels.pants["485"] = "MTHtownie04";
_partFrameLabels.pants["486"] = "pMTHsumo1";
_partFrameLabels.pants["487"] = "pMTHsumo2";
_partFrameLabels.pants["488"] = "pMTHsumo3";
_partFrameLabels.pants["489"] = "pMTHsumo4";
_partFrameLabels.pants["490"] = "MTHsamurai01";
_partFrameLabels.pants["491"] = "MTHninjaBlue";
_partFrameLabels.pants["492"] = "MTHninjaWhite";
_partFrameLabels.pants["493"] = "MTHprisoner";
_partFrameLabels.pants["494"] = "MTHdraonPuppeteer";
_partFrameLabels.pants["495"] = "MTHkimono01";
_partFrameLabels.pants["496"] = "MTHkimono02";
_partFrameLabels.pants["497"] = "MTHkimono03";
_partFrameLabels.pants["498"] = "MTHkimono04";
_partFrameLabels.pants["499"] = "MTHkimono05";
_partFrameLabels.pants["500"] = "MTHyokoAsst";
_partFrameLabels.pants["501"] = "MTHyWoman";
_partFrameLabels.pants["502"] = "MTHbookie";
_partFrameLabels.pants["503"] = "MTHartist";
_partFrameLabels.pants["504"] = "MTHgardener02";
_partFrameLabels.pants["505"] = "MTHgardener04";
_partFrameLabels.pants["506"] = "MTHfanDancer";
_partFrameLabels.pants["507"] = "MTHfemWar";
_partFrameLabels.pants["508"] = "sponsor_KickinItPants";
_partFrameLabels.pants["509"] = "sponsor_GnomeoBluRayPants";
_partFrameLabels.pants["510"] = "sponsor_GnomeoRedskirt";
_partFrameLabels.pants["511"] = "sponsor_GnomeoBlueSkirt";
_partFrameLabels.pants["512"] = "sponsor_GnomeoGreenSkirt";
_partFrameLabels.pants["513"] = "sponsorJudyMoody";
_partFrameLabels.pants["514"] = "sponserRignLeader";
_partFrameLabels.pants["515"] = "TcamoGuy";
_partFrameLabels.pants["516"] = "TiceSH";
_partFrameLabels.pants["517"] = "TpirateBlue";
_partFrameLabels.pants["518"] = "SRmom";
_partFrameLabels.pants["519"] = "SRneighbor02";
_partFrameLabels.pants["520"] = "TboogaShaman";
_partFrameLabels.pants["521"] = "sponsor_Smurfs";
_partFrameLabels.pants["522"] = "Tcumulos";
_partFrameLabels.pants["523"] = "Sponsor_AdventureTime_FinnPants";
_partFrameLabels.pants["524"] = "Tninja01";
_partFrameLabels.pants["525"] = "Tsamurai";
_partFrameLabels.pants["526"] = "mtHoudini";
_partFrameLabels.pants["527"] = "mtCleveland";
_partFrameLabels.pants["528"] = "mtTwain";
_partFrameLabels.pants["529"] = "mtEdison";
_partFrameLabels.pants["530"] = "mtSusanB";
_partFrameLabels.pants["531"] = "MTtesla";
_partFrameLabels.pants["532"] = "MTferris";
_partFrameLabels.pants["533"] = "MTeiffel";
_partFrameLabels.pants["534"] = "MTnyReporter";
_partFrameLabels.pants["535"] = "MtfReporter";
_partFrameLabels.pants["536"] = "MTtownie01";
_partFrameLabels.pants["537"] = "MTtownie02";
_partFrameLabels.pants["538"] = "MTtownie03";
_partFrameLabels.pants["539"] = "MTrich01";
_partFrameLabels.pants["540"] = "mtPoliceman";
_partFrameLabels.pants["541"] = "mtJuggler";
_partFrameLabels.pants["542"] = "Mtrich02";
_partFrameLabels.pants["543"] = "MTrich03";
_partFrameLabels.pants["544"] = "mtDancer";
_partFrameLabels.pants["545"] = "TrockKnight";
_partFrameLabels.pants["546"] = "TdreadRocker";
_partFrameLabels.pants["547"] = "pSherlock";
_partFrameLabels.pants["548"] = "sponsorAuntOpal";
_partFrameLabels.pants["549"] = "sponsor_carnivalSuit";
_partFrameLabels.pants["550"] = "GSrProf";
_partFrameLabels.pants["551"] = "GSrAthlet";
_partFrameLabels.pants["552"] = "GSrPopc";
_partFrameLabels.pants["553"] = "GSrHost";
_partFrameLabels.pants["554"] = "GSrAthlet02";
_partFrameLabels.pants["555"] = "GSfactoryWorker";
_partFrameLabels.pants["556"] = "GSrobotPromo";
_partFrameLabels.pants["557"] = "sponsor_m17";
_partFrameLabels.pants["558"] = "sponsorChipWrecked_tBritney";
_partFrameLabels.pants["559"] = "sponsorChipWrecked_Zoe";
_partFrameLabels.pants["560"] = "sponsorBen10_agentSixPants";
_partFrameLabels.pants["561"] = "sponsorChipWrecked_Jeanette";
_partFrameLabels.pants["562"] = "Gcloaked";
_partFrameLabels.pants["563"] = "Gcrone";
_partFrameLabels.pants["564"] = "Glodger";
_partFrameLabels.pants["565"] = "GpromoDaphne";
_partFrameLabels.pants["566"] = "GpromoHunter";
_partFrameLabels.pants["567"] = "GpromoBrownLady";
_partFrameLabels.pants["568"] = "sponsorTreasureBuddies";
_partFrameLabels.pants["569"] = "p_Elf_boy";
_partFrameLabels.pants["570"] = "p_elf_girl";
_partFrameLabels.pants["571"] = "SRhazmat";
_partFrameLabels.pants["572"] = "sponsor_Arrietty_Pod";
_partFrameLabels.pants["573"] = "VCvillager1";
_partFrameLabels.pants["574"] = "VCkatyasMom";
_partFrameLabels.pants["575"] = "VCcashier";
_partFrameLabels.pants["576"] = "VCkatya";
_partFrameLabels.pants["577"] = "VCgothGirl";
_partFrameLabels.pants["578"] = "sponsorMirrorMirror_skirt";
_partFrameLabels.pants["579"] = "sponsorUltimateSpiderman_Pants";
_partFrameLabels.pants["580"] = "vampireCountess";
_partFrameLabels.pants["581"] = "TT_elf1";
_partFrameLabels.pants["582"] = "TT_elfQueen";
_partFrameLabels.pants["583"] = "TT_mom";
_partFrameLabels.pants["584"] = "pLeprechaun";
_partFrameLabels.pants["585"] = "sponsorThePirates_LizPants";
_partFrameLabels.pants["586"] = "sponsorChipWreckedDVD_Alvin";
_partFrameLabels.pants["587"] = "sponsorKerstie";
_partFrameLabels.pants["588"] = "sponsor_Lilly";
_partFrameLabels.pants["589"] = "sponsor_Rick";
_partFrameLabels.pants["590"] = "sponsor_PollyP_Reward";
_partFrameLabels.pants["591"] = "Sponsor_AdventureTime_FakeFinnPants";
_partFrameLabels.overpants["2"] = "grass";
_partFrameLabels.overpants["3"] = "sponsorSpace";
_partFrameLabels.overpants["4"] = "viking2";
_partFrameLabels.overpants["5"] = "stains";
_partFrameLabels.overpants["6"] = "aztecWarrior";
_partFrameLabels.overpants["7"] = "aztecKing";
_partFrameLabels.overpants["8"] = "aztecWoman";
_partFrameLabels.overpants["9"] = "aztecQueen";
_partFrameLabels.overpants["10"] = "chineseWarrior";
_partFrameLabels.overpants["11"] = "chineseArtist";
_partFrameLabels.overpants["12"] = "chinesePeasant";
_partFrameLabels.overpants["13"] = "lewis";
_partFrameLabels.overpants["14"] = "clark";
_partFrameLabels.overpants["15"] = "york";
_partFrameLabels.overpants["16"] = "sacagawea";
_partFrameLabels.overpants["17"] = "scuba";
_partFrameLabels.overpants["18"] = "dinerWaitress";
_partFrameLabels.overpants["19"] = "drHare";
_partFrameLabels.overpants["20"] = "radioactive";
_partFrameLabels.overpants["21"] = "policeman";
_partFrameLabels.overpants["22"] = "uBelt1";
_partFrameLabels.overpants["23"] = "uBelt2";
_partFrameLabels.overpants["24"] = "uBelt3";
_partFrameLabels.overpants["25"] = "uBelt4";
_partFrameLabels.overpants["26"] = "uBelt5";
_partFrameLabels.overpants["27"] = "Nim1";
_partFrameLabels.overpants["28"] = "Nim2";
_partFrameLabels.overpants["29"] = "badAgent1";
_partFrameLabels.overpants["30"] = "badAgent2";
_partFrameLabels.overpants["31"] = "agentBelt";
_partFrameLabels.overpants["32"] = "camoBelt";
_partFrameLabels.overpants["33"] = "underwear";
_partFrameLabels.overpants["34"] = "chameleon";
_partFrameLabels.overpants["35"] = "sponsorLego";
_partFrameLabels.overpants["36"] = "egyptArch";
_partFrameLabels.overpants["37"] = "miner1";
_partFrameLabels.overpants["38"] = "miner2";
_partFrameLabels.overpants["39"] = "sponsorCTC";
_partFrameLabels.overpants["40"] = "sponsorWalmartElf";
_partFrameLabels.overpants["41"] = "sponsorWallE";
_partFrameLabels.overpants["42"] = "warriorBelt";
_partFrameLabels.overpants["43"] = "hiker";
_partFrameLabels.overpants["44"] = "cowGirl";
_partFrameLabels.overpants["45"] = "geisha";
_partFrameLabels.overpants["46"] = "montgomery";
_partFrameLabels.overpants["47"] = "FLpirate1";
_partFrameLabels.overpants["48"] = "FLpirate3";
_partFrameLabels.overpants["49"] = "pKnight1";
_partFrameLabels.overpants["50"] = "pGeisha1";
_partFrameLabels.overpants["51"] = "pGeisha2";
_partFrameLabels.overpants["52"] = "pGeisha3";
_partFrameLabels.overpants["53"] = "pPharaoh";
_partFrameLabels.overpants["54"] = "pEgyptQ";
_partFrameLabels.overpants["55"] = "pZorro";
_partFrameLabels.overpants["56"] = "pSamurai";
_partFrameLabels.overpants["57"] = "pRockerGuy1";
_partFrameLabels.overpants["58"] = "pRockerGirl1";
_partFrameLabels.overpants["59"] = "pPopGirl1";
_partFrameLabels.overpants["60"] = "pPopGirl2";
_partFrameLabels.overpants["61"] = "pPopGirl3";
_partFrameLabels.overpants["62"] = "pNinja1";
_partFrameLabels.overpants["63"] = "pRobinhood1";
_partFrameLabels.overpants["64"] = "sponsorPinoFairy";
_partFrameLabels.overpants["65"] = "sponsorPinoPino";
_partFrameLabels.overpants["66"] = "astroMonk";
_partFrameLabels.overpants["67"] = "astroCult";
_partFrameLabels.overpants["68"] = "astroChance";
_partFrameLabels.overpants["69"] = "blueKnight";
_partFrameLabels.overpants["70"] = "astroPrincess";
_partFrameLabels.overpants["71"] = "astroEvilPrincess";
_partFrameLabels.overpants["72"] = "astroServant1";
_partFrameLabels.overpants["73"] = "astroRoyal1";
_partFrameLabels.overpants["74"] = "astroVill1";
_partFrameLabels.overpants["75"] = "astroManure";
_partFrameLabels.overpants["76"] = "astroVill2";
_partFrameLabels.overpants["77"] = "astroGuard2";
_partFrameLabels.overpants["78"] = "astroFarmer";
_partFrameLabels.overpants["79"] = "astroVill3";
_partFrameLabels.overpants["80"] = "astroVill4";
_partFrameLabels.overpants["81"] = "astroPes1";
_partFrameLabels.overpants["82"] = "astroPes2";
_partFrameLabels.overpants["83"] = "astroCurrator";
_partFrameLabels.overpants["84"] = "astroGossip1";
_partFrameLabels.overpants["85"] = "astroGossip2";
_partFrameLabels.overpants["86"] = "astroGossip3";
_partFrameLabels.overpants["87"] = "astroGossip5";
_partFrameLabels.overpants["88"] = "astroAlien";
_partFrameLabels.overpants["89"] = "astroZone";
_partFrameLabels.overpants["90"] = "pSingerGuy1";
_partFrameLabels.overpants["91"] = "pPirateGuy1";
_partFrameLabels.overpants["92"] = "pPirateGirl1";
_partFrameLabels.overpants["93"] = "pRevolver";
_partFrameLabels.overpants["94"] = "pRobot2";
_partFrameLabels.overpants["95"] = "pRobot3";
_partFrameLabels.overpants["96"] = "pRobot4";
_partFrameLabels.overpants["97"] = "pRobot5";
_partFrameLabels.overpants["98"] = "pKarateBoy1";
_partFrameLabels.overpants["99"] = "pKarateBoy2";
_partFrameLabels.overpants["100"] = "pKarateBoy3";
_partFrameLabels.overpants["101"] = "pKarateGirl1";
_partFrameLabels.overpants["102"] = "pKarateGirl2";
_partFrameLabels.overpants["103"] = "pKarateGirl3";
_partFrameLabels.overpants["104"] = "sponsorWM2";
_partFrameLabels.overpants["105"] = "sponsorBedB1";
_partFrameLabels.overpants["106"] = "sponsorCWMB1";
_partFrameLabels.overpants["107"] = "sponsorCWMB2";
_partFrameLabels.overpants["108"] = "pFirefigther1";
_partFrameLabels.overpants["109"] = "pNinjaFE";
_partFrameLabels.overpants["110"] = "pAngel";
_partFrameLabels.overpants["111"] = "pPopGirlLE";
_partFrameLabels.overpants["112"] = "pBiker1";
_partFrameLabels.overpants["113"] = "pDareD1";
_partFrameLabels.overpants["114"] = "grimReaper";
_partFrameLabels.overpants["115"] = "sponsorAstro2";
_partFrameLabels.overpants["116"] = "sponsorGbCrow";
_partFrameLabels.overpants["117"] = "witch";
_partFrameLabels.overpants["118"] = "witch2";
_partFrameLabels.overpants["119"] = "sponsorTinkerbell";
_partFrameLabels.overpants["120"] = "sponsorEC1";
_partFrameLabels.overpants["121"] = "sponsorSBsanta4";
_partFrameLabels.overpants["122"] = "sponsorNM2guard";
_partFrameLabels.overpants["123"] = "blackWidow2";
_partFrameLabels.overpants["124"] = "shadyCop";
_partFrameLabels.overpants["125"] = "conWorker1";
_partFrameLabels.overpants["126"] = "securityGuard1";
_partFrameLabels.overpants["127"] = "hades";
_partFrameLabels.overpants["128"] = "poseidon";
_partFrameLabels.overpants["129"] = "zeus";
_partFrameLabels.overpants["130"] = "hercules";
_partFrameLabels.overpants["131"] = "athena";
_partFrameLabels.overpants["132"] = "aphrodite";
_partFrameLabels.overpants["133"] = "dionysus";
_partFrameLabels.overpants["134"] = "minotaur";
_partFrameLabels.overpants["135"] = "athenaOld";
_partFrameLabels.overpants["136"] = "realityWoman";
_partFrameLabels.overpants["137"] = "triton";
_partFrameLabels.overpants["138"] = "charon";
_partFrameLabels.overpants["139"] = "aeolus";
_partFrameLabels.overpants["140"] = "mythPes1";
_partFrameLabels.overpants["141"] = "mythPes2";
_partFrameLabels.overpants["142"] = "mythPes3";
_partFrameLabels.overpants["143"] = "mythPes4";
_partFrameLabels.overpants["144"] = "mythPes5";
_partFrameLabels.overpants["145"] = "mythPes6";
_partFrameLabels.overpants["146"] = "mythPes7";
_partFrameLabels.overpants["147"] = "mythTeen1";
_partFrameLabels.overpants["148"] = "mythTeen2";
_partFrameLabels.overpants["149"] = "mythBeach1";
_partFrameLabels.overpants["150"] = "mythBeach2";
_partFrameLabels.overpants["151"] = "medusa";
_partFrameLabels.overpants["152"] = "sponsorTSBRbuzz";
_partFrameLabels.overpants["153"] = "sponsorTSBRjess";
_partFrameLabels.overpants["154"] = "sponsorTSBRwoody";
_partFrameLabels.overpants["155"] = "sponsorTSBRalien";
_partFrameLabels.overpants["156"] = "pPunkGuy1";
_partFrameLabels.overpants["157"] = "pPunkGirl1";
_partFrameLabels.overpants["158"] = "pPunkGirl2";
_partFrameLabels.overpants["159"] = "pPunkGirl3";
_partFrameLabels.overpants["160"] = "pPunkGirl4";
_partFrameLabels.overpants["161"] = "pPunkGirl5";
_partFrameLabels.overpants["162"] = "skullPirate1";
_partFrameLabels.overpants["163"] = "skullPirate2";
_partFrameLabels.overpants["164"] = "skullPirate3";
_partFrameLabels.overpants["165"] = "skullPirate5";
_partFrameLabels.overpants["166"] = "skullPirate7";
_partFrameLabels.overpants["167"] = "skullSam";
_partFrameLabels.overpants["168"] = "skullNavigator";
_partFrameLabels.overpants["169"] = "skullCannon";
_partFrameLabels.overpants["170"] = "skullMoroLady1";
_partFrameLabels.overpants["171"] = "skullMoroLady2";
_partFrameLabels.overpants["172"] = "skullMoroLady3";
_partFrameLabels.overpants["173"] = "skullMoroBank1";
_partFrameLabels.overpants["174"] = "skullMoroGuy1";
_partFrameLabels.overpants["175"] = "skullMoroGuy2";
_partFrameLabels.overpants["176"] = "skullMoroGuy3";
_partFrameLabels.overpants["177"] = "skullChinaGuy1";
_partFrameLabels.overpants["178"] = "skullChinaShipwright";
_partFrameLabels.overpants["179"] = "skullChinaShipSell";
_partFrameLabels.overpants["180"] = "skullChinaMerch";
_partFrameLabels.overpants["181"] = "pSkullPirate1";
_partFrameLabels.overpants["182"] = "sponsorMH_overpants1";
_partFrameLabels.overpants["183"] = "sponsorMH_overpants2";
_partFrameLabels.overpants["184"] = "sponsorMH_overpants3";
_partFrameLabels.overpants["185"] = "sponsorMH_overpants4";
_partFrameLabels.overpants["186"] = "sponsorMH_overpants5";
_partFrameLabels.overpants["187"] = "sponsorMH_overpants6";
_partFrameLabels.overpants["188"] = "sponsorMinion";
_partFrameLabels.overpants["189"] = "sponsorAgnes";
_partFrameLabels.overpants["190"] = "sponsorPercyZeus";
_partFrameLabels.overpants["191"] = "pMythSurferZeus";
_partFrameLabels.overpants["192"] = "pMythSurferHades";
_partFrameLabels.overpants["193"] = "pMythSurferPose";
_partFrameLabels.overpants["194"] = "steamCaptain";
_partFrameLabels.overpants["195"] = "steamZach";
_partFrameLabels.overpants["196"] = "steamWorker1";
_partFrameLabels.overpants["197"] = "steamPilot";
_partFrameLabels.overpants["198"] = "pNerd";
_partFrameLabels.overpants["199"] = "pVampire_boy";
_partFrameLabels.overpants["200"] = "pVampire_girl01";
_partFrameLabels.overpants["201"] = "pVampire_girl03";
_partFrameLabels.overpants["202"] = "sponsorTinkBobble";
_partFrameLabels.overpants["203"] = "sponsorFarmGirl";
_partFrameLabels.overpants["204"] = "sponsorFarmKid";
_partFrameLabels.overpants["205"] = "sponsorCityGirl";
_partFrameLabels.overpants["206"] = "sponsor_POK-Mason";
_partFrameLabels.overpants["207"] = "sponsor_POK-Tarantula";
_partFrameLabels.overpants["208"] = "sponsor_BarbiePirate";
_partFrameLabels.overpants["209"] = "rowBoatMan";
_partFrameLabels.overpants["210"] = "pBigFoot";
_partFrameLabels.overpants["211"] = "HowardMews";
_partFrameLabels.overpants["212"] = "gardener";
_partFrameLabels.overpants["213"] = "balloonPilate02";
_partFrameLabels.overpants["214"] = "barPatron1";
_partFrameLabels.overpants["215"] = "surlyDartMan";
_partFrameLabels.overpants["216"] = "farmerBoy";
_partFrameLabels.overpants["217"] = "PuertoRicanFarmer";
_partFrameLabels.overpants["218"] = "promoWWday4";
_partFrameLabels.overpants["219"] = "promoWWday6";
_partFrameLabels.overpants["220"] = "promoWWmemOnly";
_partFrameLabels.overpants["221"] = "wwTrader";
_partFrameLabels.overpants["222"] = "wwAnnie";
_partFrameLabels.overpants["223"] = "wwMustachioB";
_partFrameLabels.overpants["224"] = "wwPonyExpress";
_partFrameLabels.overpants["225"] = "wwMarshal";
_partFrameLabels.overpants["226"] = "wwGSEvil";
_partFrameLabels.overpants["227"] = "wwGambler";
_partFrameLabels.overpants["228"] = "wwDeputy";
_partFrameLabels.overpants["229"] = "wwYoungGun";
_partFrameLabels.overpants["230"] = "wwBanditGirl";
_partFrameLabels.overpants["231"] = "wwWorker";
_partFrameLabels.overpants["232"] = "wwIndianGirl";
_partFrameLabels.overpants["233"] = "wwRough";
_partFrameLabels.overpants["234"] = "pLawmaker";
_partFrameLabels.overpants["235"] = "MTHyokozuna";
_partFrameLabels.overpants["236"] = "MTHscaredSumo";
_partFrameLabels.overpants["237"] = "MTHbasho";
_partFrameLabels.overpants["238"] = "pNinja02";
_partFrameLabels.overpants["239"] = "MTHreferee";
_partFrameLabels.overpants["240"] = "MTHtownie01";
_partFrameLabels.overpants["241"] = "MTHtownie02";
_partFrameLabels.overpants["242"] = "MTHtownie03";
_partFrameLabels.overpants["243"] = "MTHtownie04";
_partFrameLabels.overpants["244"] = "pMTHsumo1";
_partFrameLabels.overpants["245"] = "pMTHsumo2";
_partFrameLabels.overpants["246"] = "pMTHsumo3";
_partFrameLabels.overpants["247"] = "pMTHsumo4";
_partFrameLabels.overpants["248"] = "MTHsamurai01";
_partFrameLabels.overpants["249"] = "MTHninjaBlue";
_partFrameLabels.overpants["250"] = "MTHninjaWhite";
_partFrameLabels.overpants["251"] = "MTHprisoner";
_partFrameLabels.overpants["252"] = "MTHdragonPuppeteer";
_partFrameLabels.overpants["253"] = "MTHkimono01";
_partFrameLabels.overpants["254"] = "MTHkimono02";
_partFrameLabels.overpants["255"] = "MTHkimono03";
_partFrameLabels.overpants["256"] = "MTHkimono04";
_partFrameLabels.overpants["257"] = "MTHkimono05";
_partFrameLabels.overpants["258"] = "MTHyokoAsst";
_partFrameLabels.overpants["259"] = "MTHbookie";
_partFrameLabels.overpants["260"] = "MTHartist";
_partFrameLabels.overpants["261"] = "MTHgardener04";
_partFrameLabels.overpants["262"] = "MTHfemWar";
_partFrameLabels.overpants["263"] = "sponsor_KickinIt_blackbelt";
_partFrameLabels.overpants["264"] = "sponsor_KickinIt_whitebelt";
_partFrameLabels.overpants["265"] = "MTHshopkeeper";
_partFrameLabels.overpants["266"] = "MTHwoman";
_partFrameLabels.overpants["267"] = "TcamoGuy";
_partFrameLabels.overpants["268"] = "TpirateBlue";
_partFrameLabels.overpants["269"] = "SRdad";
_partFrameLabels.overpants["270"] = "Tcumulos";
_partFrameLabels.overpants["271"] = "Tninja01";
_partFrameLabels.overpants["272"] = "Tsamurai";
_partFrameLabels.overpants["273"] = "mtCoalMan";
_partFrameLabels.overpants["274"] = "mtDancer";
_partFrameLabels.overpants["275"] = "mtPoliceman";
_partFrameLabels.overpants["276"] = "mtJuggler";
_partFrameLabels.overpants["277"] = "TrockKnight";
_partFrameLabels.overpants["278"] = "TdreadRocker";
_partFrameLabels.overpants["279"] = "GSdiaper";
_partFrameLabels.overpants["280"] = "GSrobotPromo";
_partFrameLabels.overpants["281"] = "TT_elf1";
_partFrameLabels.overpants["282"] = "TT_elfQueen";
_partFrameLabels.overpants["283"] = "sponsorThePirates_LizBelt";
_partFrameLabels.overpants["284"] = "GSdiaper";
_partFrameLabels.overpants["285"] = "GSrobotPromo";
_partFrameLabels.facial["9"] = "explorer";
_partFrameLabels.facial["10"] = "voodoo";
_partFrameLabels.facial["11"] = "scuba";
_partFrameLabels.facial["12"] = "shark";
_partFrameLabels.facial["13"] = "chineseWarrior";
_partFrameLabels.facial["14"] = "frenchman1";
_partFrameLabels.facial["15"] = "frenchman2";
_partFrameLabels.facial["16"] = "greekWarrior";
_partFrameLabels.facial["17"] = "viking";
_partFrameLabels.facial["18"] = "viking3";
_partFrameLabels.facial["19"] = "lewis";
_partFrameLabels.facial["20"] = "batman";
_partFrameLabels.facial["21"] = "hillary";
_partFrameLabels.facial["22"] = "sherpa";
_partFrameLabels.facial["23"] = "franklin";
_partFrameLabels.facial["24"] = "edworker1";
_partFrameLabels.facial["25"] = "edworker2";
_partFrameLabels.facial["26"] = "edworker4";
_partFrameLabels.facial["27"] = "edworker5";
_partFrameLabels.facial["28"] = "Nim2";
_partFrameLabels.facial["29"] = "sponsorSpace";
_partFrameLabels.facial["30"] = "sponsorFLoops";
_partFrameLabels.facial["31"] = "old";
_partFrameLabels.facial["32"] = "aztecMask";
_partFrameLabels.facial["33"] = "sponsorFLoops2";
_partFrameLabels.facial["34"] = "sponsorAJ";
_partFrameLabels.facial["35"] = "drHare";
_partFrameLabels.facial["36"] = "rabbitCon";
_partFrameLabels.facial["37"] = "rabbitCon2";
_partFrameLabels.facial["38"] = "cat";
_partFrameLabels.facial["39"] = "radioactive";
_partFrameLabels.facial["40"] = "policeman";
_partFrameLabels.facial["41"] = "prisoner1";
_partFrameLabels.facial["42"] = "nerd";
_partFrameLabels.facial["43"] = "hero1";
_partFrameLabels.facial["44"] = "hero2";
_partFrameLabels.facial["45"] = "hero3";
_partFrameLabels.facial["46"] = "hero4";
_partFrameLabels.facial["47"] = "hero5";
_partFrameLabels.facial["48"] = "hero6";
_partFrameLabels.facial["49"] = "eyePatch";
_partFrameLabels.facial["50"] = "skiMask";
_partFrameLabels.facial["51"] = "chameleon";
_partFrameLabels.facial["52"] = "SS";
_partFrameLabels.facial["53"] = "funGlasses1";
_partFrameLabels.facial["54"] = "funGlasses2";
_partFrameLabels.facial["55"] = "funGlasses3";
_partFrameLabels.facial["56"] = "laserVision";
_partFrameLabels.facial["57"] = "dog";
_partFrameLabels.facial["58"] = "trash";
_partFrameLabels.facial["59"] = "tied";
_partFrameLabels.facial["60"] = "chefBAD";
_partFrameLabels.facial["61"] = "africanMask";
_partFrameLabels.facial["62"] = "sponsorLego";
_partFrameLabels.facial["63"] = "sponsorLego2";
_partFrameLabels.facial["64"] = "egyptDigger";
_partFrameLabels.facial["65"] = "egyptArch";
_partFrameLabels.facial["66"] = "oldPilot";
_partFrameLabels.facial["67"] = "miner1";
_partFrameLabels.facial["68"] = "miner2";
_partFrameLabels.facial["69"] = "sponsorCTCgirl";
_partFrameLabels.facial["70"] = "sponsorCTCguy";
_partFrameLabels.facial["71"] = "sponsorFLlemon";
_partFrameLabels.facial["72"] = "pinkGlasses";
_partFrameLabels.facial["73"] = "lawyer";
_partFrameLabels.facial["74"] = "librarian";
_partFrameLabels.facial["75"] = "hiker";
_partFrameLabels.facial["76"] = "chef";
_partFrameLabels.facial["77"] = "grandma";
_partFrameLabels.facial["78"] = "biker";
_partFrameLabels.facial["79"] = "grandpa";
_partFrameLabels.facial["80"] = "baseball";
_partFrameLabels.facial["81"] = "sponsorOS2";
_partFrameLabels.facial["82"] = "montgomery";
_partFrameLabels.facial["83"] = "santa";
_partFrameLabels.facial["84"] = "rudolf";
_partFrameLabels.facial["85"] = "yogosBucksGuy";
_partFrameLabels.facial["86"] = "yogosBucksGirl";
_partFrameLabels.facial["87"] = "scuba2";
_partFrameLabels.facial["88"] = "sponsorSBdog";
_partFrameLabels.facial["89"] = "sponsorSBsuit";
_partFrameLabels.facial["90"] = "monkey";
_partFrameLabels.facial["91"] = "sheep";
_partFrameLabels.facial["92"] = "pKnight1";
_partFrameLabels.facial["93"] = "pLion";
_partFrameLabels.facial["94"] = "pRooster1";
_partFrameLabels.facial["95"] = "pRooster2";
_partFrameLabels.facial["96"] = "pRooster3";
_partFrameLabels.facial["97"] = "pGeisha1";
_partFrameLabels.facial["98"] = "pGeisha2";
_partFrameLabels.facial["99"] = "pGeisha3";
_partFrameLabels.facial["100"] = "pRobot";
_partFrameLabels.facial["101"] = "pRobot1b";
_partFrameLabels.facial["102"] = "girlCap1";
_partFrameLabels.facial["103"] = "girlCap2";
_partFrameLabels.facial["104"] = "girlCap3";
_partFrameLabels.facial["105"] = "pZorro";
_partFrameLabels.facial["106"] = "pSamurai";
_partFrameLabels.facial["107"] = "pRockerGuy1";
_partFrameLabels.facial["108"] = "pRockerGuy2";
_partFrameLabels.facial["109"] = "pRockerGuy3";
_partFrameLabels.facial["110"] = "pRockerGirl1";
_partFrameLabels.facial["111"] = "pRockerGirl2";
_partFrameLabels.facial["112"] = "pRockerGirl3";
_partFrameLabels.facial["113"] = "pRiding1";
_partFrameLabels.facial["114"] = "pRiding2";
_partFrameLabels.facial["115"] = "pRiding3";
_partFrameLabels.facial["116"] = "pDragon1";
_partFrameLabels.facial["117"] = "pDragon2";
_partFrameLabels.facial["118"] = "pDragon3";
_partFrameLabels.facial["119"] = "pMouse";
_partFrameLabels.facial["120"] = "pDog1";
_partFrameLabels.facial["121"] = "pDog2";
_partFrameLabels.facial["122"] = "pDog3";
_partFrameLabels.facial["123"] = "pPopGirl1";
_partFrameLabels.facial["124"] = "pPopGirl2";
_partFrameLabels.facial["125"] = "pPopGirl3";
_partFrameLabels.facial["126"] = "pNinja1";
_partFrameLabels.facial["127"] = "pRobinhood1";
_partFrameLabels.facial["128"] = "pRobinhood2";
_partFrameLabels.facial["129"] = "pRobinhood3";
_partFrameLabels.facial["130"] = "pRobinhood4";
_partFrameLabels.facial["131"] = "pRobinhood5";
_partFrameLabels.facial["132"] = "sponsorPinoPino";
_partFrameLabels.facial["133"] = "cyberJester";
_partFrameLabels.facial["134"] = "astroChance";
_partFrameLabels.facial["135"] = "redKnight";
_partFrameLabels.facial["136"] = "blueKnight";
_partFrameLabels.facial["137"] = "greenKnight";
_partFrameLabels.facial["138"] = "astroGuard1";
_partFrameLabels.facial["139"] = "astroCult";
_partFrameLabels.facial["140"] = "astroManure";
_partFrameLabels.facial["141"] = "astroGuard2";
_partFrameLabels.facial["142"] = "sponsorFLoct";
_partFrameLabels.facial["143"] = "pSingerGuy1";
_partFrameLabels.facial["144"] = "pSingerGuy2";
_partFrameLabels.facial["145"] = "pSingerGuy3";
_partFrameLabels.facial["146"] = "pPirateGuy1";
_partFrameLabels.facial["147"] = "pBaseball1Girl1";
_partFrameLabels.facial["148"] = "pBaseball1Girl2";
_partFrameLabels.facial["149"] = "pBaseball1Girl3";
_partFrameLabels.facial["150"] = "pBaseball2Girl1";
_partFrameLabels.facial["151"] = "pBaseball2Girl2";
_partFrameLabels.facial["152"] = "pBaseball2Girl3";
_partFrameLabels.facial["153"] = "pBaseball1Guy1";
_partFrameLabels.facial["154"] = "pBaseball1Guy2";
_partFrameLabels.facial["155"] = "pBaseball1Guy3";
_partFrameLabels.facial["156"] = "pBaseball2Guy1";
_partFrameLabels.facial["157"] = "pBaseball2Guy2";
_partFrameLabels.facial["158"] = "pBaseball2Guy3";
_partFrameLabels.facial["159"] = "pRobot2";
_partFrameLabels.facial["160"] = "pRobot3";
_partFrameLabels.facial["161"] = "pRobot4_1";
_partFrameLabels.facial["162"] = "pRobot4_2";
_partFrameLabels.facial["163"] = "pRobot4_3";
_partFrameLabels.facial["164"] = "pRobot5";
_partFrameLabels.facial["165"] = "sponsorWM2";
_partFrameLabels.facial["166"] = "pAstronaut1";
_partFrameLabels.facial["167"] = "sponsorCWMB4";
_partFrameLabels.facial["168"] = "pFirefighter1";
_partFrameLabels.facial["169"] = "pClown1";
_partFrameLabels.facial["170"] = "pNinjaLE";
_partFrameLabels.facial["171"] = "pPopGirlLE";
_partFrameLabels.facial["172"] = "sponsorLegoBio";
_partFrameLabels.facial["173"] = "pBiker1";
_partFrameLabels.facial["174"] = "pBiker2";
_partFrameLabels.facial["175"] = "pDareD1";
_partFrameLabels.facial["176"] = "grimReaper";
_partFrameLabels.facial["177"] = "hyde";
_partFrameLabels.facial["178"] = "mummy";
_partFrameLabels.facial["179"] = "sponsorGbMummy";
_partFrameLabels.facial["180"] = "sponsorGbCrow";
_partFrameLabels.facial["181"] = "pumpkinHead";
_partFrameLabels.facial["182"] = "pumpkinHead2";
_partFrameLabels.facial["183"] = "pumpkinHead3";
_partFrameLabels.facial["184"] = "witch2";
_partFrameLabels.facial["185"] = "skeleton1";
_partFrameLabels.facial["186"] = "pWolf1";
_partFrameLabels.facial["187"] = "sponsorMinc1";
_partFrameLabels.facial["188"] = "sponsorSBsanta";
_partFrameLabels.facial["189"] = "sponsorSBsanta4";
_partFrameLabels.facial["190"] = "sponsorPFxmas";
_partFrameLabels.facial["191"] = "shadyCop";
_partFrameLabels.facial["192"] = "curator";
_partFrameLabels.facial["193"] = "chef2";
_partFrameLabels.facial["194"] = "conWorker1";
_partFrameLabels.facial["195"] = "sponsorMinc3";
_partFrameLabels.facial["196"] = "patron1";
_partFrameLabels.facial["197"] = "pTigerShark";
_partFrameLabels.facial["198"] = "frenchPol1";
_partFrameLabels.facial["199"] = "frenchPol2";
_partFrameLabels.facial["200"] = "sponsorSpyNext";
_partFrameLabels.facial["201"] = "pSnowman";
_partFrameLabels.facial["202"] = "tvSalesman";
_partFrameLabels.facial["203"] = "papaPetes";
_partFrameLabels.facial["204"] = "realityTeen";
_partFrameLabels.facial["205"] = "sponsorWilson";
_partFrameLabels.facial["206"] = "sponsorFizzy";
_partFrameLabels.facial["207"] = "pFootball1";
_partFrameLabels.facial["208"] = "pFootball2";
_partFrameLabels.facial["209"] = "pFootball3";
_partFrameLabels.facial["210"] = "pFootball4";
_partFrameLabels.facial["211"] = "minotaur";
_partFrameLabels.facial["212"] = "athenaOld";
_partFrameLabels.facial["213"] = "triton";
_partFrameLabels.facial["214"] = "mythBeach1";
_partFrameLabels.facial["215"] = "mythBeach2";
_partFrameLabels.facial["216"] = "sponsorBF5a";
_partFrameLabels.facial["217"] = "sponsorBF5b";
_partFrameLabels.facial["218"] = "sponsorBF5c";
_partFrameLabels.facial["219"] = "sponsorBF5d";
_partFrameLabels.facial["220"] = "sponsorBF5e";
_partFrameLabels.facial["221"] = "sponsorTSBRbuzz";
_partFrameLabels.facial["222"] = "pPunkGuy1";
_partFrameLabels.facial["223"] = "pPunkGuy2";
_partFrameLabels.facial["224"] = "pPunkGuy3";
_partFrameLabels.facial["225"] = "pPunkGuy4";
_partFrameLabels.facial["226"] = "pPunkGuy5";
_partFrameLabels.facial["227"] = "pPunkGirl1";
_partFrameLabels.facial["228"] = "pPunkGirl2";
_partFrameLabels.facial["229"] = "pPunkGirl3";
_partFrameLabels.facial["230"] = "pPunkGirl4";
_partFrameLabels.facial["231"] = "pPunkGirl5";
_partFrameLabels.facial["232"] = "pRabbot";
_partFrameLabels.facial["233"] = "pDrHare_Scientist";
_partFrameLabels.facial["234"] = "pDrHare_Hench";
_partFrameLabels.facial["235"] = "pEinstein";
_partFrameLabels.facial["236"] = "sponsorFurryV";
_partFrameLabels.facial["237"] = "pDarkKnight_boy";
_partFrameLabels.facial["238"] = "pDarkKnight_girl";
_partFrameLabels.facial["239"] = "pKight_Earth";
_partFrameLabels.facial["240"] = "pKnight_Heart";
_partFrameLabels.facial["241"] = "pFool";
_partFrameLabels.facial["242"] = "captCrawfish";
_partFrameLabels.facial["243"] = "skullMainLadyFarm";
_partFrameLabels.facial["244"] = "skullMainFarmer2";
_partFrameLabels.facial["245"] = "skullMainGirl";
_partFrameLabels.facial["246"] = "skullMainSadLady";
_partFrameLabels.facial["247"] = "skullMoroLady2";
_partFrameLabels.facial["248"] = "skullMoroLady3";
_partFrameLabels.facial["249"] = "skullChinaMerch";
_partFrameLabels.facial["250"] = "sponsorHypnotic";
_partFrameLabels.facial["251"] = "pSkullPirate1";
_partFrameLabels.facial["252"] = "pPromQueen1";
_partFrameLabels.facial["253"] = "sponsorMH_Mummy";
_partFrameLabels.facial["254"] = "sponsorMinion";
_partFrameLabels.facial["255"] = "sponsorEdith";
_partFrameLabels.facial["256"] = "sponsorMargo";
_partFrameLabels.facial["257"] = "sponsorGoldfishB";
_partFrameLabels.facial["258"] = "SponsorGoldfishG";
_partFrameLabels.facial["259"] = "sponsorPercyJackson";
_partFrameLabels.facial["260"] = "pMythSurferZeus";
_partFrameLabels.facial["261"] = "pMythSurferHades";
_partFrameLabels.facial["262"] = "pMythSurferPose";
_partFrameLabels.facial["263"] = "steamCaptain";
_partFrameLabels.facial["264"] = "sponsor_Ramona";
_partFrameLabels.facial["265"] = "sponsor_SpyHelmet";
_partFrameLabels.facial["266"] = "sponsorCDdog";
_partFrameLabels.facial["267"] = "pHammerShark";
_partFrameLabels.facial["268"] = "steamZach";
_partFrameLabels.facial["269"] = "steamWorker1";
_partFrameLabels.facial["270"] = "steamPilot";
_partFrameLabels.facial["271"] = "pGamerGirl";
_partFrameLabels.facial["272"] = "pGamerDude";
_partFrameLabels.facial["273"] = "pNerdBoy";
_partFrameLabels.facial["274"] = "pNerdGirl";
_partFrameLabels.facial["275"] = "pVampire_boy";
_partFrameLabels.facial["276"] = "pVampire_girl03";
_partFrameLabels.facial["277"] = "pVampire_girl02";
_partFrameLabels.facial["278"] = "sponsorTinkBobble";
_partFrameLabels.facial["279"] = "sponsorNannyMcPhee";
_partFrameLabels.facial["280"] = "sponsorAlphaOmega";
_partFrameLabels.facial["281"] = "sponsorAlphaOmegaF";
_partFrameLabels.facial["282"] = "sponsorAO_Omega";
_partFrameLabels.facial["283"] = "sponsorAO_Alpha";
_partFrameLabels.facial["284"] = "sponsor_POK-Tarantula";
_partFrameLabels.facial["285"] = "sponsorFishHooks_helmet";
_partFrameLabels.facial["286"] = "pSteamRobot";
_partFrameLabels.facial["287"] = "Birthday_3";
_partFrameLabels.facial["288"] = "peanutsMask";
_partFrameLabels.facial["289"] = "sponsor_BarbiePirate";
_partFrameLabels.facial["290"] = "sponsor_BarbieCat";
_partFrameLabels.facial["291"] = "sponsor_bouncer";
_partFrameLabels.facial["292"] = "sponsor_BarbiePirateB";
_partFrameLabels.facial["293"] = "sponsorLegoHero";
_partFrameLabels.facial["294"] = "sponsorFLPharoah";
_partFrameLabels.facial["295"] = "sponsorFLPharoah_g";
_partFrameLabels.facial["296"] = "sponsorAppleJacks_blitz_apple";
_partFrameLabels.facial["297"] = "sponsorBarbieGGdog1";
_partFrameLabels.facial["298"] = "scottishMan";
_partFrameLabels.facial["299"] = "rowBoatMan";
_partFrameLabels.facial["300"] = "sponsorMummyFL";
_partFrameLabels.facial["301"] = "HNC_HoneyDefender";
_partFrameLabels.facial["302"] = "nessieTourist1";
_partFrameLabels.facial["303"] = "haroldMews";
_partFrameLabels.facial["304"] = "gretchen";
_partFrameLabels.facial["305"] = "gretchen_glasses";
_partFrameLabels.facial["306"] = "balloonPilate01";
_partFrameLabels.facial["307"] = "balloonPilate02";
_partFrameLabels.facial["308"] = "gliderGirl";
_partFrameLabels.facial["309"] = "snootyLady";
_partFrameLabels.facial["310"] = "HunterGiveUp";
_partFrameLabels.facial["311"] = "barPatron1";
_partFrameLabels.facial["312"] = "surlyDartMan";
_partFrameLabels.facial["313"] = "barPatron2";
_partFrameLabels.facial["314"] = "farmerBoy";
_partFrameLabels.facial["315"] = "PuertoRico_Farmer1";
_partFrameLabels.facial["316"] = "PuertoRicoFarmerBrother";
_partFrameLabels.facial["317"] = "PuertoRicoFarmer2";
_partFrameLabels.facial["318"] = "PuertoRicoFarmer3";
_partFrameLabels.facial["319"] = "bartenderPub";
_partFrameLabels.facial["320"] = "oldSherpa";
_partFrameLabels.facial["321"] = "youngSherpa";
_partFrameLabels.facial["322"] = "nateG";
_partFrameLabels.facial["323"] = "nateG2";
_partFrameLabels.facial["324"] = "tyson";
_partFrameLabels.facial["325"] = "townie9";
_partFrameLabels.facial["326"] = "fortuneHunter2";
_partFrameLabels.facial["327"] = "fortuneHunter1";
_partFrameLabels.facial["328"] = "sponsorOS3";
_partFrameLabels.facial["329"] = "sponsorOS3_Ursa";
_partFrameLabels.facial["330"] = "sponsorOS3_Doug";
_partFrameLabels.facial["331"] = "pDisco_King";
_partFrameLabels.facial["332"] = "pDisco_Queen";
_partFrameLabels.facial["333"] = "sponsorRedRanger";
_partFrameLabels.facial["334"] = "sponsorYellowRanger";
_partFrameLabels.facial["335"] = "promoWWday4";
_partFrameLabels.facial["336"] = "promoWWday3";
_partFrameLabels.facial["337"] = "promoWWmemOnly";
_partFrameLabels.facial["338"] = "sponsorGnomeo";
_partFrameLabels.facial["339"] = "sponsorJuliet";
_partFrameLabels.facial["340"] = "sponsorPinkRanger";
_partFrameLabels.facial["341"] = "wwMustachioB";
_partFrameLabels.facial["342"] = "wwRJEarl";
_partFrameLabels.facial["343"] = "wwMarshal";
_partFrameLabels.facial["344"] = "wwGSEvil";
_partFrameLabels.facial["345"] = "wwGambler";
_partFrameLabels.facial["346"] = "wwConductor";
_partFrameLabels.facial["347"] = "wwBanditGirl";
_partFrameLabels.facial["348"] = "wwProspector";
_partFrameLabels.facial["349"] = "wwRough";
_partFrameLabels.facial["350"] = "wwNoName";
_partFrameLabels.facial["351"] = "sponsorMarsNeedsMomsVisor";
_partFrameLabels.facial["352"] = "sponsorMarsNeedsMoms_gribblehat";
_partFrameLabels.facial["353"] = "Members_Paperboy/Girl";
_partFrameLabels.facial["354"] = "sponsorMonsterHigh";
_partFrameLabels.facial["355"] = "pOutlaw_boys";
_partFrameLabels.facial["356"] = "pOutlaw_girls";
_partFrameLabels.facial["357"] = "paperBoy_01";
_partFrameLabels.facial["358"] = "paperBoy_02";
_partFrameLabels.facial["359"] = "paperGirl_01";
_partFrameLabels.facial["360"] = "paperGirl_02";
_partFrameLabels.facial["361"] = "pLawman";
_partFrameLabels.facial["362"] = "pPeaceKeeper";
_partFrameLabels.facial["363"] = "sponsorChuck";
_partFrameLabels.facial["364"] = "MTHjack";
_partFrameLabels.facial["365"] = "MTHfisherman";
_partFrameLabels.facial["366"] = "MTHshogunCasual";
_partFrameLabels.facial["367"] = "MTHshogunArmor";
_partFrameLabels.facial["368"] = "MTHbasho";
_partFrameLabels.facial["369"] = "pNinja02";
_partFrameLabels.facial["370"] = "MTHsamurai01";
_partFrameLabels.facial["371"] = "MTHsamurai02";
_partFrameLabels.facial["372"] = "MTHninjaBlue";
_partFrameLabels.facial["373"] = "MTHninjaWhite";
_partFrameLabels.facial["374"] = "MTHdragPup01";
_partFrameLabels.facial["375"] = "MTHdragPup02";
_partFrameLabels.facial["376"] = "MTHbookie";
_partFrameLabels.facial["377"] = "MTHfishmonger";
_partFrameLabels.facial["378"] = "MTHforeman";
_partFrameLabels.facial["379"] = "sponsorGoldfishBunniesHat";
_partFrameLabels.facial["380"] = "sponsorGoldfishBunniesHead";
_partFrameLabels.facial["381"] = "MTHgardener01";
_partFrameLabels.facial["382"] = "sponsor_looneyTunesShow";
_partFrameLabels.facial["383"] = "sponsorLemonadeMouth";
_partFrameLabels.facial["384"] = "sponsorLM_Olivia";
_partFrameLabels.facial["385"] = "sponsor_LM_Stella";
_partFrameLabels.facial["386"] = "sponsorGnomeoBluRayBlue";
_partFrameLabels.facial["387"] = "sponsorGnomeoBluRayRed";
_partFrameLabels.facial["388"] = "sponsorGnomeoBluRayGreen";
_partFrameLabels.facial["389"] = "sponsorJulietRed";
_partFrameLabels.facial["390"] = "sponsorJulietBlue";
_partFrameLabels.facial["391"] = "sponsorJulietGreen";
_partFrameLabels.facial["392"] = "sponsorRingLeader";
_partFrameLabels.facial["393"] = "TcamoGuy";
_partFrameLabels.facial["394"] = "TiceSH";
_partFrameLabels.facial["395"] = "TshrkSfr";
_partFrameLabels.facial["396"] = "TfunGlasses";
_partFrameLabels.facial["397"] = "SRshady";
_partFrameLabels.facial["398"] = "LSword_robot1";
_partFrameLabels.facial["399"] = "TboogaShaman";
_partFrameLabels.facial["400"] = "sponsorGregWrapped";
_partFrameLabels.facial["401"] = "sponsor_PoppersPenguinsHat";
_partFrameLabels.facial["402"] = "SRsilva";
_partFrameLabels.facial["403"] = "ShrinkRayPromo1";
_partFrameLabels.facial["404"] = "ShrinkRayPromo2";
_partFrameLabels.facial["405"] = "LSword_robot2";
_partFrameLabels.facial["406"] = "LSword_robot3";
_partFrameLabels.facial["407"] = "sponsorFijitFriends";
_partFrameLabels.facial["408"] = "Tcumulos";
_partFrameLabels.facial["409"] = "sponsor_Rio_toucan";
_partFrameLabels.facial["410"] = "LSword_robot4";
_partFrameLabels.facial["411"] = "sponsor_Rio";
_partFrameLabels.facial["412"] = "Sponsor_AdventureTime_FinnHead";
_partFrameLabels.facial["413"] = "Sponsor_AdventureTime_JakeHead";
_partFrameLabels.facial["414"] = "Tninja01";
_partFrameLabels.facial["415"] = "Tsamurai";
_partFrameLabels.facial["416"] = "mtHoudini";
_partFrameLabels.facial["417"] = "mtTwain";
_partFrameLabels.facial["418"] = "mtCleveland";
_partFrameLabels.facial["419"] = "mtPorter";
_partFrameLabels.facial["420"] = "mtPinkertonThug";
_partFrameLabels.facial["421"] = "mtCoalMan";
_partFrameLabels.facial["422"] = "MTtesla";
_partFrameLabels.facial["423"] = "MTferris";
_partFrameLabels.facial["424"] = "MTeiffel";
_partFrameLabels.facial["425"] = "MTnyReporter";
_partFrameLabels.facial["426"] = "MTtownie02";
_partFrameLabels.facial["427"] = "Rich01";
_partFrameLabels.facial["428"] = "MTrich03";
_partFrameLabels.facial["429"] = "MTeiffelTowerHat";
_partFrameLabels.facial["430"] = "mtPoliceman";
_partFrameLabels.facial["431"] = "TrockKnight";
_partFrameLabels.facial["432"] = "TdreadRocker";
_partFrameLabels.facial["433"] = "pSherlock";
_partFrameLabels.facial["434"] = "psherlock02";
_partFrameLabels.facial["435"] = "sponsorHasbroFGN";
_partFrameLabels.facial["436"] = "sponsorLionKing";
_partFrameLabels.facial["437"] = "sponsorLionKing2";
_partFrameLabels.facial["438"] = "GSrProf";
_partFrameLabels.facial["439"] = "GSrAthlet";
_partFrameLabels.facial["440"] = "GSrPopc";
_partFrameLabels.facial["441"] = "GSrHost";
_partFrameLabels.facial["442"] = "sponsorZookeeper";
_partFrameLabels.facial["443"] = "GSrAthlet02";
_partFrameLabels.facial["444"] = "GSfactoryWorker";
_partFrameLabels.facial["445"] = "GSdiaper";
_partFrameLabels.facial["446"] = "sponsorPussNBoots";
_partFrameLabels.facial["447"] = "Tron_robot";
_partFrameLabels.facial["448"] = "Zombie";
_partFrameLabels.facial["449"] = "GSempHat";
_partFrameLabels.facial["450"] = "promo_Guidebk_glasses";
_partFrameLabels.facial["451"] = "GSheatVision";
_partFrameLabels.facial["452"] = "sponsorFijitFriendsDance";
_partFrameLabels.facial["453"] = "sponsor_cabinFever";
_partFrameLabels.facial["454"] = "sponsor_CabinFever_girl";
_partFrameLabels.facial["455"] = "GSrobotPromo";
_partFrameLabels.facial["456"] = "sponsorArthurChristmas";
_partFrameLabels.facial["457"] = "EVile";
_partFrameLabels.facial["458"] = "Skull_Mask";
_partFrameLabels.facial["459"] = "sponsorFijitFriendsDanceEars";
_partFrameLabels.facial["460"] = "sponsorSmurfsDVD";
_partFrameLabels.facial["461"] = "sponsorChipWrecked_pSailing";
_partFrameLabels.facial["462"] = "sponsorChipWrecked_tAlvin";
_partFrameLabels.facial["463"] = "sponsorChipWrecked_Alvin";
_partFrameLabels.facial["464"] = "sponsorChipWrecked_Brit";
_partFrameLabels.facial["465"] = "sponsorBen10_HumungosaurFace";
_partFrameLabels.facial["466"] = "pBully_bot";
_partFrameLabels.facial["467"] = "sponsorChipWrecked_Simon";
_partFrameLabels.facial["468"] = "sponsorChipWrecked_Jeanette";
_partFrameLabels.facial["469"] = "Gcloaked";
_partFrameLabels.facial["470"] = "Gcrone";
_partFrameLabels.facial["471"] = "Ginnk";
_partFrameLabels.facial["472"] = "Ginnkw";
_partFrameLabels.facial["473"] = "Glighthouse";
_partFrameLabels.facial["474"] = "GpromoDaphne";
_partFrameLabels.facial["475"] = "GpromoHunter";
_partFrameLabels.facial["477"] = "sponsorTreasureBuddies";
_partFrameLabels.facial["478"] = "SRhazmat";
_partFrameLabels.facial["479"] = "sponsor_Arrietty_Pod";
_partFrameLabels.facial["480"] = "sponsorBlueRanger";
_partFrameLabels.facial["481"] = "sponsorGoldRanger";
_partFrameLabels.facial["482"] = "sponsorRangersMooger";
_partFrameLabels.facial["483"] = "VCvillager1";
_partFrameLabels.facial["484"] = "sponsor_Lorax_Mustache";
_partFrameLabels.facial["485"] = "VCvillager3";
_partFrameLabels.facial["486"] = "sponsor_McGurk";
_partFrameLabels.facial["487"] = "sponsorMirrorMirror_Hat";
_partFrameLabels.facial["488"] = "sponsorDizzyDancersMandiPandee";
_partFrameLabels.facial["489"] = "sponsorDizzyDancersLulaBlu";
_partFrameLabels.facial["490"] = "VChunter";
_partFrameLabels.facial["491"] = "sponsor_DD_Penolopaw";
_partFrameLabels.facial["492"] = "sponsor_DD_Dragaloo";
_partFrameLabels.facial["493"] = "sponsorUltimateSpiderman_Mask";
_partFrameLabels.facial["494"] = "p_CountessVampire";
_partFrameLabels.facial["495"] = "p_CountVampire";
_partFrameLabels.facial["496"] = "sponsorChipWreckedDVD_Alvin";
_partFrameLabels.facial["497"] = "sponsorChipWreckedDVD_Brit";
_partFrameLabels.facial["498"] = "TT_elf1";
_partFrameLabels.facial["499"] = "TT_elf2";
_partFrameLabels.facial["500"] = "WLgoon";
_partFrameLabels.facial["501"] = "pLumberjerk";
_partFrameLabels.facial["502"] = "pLumberjerk_girl";
_partFrameLabels.facial["503"] = "pTroll";
_partFrameLabels.facial["504"] = "TT_goblin";
_partFrameLabels.facial["505"] = "sponsorThePirates_LizHat";
_partFrameLabels.facial["506"] = "sponsorThePirates_CapHat";
_partFrameLabels.facial["507"] = "Pie_Hat";
_partFrameLabels.facial["508"] = "Sponsor_AdventureTime_FakeFinnHead";
_partFrameLabels.marks["2"] = "shadow1";
_partFrameLabels.marks["3"] = "shadow2";
_partFrameLabels.marks["4"] = "shadowScar";
_partFrameLabels.marks["5"] = "beardShort1";
_partFrameLabels.marks["6"] = "beardShort2";
_partFrameLabels.marks["7"] = "beardShort3";
_partFrameLabels.marks["8"] = "beardShort4";
_partFrameLabels.marks["9"] = "beardMed1";
_partFrameLabels.marks["10"] = "beardMed2";
_partFrameLabels.marks["11"] = "beardMed3";
_partFrameLabels.marks["12"] = "beardMed4";
_partFrameLabels.marks["13"] = "beardLong";
_partFrameLabels.marks["14"] = "beardGreek";
_partFrameLabels.marks["15"] = "beardBand";
_partFrameLabels.marks["16"] = "beardHair";
_partFrameLabels.marks["17"] = "sideBurns";
_partFrameLabels.marks["18"] = "hairBurns";
_partFrameLabels.marks["19"] = "mustache1";
_partFrameLabels.marks["20"] = "mustache2";
_partFrameLabels.marks["21"] = "mustache3";
_partFrameLabels.marks["22"] = "goat1";
_partFrameLabels.marks["23"] = "goat2";
_partFrameLabels.marks["24"] = "goat3";
_partFrameLabels.marks["25"] = "goatScar";
_partFrameLabels.marks["26"] = "handlebar";
_partFrameLabels.marks["27"] = "goat4";
_partFrameLabels.marks["28"] = "goat5";
_partFrameLabels.marks["29"] = "goat6";
_partFrameLabels.marks["30"] = "goat7";
_partFrameLabels.marks["31"] = "goat8";
_partFrameLabels.marks["32"] = "laurels";
_partFrameLabels.marks["33"] = "goth";
_partFrameLabels.marks["34"] = "bangs1";
_partFrameLabels.marks["35"] = "bangs2";
_partFrameLabels.marks["36"] = "bangs3";
_partFrameLabels.marks["37"] = "bangs4";
_partFrameLabels.marks["38"] = "bangs5";
_partFrameLabels.marks["39"] = "sponsorTinkerbell";
_partFrameLabels.marks["40"] = "hillary";
_partFrameLabels.marks["41"] = "sherpa";
_partFrameLabels.marks["42"] = "beautymark";
_partFrameLabels.marks["43"] = "acne";
_partFrameLabels.marks["44"] = "wrinkles";
_partFrameLabels.marks["45"] = "bags";
_partFrameLabels.marks["46"] = "scar";
_partFrameLabels.marks["47"] = "fm1";
_partFrameLabels.marks["48"] = "fm2";
_partFrameLabels.marks["49"] = "fm3";
_partFrameLabels.marks["50"] = "fm4";
_partFrameLabels.marks["51"] = "fm5";
_partFrameLabels.marks["52"] = "fm6";
_partFrameLabels.marks["53"] = "fm7";
_partFrameLabels.marks["54"] = "fm8";
_partFrameLabels.marks["55"] = "fm9";
_partFrameLabels.marks["56"] = "fm10";
_partFrameLabels.marks["57"] = "africanPaint1";
_partFrameLabels.marks["58"] = "africanPaint2";
_partFrameLabels.marks["59"] = "scuffMarks";
_partFrameLabels.marks["60"] = "beardHippie";
_partFrameLabels.marks["61"] = "freckles";
_partFrameLabels.marks["62"] = "snootyGirl";
_partFrameLabels.marks["63"] = "grandma";
_partFrameLabels.marks["64"] = "grandpa";
_partFrameLabels.marks["65"] = "gothGirl";
_partFrameLabels.marks["66"] = "magician";
_partFrameLabels.marks["67"] = "FLpirate1";
_partFrameLabels.marks["68"] = "FLpirate3";
_partFrameLabels.marks["69"] = "sponsorSBdog";
_partFrameLabels.marks["70"] = "monkey";
_partFrameLabels.marks["71"] = "sheep";
_partFrameLabels.marks["72"] = "pGeisha1";
_partFrameLabels.marks["73"] = "pBall1";
_partFrameLabels.marks["74"] = "pPharaoh";
_partFrameLabels.marks["75"] = "pEgyptQ";
_partFrameLabels.marks["76"] = "pRockerGirl1";
_partFrameLabels.marks["77"] = "pRockerGirl2";
_partFrameLabels.marks["78"] = "pRockerGirl3";
_partFrameLabels.marks["79"] = "pRiding1";
_partFrameLabels.marks["80"] = "pMouse";
_partFrameLabels.marks["81"] = "pDog1";
_partFrameLabels.marks["82"] = "pDog2";
_partFrameLabels.marks["83"] = "pDog3";
_partFrameLabels.marks["84"] = "pPopGirl1";
_partFrameLabels.marks["85"] = "pFairy1";
_partFrameLabels.marks["86"] = "cyberJester";
_partFrameLabels.marks["87"] = "astroRoyal1";
_partFrameLabels.marks["88"] = "astroVill1";
_partFrameLabels.marks["89"] = "astroFarmer";
_partFrameLabels.marks["90"] = "astroPrincess";
_partFrameLabels.marks["91"] = "astroAlien";
_partFrameLabels.marks["92"] = "pSingerGuy1";
_partFrameLabels.marks["93"] = "pPirateGuy1";
_partFrameLabels.marks["94"] = "pPirateGirl1";
_partFrameLabels.marks["95"] = "pFries";
_partFrameLabels.marks["96"] = "pDrink";
_partFrameLabels.marks["97"] = "pBurger";
_partFrameLabels.marks["98"] = "pCone";
_partFrameLabels.marks["99"] = "pBaseball";
_partFrameLabels.marks["100"] = "medusa";
_partFrameLabels.marks["101"] = "pKarateGirl";
_partFrameLabels.marks["102"] = "pCheerleaderGoth";
_partFrameLabels.marks["103"] = "sponsorCWMB1";
_partFrameLabels.marks["104"] = "sponsorCWMB2";
_partFrameLabels.marks["105"] = "pClown1";
_partFrameLabels.marks["106"] = "pSheDevil";
_partFrameLabels.marks["107"] = "pDevil1";
_partFrameLabels.marks["108"] = "pAngelF";
_partFrameLabels.marks["109"] = "pPopGirlLE";
_partFrameLabels.marks["110"] = "pBiker1";
_partFrameLabels.marks["111"] = "frankenstein";
_partFrameLabels.marks["112"] = "vampire";
_partFrameLabels.marks["113"] = "vampire2";
_partFrameLabels.marks["114"] = "sponsorAstro1";
_partFrameLabels.marks["115"] = "sponsorAstro2";
_partFrameLabels.marks["116"] = "hyde";
_partFrameLabels.marks["117"] = "sponsorIceAge";
_partFrameLabels.marks["118"] = "pWolf1";
_partFrameLabels.marks["119"] = "pLagoon";
_partFrameLabels.marks["120"] = "pMunster";
_partFrameLabels.marks["121"] = "sponsorMinc2";
_partFrameLabels.marks["122"] = "fisherman2";
_partFrameLabels.marks["123"] = "blackWidow1";
_partFrameLabels.marks["124"] = "blackWidow2";
_partFrameLabels.marks["125"] = "shadyCop";
_partFrameLabels.marks["126"] = "tourGuide";
_partFrameLabels.marks["127"] = "mime";
_partFrameLabels.marks["128"] = "sponsorCWMBnoodle";
_partFrameLabels.marks["129"] = "sponsorCWMBcone";
_partFrameLabels.marks["130"] = "candyCane";
_partFrameLabels.marks["131"] = "buckyLucas";
_partFrameLabels.marks["132"] = "realityTeen";
_partFrameLabels.marks["133"] = "sponsorDitch";
_partFrameLabels.marks["134"] = "sponsorWilson";
_partFrameLabels.marks["135"] = "sponsorMonkeyBall";
_partFrameLabels.marks["136"] = "sponsorFLegypt1";
_partFrameLabels.marks["137"] = "sponsorFLegypt2";
_partFrameLabels.marks["138"] = "charon";
_partFrameLabels.marks["139"] = "aeolus";
_partFrameLabels.marks["140"] = "hades";
_partFrameLabels.marks["141"] = "poseidon";
_partFrameLabels.marks["142"] = "zeus";
_partFrameLabels.marks["143"] = "hercules";
_partFrameLabels.marks["144"] = "athena";
_partFrameLabels.marks["145"] = "aphrodite";
_partFrameLabels.marks["146"] = "dionysus";
_partFrameLabels.marks["147"] = "minotaur";
_partFrameLabels.marks["148"] = "mythPes1";
_partFrameLabels.marks["149"] = "mythPes6";
_partFrameLabels.marks["150"] = "mythTeen1";
_partFrameLabels.marks["151"] = "mythTeen2";
_partFrameLabels.marks["152"] = "satyr";
_partFrameLabels.marks["153"] = "pBigHeart1";
_partFrameLabels.marks["154"] = "pBigHeart2";
_partFrameLabels.marks["155"] = "pBigHeart3";
_partFrameLabels.marks["156"] = "sponsorTSBRbuzz";
_partFrameLabels.marks["157"] = "sponsorTSBRalien";
_partFrameLabels.marks["158"] = "pMagic1";
_partFrameLabels.marks["159"] = "pPunkGuy1";
_partFrameLabels.marks["160"] = "pPunkGirl1";
_partFrameLabels.marks["161"] = "pPunkGirl2";
_partFrameLabels.marks["162"] = "pPunkGirl3";
_partFrameLabels.marks["163"] = "pPunkGirl4";
_partFrameLabels.marks["164"] = "pPunkGirl5";
_partFrameLabels.marks["165"] = "medusa1";
_partFrameLabels.marks["166"] = "pFool";
_partFrameLabels.marks["167"] = "sponsorKoiFish";
_partFrameLabels.marks["168"] = "sponsorKoiFish_girl";
_partFrameLabels.marks["169"] = "captCrawfish";
_partFrameLabels.marks["170"] = "skullMainFarmer2";
_partFrameLabels.marks["171"] = "skullMainFarmer1";
_partFrameLabels.marks["172"] = "skullMainOldMan";
_partFrameLabels.marks["173"] = "skullPirate1";
_partFrameLabels.marks["174"] = "skullPirate6";
_partFrameLabels.marks["175"] = "skullPirate8";
_partFrameLabels.marks["176"] = "skullElegantLady";
_partFrameLabels.marks["177"] = "skullChinaGuy1";
_partFrameLabels.marks["178"] = "skullChinaGuy2";
_partFrameLabels.marks["179"] = "pSkullPirate1";
_partFrameLabels.marks["180"] = "sponsor_MH";
_partFrameLabels.marks["181"] = "pDaisy";
_partFrameLabels.marks["182"] = "pPromQueen1";
_partFrameLabels.marks["183"] = "sponsorAgnes";
_partFrameLabels.marks["184"] = "sponsorPercyZeus";
_partFrameLabels.marks["185"] = "pHotdog";
_partFrameLabels.marks["186"] = "pTofudog";
_partFrameLabels.marks["187"] = "sponsor_SelenaG";
_partFrameLabels.marks["188"] = "sponsorDOWKwrest";
_partFrameLabels.marks["189"] = "pVampire_boy";
_partFrameLabels.marks["190"] = "pVampire_girl";
_partFrameLabels.marks["191"] = "sponsorTinkerbell3";
_partFrameLabels.marks["192"] = "sponsorNannyMcPhee";
_partFrameLabels.marks["193"] = "sponsorAlphaOmegaM";
_partFrameLabels.marks["194"] = "sponsor_FLWitchDoctor";
_partFrameLabels.marks["195"] = "sponsor_MrHan";
_partFrameLabels.marks["196"] = "sponsor_BarbieVampire";
_partFrameLabels.marks["197"] = "sponsor_BarbieBee";
_partFrameLabels.marks["198"] = "sponsorCDdog";
_partFrameLabels.marks["199"] = "sponsorBarbieGGdog2";
_partFrameLabels.marks["200"] = "sponsorBarbieGGdog3";
_partFrameLabels.marks["201"] = "sponsorBarbieGGdog4";
_partFrameLabels.marks["202"] = "sponsorBarbieGGgirl";
_partFrameLabels.marks["203"] = "promo_Nessie";
_partFrameLabels.marks["204"] = "scottishMan";
_partFrameLabels.marks["205"] = "rowBoatMan";
_partFrameLabels.marks["206"] = "SubGuide";
_partFrameLabels.marks["207"] = "sponsorBarbieGGgirl2";
_partFrameLabels.marks["208"] = "pBigFoot";
_partFrameLabels.marks["209"] = "snootyDog";
_partFrameLabels.marks["210"] = "haroldMews";
_partFrameLabels.marks["211"] = "gretchen";
_partFrameLabels.marks["212"] = "gardener";
_partFrameLabels.marks["213"] = "MaintenanceMan";
_partFrameLabels.marks["214"] = "snootyLady";
_partFrameLabels.marks["215"] = "HunterGiveUp";
_partFrameLabels.marks["216"] = "barPatron1";
_partFrameLabels.marks["217"] = "PuertoRicoFarmer2";
_partFrameLabels.marks["218"] = "oldSherpa";
_partFrameLabels.marks["219"] = "youngSherpa";
_partFrameLabels.marks["220"] = "sideburns2";
_partFrameLabels.marks["221"] = "tyson";
_partFrameLabels.marks["222"] = "townie3";
_partFrameLabels.marks["223"] = "townie4";
_partFrameLabels.marks["224"] = "townie8";
_partFrameLabels.marks["225"] = "townie9";
_partFrameLabels.marks["226"] = "pHoildayBall_red";
_partFrameLabels.marks["227"] = "pHollidayBall_green";
_partFrameLabels.marks["228"] = "pHollidayBall_blue";
_partFrameLabels.marks["229"] = "wwSaloonGirl";
_partFrameLabels.marks["230"] = "wwCasinoPatron2";
_partFrameLabels.marks["231"] = "wwPrettyWoman";
_partFrameLabels.marks["232"] = "wwGeneicLady";
_partFrameLabels.marks["233"] = "pDisco_Queen";
_partFrameLabels.marks["234"] = "sponsorFrootLoopsBowl";
_partFrameLabels.marks["235"] = "sponsorGnomeo";
_partFrameLabels.marks["236"] = "wwRJEarl";
_partFrameLabels.marks["237"] = "wwMarshal";
_partFrameLabels.marks["238"] = "wwRuby";
_partFrameLabels.marks["239"] = "wwGSEvil";
_partFrameLabels.marks["240"] = "wwPhoto";
_partFrameLabels.marks["241"] = "wwBanker";
_partFrameLabels.marks["242"] = "wwDeputy";
_partFrameLabels.marks["243"] = "wwSlouch01";
_partFrameLabels.marks["244"] = "wwRough";
_partFrameLabels.marks["245"] = "sponsorHOPears";
_partFrameLabels.marks["246"] = "sponsorHOPsuit";
_partFrameLabels.marks["247"] = "pOutlaw_boys";
_partFrameLabels.marks["248"] = "pOutlaw_girls";
_partFrameLabels.marks["249"] = "pLawman";
_partFrameLabels.marks["250"] = "pPeacekeeper";
_partFrameLabels.marks["251"] = "MTHscaredSumo";
_partFrameLabels.marks["252"] = "MTHbonsaiWoman";
_partFrameLabels.marks["253"] = "MTHshogunCasual";
_partFrameLabels.marks["254"] = "MTHbasho";
_partFrameLabels.marks["255"] = "pMTHsumo1";
_partFrameLabels.marks["256"] = "pMTHsumo2";
_partFrameLabels.marks["257"] = "pMTHsumo3";
_partFrameLabels.marks["258"] = "pMTHsumo4";
_partFrameLabels.marks["259"] = "MTHprisoner";
_partFrameLabels.marks["260"] = "MTHfanDancer";
_partFrameLabels.marks["261"] = "MTHFemWar";
_partFrameLabels.marks["262"] = "sponsorPopCorn";
_partFrameLabels.marks["263"] = "TcarlJrStar";
_partFrameLabels.marks["264"] = "TcamoGuy";
_partFrameLabels.marks["265"] = "TshrkSfr";
_partFrameLabels.marks["266"] = "SRmom";
_partFrameLabels.marks["267"] = "SRstudent04";
_partFrameLabels.marks["268"] = "pBeachBall";
_partFrameLabels.marks["269"] = "pBeachBall2";
_partFrameLabels.marks["270"] = "pBeachBall3";
_partFrameLabels.marks["271"] = "mtCleveland";
_partFrameLabels.marks["272"] = "mtCoalMan";
_partFrameLabels.marks["273"] = "mtPromo_SlowChef";
_partFrameLabels.marks["274"] = "mtChefFast";
_partFrameLabels.marks["275"] = "mtDancer";
_partFrameLabels.marks["276"] = "sponsor_JE";
_partFrameLabels.marks["277"] = "GSgiftShop";
_partFrameLabels.marks["278"] = "Zombie";
_partFrameLabels.marks["279"] = "sponsorArthurChristmas";
_partFrameLabels.marks["280"] = "sponsorChipWrecked_Alvin";
_partFrameLabels.marks["281"] = "sponsorChipWrecked_Brit";
_partFrameLabels.marks["282"] = "sponsorBen10_AgentSixHair";
_partFrameLabels.marks["283"] = "SRishmael";
_partFrameLabels.marks["284"] = "SRboomer";
_partFrameLabels.marks["285"] = "SRflask";
_partFrameLabels.marks["286"] = "SRstubb";
_partFrameLabels.marks["287"] = "sponsorMonsterHigh1600_bangs";
_partFrameLabels.marks["288"] = "VCdracula";
_partFrameLabels.marks["289"] = "VCdraculaOld";
_partFrameLabels.marks["290"] = "VCkatyasMom";
_partFrameLabels.marks["291"] = "VCkatya";
_partFrameLabels.marks["292"] = "VCchris";
_partFrameLabels.marks["293"] = "p_seaCaptain";
_partFrameLabels.marks["294"] = "sponsorDizzyDancersMandiPandee";
_partFrameLabels.marks["295"] = "sponsorDizzyDancersLulaBlu";
_partFrameLabels.marks["296"] = "VChunter";
_partFrameLabels.marks["297"] = "sponsor_DD_Penolopaw";
_partFrameLabels.marks["298"] = "sponsor_DD_Dragaloo";
_partFrameLabels.marks["299"] = "p_CountVampire";
_partFrameLabels.marks["300"] = "sponsorChipWreckedDVD_Alvin";
_partFrameLabels.marks["301"] = "TT_elf1";
_partFrameLabels.marks["302"] = "TT_elf2";
_partFrameLabels.marks["303"] = "TT_elfQueen";
_partFrameLabels.marks["304"] = "pTroll";
_partFrameLabels.marks["305"] = "sponsor_lilly";
_partFrameLabels.marks["306"] = "p_waffle_girl";
_partFrameLabels.marks["307"] = "p_waffle_boy";
_partFrameLabels.item["2"] = "glowStick";
_partFrameLabels.item["3"] = "brush";
_partFrameLabels.item["4"] = "bigSword";
_partFrameLabels.item["5"] = "basketball";
_partFrameLabels.item["6"] = "cellphone";
_partFrameLabels.item["7"] = "football";
_partFrameLabels.item["8"] = "racket";
_partFrameLabels.item["9"] = "guitar";
_partFrameLabels.item["10"] = "skater";
_partFrameLabels.item["11"] = "fish";
_partFrameLabels.item["12"] = "spear";
_partFrameLabels.item["13"] = "voodoo";
_partFrameLabels.item["14"] = "oldExplorer";
_partFrameLabels.item["15"] = "fisherman";
_partFrameLabels.item["16"] = "distressedMom";
_partFrameLabels.item["17"] = "aztecClub";
_partFrameLabels.item["18"] = "aztecSpear";
_partFrameLabels.item["19"] = "corn";
_partFrameLabels.item["20"] = "aztecStaff";
_partFrameLabels.item["21"] = "mallet";
_partFrameLabels.item["22"] = "chineseShovel";
_partFrameLabels.item["23"] = "scroll";
_partFrameLabels.item["24"] = "greekSpear";
_partFrameLabels.item["25"] = "oracle";
_partFrameLabels.item["26"] = "staff";
_partFrameLabels.item["27"] = "vikingAxe";
_partFrameLabels.item["28"] = "vikingSpear";
_partFrameLabels.item["29"] = "cane";
_partFrameLabels.item["30"] = "lewisRifle";
_partFrameLabels.item["31"] = "clarkTelescope";
_partFrameLabels.item["32"] = "icepick";
_partFrameLabels.item["33"] = "spansword";
_partFrameLabels.item["34"] = "aztecMask";
_partFrameLabels.item["35"] = "bag";
_partFrameLabels.item["36"] = "torch";
_partFrameLabels.item["37"] = "referee";
_partFrameLabels.item["38"] = "glass";
_partFrameLabels.item["39"] = "spatula";
_partFrameLabels.item["40"] = "pitchfork";
_partFrameLabels.item["41"] = "screwdriver";
_partFrameLabels.item["42"] = "pitcher";
_partFrameLabels.item["43"] = "trainGlass";
_partFrameLabels.item["44"] = "clipboard";
_partFrameLabels.item["45"] = "scissors";
_partFrameLabels.item["46"] = "tongs";
_partFrameLabels.item["47"] = "tnt";
_partFrameLabels.item["48"] = "pretzel";
_partFrameLabels.item["49"] = "moneybag";
_partFrameLabels.item["50"] = "hotdog";
_partFrameLabels.item["51"] = "handcuffs";
_partFrameLabels.item["52"] = "grenade";
_partFrameLabels.item["53"] = "canister";
_partFrameLabels.item["54"] = "chalice";
_partFrameLabels.item["55"] = "pointer";
_partFrameLabels.item["56"] = "wineglass";
_partFrameLabels.item["57"] = "sponsorLego";
_partFrameLabels.item["58"] = "africanDrum";
_partFrameLabels.item["59"] = "swaziShield";
_partFrameLabels.item["60"] = "swaziWeapon";
_partFrameLabels.item["61"] = "zuluSpear";
_partFrameLabels.item["62"] = "africanSpear";
_partFrameLabels.item["63"] = "shepherdStaff";
_partFrameLabels.item["64"] = "shovel";
_partFrameLabels.item["65"] = "wrench";
_partFrameLabels.item["66"] = "pick";
_partFrameLabels.item["67"] = "sponsorTinkerbell";
_partFrameLabels.item["68"] = "broom1";
_partFrameLabels.item["69"] = "plunger";
_partFrameLabels.item["70"] = "candyCane";
_partFrameLabels.item["71"] = "FLpirate2";
_partFrameLabels.item["72"] = "cracker";
_partFrameLabels.item["73"] = "banana";
_partFrameLabels.item["74"] = "sponsorPW2";
_partFrameLabels.item["75"] = "pLion";
_partFrameLabels.item["76"] = "pBall1";
_partFrameLabels.item["77"] = "pKnight1";
_partFrameLabels.item["78"] = "pGeisha1";
_partFrameLabels.item["79"] = "pRobot";
_partFrameLabels.item["80"] = "pRobot1b";
_partFrameLabels.item["81"] = "pPharaoh";
_partFrameLabels.item["82"] = "pEgyptQ";
_partFrameLabels.item["83"] = "pZorro";
_partFrameLabels.item["84"] = "pSamurai";
_partFrameLabels.item["85"] = "pRockerGuy1";
_partFrameLabels.item["86"] = "pRockerGuy2";
_partFrameLabels.item["87"] = "pRockerGuy3";
_partFrameLabels.item["88"] = "pRockerGirl1";
_partFrameLabels.item["89"] = "pRockerGirl2";
_partFrameLabels.item["90"] = "pRockerGirl3";
_partFrameLabels.item["91"] = "pRiding1";
_partFrameLabels.item["92"] = "pRiding2";
_partFrameLabels.item["93"] = "pRiding3";
_partFrameLabels.item["94"] = "pMouse";
_partFrameLabels.item["95"] = "pDog1";
_partFrameLabels.item["96"] = "pPopGirl1";
_partFrameLabels.item["97"] = "pNinja1";
_partFrameLabels.item["98"] = "pRobinhood1";
_partFrameLabels.item["99"] = "pFairy1";
_partFrameLabels.item["100"] = "sponsorPinoFairy";
_partFrameLabels.item["101"] = "sponsorPinoPino";
_partFrameLabels.item["102"] = "lute";
_partFrameLabels.item["103"] = "septre";
_partFrameLabels.item["104"] = "feather";
_partFrameLabels.item["105"] = "axe";
_partFrameLabels.item["106"] = "manureShovel";
_partFrameLabels.item["107"] = "oldBook";
_partFrameLabels.item["108"] = "pPirateSword";
_partFrameLabels.item["109"] = "pBat";
_partFrameLabels.item["110"] = "pBaseball";
_partFrameLabels.item["111"] = "pRevolver";
_partFrameLabels.item["112"] = "pRobot2";
_partFrameLabels.item["113"] = "pRobot3";
_partFrameLabels.item["114"] = "pRobot4";
_partFrameLabels.item["115"] = "pRobot5";
_partFrameLabels.item["116"] = "pBowStaff";
_partFrameLabels.item["117"] = "pPomPom";
_partFrameLabels.item["118"] = "pPomPom2";
_partFrameLabels.item["119"] = "sponsorWizWand1";
_partFrameLabels.item["120"] = "sponsorWizWand2";
_partFrameLabels.item["121"] = "sponsorWizWand3";
_partFrameLabels.item["122"] = "sponsorWizWand4";
_partFrameLabels.item["123"] = "sponsorBedB1";
_partFrameLabels.item["124"] = "sponsorCWMB2";
_partFrameLabels.item["125"] = "flowerpower";
_partFrameLabels.item["126"] = "pFirefighter1";
_partFrameLabels.item["127"] = "pClown1";
_partFrameLabels.item["128"] = "pNinjaLE";
_partFrameLabels.item["129"] = "pDevil";
_partFrameLabels.item["130"] = "pHarp";
_partFrameLabels.item["131"] = "sponsorLegoBio";
_partFrameLabels.item["132"] = "timeFreezer";
_partFrameLabels.item["133"] = "grimReaper";
_partFrameLabels.item["134"] = "broom2";
_partFrameLabels.item["135"] = "pumpkin";
_partFrameLabels.item["136"] = "sponsorTinkerbell4";
_partFrameLabels.item["137"] = "sponsorFuel";
_partFrameLabels.item["138"] = "sponsorIceAge";
_partFrameLabels.item["139"] = "sillyString";
_partFrameLabels.item["140"] = "sponsorNM2guard";
_partFrameLabels.item["141"] = "sponsorPFxmas";
_partFrameLabels.item["142"] = "pTigerShark";
_partFrameLabels.item["143"] = "sponsorSpyNext";
_partFrameLabels.item["144"] = "papaPetes";
_partFrameLabels.item["145"] = "tabloid";
_partFrameLabels.item["146"] = "sponsorMonkeyBall";
_partFrameLabels.item["147"] = "sponsorFLegypt1";
_partFrameLabels.item["148"] = "sponsorFLegypt2";
_partFrameLabels.item["149"] = "charon";
_partFrameLabels.item["150"] = "hades";
_partFrameLabels.item["151"] = "poseidon";
_partFrameLabels.item["152"] = "zeus";
_partFrameLabels.item["153"] = "athena";
_partFrameLabels.item["154"] = "aphroMirror";
_partFrameLabels.item["155"] = "minotaur";
_partFrameLabels.item["156"] = "triton";
_partFrameLabels.item["157"] = "mythBucket";
_partFrameLabels.item["158"] = "satyr";
_partFrameLabels.item["159"] = "pMagic1";
_partFrameLabels.item["160"] = "pPunkGuy1";
_partFrameLabels.item["161"] = "pPunkGuy2";
_partFrameLabels.item["162"] = "pPunkGuy3";
_partFrameLabels.item["163"] = "pPunkGuy4";
_partFrameLabels.item["164"] = "pPunkGuy5";
_partFrameLabels.item["165"] = "pPunkGirl1";
_partFrameLabels.item["166"] = "pPunkGirl2";
_partFrameLabels.item["167"] = "pPunkGirl3";
_partFrameLabels.item["168"] = "pPunkGirl4";
_partFrameLabels.item["169"] = "pPunkGirl5";
_partFrameLabels.item["170"] = "pDrHare_Scientist";
_partFrameLabels.item["171"] = "pLightningStaff";
_partFrameLabels.item["172"] = "pEarthKnight";
_partFrameLabels.item["173"] = "pGirlKnight";
_partFrameLabels.item["174"] = "pDarkKnight_boy";
_partFrameLabels.item["175"] = "pDarkKnight_girl";
_partFrameLabels.item["176"] = "pFool";
_partFrameLabels.item["177"] = "skullMainGuard1";
_partFrameLabels.item["178"] = "pFrootBowl";
_partFrameLabels.item["179"] = "captCrawfish";
_partFrameLabels.item["180"] = "basket";
_partFrameLabels.item["181"] = "colonialRake";
_partFrameLabels.item["182"] = "pirateSword2";
_partFrameLabels.item["183"] = "quill";
_partFrameLabels.item["184"] = "skullMoroGuy3";
_partFrameLabels.item["185"] = "fishing2";
_partFrameLabels.item["186"] = "hay";
_partFrameLabels.item["187"] = "skullMallet";
_partFrameLabels.item["188"] = "pSkullPirate1";
_partFrameLabels.item["189"] = "brokenMirror";
_partFrameLabels.item["190"] = "pPromKing1a";
_partFrameLabels.item["191"] = "pPromKing1b";
_partFrameLabels.item["192"] = "pPromKing1c";
_partFrameLabels.item["193"] = "pPromKing1d";
_partFrameLabels.item["194"] = "sponsorShrinkRay";
_partFrameLabels.item["195"] = "ShrinkRayGame";
_partFrameLabels.item["196"] = "sponsorPercyZeus";
_partFrameLabels.item["197"] = "pMythSurferZeus";
_partFrameLabels.item["198"] = "pMythSurferHades";
_partFrameLabels.item["199"] = "pMythSurferPose";
_partFrameLabels.item["200"] = "pSoccerball";
_partFrameLabels.item["201"] = "sponsor_Ramona";
_partFrameLabels.item["202"] = "sponsorMagicBrush";
_partFrameLabels.item["203"] = "sponsorCatsAndDogs2Hologram";
_partFrameLabels.item["204"] = "pAtomGlowStick";
_partFrameLabels.item["205"] = "pRocket";
_partFrameLabels.item["206"] = "pHammerShark";
_partFrameLabels.item["207"] = "pNerdBoy";
_partFrameLabels.item["208"] = "pNerdGirl";
_partFrameLabels.item["209"] = "sponsorNannyMcPhee";
_partFrameLabels.item["210"] = "sponsor_MayanWarrior";
_partFrameLabels.item["211"] = "sponsorKarateKid";
_partFrameLabels.item["212"] = "sponsor_KarateKid";
_partFrameLabels.item["213"] = "Birthday_3";
_partFrameLabels.item["214"] = "sponsor_BarbieCat";
_partFrameLabels.item["215"] = "sponsorLegoHero";
_partFrameLabels.item["216"] = "sponsorFLPharoah_b";
_partFrameLabels.item["217"] = "sponsorFLPharoah_g";
_partFrameLabels.item["218"] = "sponsorBarbieGGdog";
_partFrameLabels.item["219"] = "Nessie_tourist1";
_partFrameLabels.item["220"] = "cryptidLantern";
_partFrameLabels.item["221"] = "cryptidLantern2";
_partFrameLabels.item["222"] = "Nessie_tourist3";
_partFrameLabels.item["223"] = "gardener";
_partFrameLabels.item["224"] = "maintenanceMan";
_partFrameLabels.item["225"] = "dart";
_partFrameLabels.item["226"] = "youngSherpa";
_partFrameLabels.item["227"] = "fryingPan";
_partFrameLabels.item["228"] = "gretchenGun";
_partFrameLabels.item["229"] = "fan2";
_partFrameLabels.item["230"] = "pDisco_Dance";
_partFrameLabels.item["231"] = "sponsorRedRanger";
_partFrameLabels.item["232"] = "sponsorYellowRanger";
_partFrameLabels.item["233"] = "promoWWmemOnly";
_partFrameLabels.item["234"] = "sponsorGnome";
_partFrameLabels.item["235"] = "spuderbuss";
_partFrameLabels.item["236"] = "wwFrontGun";
_partFrameLabels.item["237"] = "wwPeaShooter";
_partFrameLabels.item["238"] = "wwSpudGun";
_partFrameLabels.item["239"] = "wwWhistle";
_partFrameLabels.item["240"] = "wwAnnie";
_partFrameLabels.item["241"] = "Snake_lasso";
_partFrameLabels.item["242"] = "sponsorMarsNeedsMoms";
_partFrameLabels.item["243"] = "sponserHOPtrophy";
_partFrameLabels.item["244"] = "sponsorHOPcandy";
_partFrameLabels.item["245"] = "pOutlaw_boys";
_partFrameLabels.item["246"] = "pLawman";
_partFrameLabels.item["247"] = "ninjaStaff";
_partFrameLabels.item["248"] = "ninjaStar";
_partFrameLabels.item["249"] = "ninjaBomb";
_partFrameLabels.item["250"] = "bonsaiShear";
_partFrameLabels.item["251"] = "fishing3";
_partFrameLabels.item["252"] = "shogunBaton";
_partFrameLabels.item["253"] = "sumoFan";
_partFrameLabels.item["254"] = "katana2";
_partFrameLabels.item["255"] = "bambooCane";
_partFrameLabels.item["256"] = "sai";
_partFrameLabels.item["257"] = "naginata";
_partFrameLabels.item["258"] = "samuraiSpear";
_partFrameLabels.item["259"] = "wandOfDianthus";
_partFrameLabels.item["260"] = "sponsorLooneyTunesShow";
_partFrameLabels.item["261"] = "MTHfanDancer";
_partFrameLabels.item["262"] = "sponsorLemonadeMouth";
_partFrameLabels.item["263"] = "MTHfemWar";
_partFrameLabels.item["264"] = "bonsai1";
_partFrameLabels.item["265"] = "bonsai2";
_partFrameLabels.item["266"] = "bonsai3";
_partFrameLabels.item["267"] = "sponsorGnomeoBluRay";
_partFrameLabels.item["268"] = "sponsorStuffedCat";
_partFrameLabels.item["269"] = "sponsorRingLeader";
_partFrameLabels.item["270"] = "MTHhoe";
_partFrameLabels.item["271"] = "MTHbasket";
_partFrameLabels.item["272"] = "TplungerGun";
_partFrameLabels.item["273"] = "TgreenRope";
_partFrameLabels.item["274"] = "TiceSHstaff";
_partFrameLabels.item["275"] = "TiceSHshield";
_partFrameLabels.item["276"] = "TshrkSfr";
_partFrameLabels.item["277"] = "TlzrLance";
_partFrameLabels.item["278"] = "Tcarrot";
_partFrameLabels.item["279"] = "TshrkByPlush";
_partFrameLabels.item["280"] = "TcoolByPlush";
_partFrameLabels.item["281"] = "TdrHarePlush";
_partFrameLabels.item["282"] = "pSwish01";
_partFrameLabels.item["283"] = "pTossFish";
_partFrameLabels.item["284"] = "TguitarV";
_partFrameLabels.item["285"] = "TguitarR";
_partFrameLabels.item["286"] = "TguitarW";
_partFrameLabels.item["287"] = "Sponsor_PoppersPenguins";
_partFrameLabels.item["288"] = "sponsorToiletPaper";
_partFrameLabels.item["289"] = "sponsorMrPoppers";
_partFrameLabels.item["290"] = "pBeachBall";
_partFrameLabels.item["291"] = "pSodaBottle";
_partFrameLabels.item["292"] = "sponsorFijitFriend";
_partFrameLabels.item["293"] = "Tninja01";
_partFrameLabels.item["294"] = "Tsamuri01";
_partFrameLabels.item["295"] = "Tpeppergun";
_partFrameLabels.item["296"] = "Tpepper";
_partFrameLabels.item["297"] = "TbardStaff";
_partFrameLabels.item["298"] = "noteBook";
_partFrameLabels.item["299"] = "notepadPaper";
_partFrameLabels.item["300"] = "briefcase01";
_partFrameLabels.item["301"] = "caneDiamond";
_partFrameLabels.item["302"] = "briefcase02";
_partFrameLabels.item["303"] = "mtTeslaCoilReward";
_partFrameLabels.item["304"] = "mtEdisonBulbReward";
_partFrameLabels.item["305"] = "pSwish02";
_partFrameLabels.item["306"] = "mtPoliceman";
_partFrameLabels.item["307"] = "photdogShooter1";
_partFrameLabels.item["308"] = "pHotdogShooter2";
_partFrameLabels.item["309"] = "pHotDogShooter3";
_partFrameLabels.item["310"] = "pHotdogShooter4";
_partFrameLabels.item["311"] = "mtFeeder";
_partFrameLabels.item["312"] = "TemeraldHammer";
_partFrameLabels.item["313"] = "TfireSword";
_partFrameLabels.item["314"] = "TiceSword";
_partFrameLabels.item["315"] = "pSherlock";
_partFrameLabels.item["316"] = "sponsorHasbroFGN";
_partFrameLabels.item["317"] = "pPopCake";
_partFrameLabels.item["318"] = "sponsorLionKing";
_partFrameLabels.item["319"] = "sponsor_carnivalCane";
_partFrameLabels.item["320"] = "sponsor_JudyBall";
_partFrameLabels.item["321"] = "peanut";
_partFrameLabels.item["322"] = "fries";
_partFrameLabels.item["323"] = "GSumbrella";
_partFrameLabels.item["324"] = "oilTray";
_partFrameLabels.item["325"] = "handFan";
_partFrameLabels.item["326"] = "sponsor_laserPen";
_partFrameLabels.item["327"] = "sponsor_laserLipstick";
_partFrameLabels.item["328"] = "sponsorPussInBoots_Beans";
_partFrameLabels.item["329"] = "robotDance";
_partFrameLabels.item["330"] = "promo_PopGuide_bk";
_partFrameLabels.item["331"] = "GSelectricFan";
_partFrameLabels.item["332"] = "pearsonFlashlight";
_partFrameLabels.item["333"] = "sponsorMakeYourMark";
_partFrameLabels.item["334"] = "sponsorJackAndJill";
_partFrameLabels.item["335"] = "sponsor_wimpybook";
_partFrameLabels.item["336"] = "sponsorArthurChristmas";
_partFrameLabels.item["337"] = "sponsorChipWrecked_Torch";
_partFrameLabels.item["338"] = "sponsorChipWrecked_Basket";
_partFrameLabels.item["339"] = "rose";
_partFrameLabels.item["340"] = "pamphlets";
_partFrameLabels.item["341"] = "cane02";
_partFrameLabels.item["342"] = "newspaperRolled";
_partFrameLabels.item["343"] = "newspaperFlat";
_partFrameLabels.item["344"] = "saltShaker";
_partFrameLabels.item["345"] = "sponsorChipwrecked_AlvinPow";
_partFrameLabels.item["346"] = "Gpromo_net";
_partFrameLabels.item["347"] = "GhostTorch";
_partFrameLabels.item["348"] = "spatulla";
_partFrameLabels.item["349"] = "microphone";
_partFrameLabels.item["350"] = "dollars";
_partFrameLabels.item["351"] = "p_Candy_Cane-on";
_partFrameLabels.item["352"] = "sponsorMonsterHigh1600_umb";
_partFrameLabels.item["353"] = "SRhazmat";
_partFrameLabels.item["354"] = "sponsor_Arrietty_Pod";
_partFrameLabels.item["355"] = "sponsor_Arrietty";
_partFrameLabels.item["356"] = "sponsorRangerBlaster";
_partFrameLabels.item["357"] = "sponsorRedRangerSuperSword";
_partFrameLabels.item["358"] = "sponsor_GoldfishActiveQuest2";
_partFrameLabels.item["359"] = "sponsor_TruffulaSeed";
_partFrameLabels.item["360"] = "sponsor_DiscoTreeSeed";
_partFrameLabels.item["361"] = "p_fishingPole";
_partFrameLabels.item["362"] = "VCcrossbow";
_partFrameLabels.item["363"] = "VCstick";
_partFrameLabels.item["364"] = "sponsorMirrorMirror_stick";
_partFrameLabels.item["365"] = "sponsorMirrorMirror_mirror";
_partFrameLabels.item["366"] = "cannonball";
_partFrameLabels.item["367"] = "VCpoker";
_partFrameLabels.item["368"] = "sponsorDizzyDancersSpinPower";
_partFrameLabels.item["369"] = "vampirePromoGarlicBreath";
_partFrameLabels.item["370"] = "sponsorUltimateSpiderMan_Power";
_partFrameLabels.item["371"] = "sponsorSpiderman";
_partFrameLabels.item["372"] = "sponsorChipWrecked_SmokeStick";
_partFrameLabels.item["373"] = "TT_elfKnife";
_partFrameLabels.item["374"] = "TT_elfSpear";
_partFrameLabels.item["375"] = "TT_dev";
_partFrameLabels.item["376"] = "pipeWrench";
_partFrameLabels.item["377"] = "2axe";
_partFrameLabels.item["378"] = "chainSaw";
_partFrameLabels.item["379"] = "pLumberjerk";
_partFrameLabels.item["380"] = "sponsorThePirates_LizSword";
_partFrameLabels.item["381"] = "sponsorPollyPocketSplashPower";
_partFrameLabels.item["382"] = "sponsor_PollyPocket";
_partFrameLabels.pack["5"] = "jet";
_partFrameLabels.pack["6"] = "explorer";
_partFrameLabels.pack["7"] = "shark";
_partFrameLabels.pack["8"] = "sticks";
_partFrameLabels.pack["9"] = "aztecCape";
_partFrameLabels.pack["10"] = "greekWarrior";
_partFrameLabels.pack["11"] = "viking3";
_partFrameLabels.pack["12"] = "viking2";
_partFrameLabels.pack["13"] = "sacagawea";
_partFrameLabels.pack["14"] = "york";
_partFrameLabels.pack["15"] = "batman";
_partFrameLabels.pack["16"] = "hillary";
_partFrameLabels.pack["17"] = "sherpa";
_partFrameLabels.pack["18"] = "sponsorSpace";
_partFrameLabels.pack["19"] = "glider";
_partFrameLabels.pack["20"] = "drHare";
_partFrameLabels.pack["21"] = "radioactive";
_partFrameLabels.pack["22"] = "hero1";
_partFrameLabels.pack["23"] = "hero2";
_partFrameLabels.pack["24"] = "hero3";
_partFrameLabels.pack["25"] = "hero4";
_partFrameLabels.pack["26"] = "hero5";
_partFrameLabels.pack["27"] = "hero6";
_partFrameLabels.pack["28"] = "hero7";
_partFrameLabels.pack["29"] = "cat";
_partFrameLabels.pack["30"] = "fm1";
_partFrameLabels.pack["31"] = "fm2";
_partFrameLabels.pack["32"] = "fm3";
_partFrameLabels.pack["33"] = "fm4";
_partFrameLabels.pack["34"] = "fm5";
_partFrameLabels.pack["35"] = "fm6";
_partFrameLabels.pack["36"] = "fm7";
_partFrameLabels.pack["37"] = "fm8";
_partFrameLabels.pack["38"] = "dog";
_partFrameLabels.pack["39"] = "sponsorTinkerbell";
_partFrameLabels.pack["40"] = "vampire";
_partFrameLabels.pack["41"] = "magician";
_partFrameLabels.pack["42"] = "witch";
_partFrameLabels.pack["43"] = "hiker";
_partFrameLabels.pack["44"] = "geisha";
_partFrameLabels.pack["45"] = "scuba2";
_partFrameLabels.pack["46"] = "sponsorSBdog";
_partFrameLabels.pack["47"] = "sponsorSBsuit";
_partFrameLabels.pack["48"] = "monkey";
_partFrameLabels.pack["49"] = "pKnight1";
_partFrameLabels.pack["50"] = "pKnight2";
_partFrameLabels.pack["51"] = "pKnight3";
_partFrameLabels.pack["52"] = "pLion";
_partFrameLabels.pack["53"] = "pGeisha1";
_partFrameLabels.pack["54"] = "pRooster1";
_partFrameLabels.pack["55"] = "pRooster2";
_partFrameLabels.pack["56"] = "pRooster3";
_partFrameLabels.pack["57"] = "pBall1";
_partFrameLabels.pack["58"] = "pBall2";
_partFrameLabels.pack["59"] = "pBall3";
_partFrameLabels.pack["60"] = "pRobot";
_partFrameLabels.pack["61"] = "pRobot1b";
_partFrameLabels.pack["62"] = "pPharaoh";
_partFrameLabels.pack["63"] = "pEgyptQ";
_partFrameLabels.pack["64"] = "pZorro";
_partFrameLabels.pack["65"] = "pSamurai";
_partFrameLabels.pack["66"] = "pDragon1";
_partFrameLabels.pack["67"] = "pDragon2";
_partFrameLabels.pack["68"] = "pDragon3";
_partFrameLabels.pack["69"] = "pMouse";
_partFrameLabels.pack["70"] = "pDog1";
_partFrameLabels.pack["71"] = "pDog2";
_partFrameLabels.pack["72"] = "pDog3";
_partFrameLabels.pack["73"] = "pNinja1";
_partFrameLabels.pack["74"] = "pRobinhood1";
_partFrameLabels.pack["75"] = "pFairy1";
_partFrameLabels.pack["76"] = "sponsorPinoFairy";
_partFrameLabels.pack["77"] = "astroChance";
_partFrameLabels.pack["78"] = "redKnight";
_partFrameLabels.pack["79"] = "blueKnight";
_partFrameLabels.pack["80"] = "greenKnight";
_partFrameLabels.pack["81"] = "astroRoyal1";
_partFrameLabels.pack["82"] = "astroKing";
_partFrameLabels.pack["83"] = "hay";
_partFrameLabels.pack["84"] = "astroVill4";
_partFrameLabels.pack["85"] = "pRobot2";
_partFrameLabels.pack["86"] = "pRobot3";
_partFrameLabels.pack["87"] = "pRobot4";
_partFrameLabels.pack["88"] = "pRobot5";
_partFrameLabels.pack["89"] = "pAstronaut1";
_partFrameLabels.pack["90"] = "pFirefighter1";
_partFrameLabels.pack["91"] = "pNinjaLE";
_partFrameLabels.pack["92"] = "pSheDevil";
_partFrameLabels.pack["93"] = "pDevil1";
_partFrameLabels.pack["94"] = "pAngelWings";
_partFrameLabels.pack["95"] = "sponsorLegoBio";
_partFrameLabels.pack["96"] = "pDareD1";
_partFrameLabels.pack["97"] = "grimReaper";
_partFrameLabels.pack["98"] = "frankBride";
_partFrameLabels.pack["99"] = "pWolf1";
_partFrameLabels.pack["100"] = "pLagoon";
_partFrameLabels.pack["101"] = "pMunster";
_partFrameLabels.pack["102"] = "sponsorMinc1";
_partFrameLabels.pack["103"] = "sponsorMinc2";
_partFrameLabels.pack["104"] = "pTigerShark";
_partFrameLabels.pack["105"] = "sponsorCBee";
_partFrameLabels.pack["106"] = "sponsorWilson";
_partFrameLabels.pack["107"] = "sponsorDitch";
_partFrameLabels.pack["108"] = "sponsorMonkeyBall";
_partFrameLabels.pack["109"] = "sponsorFLegypt1";
_partFrameLabels.pack["110"] = "sponsorFLegypt2";
_partFrameLabels.pack["111"] = "hades";
_partFrameLabels.pack["112"] = "zeus";
_partFrameLabels.pack["113"] = "athena";
_partFrameLabels.pack["114"] = "athenaOld";
_partFrameLabels.pack["115"] = "aphrodite";
_partFrameLabels.pack["116"] = "mythTeen1";
_partFrameLabels.pack["117"] = "mythTeen2";
_partFrameLabels.pack["118"] = "medusa";
_partFrameLabels.pack["119"] = "satyr";
_partFrameLabels.pack["120"] = "sponsorTSBRbuzz";
_partFrameLabels.pack["121"] = "pMagic1";
_partFrameLabels.pack["122"] = "sponsorFurryV";
_partFrameLabels.pack["123"] = "pEarthKnight";
_partFrameLabels.pack["124"] = "pGirlKnight";
_partFrameLabels.pack["125"] = "pDarkKnght_boy";
_partFrameLabels.pack["126"] = "pDarkKnight_girl";
_partFrameLabels.pack["127"] = "hayPack";
_partFrameLabels.pack["128"] = "skullMoroGuy3";
_partFrameLabels.pack["129"] = "sponsorPercyZeus";
_partFrameLabels.pack["130"] = "sponsorCDdog";
_partFrameLabels.pack["131"] = "pHammerShark";
_partFrameLabels.pack["132"] = "steamWorker1";
_partFrameLabels.pack["133"] = "steamPilot";
_partFrameLabels.pack["134"] = "sponsorTink3";
_partFrameLabels.pack["135"] = "sponsorAlphaOmega";
_partFrameLabels.pack["136"] = "sponsorAO_Omega";
_partFrameLabels.pack["137"] = "sponsorAO_Alpha";
_partFrameLabels.pack["138"] = "pSteamRobot";
_partFrameLabels.pack["139"] = "sponsor_BarbieBee";
_partFrameLabels.pack["140"] = "sponsorLegoHero";
_partFrameLabels.pack["141"] = "sponsorBarbleGGdog2";
_partFrameLabels.pack["142"] = "sponsorBarbleGGdog3";
_partFrameLabels.pack["143"] = "sponsorHNC_HoneyDefender";
_partFrameLabels.pack["144"] = "youngSherpa";
_partFrameLabels.pack["145"] = "fortuneHunter1";
_partFrameLabels.pack["146"] = "fortuneHunter2";
_partFrameLabels.pack["147"] = "sponsorHOPsuit";
_partFrameLabels.pack["148"] = "MTHbonsaiWoman";
_partFrameLabels.pack["149"] = "MTHjack";
_partFrameLabels.pack["150"] = "MTHyWoman";
_partFrameLabels.pack["151"] = "MTHgardener02";
_partFrameLabels.pack["152"] = "MTHfanDancer";
_partFrameLabels.pack["153"] = "MTHfemWar";
_partFrameLabels.pack["154"] = "TiceSH";
_partFrameLabels.pack["155"] = "Tcumulos";
_partFrameLabels.pack["156"] = "Sponsor_AdventureTime_FinnPack";
_partFrameLabels.pack["157"] = "promo_PopGuidebk_bkpack";
_partFrameLabels.pack["158"] = "sponsorJackAndJill";
_partFrameLabels.pack["159"] = "sponsorArthurChristmas";
_partFrameLabels.pack["160"] = "EVile";
_partFrameLabels.pack["161"] = "sponsorChipWrecked_Alvin";
_partFrameLabels.pack["162"] = "sponsorChipWrecked_Brit";
_partFrameLabels.pack["163"] = "sponsorBen10_humungosaurTail";
_partFrameLabels.pack["164"] = "Gcloaked";
_partFrameLabels.pack["165"] = "GpromoHunter";
_partFrameLabels.pack["166"] = "SRhazmat";
_partFrameLabels.pack["167"] = "sponser_Arrietty_Pod";
_partFrameLabels.pack["168"] = "VCdracula";
_partFrameLabels.pack["169"] = "sponsorMirrorMirror_cape";
_partFrameLabels.pack["170"] = "VChunter";
_partFrameLabels.pack["171"] = "p_countessVampire";
_partFrameLabels.pack["172"] = "p_CountVampire";
_partFrameLabels.pack["173"] = "TT_elft1";
_partFrameLabels.pack["174"] = "TT_elfQueen";
_partFrameLabels.pack["175"] = "pTroll";
_partFrameLabels.pack["176"] = "Sponsor_AdventureTime_FakeFinnPack";
_partFrameLabels.hair["31"] = "bald";
_partFrameLabels.hair["45"] = "leo";
_partFrameLabels.hair["46"] = "vendor";
_partFrameLabels.hair["47"] = "explorer";
_partFrameLabels.hair["48"] = "skater";
_partFrameLabels.hair["49"] = "goth";
_partFrameLabels.hair["50"] = "shark";
_partFrameLabels.hair["51"] = "voodoo";
_partFrameLabels.hair["52"] = "finVendor";
_partFrameLabels.hair["53"] = "oldExplorer";
_partFrameLabels.hair["54"] = "hulaLady";
_partFrameLabels.hair["55"] = "fisherman";
_partFrameLabels.hair["56"] = "aztecWarrior";
_partFrameLabels.hair["57"] = "aztecKing";
_partFrameLabels.hair["58"] = "aztecWoman";
_partFrameLabels.hair["59"] = "aztecQueen";
_partFrameLabels.hair["60"] = "aztecSlave";
_partFrameLabels.hair["61"] = "aztecWomanSlave";
_partFrameLabels.hair["62"] = "aztecWiseGuy";
_partFrameLabels.hair["63"] = "chineseWarrior";
_partFrameLabels.hair["64"] = "chineseWiseGuy";
_partFrameLabels.hair["65"] = "chineseArtist";
_partFrameLabels.hair["66"] = "chinesePeasant";
_partFrameLabels.hair["67"] = "bartholdi";
_partFrameLabels.hair["68"] = "oracle";
_partFrameLabels.hair["69"] = "greekLady";
_partFrameLabels.hair["70"] = "jefferson";
_partFrameLabels.hair["71"] = "turbinGuy";
_partFrameLabels.hair["72"] = "turbinLady";
_partFrameLabels.hair["73"] = "clark";
_partFrameLabels.hair["74"] = "lewis";
_partFrameLabels.hair["75"] = "sacagawea";
_partFrameLabels.hair["76"] = "york";
_partFrameLabels.hair["77"] = "toussaint";
_partFrameLabels.hair["78"] = "franklin";
_partFrameLabels.hair["79"] = "adams";
_partFrameLabels.hair["80"] = "tourist";
_partFrameLabels.hair["81"] = "leoassist";
_partFrameLabels.hair["82"] = "spanishcon";
_partFrameLabels.hair["83"] = "frenchman";
_partFrameLabels.hair["84"] = "referee";
_partFrameLabels.hair["85"] = "gasDude";
_partFrameLabels.hair["86"] = "dinerWaitress";
_partFrameLabels.hair["87"] = "dinerCook";
_partFrameLabels.hair["88"] = "farmer";
_partFrameLabels.hair["89"] = "mayor";
_partFrameLabels.hair["90"] = "hobo";
_partFrameLabels.hair["91"] = "prisoner1";
_partFrameLabels.hair["92"] = "prisoner2";
_partFrameLabels.hair["93"] = "prisoner3";
_partFrameLabels.hair["94"] = "prisoner4";
_partFrameLabels.hair["95"] = "prisoner5";
_partFrameLabels.hair["96"] = "prisoner6";
_partFrameLabels.hair["97"] = "nerd";
_partFrameLabels.hair["98"] = "tailor";
_partFrameLabels.hair["99"] = "hotDogVendor";
_partFrameLabels.hair["100"] = "pretzelVendor";
_partFrameLabels.hair["101"] = "cat";
_partFrameLabels.hair["102"] = "fm1";
_partFrameLabels.hair["103"] = "fm2";
_partFrameLabels.hair["104"] = "fm3";
_partFrameLabels.hair["105"] = "fm4";
_partFrameLabels.hair["106"] = "fm5";
_partFrameLabels.hair["107"] = "fm6";
_partFrameLabels.hair["108"] = "fm7";
_partFrameLabels.hair["109"] = "fm8";
_partFrameLabels.hair["110"] = "fm9";
_partFrameLabels.hair["111"] = "fm10";
_partFrameLabels.hair["112"] = "fm11";
_partFrameLabels.hair["113"] = "fm12";
_partFrameLabels.hair["114"] = "fm13";
_partFrameLabels.hair["115"] = "fm14";
_partFrameLabels.hair["116"] = "fm15";
_partFrameLabels.hair["117"] = "fm16";
_partFrameLabels.hair["118"] = "Sears1";
_partFrameLabels.hair["119"] = "Sears2";
_partFrameLabels.hair["120"] = "Sears3";
_partFrameLabels.hair["121"] = "Sears5";
_partFrameLabels.hair["122"] = "Sears6";
_partFrameLabels.hair["123"] = "agentGirl";
_partFrameLabels.hair["124"] = "agentGuy";
_partFrameLabels.hair["125"] = "camoHat";
_partFrameLabels.hair["126"] = "promHair";
_partFrameLabels.hair["127"] = "dog";
_partFrameLabels.hair["128"] = "swaziGuy1";
_partFrameLabels.hair["129"] = "swaziGuy2";
_partFrameLabels.hair["130"] = "africanGuy2";
_partFrameLabels.hair["131"] = "africanShepherd";
_partFrameLabels.hair["132"] = "zuluGuy1";
_partFrameLabels.hair["133"] = "africanLady1";
_partFrameLabels.hair["134"] = "africanLady2";
_partFrameLabels.hair["135"] = "africanLady3";
_partFrameLabels.hair["136"] = "africanLady4";
_partFrameLabels.hair["137"] = "africanLady5";
_partFrameLabels.hair["138"] = "africanLady6";
_partFrameLabels.hair["139"] = "egyptDigger";
_partFrameLabels.hair["140"] = "sponsorTinkerbell";
_partFrameLabels.hair["141"] = "sponsorWalmartElfM";
_partFrameLabels.hair["142"] = "sponsorWalmartElfF";
_partFrameLabels.hair["143"] = "sponsorWallEM";
_partFrameLabels.hair["144"] = "sponsorWallEF";
_partFrameLabels.hair["145"] = "girlHair1";
_partFrameLabels.hair["146"] = "girlHair2";
_partFrameLabels.hair["147"] = "girlHair3";
_partFrameLabels.hair["148"] = "girlHair4";
_partFrameLabels.hair["149"] = "girlHair5";
_partFrameLabels.hair["150"] = "girlHair6";
_partFrameLabels.hair["151"] = "hippie";
_partFrameLabels.hair["152"] = "librarian";
_partFrameLabels.hair["153"] = "basketball";
_partFrameLabels.hair["154"] = "musicLoverG";
_partFrameLabels.hair["155"] = "lawyer";
_partFrameLabels.hair["156"] = "fastFood";
_partFrameLabels.hair["157"] = "hipHop";
_partFrameLabels.hair["158"] = "girlScout";
_partFrameLabels.hair["159"] = "snootyGirl";
_partFrameLabels.hair["160"] = "grandma";
_partFrameLabels.hair["161"] = "cowGirl";
_partFrameLabels.hair["162"] = "grandpa";
_partFrameLabels.hair["163"] = "gothGirl";
_partFrameLabels.hair["164"] = "geisha";
_partFrameLabels.hair["165"] = "soccer";
_partFrameLabels.hair["166"] = "magician";
_partFrameLabels.hair["167"] = "sponsorOS2b";
_partFrameLabels.hair["168"] = "FLpirate1";
_partFrameLabels.hair["169"] = "FLpirate2";
_partFrameLabels.hair["170"] = "FLpirate3";
_partFrameLabels.hair["171"] = "pBall1";
_partFrameLabels.hair["172"] = "pBall2";
_partFrameLabels.hair["173"] = "pBall3";
_partFrameLabels.hair["174"] = "sponsorHSM3guy";
_partFrameLabels.hair["175"] = "sponsorHSM3girl";
_partFrameLabels.hair["176"] = "pPharaoh";
_partFrameLabels.hair["177"] = "pEgyptQ";
_partFrameLabels.hair["178"] = "pRockerGuy1";
_partFrameLabels.hair["179"] = "pRockerGuy2";
_partFrameLabels.hair["180"] = "pRockerGuy3";
_partFrameLabels.hair["181"] = "pRockerGirl1";
_partFrameLabels.hair["182"] = "pRockerGirl2";
_partFrameLabels.hair["183"] = "pRockerGirl3";
_partFrameLabels.hair["184"] = "pPopGirl1";
_partFrameLabels.hair["185"] = "pFairy1";
_partFrameLabels.hair["186"] = "pFairy2";
_partFrameLabels.hair["187"] = "pFairy3";
_partFrameLabels.hair["188"] = "sponsorPinoFairy";
_partFrameLabels.hair["189"] = "sponsorPinoPino";
_partFrameLabels.hair["190"] = "cyberJester";
_partFrameLabels.hair["191"] = "astroEvilPrincess";
_partFrameLabels.hair["192"] = "astroMonk";
_partFrameLabels.hair["193"] = "astroServant2";
_partFrameLabels.hair["194"] = "astroChance";
_partFrameLabels.hair["195"] = "astroPrincess";
_partFrameLabels.hair["196"] = "astroServant1";
_partFrameLabels.hair["197"] = "astroQueen";
_partFrameLabels.hair["198"] = "astroRoyal1";
_partFrameLabels.hair["199"] = "astroKing";
_partFrameLabels.hair["200"] = "astroVill2";
_partFrameLabels.hair["201"] = "sponsorFLoctF";
_partFrameLabels.hair["202"] = "sponsorFLoctM";
_partFrameLabels.hair["203"] = "sponsorFLoct2";
_partFrameLabels.hair["204"] = "astroVill3";
_partFrameLabels.hair["205"] = "astroVill4";
_partFrameLabels.hair["206"] = "astroPes2";
_partFrameLabels.hair["207"] = "astroPes1";
_partFrameLabels.hair["208"] = "astroCurrator";
_partFrameLabels.hair["209"] = "astroGossip1";
_partFrameLabels.hair["210"] = "astroGossip2";
_partFrameLabels.hair["211"] = "astroGossip3";
_partFrameLabels.hair["212"] = "astroGossip4";
_partFrameLabels.hair["213"] = "astroGossip5";
_partFrameLabels.hair["214"] = "astroAlien1";
_partFrameLabels.hair["215"] = "astroAlien2";
_partFrameLabels.hair["216"] = "astroAlien3";
_partFrameLabels.hair["217"] = "astroAlien4";
_partFrameLabels.hair["218"] = "astroAlien5";
_partFrameLabels.hair["219"] = "astroAlien6";
_partFrameLabels.hair["220"] = "pSingerGuy1";
_partFrameLabels.hair["221"] = "pPirateGuy1";
_partFrameLabels.hair["222"] = "pPirateGirl1";
_partFrameLabels.hair["223"] = "pCowgirl1";
_partFrameLabels.hair["224"] = "pCowboy1";
_partFrameLabels.hair["225"] = "pKarateBoy1";
_partFrameLabels.hair["226"] = "pKarateBoy2";
_partFrameLabels.hair["227"] = "pKarateBoy3";
_partFrameLabels.hair["228"] = "pKarateGirl1";
_partFrameLabels.hair["229"] = "pKarateGirl2";
_partFrameLabels.hair["230"] = "pKarateGirl3";
_partFrameLabels.hair["231"] = "pCheerleader1";
_partFrameLabels.hair["232"] = "pCheerleader2";
_partFrameLabels.hair["233"] = "pCheerleader3";
_partFrameLabels.hair["234"] = "pCheerleaderGoth";
_partFrameLabels.hair["235"] = "sponsorWM1";
_partFrameLabels.hair["236"] = "sponsorBedB1";
_partFrameLabels.hair["237"] = "sponsorBedB2";
_partFrameLabels.hair["238"] = "sponsorCWMB1";
_partFrameLabels.hair["239"] = "sponsorCWMB2";
_partFrameLabels.hair["240"] = "sponsorCWMB3";
_partFrameLabels.hair["241"] = "pFirefighter1";
_partFrameLabels.hair["242"] = "pFirefighter2";
_partFrameLabels.hair["243"] = "pClown1";
_partFrameLabels.hair["244"] = "pSheDevil";
_partFrameLabels.hair["245"] = "pAngelF";
_partFrameLabels.hair["246"] = "pAngelM";
_partFrameLabels.hair["247"] = "pPopGirlLE";
_partFrameLabels.hair["248"] = "pBiker1";
_partFrameLabels.hair["249"] = "vampire";
_partFrameLabels.hair["250"] = "frankenstein";
_partFrameLabels.hair["251"] = "frankBride";
_partFrameLabels.hair["252"] = "sponsorAstro1";
_partFrameLabels.hair["253"] = "sponsorAstro2";
_partFrameLabels.hair["254"] = "sponsorGbCrow";
_partFrameLabels.hair["255"] = "witch";
_partFrameLabels.hair["256"] = "witch2";
_partFrameLabels.hair["257"] = "vampire2";
_partFrameLabels.hair["258"] = "sponsorTinkerbell2";
_partFrameLabels.hair["259"] = "sponsorTinkerbell3";
_partFrameLabels.hair["260"] = "sponsorTinkerbell4";
_partFrameLabels.hair["261"] = "sponsorFuel1";
_partFrameLabels.hair["262"] = "sponsorFuel2";
_partFrameLabels.hair["263"] = "sponsorEC1";
_partFrameLabels.hair["264"] = "sponsorEC2";
_partFrameLabels.hair["265"] = "pWolf1";
_partFrameLabels.hair["266"] = "pLagoon";
_partFrameLabels.hair["267"] = "pMunster";
_partFrameLabels.hair["268"] = "sponsorSBsanta";
_partFrameLabels.hair["269"] = "sponsorSBsanta3";
_partFrameLabels.hair["270"] = "blackWidow1";
_partFrameLabels.hair["271"] = "blackWidow2";
_partFrameLabels.hair["272"] = "curator";
_partFrameLabels.hair["273"] = "tourGuide";
_partFrameLabels.hair["274"] = "sponsorPFxmas";
_partFrameLabels.hair["275"] = "mime1";
_partFrameLabels.hair["276"] = "mime2";
_partFrameLabels.hair["277"] = "pBallerina1";
_partFrameLabels.hair["278"] = "pBallerina2";
_partFrameLabels.hair["279"] = "pBallerina3";
_partFrameLabels.hair["280"] = "sponsorSpyNext";
_partFrameLabels.hair["281"] = "sponsorCBee";
_partFrameLabels.hair["282"] = "buckyLucas";
_partFrameLabels.hair["283"] = "mikesMarket";
_partFrameLabels.hair["284"] = "realityTeen";
_partFrameLabels.hair["285"] = "sponsorFizzy";
_partFrameLabels.hair["286"] = "sponsorMonkeyBall";
_partFrameLabels.hair["287"] = "sponsorFLegypt1";
_partFrameLabels.hair["288"] = "sponsorFLegypt2";
_partFrameLabels.hair["289"] = "charon";
_partFrameLabels.hair["290"] = "aeolus";
_partFrameLabels.hair["291"] = "hades";
_partFrameLabels.hair["292"] = "poseidon";
_partFrameLabels.hair["293"] = "zeus";
_partFrameLabels.hair["294"] = "hercules";
_partFrameLabels.hair["295"] = "athena";
_partFrameLabels.hair["296"] = "aphrodite";
_partFrameLabels.hair["297"] = "dionysus";
_partFrameLabels.hair["298"] = "minotaur";
_partFrameLabels.hair["299"] = "mythPes1";
_partFrameLabels.hair["300"] = "mythPes2";
_partFrameLabels.hair["301"] = "mythPes3";
_partFrameLabels.hair["302"] = "mythPes4";
_partFrameLabels.hair["303"] = "mythPes5";
_partFrameLabels.hair["304"] = "mythPes6";
_partFrameLabels.hair["305"] = "mythPes7";
_partFrameLabels.hair["306"] = "mythTeen1";
_partFrameLabels.hair["307"] = "mythTeen2";
_partFrameLabels.hair["308"] = "mythBeach1";
_partFrameLabels.hair["309"] = "mythBeach2";
_partFrameLabels.hair["310"] = "satyr";
_partFrameLabels.hair["311"] = "sponsorWimpy1";
_partFrameLabels.hair["312"] = "sponsorTSBRjess";
_partFrameLabels.hair["313"] = "sponsorTSBRalien";
_partFrameLabels.hair["314"] = "pMagic1";
_partFrameLabels.hair["315"] = "pPunkGuy1";
_partFrameLabels.hair["316"] = "pPunkGuy2";
_partFrameLabels.hair["317"] = "pPunkGuy3";
_partFrameLabels.hair["318"] = "pPunkGuy4";
_partFrameLabels.hair["319"] = "pPunkGuy5";
_partFrameLabels.hair["320"] = "pPunkGirl1";
_partFrameLabels.hair["321"] = "pPunkGirl2";
_partFrameLabels.hair["322"] = "pPunkGirl3";
_partFrameLabels.hair["323"] = "pPunkGirl4";
_partFrameLabels.hair["324"] = "pPunkGirl5";
_partFrameLabels.hair["325"] = "pDrHare_Hench1";
_partFrameLabels.hair["326"] = "pDrHare_Hench2";
_partFrameLabels.hair["327"] = "pDrHare_Hench3";
_partFrameLabels.hair["328"] = "pEinstein";
_partFrameLabels.hair["329"] = "hades2";
_partFrameLabels.hair["330"] = "sponsorKoiFish";
_partFrameLabels.hair["331"] = "skullMainGuard1";
_partFrameLabels.hair["332"] = "skullMainBoy";
_partFrameLabels.hair["333"] = "fisherman3";
_partFrameLabels.hair["334"] = "skullMainMerchant";
_partFrameLabels.hair["335"] = "skullMainGov";
_partFrameLabels.hair["336"] = "skullMainServant";
_partFrameLabels.hair["337"] = "skullMainHayLady";
_partFrameLabels.hair["338"] = "skullMainOldLady";
_partFrameLabels.hair["339"] = "skullMainFarmer1";
_partFrameLabels.hair["340"] = "skullMainOldMan";
_partFrameLabels.hair["341"] = "captCrawfish";
_partFrameLabels.hair["342"] = "skullPirate1";
_partFrameLabels.hair["343"] = "skullPirate2";
_partFrameLabels.hair["344"] = "skullPirate3";
_partFrameLabels.hair["345"] = "skullPirate4";
_partFrameLabels.hair["346"] = "skullPirate5";
_partFrameLabels.hair["347"] = "skullPirate6";
_partFrameLabels.hair["348"] = "skullPirate7";
_partFrameLabels.hair["349"] = "skullPirate8";
_partFrameLabels.hair["350"] = "skullPirate9";
_partFrameLabels.hair["351"] = "skullSam";
_partFrameLabels.hair["352"] = "skullNavigator";
_partFrameLabels.hair["353"] = "skullBartender";
_partFrameLabels.hair["354"] = "skullCannon";
_partFrameLabels.hair["355"] = "skullWarehouse1";
_partFrameLabels.hair["356"] = "skullInk";
_partFrameLabels.hair["357"] = "skullElegantLady";
_partFrameLabels.hair["358"] = "skullMerchant1";
_partFrameLabels.hair["359"] = "skullMerchant2";
_partFrameLabels.hair["360"] = "skullMerchant3";
_partFrameLabels.hair["361"] = "skullMerchant4";
_partFrameLabels.hair["362"] = "skullMoroLady1";
_partFrameLabels.hair["363"] = "skullMoroLady2";
_partFrameLabels.hair["364"] = "skullMoroLady3";
_partFrameLabels.hair["365"] = "skullMoroBank1";
_partFrameLabels.hair["366"] = "skullMoroBank2";
_partFrameLabels.hair["367"] = "skullMoroGuy1";
_partFrameLabels.hair["368"] = "skullMoroGuy2";
_partFrameLabels.hair["369"] = "skullChinaGuy1";
_partFrameLabels.hair["370"] = "skullChinaGuy2";
_partFrameLabels.hair["371"] = "skullChinaMerch";
_partFrameLabels.hair["372"] = "skullChinaWorker1";
_partFrameLabels.hair["373"] = "skullChinaShipwright";
_partFrameLabels.hair["374"] = "skullChinaWiseLady";
_partFrameLabels.hair["375"] = "sponsorHypnotic";
_partFrameLabels.hair["376"] = "pSkullPirate1a";
_partFrameLabels.hair["377"] = "pSkullPirate1b";
_partFrameLabels.hair["378"] = "pSkullPirate1c";
_partFrameLabels.hair["379"] = "pSkullPirate1d";
_partFrameLabels.hair["380"] = "sponsor_MH";
_partFrameLabels.hair["381"] = "pPromKing1a";
_partFrameLabels.hair["382"] = "pPromKing1b";
_partFrameLabels.hair["383"] = "pPromKing1c";
_partFrameLabels.hair["384"] = "pPromKing1d";
_partFrameLabels.hair["385"] = "pPromQueen1";
_partFrameLabels.hair["386"] = "sponsorMinion";
_partFrameLabels.hair["387"] = "sponsorAgnes";
_partFrameLabels.hair["388"] = "sponsorEdith";
_partFrameLabels.hair["389"] = "sponsorMargo";
_partFrameLabels.hair["390"] = "sponsorPercyJackson";
_partFrameLabels.hair["391"] = "sponsorPercyZeus";
_partFrameLabels.hair["392"] = "storeMythSurfer1";
_partFrameLabels.hair["393"] = "storeMythSurfer2a";
_partFrameLabels.hair["394"] = "storeMythSurfer2b";
_partFrameLabels.hair["395"] = "storeMythSurfer2c";
_partFrameLabels.hair["396"] = "pGradBoy1a";
_partFrameLabels.hair["397"] = "pGradBoy1b";
_partFrameLabels.hair["398"] = "pGradBoy3c";
_partFrameLabels.hair["399"] = "pGradGirl1a";
_partFrameLabels.hair["400"] = "pGradGirl1b";
_partFrameLabels.hair["401"] = "pGradGirl1c";
_partFrameLabels.hair["402"] = "pSoccer1a";
_partFrameLabels.hair["403"] = "pSoccer1b";
_partFrameLabels.hair["404"] = "pSoccer1c";
_partFrameLabels.hair["405"] = "pSoccer1d";
_partFrameLabels.hair["406"] = "pSoccerF1a";
_partFrameLabels.hair["407"] = "pSoccerF1b";
_partFrameLabels.hair["408"] = "pSoccerF1c";
_partFrameLabels.hair["409"] = "pSoccerF1d";
_partFrameLabels.hair["410"] = "sponsor_SelenaG";
_partFrameLabels.hair["411"] = "sponsor_Ramona";
_partFrameLabels.hair["412"] = "steamZach1";
_partFrameLabels.hair["413"] = "steamZach2";
_partFrameLabels.hair["414"] = "steamSully";
_partFrameLabels.hair["415"] = "steamMayor";
_partFrameLabels.hair["416"] = "steamCaptain";
_partFrameLabels.hair["417"] = "pGamerGirl";
_partFrameLabels.hair["418"] = "pGamerDude";
_partFrameLabels.hair["419"] = "pNerdBoy";
_partFrameLabels.hair["420"] = "pNerdGirl";
_partFrameLabels.hair["421"] = "pVampire_boy";
_partFrameLabels.hair["422"] = "pVampire_girl01";
_partFrameLabels.hair["423"] = "pVampire_girl02";
_partFrameLabels.hair["424"] = "pVampire_girl03";
_partFrameLabels.hair["425"] = "sponsorTinkBobble";
_partFrameLabels.hair["426"] = "sponsorFarmGirl";
_partFrameLabels.hair["427"] = "sponsorFarmKid";
_partFrameLabels.hair["428"] = "sponsorFarmBoy";
_partFrameLabels.hair["429"] = "sponsorCityBoy";
_partFrameLabels.hair["430"] = "sponsorCityGirl";
_partFrameLabels.hair["431"] = "sponsorFarmMom";
_partFrameLabels.hair["432"] = "sponsorNannyMcPhee";
_partFrameLabels.hair["433"] = "sponsorAlphaOmega";
_partFrameLabels.hair["434"] = "sponsor_MayanWarrior";
_partFrameLabels.hair["435"] = "sponsor_FLWitchDoctor";
_partFrameLabels.hair["436"] = "sponsor_POK-King";
_partFrameLabels.hair["437"] = "sponsor_POK-Mason";
_partFrameLabels.hair["438"] = "sponsor_POK-Tarantula";
_partFrameLabels.hair["439"] = "sponsor_KK_Bully01";
_partFrameLabels.hair["440"] = "sponsor_KK_Bully02";
_partFrameLabels.hair["441"] = "sponsor_KK_Bully03";
_partFrameLabels.hair["442"] = "sponsor_KK_Bully04";
_partFrameLabels.hair["443"] = "sponsor_KK_Bully05";
_partFrameLabels.hair["444"] = "sponsor_KK_Bully06";
_partFrameLabels.hair["445"] = "sponsor_MrHan";
_partFrameLabels.hair["446"] = "sponsor_KarateKid";
_partFrameLabels.hair["447"] = "sponsorTSBRwoody";
_partFrameLabels.hair["448"] = "sponsor_BarbiePirate";
_partFrameLabels.hair["449"] = "sponsor_BarbieVampire";
_partFrameLabels.hair["450"] = "sponsor_BarbieWizard";
_partFrameLabels.hair["451"] = "sponsor_BarbieBee";
_partFrameLabels.hair["452"] = "sponsorBarbieB";
_partFrameLabels.hair["453"] = "sponsorBarbieCat";
_partFrameLabels.hair["454"] = "sponsor_BarbiCostB";
_partFrameLabels.hair["455"] = "sponsor_BarbieBWiz";
_partFrameLabels.hair["456"] = "sponsor_BarbieBbee";
_partFrameLabels.hair["457"] = "sponsorFLPharoah";
_partFrameLabels.hair["458"] = "sponsorAppleJacks_blitz_Cinna";
_partFrameLabels.hair["459"] = "sponsorBarbieGGgirl";
_partFrameLabels.hair["460"] = "sponsorBarbieGGgirl2";
_partFrameLabels.hair["461"] = "rowBoatMan";
_partFrameLabels.hair["462"] = "subGuide";
_partFrameLabels.hair["463"] = "Nessie_tourist1";
_partFrameLabels.hair["464"] = "Nessie_tourist2";
_partFrameLabels.hair["465"] = "Gulliver";
_partFrameLabels.hair["466"] = "haroldMews";
_partFrameLabels.hair["467"] = "Gretchen";
_partFrameLabels.hair["468"] = "gardener";
_partFrameLabels.hair["469"] = "gilderGirl";
_partFrameLabels.hair["470"] = "maintenanceMan";
_partFrameLabels.hair["471"] = "snootyLady";
_partFrameLabels.hair["472"] = "butler";
_partFrameLabels.hair["473"] = "HunterGiveUp";
_partFrameLabels.hair["474"] = "surlyDartMan";
_partFrameLabels.hair["475"] = "bartenderPub";
_partFrameLabels.hair["476"] = "CampCook";
_partFrameLabels.hair["477"] = "Tyson";
_partFrameLabels.hair["478"] = "wwSaloonGirl";
_partFrameLabels.hair["479"] = "OS3BunnyHat_boy";
_partFrameLabels.hair["480"] = "OS3BunnyHat_girl";
_partFrameLabels.hair["481"] = "nateG";
_partFrameLabels.hair["482"] = "pTanglednLights_girl";
_partFrameLabels.hair["483"] = "pTanglednLights_boy";
_partFrameLabels.hair["484"] = "pDisco_King";
_partFrameLabels.hair["485"] = "pDisco_Queen";
_partFrameLabels.hair["486"] = "promoWWday1";
_partFrameLabels.hair["487"] = "promoWWday2m";
_partFrameLabels.hair["488"] = "promoWWday2f";
_partFrameLabels.hair["489"] = "promoWWday3m";
_partFrameLabels.hair["490"] = "promoWWday3f";
_partFrameLabels.hair["491"] = "promoWWday5m";
_partFrameLabels.hair["492"] = "promoWWday5f";
_partFrameLabels.hair["493"] = "promoWWday6";
_partFrameLabels.hair["494"] = "promoWWmemOnlym";
_partFrameLabels.hair["495"] = "promoWWmemOnlyf";
_partFrameLabels.hair["496"] = "wwTrader";
_partFrameLabels.hair["497"] = "wwMustachio";
_partFrameLabels.hair["498"] = "wwMustachioB";
_partFrameLabels.hair["499"] = "wwPonyExpress";
_partFrameLabels.hair["500"] = "wwPonyExpressB";
_partFrameLabels.hair["501"] = "wwMarshal";
_partFrameLabels.hair["502"] = "wwRuby";
_partFrameLabels.hair["503"] = "wwGambler";
_partFrameLabels.hair["504"] = "wwAnnie";
_partFrameLabels.hair["505"] = "wwPhoto";
_partFrameLabels.hair["506"] = "wwProspector";
_partFrameLabels.hair["507"] = "wwBanker";
_partFrameLabels.hair["508"] = "wwDeputy";
_partFrameLabels.hair["509"] = "wwCattledriver";
_partFrameLabels.hair["510"] = "wwRancher";
_partFrameLabels.hair["511"] = "wwPospector";
_partFrameLabels.hair["512"] = "wwPrisoner";
_partFrameLabels.hair["513"] = "wwIndianGirl";
_partFrameLabels.hair["514"] = "wwMan";
_partFrameLabels.hair["515"] = "wwCowgirl";
_partFrameLabels.hair["516"] = "wwGenericGuy";
_partFrameLabels.hair["517"] = "wwAnnouncer";
_partFrameLabels.hair["518"] = "wwMexBandiit";
_partFrameLabels.hair["519"] = "wwCasinoPatron2";
_partFrameLabels.hair["520"] = "wwSlouch01";
_partFrameLabels.hair["521"] = "wwInvisible";
_partFrameLabels.hair["522"] = "sideQuest_Rattlerhat";
_partFrameLabels.hair["523"] = "SponsorMonsterHigh";
_partFrameLabels.hair["524"] = "paperGirl_01";
_partFrameLabels.hair["525"] = "paperGirl_02";
_partFrameLabels.hair["526"] = "sponsorChuck";
_partFrameLabels.hair["527"] = "sponsorMonsterHigh_gloomHairdoo";
_partFrameLabels.hair["528"] = "MTHyokozuna";
_partFrameLabels.hair["529"] = "MTHscaredSumo";
_partFrameLabels.hair["530"] = "MTHbonsaiWoman";
_partFrameLabels.hair["531"] = "MTHjack";
_partFrameLabels.hair["532"] = "MTHannie";
_partFrameLabels.hair["533"] = "MTHshogunCasual";
_partFrameLabels.hair["534"] = "MTHbasho";
_partFrameLabels.hair["535"] = "MTHreferee";
_partFrameLabels.hair["536"] = "MTHtownie02";
_partFrameLabels.hair["537"] = "MTHtownie03";
_partFrameLabels.hair["538"] = "MTHtownie04";
_partFrameLabels.hair["539"] = "MTHprisoner";
_partFrameLabels.hair["540"] = "MTHdragonPuppeteer";
_partFrameLabels.hair["541"] = "MTHdragonPuppeteer02";
_partFrameLabels.hair["542"] = "MTHyokoAsst";
_partFrameLabels.hair["543"] = "MTHbookie";
_partFrameLabels.hair["544"] = "MTHartist";
_partFrameLabels.hair["545"] = "MTHforeman";
_partFrameLabels.hair["546"] = "MTHgardener02";
_partFrameLabels.hair["547"] = "MTHgardener04";
_partFrameLabels.hair["548"] = "MTHfanDancer";
_partFrameLabels.hair["549"] = "sponsorLN_Mo";
_partFrameLabels.hair["550"] = "sponsor_LM_Stella";
_partFrameLabels.hair["551"] = "sponsorLM_Charlie";
_partFrameLabels.hair["552"] = "MTHfemWar";
_partFrameLabels.hair["553"] = "sponsor_KickinItJerry";
_partFrameLabels.hair["554"] = "sponsor_KickinItJack";
_partFrameLabels.hair["555"] = "Sponsor_KickinItKim";
_partFrameLabels.hair["556"] = "sponsor_kickinItRudy";
_partFrameLabels.hair["557"] = "MTHwoman";
_partFrameLabels.hair["558"] = "MTHgardener03";
_partFrameLabels.hair["559"] = "TcamoGuy";
_partFrameLabels.hair["560"] = "TiceSH";
_partFrameLabels.hair["561"] = "TpirateRed";
_partFrameLabels.hair["562"] = "TpirateBlue";
_partFrameLabels.hair["563"] = "TshrkSfr";
_partFrameLabels.hair["564"] = "TrockStar";
_partFrameLabels.hair["565"] = "SRcj";
_partFrameLabels.hair["566"] = "SRmom";
_partFrameLabels.hair["567"] = "SRstudent01";
_partFrameLabels.hair["568"] = "SRstudent02";
_partFrameLabels.hair["569"] = "sponsorGregWrapped";
_partFrameLabels.hair["570"] = "SRsilva";
_partFrameLabels.hair["571"] = "sponsorSmurfs1";
_partFrameLabels.hair["572"] = "spnosorSmurfs2";
_partFrameLabels.hair["573"] = "ShrinkRayPromo3";
_partFrameLabels.hair["574"] = "Tcumulos";
_partFrameLabels.hair["575"] = "mtHoudini";
_partFrameLabels.hair["576"] = "mtSusanB";
_partFrameLabels.hair["577"] = "mtTwain";
_partFrameLabels.hair["578"] = "mtEdison";
_partFrameLabels.hair["579"] = "mtCleveland";
_partFrameLabels.hair["580"] = "mtPinkertonThug";
_partFrameLabels.hair["581"] = "MTtesla";
_partFrameLabels.hair["582"] = "Mtferris";
_partFrameLabels.hair["583"] = "MTeiffel";
_partFrameLabels.hair["584"] = "MTnyReporter";
_partFrameLabels.hair["585"] = "MTfReporter";
_partFrameLabels.hair["586"] = "MTtownie01";
_partFrameLabels.hair["587"] = "MTtownie02";
_partFrameLabels.hair["588"] = "Mttownie03";
_partFrameLabels.hair["589"] = "Mtrich01";
_partFrameLabels.hair["590"] = "Rich02";
_partFrameLabels.hair["591"] = "mtCookSlowHair";
_partFrameLabels.hair["592"] = "mtCookFastHair";
_partFrameLabels.hair["593"] = "mtTwainReward";
_partFrameLabels.hair["594"] = "mtMagiciansHatReward";
_partFrameLabels.hair["595"] = "mtDancer";
_partFrameLabels.hair["596"] = "mtFeeder";
_partFrameLabels.hair["597"] = "mtJuggler";
_partFrameLabels.hair["598"] = "TdreadRocker";
_partFrameLabels.hair["599"] = "buzzCut";
_partFrameLabels.hair["600"] = "pPopCake";
_partFrameLabels.hair["601"] = "sponsorHasbroFGN2";
_partFrameLabels.hair["602"] = "sponsorAuntOpal";
_partFrameLabels.hair["603"] = "sponsor_carnivalHat";
_partFrameLabels.hair["604"] = "sponsor_carnivalHat_boy";
_partFrameLabels.hair["605"] = "GSrPopc";
_partFrameLabels.hair["606"] = "GSrHost";
_partFrameLabels.hair["607"] = "sponsor_JEhair";
_partFrameLabels.hair["608"] = "sponser_m17";
_partFrameLabels.hair["609"] = "promo_Popguidebk_hair";
_partFrameLabels.hair["610"] = "sponsor_CavinFever";
_partFrameLabels.hair["611"] = "sponsor_CabinFever_girl";
_partFrameLabels.hair["612"] = "sponsorChipWrecked_tBritney";
_partFrameLabels.hair["613"] = "sponsorChipWrecked_Zoe";
_partFrameLabels.hair["614"] = "sponsorChipWrecked_Simon";
_partFrameLabels.hair["615"] = "sponsorChipWrecked_Jeanette";
_partFrameLabels.hair["616"] = "Gboater";
_partFrameLabels.hair["617"] = "Ginnk";
_partFrameLabels.hair["618"] = "Ginnkw";
_partFrameLabels.hair["619"] = "Glodger";
_partFrameLabels.hair["620"] = "Gtent";
_partFrameLabels.hair["621"] = "Gtour";
_partFrameLabels.hair["622"] = "Gvaliant";
_partFrameLabels.hair["623"] = "Gtinfoil";
_partFrameLabels.hair["624"] = "Gbaker";
_partFrameLabels.hair["625"] = "GbakerW";
_partFrameLabels.hair["626"] = "GpromoBrownLady";
_partFrameLabels.hair["627"] = "GpromoHeadlessMan";
_partFrameLabels.hair["628"] = "SRishmael";
_partFrameLabels.hair["629"] = "SRboomer";
_partFrameLabels.hair["630"] = "SRflask";
_partFrameLabels.hair["631"] = "SRstubb";
_partFrameLabels.hair["632"] = "SRstarbuck";
_partFrameLabels.hair["633"] = "SRmate";
_partFrameLabels.hair["634"] = "SRrich02";
_partFrameLabels.hair["635"] = "sponsorMonsterHigh1600_hair";
_partFrameLabels.hair["636"] = "sponsor_Arrietty";
_partFrameLabels.hair["637"] = "VCdracula";
_partFrameLabels.hair["638"] = "VCvillager2";
_partFrameLabels.hair["639"] = "VCchris";
_partFrameLabels.hair["640"] = "VCgothBoy";
_partFrameLabels.hair["641"] = "VCgothGirl";
_partFrameLabels.hair["642"] = "p_seaCaptain";
_partFrameLabels.hair["643"] = "sponsorDizzyDancersMandiPandee";
_partFrameLabels.hair["644"] = "sponsorDizzyDancersRozPawz";
_partFrameLabels.hair["645"] = "sponsorMirrorMirror_hair";
_partFrameLabels.hair["646"] = "p_CountessVampire";
_partFrameLabels.hair["647"] = "p_CountVampire";
_partFrameLabels.hair["648"] = "TT_elf3";
_partFrameLabels.hair["649"] = "TT_elfQueen";
_partFrameLabels.hair["650"] = "TT_goon";
_partFrameLabels.hair["651"] = "TT_dev";
_partFrameLabels.hair["652"] = "pLeprecaun";
_partFrameLabels.hair["653"] = "pLeprechaun_girl";
_partFrameLabels.hair["654"] = "sponsor_kerstie";
_partFrameLabels.hair["655"] = "sponsor_lilly";
_partFrameLabels.hair["656"] = "sponsor_Rick";
_partFrameLabels.hair["657"] = "sponsor_PollyPocket";
_partFrameLabels.hair["658"] = "sponsor_PollyPocket_lea";
_partFrameLabels.hair["659"] = "sponsor_PollyPocket_lila";
_partFrameLabels.overshirt["2"] = "medalShark";
_partFrameLabels.overshirt["3"] = "medalEarly";
_partFrameLabels.overshirt["4"] = "apron";
_partFrameLabels.overshirt["5"] = "sponsorSpace";
_partFrameLabels.overshirt["6"] = "sponsorFLoops";
_partFrameLabels.overshirt["7"] = "amulet";
_partFrameLabels.overshirt["8"] = "medalTime";
_partFrameLabels.overshirt["9"] = "voodoo";
_partFrameLabels.overshirt["10"] = "leaves";
_partFrameLabels.overshirt["11"] = "ruby";
_partFrameLabels.overshirt["12"] = "heman";
_partFrameLabels.overshirt["13"] = "lei";
_partFrameLabels.overshirt["14"] = "camera";
_partFrameLabels.overshirt["15"] = "aztecWarrior";
_partFrameLabels.overshirt["16"] = "aztecKing";
_partFrameLabels.overshirt["17"] = "aztecWoman";
_partFrameLabels.overshirt["18"] = "aztecQueen";
_partFrameLabels.overshirt["19"] = "aztecWiseGuy";
_partFrameLabels.overshirt["20"] = "sponsorAJ";
_partFrameLabels.overshirt["21"] = "sponsorAJ_apple";
_partFrameLabels.overshirt["22"] = "sponsorAJ_CM";
_partFrameLabels.overshirt["23"] = "dinerCook";
_partFrameLabels.overshirt["24"] = "clerk";
_partFrameLabels.overshirt["25"] = "medalCarrot";
_partFrameLabels.overshirt["26"] = "labCoat";
_partFrameLabels.overshirt["27"] = "hotDogVendor";
_partFrameLabels.overshirt["28"] = "pretzelVendor";
_partFrameLabels.overshirt["29"] = "Sears1";
_partFrameLabels.overshirt["30"] = "Sears2";
_partFrameLabels.overshirt["31"] = "Sears5";
_partFrameLabels.overshirt["32"] = "medalSuper";
_partFrameLabels.overshirt["33"] = "necklace";
_partFrameLabels.overshirt["34"] = "grappleTie";
_partFrameLabels.overshirt["35"] = "dog";
_partFrameLabels.overshirt["36"] = "tied";
_partFrameLabels.overshirt["37"] = "medalSpy";
_partFrameLabels.overshirt["38"] = "sponsorLego";
_partFrameLabels.overshirt["39"] = "sponsorLego2";
_partFrameLabels.overshirt["40"] = "swaziGuy1";
_partFrameLabels.overshirt["41"] = "swaziGuy2";
_partFrameLabels.overshirt["42"] = "zuluGuy1";
_partFrameLabels.overshirt["43"] = "africanGuy1";
_partFrameLabels.overshirt["44"] = "africanLady1";
_partFrameLabels.overshirt["45"] = "africanLady2";
_partFrameLabels.overshirt["46"] = "africanLady3";
_partFrameLabels.overshirt["47"] = "africanLady4";
_partFrameLabels.overshirt["48"] = "africanGuy2";
_partFrameLabels.overshirt["49"] = "africanLady6";
_partFrameLabels.overshirt["50"] = "africanShepherd";
_partFrameLabels.overshirt["51"] = "egyptArch";
_partFrameLabels.overshirt["52"] = "oldPilot";
_partFrameLabels.overshirt["53"] = "sponsorFLlemon";
_partFrameLabels.overshirt["54"] = "mummy";
_partFrameLabels.overshirt["55"] = "hippie";
_partFrameLabels.overshirt["56"] = "hipHop";
_partFrameLabels.overshirt["57"] = "hiker";
_partFrameLabels.overshirt["58"] = "gothGirl";
_partFrameLabels.overshirt["59"] = "sponsorOS2";
_partFrameLabels.overshirt["60"] = "medalNabooti";
_partFrameLabels.overshirt["61"] = "sponsorOS2b";
_partFrameLabels.overshirt["62"] = "sponsorPP2";
_partFrameLabels.overshirt["63"] = "yogosBucks";
_partFrameLabels.overshirt["64"] = "sponsorSBdog";
_partFrameLabels.overshirt["65"] = "sponsorSBsuit";
_partFrameLabels.overshirt["66"] = "monkey";
_partFrameLabels.overshirt["67"] = "sheep";
_partFrameLabels.overshirt["68"] = "pKnight1";
_partFrameLabels.overshirt["69"] = "pBall1";
_partFrameLabels.overshirt["70"] = "pRiding1";
_partFrameLabels.overshirt["71"] = "sponsorHSM3";
_partFrameLabels.overshirt["72"] = "vest1";
_partFrameLabels.overshirt["73"] = "vest2";
_partFrameLabels.overshirt["74"] = "vest3";
_partFrameLabels.overshirt["75"] = "tie1";
_partFrameLabels.overshirt["76"] = "tie2";
_partFrameLabels.overshirt["77"] = "tie3";
_partFrameLabels.overshirt["78"] = "medalBigNate";
_partFrameLabels.overshirt["79"] = "jacket1";
_partFrameLabels.overshirt["80"] = "pRobot";
_partFrameLabels.overshirt["81"] = "pRobot1b";
_partFrameLabels.overshirt["82"] = "pPharaoh";
_partFrameLabels.overshirt["83"] = "pEgyptQ";
_partFrameLabels.overshirt["84"] = "pSamurai";
_partFrameLabels.overshirt["85"] = "pRockerGuy1";
_partFrameLabels.overshirt["86"] = "pRockerGirl1";
_partFrameLabels.overshirt["87"] = "pDog1";
_partFrameLabels.overshirt["88"] = "pPopGirl1";
_partFrameLabels.overshirt["89"] = "pPopGirl2";
_partFrameLabels.overshirt["90"] = "pPopGirl3";
_partFrameLabels.overshirt["91"] = "pRobinhood1";
_partFrameLabels.overshirt["92"] = "pRobinhood2";
_partFrameLabels.overshirt["93"] = "pRobinhood3";
_partFrameLabels.overshirt["94"] = "pRobinhood4";
_partFrameLabels.overshirt["95"] = "pRobinhood5";
_partFrameLabels.overshirt["96"] = "pFairy1";
_partFrameLabels.overshirt["97"] = "sponsorPinoPino";
_partFrameLabels.overshirt["98"] = "sponsorGbMummy";
_partFrameLabels.overshirt["99"] = "astroChance";
_partFrameLabels.overshirt["100"] = "greenKnight";
_partFrameLabels.overshirt["101"] = "astroGuard1";
_partFrameLabels.overshirt["102"] = "astroRoyal1";
_partFrameLabels.overshirt["103"] = "astroKing";
_partFrameLabels.overshirt["104"] = "astroManure";
_partFrameLabels.overshirt["105"] = "astroGuard2";
_partFrameLabels.overshirt["106"] = "astroCult";
_partFrameLabels.overshirt["107"] = "medalAstro";
_partFrameLabels.overshirt["108"] = "lifeJacket";
_partFrameLabels.overshirt["109"] = "pSingerGuy1";
_partFrameLabels.overshirt["110"] = "pPirateGuy1";
_partFrameLabels.overshirt["111"] = "pCone";
_partFrameLabels.overshirt["112"] = "pCowgirl1";
_partFrameLabels.overshirt["113"] = "pCowboy1";
_partFrameLabels.overshirt["114"] = "pRobot2";
_partFrameLabels.overshirt["115"] = "pRobot3";
_partFrameLabels.overshirt["116"] = "pRobot4";
_partFrameLabels.overshirt["117"] = "pRobot5";
_partFrameLabels.overshirt["118"] = "pAstronaut1";
_partFrameLabels.overshirt["119"] = "sponsorBedB1";
_partFrameLabels.overshirt["120"] = "sponsorCWMB1";
_partFrameLabels.overshirt["121"] = "sponsorCWMB2";
_partFrameLabels.overshirt["122"] = "pFirefighter1";
_partFrameLabels.overshirt["123"] = "pClown1";
_partFrameLabels.overshirt["124"] = "pPopGirlLE";
_partFrameLabels.overshirt["125"] = "sponsorLegoBio";
_partFrameLabels.overshirt["126"] = "pBiker1";
_partFrameLabels.overshirt["127"] = "vampire";
_partFrameLabels.overshirt["128"] = "pumpkin";
_partFrameLabels.overshirt["129"] = "frankenstein";
_partFrameLabels.overshirt["130"] = "hyde";
_partFrameLabels.overshirt["131"] = "sponsorGbCrow";
_partFrameLabels.overshirt["132"] = "skeleton1";
_partFrameLabels.overshirt["133"] = "sponsorTinkerbell";
_partFrameLabels.overshirt["135"] = "sponsorIceAge";
_partFrameLabels.overshirt["136"] = "sponsorEC1";
_partFrameLabels.overshirt["137"] = "sponsorEC2";
_partFrameLabels.overshirt["138"] = "sponsorMinc1";
_partFrameLabels.overshirt["139"] = "sponsorMinc2";
_partFrameLabels.overshirt["140"] = "sponsorSBsanta";
_partFrameLabels.overshirt["141"] = "sponsorSBsanta2";
_partFrameLabels.overshirt["142"] = "sponsorSBsanta3";
_partFrameLabels.overshirt["143"] = "sponsorPFxmas";
_partFrameLabels.overshirt["144"] = "sponsorNM2guard";
_partFrameLabels.overshirt["145"] = "fisherman2";
_partFrameLabels.overshirt["146"] = "shadyCop";
_partFrameLabels.overshirt["147"] = "securityGuard1";
_partFrameLabels.overshirt["148"] = "sponsorMinc3";
_partFrameLabels.overshirt["149"] = "pSnowman";
_partFrameLabels.overshirt["150"] = "medalCounter";
_partFrameLabels.overshirt["151"] = "sponsorCWMBnoodle";
_partFrameLabels.overshirt["152"] = "sponsorCWMBcone";
_partFrameLabels.overshirt["153"] = "medalReality";
_partFrameLabels.overshirt["154"] = "buckyLucas";
_partFrameLabels.overshirt["155"] = "mikesMarket";
_partFrameLabels.overshirt["156"] = "sponsorFuzzy";
_partFrameLabels.overshirt["157"] = "sponsorFLegypt1";
_partFrameLabels.overshirt["158"] = "sponsorFLegypt2";
_partFrameLabels.overshirt["159"] = "triton";
_partFrameLabels.overshirt["160"] = "aeolus";
_partFrameLabels.overshirt["161"] = "poseidon";
_partFrameLabels.overshirt["162"] = "zeus";
_partFrameLabels.overshirt["163"] = "hercules";
_partFrameLabels.overshirt["164"] = "aphrodite";
_partFrameLabels.overshirt["165"] = "minotaur";
_partFrameLabels.overshirt["166"] = "athenaOld";
_partFrameLabels.overshirt["167"] = "mythPes3";
_partFrameLabels.overshirt["168"] = "medalMythology";
_partFrameLabels.overshirt["169"] = "pPunkGuy1";
_partFrameLabels.overshirt["170"] = "pRabbot";
_partFrameLabels.overshirt["171"] = "pDrHare_Scientist";
_partFrameLabels.overshirt["172"] = "sponsorFuryV";
_partFrameLabels.overshirt["173"] = "pFool";
_partFrameLabels.overshirt["174"] = "fisherman3";
_partFrameLabels.overshirt["175"] = "skullMainOldLady";
_partFrameLabels.overshirt["176"] = "skullMainFarmer2";
_partFrameLabels.overshirt["177"] = "skullMainGuard1";
_partFrameLabels.overshirt["178"] = "captCrawfish";
_partFrameLabels.overshirt["179"] = "skullPirate2";
_partFrameLabels.overshirt["180"] = "skullPirate3";
_partFrameLabels.overshirt["181"] = "skullMainHayLady";
_partFrameLabels.overshirt["182"] = "skullCannon";
_partFrameLabels.overshirt["183"] = "skullWarehouse";
_partFrameLabels.overshirt["184"] = "skullElegantLady";
_partFrameLabels.overshirt["185"] = "skullMoroLady3";
_partFrameLabels.overshirt["186"] = "skullMoroLady1";
_partFrameLabels.overshirt["187"] = "skullChinaShipwright";
_partFrameLabels.overshirt["188"] = "skullChinaWiseLady";
_partFrameLabels.overshirt["189"] = "medalSkull";
_partFrameLabels.overshirt["190"] = "sponsorMH_overshirt1";
_partFrameLabels.overshirt["191"] = "sponsorMH_overshirt2";
_partFrameLabels.overshirt["192"] = "sponsorMH_overshirt3";
_partFrameLabels.overshirt["193"] = "sponsorMH_overshirt4";
_partFrameLabels.overshirt["194"] = "sponsorMH_overshirt5";
_partFrameLabels.overshirt["195"] = "sponsorMH_overshirt6";
_partFrameLabels.overshirt["196"] = "sponsorMH_Mummy";
_partFrameLabels.overshirt["197"] = "sponsorMargo";
_partFrameLabels.overshirt["198"] = "sponsorPercyJackson";
_partFrameLabels.overshirt["199"] = "pMythSurferZeus";
_partFrameLabels.overshirt["200"] = "pMythSurferHades";
_partFrameLabels.overshirt["201"] = "pMythSurferPose";
_partFrameLabels.overshirt["202"] = "pGrad";
_partFrameLabels.overshirt["203"] = "sponsor_SelenaG";
_partFrameLabels.overshirt["204"] = "sponsor_Ramona";
_partFrameLabels.overshirt["205"] = "sponsorCDdog";
_partFrameLabels.overshirt["206"] = "sponsorDOWKwrest";
_partFrameLabels.overshirt["207"] = "medalSteam";
_partFrameLabels.overshirt["208"] = "steamCaptain";
_partFrameLabels.overshirt["209"] = "steamSully";
_partFrameLabels.overshirt["210"] = "pVampire_boy";
_partFrameLabels.overshirt["211"] = "pVampire_girl01";
_partFrameLabels.overshirt["212"] = "pVampire_girl02";
_partFrameLabels.overshirt["213"] = "pVampire_girl03";
_partFrameLabels.overshirt["214"] = "sponsorCityGirl";
_partFrameLabels.overshirt["215"] = "sponsorNannyMcPhee";
_partFrameLabels.overshirt["216"] = "pSteamRobot";
_partFrameLabels.overshirt["217"] = "sponsor_MrHan";
_partFrameLabels.overshirt["218"] = "medalPeanuts";
_partFrameLabels.overshirt["219"] = "sponsor_BarbieB";
_partFrameLabels.overshirt["220"] = "sponsorLegoHero";
_partFrameLabels.overshirt["221"] = "pFM1";
_partFrameLabels.overshirt["222"] = "pFM2";
_partFrameLabels.overshirt["223"] = "pFM3";
_partFrameLabels.overshirt["224"] = "pFM4";
_partFrameLabels.overshirt["225"] = "pFM5";
_partFrameLabels.overshirt["226"] = "pFM6";
_partFrameLabels.overshirt["227"] = "pFM7";
_partFrameLabels.overshirt["228"] = "pFM8";
_partFrameLabels.overshirt["229"] = "sponsorAppleJacks_blitz";
_partFrameLabels.overshirt["230"] = "scottishMan";
_partFrameLabels.overshirt["231"] = "rowBoatMan";
_partFrameLabels.overshirt["232"] = "sponsorMummyFL";
_partFrameLabels.overshirt["233"] = "medalCryptids";
_partFrameLabels.overshirt["234"] = "snootyDog";
_partFrameLabels.overshirt["235"] = "ballonPilate01";
_partFrameLabels.overshirt["236"] = "butler";
_partFrameLabels.overshirt["237"] = "HunterGiveUp";
_partFrameLabels.overshirt["238"] = "bartenderPub";
_partFrameLabels.overshirt["239"] = "fortuneHunter2";
_partFrameLabels.overshirt["240"] = "wwSaloonGirl";
_partFrameLabels.overshirt["241"] = "pTangled_n_Lights";
_partFrameLabels.overshirt["242"] = "sponserOS3";
_partFrameLabels.overshirt["243"] = "sponsorOS3_Ursa";
_partFrameLabels.overshirt["244"] = "sponsorOS3_Doug";
_partFrameLabels.overshirt["245"] = "cryptidHarness";
_partFrameLabels.overshirt["246"] = "promoWWday5";
_partFrameLabels.overshirt["247"] = "promoWWday6";
_partFrameLabels.overshirt["248"] = "wwTrader";
_partFrameLabels.overshirt["249"] = "wwMustachioB";
_partFrameLabels.overshirt["250"] = "wwMarshal";
_partFrameLabels.overshirt["251"] = "wwGSEvil";
_partFrameLabels.overshirt["252"] = "wwBanditGirl";
_partFrameLabels.overshirt["253"] = "wwPrisoner";
_partFrameLabels.overshirt["254"] = "wwBadge";
_partFrameLabels.overshirt["255"] = "medalWest";
_partFrameLabels.overshirt["256"] = "wwMexBandit";
_partFrameLabels.overshirt["257"] = "wwCasinoPatron2";
_partFrameLabels.overshirt["258"] = "RattleSnake";
_partFrameLabels.overshirt["259"] = "sponsorHOPsuit";
_partFrameLabels.overshirt["260"] = "medalWimpy";
_partFrameLabels.overshirt["261"] = "paperBoy";
_partFrameLabels.overshirt["262"] = "paperGirl";
_partFrameLabels.overshirt["263"] = "sponsorMonsterHigh";
_partFrameLabels.overshirt["264"] = "pOutlaw_boys";
_partFrameLabels.overshirt["265"] = "pOutlaw_girls";
_partFrameLabels.overshirt["266"] = "paperBoy_01";
_partFrameLabels.overshirt["267"] = "paperBoy_02";
_partFrameLabels.overshirt["268"] = "paperGirl_01";
_partFrameLabels.overshirt["269"] = "paperGirl_02";
_partFrameLabels.overshirt["270"] = "pPeaceMaker";
_partFrameLabels.overshirt["271"] = "sponsorMonsterHigh_Draculara";
_partFrameLabels.overshirt["272"] = "MTHbonsaiWoman";
_partFrameLabels.overshirt["273"] = "MTHjack";
_partFrameLabels.overshirt["274"] = "MTHshogunCasual";
_partFrameLabels.overshirt["275"] = "medalRedDragon";
_partFrameLabels.overshirt["276"] = "MTHprisoner";
_partFrameLabels.overshirt["277"] = "MTHdragonPuppeteer";
_partFrameLabels.overshirt["278"] = "MTHyokoAsst";
_partFrameLabels.overshirt["279"] = "MTHyWoman";
_partFrameLabels.overshirt["280"] = "MTHfishmonger";
_partFrameLabels.overshirt["281"] = "MTHgardener02";
_partFrameLabels.overshirt["282"] = "MTHfanDancer";
_partFrameLabels.overshirt["283"] = "sponsorLM_Stella";
_partFrameLabels.overshirt["284"] = "sponsorLM_Wen";
_partFrameLabels.overshirt["285"] = "MTHfemWar";
_partFrameLabels.overshirt["286"] = "sponsorRingLeader";
_partFrameLabels.overshirt["287"] = "MTHwoman";
_partFrameLabels.overshirt["288"] = "TpirateBlue";
_partFrameLabels.overshirt["289"] = "Srcj";
_partFrameLabels.overshirt["290"] = "LSword_robot1";
_partFrameLabels.overshirt["291"] = "sponsorGregWrapped";
_partFrameLabels.overshirt["292"] = "sponsor_PoppersPenguins_body";
_partFrameLabels.overshirt["293"] = "ShrinkRayPromo4";
_partFrameLabels.overshirt["294"] = "ShrinkRayPromo5";
_partFrameLabels.overshirt["295"] = "medalShrinkRay";
_partFrameLabels.overshirt["296"] = "LSword_robot3";
_partFrameLabels.overshirt["297"] = "sponsor_Smurfs";
_partFrameLabels.overshirt["298"] = "sponsorFijitFriends";
_partFrameLabels.overshirt["299"] = "sponsor_Rio";
_partFrameLabels.overshirt["300"] = "LSword_robot4";
_partFrameLabels.overshirt["301"] = "sponsor_Rio_flightless";
_partFrameLabels.overshirt["302"] = "Sponsor_AdventureTime_JakeOutfit";
_partFrameLabels.overshirt["303"] = "mtPinkertonThug";
_partFrameLabels.overshirt["304"] = "mtCoalMan";
_partFrameLabels.overshirt["305"] = "Mtrich01";
_partFrameLabels.overshirt["306"] = "MTrich02";
_partFrameLabels.overshirt["307"] = "medalMysteryTrain";
_partFrameLabels.overshirt["308"] = "mtDancer";
_partFrameLabels.overshirt["309"] = "TrockKnight";
_partFrameLabels.overshirt["310"] = "TdreadRocker";
_partFrameLabels.overshirt["311"] = "pSherlock";
_partFrameLabels.overshirt["312"] = "MTteslaChains";
_partFrameLabels.overshirt["313"] = "blueBlazer";
_partFrameLabels.overshirt["314"] = "sponsorHasbroFGN";
_partFrameLabels.overshirt["315"] = "pPopcake";
_partFrameLabels.overshirt["316"] = "sponsorLionKing";
_partFrameLabels.overshirt["317"] = "sponsorAuntOpal";
_partFrameLabels.overshirt["318"] = "GSrProf";
_partFrameLabels.overshirt["319"] = "GSrAthlet";
_partFrameLabels.overshirt["320"] = "GsrPopc";
_partFrameLabels.overshirt["321"] = "GSrHost";
_partFrameLabels.overshirt["322"] = "GSrAthlet02";
_partFrameLabels.overshirt["323"] = "GSgiftShop";
_partFrameLabels.overshirt["324"] = "Tron_robot";
_partFrameLabels.overshirt["325"] = "GSbowlingBall";
_partFrameLabels.overshirt["326"] = "medalGameShow";
_partFrameLabels.overshirt["327"] = "sponsorJackAndJill";
_partFrameLabels.overshirt["328"] = "sponsorFijitFriendsDance";
_partFrameLabels.overshirt["329"] = "sponsor_CabinFever";
_partFrameLabels.overshirt["330"] = "GSrobotPromo";
_partFrameLabels.overshirt["331"] = "sponsorChipWrecked_Zoe";
_partFrameLabels.overshirt["332"] = "sponsorBen10_Humungosaur";
_partFrameLabels.overshirt["333"] = "sponsorBen10_ben10Jacket";
_partFrameLabels.overshirt["334"] = "sponsorBen10_RexJacket";
_partFrameLabels.overshirt["335"] = "pBully_bot";
_partFrameLabels.overshirt["336"] = "Gtent";
_partFrameLabels.overshirt["337"] = "Geditor";
_partFrameLabels.overshirt["338"] = "GpromoDaphne";
_partFrameLabels.overshirt["339"] = "medalGhostStory";
_partFrameLabels.overshirt["340"] = "SRishmael";
_partFrameLabels.overshirt["341"] = "SRflask";
_partFrameLabels.overshirt["342"] = "sponsorTreasureBuddies";
_partFrameLabels.overshirt["343"] = "medalSOS";
_partFrameLabels.overshirt["344"] = "sponsorMonsterHigh1600_dress";
_partFrameLabels.overshirt["345"] = "SRhazmat";
_partFrameLabels.overshirt["346"] = "sponsor_Arrietty_Pod";
_partFrameLabels.overshirt["347"] = "sponsorThe_Lorax_Thneed";
_partFrameLabels.overshirt["348"] = "sponsor_Mooney";
_partFrameLabels.overshirt["349"] = "p_seaCaptain";
_partFrameLabels.overshirt["350"] = "medalVampire";
_partFrameLabels.overshirt["351"] = "VCamulet";
_partFrameLabels.overshirt["352"] = "sponsorMirrorMirror_tie";
_partFrameLabels.overshirt["353"] = "sponsorMirrorMirror_Dwarf";
_partFrameLabels.overshirt["354"] = "VChunter";
_partFrameLabels.overshirt["355"] = "p_CountVampire";
_partFrameLabels.overshirt["356"] = "TTamulet";
_partFrameLabels.overshirt["357"] = "medalWoodland";
_partFrameLabels.overshirt["358"] = "TT_elf1";
_partFrameLabels.overshirt["359"] = "TT_elfQueen";
_partFrameLabels.overshirt["360"] = "WLconstr";
_partFrameLabels.overshirt["361"] = "pTroll";
_partFrameLabels.overshirt["362"] = "pLeprechaun";
_partFrameLabels.overshirt["363"] = "sponsorThePirates_LizBling";
_partFrameLabels.overshirt["364"] = "sponsorThePirates_CapBelt";
_partFrameLabels.overshirt["365"] = "Pie_Cherry";
_partFrameLabels.overshirt["366"] = "Pie_Lemon";
_partFrameLabels.overshirt["367"] = "Pie_Mud";
var partsLoading = 0;
var gLoadedParts = new Object();
var default_girl = {marks:1,facial:1,hair:"sponsor_selenag",shirt:"brandxpand_defaultgirl",pants:6,pack:1,item:1,overshirt:1,overpants:1};
var default_boy = {marks:1,facial:1,hair:"sears5",shirt:"brandxpand_defaultboy",pants:6,pack:1,item:1,overshirt:1,overpants:1};
var defaultShirtExceptions = {ad_randyninja:"mthninjablue",sponsor_arrietty_tshirt:"shirtvest2",sponsor_barbieb:"shirtvest1"};
var defaultPantsExceptions = {ad_randyninja:"mthninjablue"};
var defaultFacialExceptions = {ad_randyninja:"mthninjablue"};
var vExpiredStatus = false;
var activeAbilities = new Array();
var colors = [16768981,16764057,16108912,14193168,9321734,3394560,3381504,39372,3355596,13743099,10053324,16776960,16763955,16724736,16751052,16724889,52428,13421772,16777215,3355443];
var normalSkinColors = [16768981,16764057,16108912,14193168,9321734];
var normalHairColors = [16764057,16108912,14193168,9321734,16776960,16763955,16724736,13421772,5382915,3479042];
var monsterSkinColors = [16768981,16764057,16108912,14193168,9321734];
var monsterHairColors = [16764057,16108912,14193168,9321734,16776960,16763955,16724736,13421772,5382915,3479042];
var specialAbility;
var specialAbilityParams;
var monsterhair = ["fm1","fm2","fm3","fm4","fm5","fm6","fm7","fm8","fm9","fm10","fm11","fm12","fm13","fm14","fm15","fm16"];
var monsterpack = ["fm1","fm2","fm3","fm4","fm5","fm6","fm7","fm8"];
var monstermark = ["fm1","fm2","fm3","fm4","fm5","fm6","fm7","fm8","fm9","fm10"];
var monstermouth = ["fm1","fm2","fm3","fm4","fm5","fm6","fm7","fm8"];
var monsterpants = ["bare"];
var monstershirt = ["fm1","fm2","fm3","fm4","fm5","fm6","fm7"];
var normalboyhair = [1,3,4,6,7,8,9,10,11,14,22,24,26,28,34,35,36,44,"swaziGuy2"];
var normalgirlhair = [15,16,17,18,19,20,21,23,27,29,30,32,38,39,40,43,"Sears1","Sears2","Sears3","girlHair4","girlHair5"];
var radboyhair = [2,5,12,13,25,37,41,"bartholdi","frenchman","nerd"];
var radgirlhair = [5,12,14,33,42,"hulaLady","sacagawea","girlHair1","girlHair2","girlHair3","girlHair6"];
var normalboypack = [1];
var normalgirlpack = [1];
var radboypack = [1,1,1,2];
var radgirlpack = [1,1,1,3];
var normalboyitem = [1];
var normalgirlitem = [1];
var radboyitem = [1,1,1,1,5,6,7,8];
var radgirlitem = [1,1,1,1,5,6,7,8];
var normalboymouth = [1,2,3,4,5,6,7,12,14,15,16,17,"leo","prisoner4","nerd","teethGrin2"];
var normalgirlmouth = [1,2,3,4,5,6,7,9,10,11,12,14,15,16,17,18,19,"prisoner2","leo","prisoner4","nerd","teethGrin2"];
var radboymouth = [];
var radgirlmouth = [];
var normalboymarks = [1];
var normalgirlmarks = [1];
var radboymarks = [];
var radgirlmarks = [1,1,1,"bangs1","bangs2","bangs3","bangs4","beautymark","freckles"];
var normalboyfacial = [1];
var normalgirlfacial = [1];
var radboyfacial = [1,1,1,2,3,6,7,8,"nerd","lawyer"];
var radgirlfacial = [1,1,1,2,3,4,5,7,8,"pinkGlasses","girlCap1","girlCap2","girlCap3"];
var normalboypants = [1,2,3,6,10,11,13,"fisherman","Sears2","Sears4","Sears5","Sears6","Nim2"];
var normalgirlpants = [1,2,3,4,8,9,11,12,13,14,"fisherman","Sears2","Sears3","Nim2","girlSkirt1"];
var radboypants = [7,"skater","explorer","finVender"];
var radgirlpants = [7,"skater","explorer","finVender","pinkSkirt","sponsorCTCgirl","Sears4","girlSkirt2","girlSkirt3","girlSkirt4","girlSkirt5"];
var normalboyoverpants = [1];
var normalgirloverpants = [1];
var radboyoverpants = [1];
var radgirloverpants = [1];
var normalboyshirt = [1,3,4,5,6,11,12,13,14,15,16,17,21,22,26,"skater","chineseArtist","Sears4","Sears5","Sears6","egyptArch","boyShirt1"];
var normalgirlshirt = [1,2,3,4,5,6,7,9,10,11,12,13,19,23,25,26,"skater","pinkV","Sears1","Sears2","Sears3","egyptArch"];
var radboyshirt = ["van","nim2","edworker2","referee","tourist","SS"];
var radgirlshirt = ["rat","nim1","referee","tourist","shirtVest1","musicShirt1","musicShirt2"];
var normalboyovershirt = [1];
var normalgirlovershirt = [1];
var radboyovershirt = [1,1,1,1,"Sears5","jacket1"];
var radgirlovershirt = [1,1,1,1,"Sears1","Sears2","necklace","vest1","vest2","vest3","tie1","tie2","tie3","jacket1"];
lineAlpha = 100;
var FunBrain_so = getNewSO("Char","/");
this.createEmptyMovieClip("colorSetter",this.getNextHighestDepth());
if(FunBrain_so.data.shirtFrame.substr(0,2) == "fm")
{
   FunBrain_so.data.shirtFrame = 1;
}
if(FunBrain_so.data.timeWarp && _parent.isChar)
{
   _parent.setGlow();
}
fatBody._visible = false;
