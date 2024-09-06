class multiplayer.MultiUserObjectManager
{
   static var mGroup;
   static var mBaseScope;
   static var mInitialized = false;
   static var mCreateForNewUserTimer = null;
   static var mNewUserData = null;
   static var CREATE_FOR_NEW_USER_UPDATE = 1000;
   function MultiUserObjectManager()
   {
   }
   static function init(baseScope)
   {
      multiplayer.MultiUserObjectManager.mGroup = new GroupManager();
      multiplayer.MultiUserObjectManager.mBaseScope = baseScope;
      multiplayer.MultiUserObjectManager.mInitialized = true;
      utils.Logger.setWarningLevel(utils.Logger.VERBOSE);
   }
   static function reset()
   {
      multiplayer.MultiUserObjectManager.stopCreateForNewUser();
      multiplayer.MultiUserObjectManager.mGroup.deleteAllElements();
      multiplayer.MultiUserObjectManager.mInitialized = false;
      multiplayer.MultiUserObjectManager.mGroup = null;
      multiplayer.MultiUserObjectManager.mBaseScope = null;
      multiplayer.MultiUserObjectManager.mCreateForNewUserTimer = null;
      multiplayer.MultiUserObjectManager.mNewUserData = null;
      utils.Logger.log("MultiUserObjectManager :: resetting...",utils.Logger.ALL);
   }
   static function createNew(type, scope, baseScope, x, y)
   {
      if(!multiplayer.MultiUserObjectManager.mInitialized)
      {
         multiplayer.MultiUserObjectManager.init(baseScope);
      }
      var _loc6_ = undefined;
      var _loc3_ = multiplayer.MultiUserObjectManager.getElementsOfType(type);
      if(_loc3_.length > 0)
      {
         _loc6_ = _loc3_[0];
         if(!_loc6_.allowMultipleInstances())
         {
            utils.Logger.log("MultiUserObjectManager :: object of type " + type + " already exists.  No more can be created.",utils.Logger.WARNING);
            return undefined;
         }
      }
      var _loc5_ = ["create"];
      utils.Logger.log("MultiUserObjectManager :: createNew : " + _loc5_.concat(arguments),utils.Logger.ALL);
      var _loc4_ = Math.floor(Math.random() * 10000);
      var _loc2_ = _loc5_.concat(arguments);
      multiplayer.MultiUserObjectManager.sendAction(_loc4_,_loc2_);
      _loc2_[0] = "createForNewUser";
      multiplayer.MultiUserObjectManager.mNewUserData = new Object();
      multiplayer.MultiUserObjectManager.mNewUserData.id = _loc4_;
      multiplayer.MultiUserObjectManager.mNewUserData.params = _loc2_;
   }
   static function create(id, type, scope, baseScope, x, y)
   {
      utils.Logger.log("MultiUserObjectManager :: create : " + arguments,utils.Logger.ALL);
      if(typeof type == "string")
      {
         type = Number(type);
      }
      if(typeof scope == "string")
      {
         scope = eval(scope);
      }
      if(typeof baseScope == "string")
      {
         baseScope = eval(baseScope);
      }
      if(typeof id == "string")
      {
         id = Number(id);
      }
      if(!multiplayer.MultiUserObjectManager.mInitialized)
      {
         multiplayer.MultiUserObjectManager.init(baseScope);
      }
      var multiUserObject;
      var multiUserObjects = multiplayer.MultiUserObjectManager.getElementsOfType(type);
      if(multiUserObjects.length > 0)
      {
         if(multiplayer.MultiUserObjectManager.mGroup.getElementByID(id,type) != null)
         {
            utils.Logger.log("MultiUserObjectManager :: object with id " + id + " already exists.",utils.Logger.WARNING);
            return undefined;
         }
         multiUserObject = multiUserObjects[0];
         if(!multiUserObject.allowMultipleInstances())
         {
            utils.Logger.log("MultiUserObjectManager :: object of type " + type + " already exists.  No more can be created.",utils.Logger.WARNING);
            return undefined;
         }
      }
      switch(type)
      {
         case multiplayer.MultiUserObjectType.FORTUNE_COOKIE:
            multiUserObject = new multiplayer.FortuneCookie(scope);
            multiplayer.FortuneCookie(multiUserObject).show();
            break;
         case multiplayer.MultiUserObjectType.PRANK_CAN:
            multiUserObject = new multiplayer.PrankCan(scope);
            multiplayer.PrankCan(multiUserObject).show();
            break;
         default:
            utils.Logger.log("MultiUserObjectManager :: Unknown object type : " + type,utils.Logger.ERROR);
            return undefined;
      }
      multiplayer.MultiUserObjectManager.mGroup.addElement(multiUserObject,id,type);
      multiUserObject.setBaseScope(baseScope);
      multiUserObject.setPosition(Number(x),Number(y));
      multiUserObject.setID(id);
      multiUserObject.setType(type);
      if(multiplayer.MultiUserObjectManager.mNewUserData != null)
      {
         if(type == multiplayer.MultiUserObjectType.FORTUNE_COOKIE)
         {
            multiUserObject.broadcastUserName();
            var randomFortune = multiplayer.FortuneCookie(multiUserObject).getRandomFortune();
            multiplayer.MultiUserObjectManager.sendAction(id,["setFortune",randomFortune]);
         }
         if(type == multiplayer.MultiUserObjectType.PRANK_CAN)
         {
            multiplayer.MultiUserObjectManager.sendAction(id,["setPrank",_global.prank,_global.canFrame]);
         }
         multiplayer.MultiUserObjectManager.startCreateForNewUser();
      }
      return multiUserObject;
   }
   static function createForNewUser(id, type, scope, baseScope, x, y, arg1, arg2, arg3)
   {
      if(typeof id == "string")
      {
         id = Number(id);
      }
      if(typeof type == "string")
      {
         type = Number(type);
      }
      if(typeof baseScope == "string")
      {
         baseScope = eval(baseScope);
      }
      if(!multiplayer.MultiUserObjectManager.mInitialized)
      {
         multiplayer.MultiUserObjectManager.init(baseScope);
      }
      utils.Logger.log("MultiUserObjectManager :: id is : " + multiplayer.MultiUserObjectManager.mGroup.getElementByID(id,type) + " for id : " + id,utils.Logger.VERBOSE);
      if(multiplayer.MultiUserObjectManager.mGroup.getElementByID(id,type) == null)
      {
         utils.Logger.log("MultiUserObjectManager :: createForNewUser( " + arguments + " )",utils.Logger.ALL);
         var multiUserObject = multiplayer.MultiUserObjectManager.create(id,type,scope,baseScope,x,y);
         switch(type)
         {
            case multiplayer.MultiUserObjectType.FORTUNE_COOKIE:
               multiplayer.FortuneCookie(multiUserObject).setObjectClicks(Number(arg1));
               multiUserObject.setLeaderUserName(arg2);
               multiplayer.FortuneCookie(multiUserObject).setFortune(arg3);
               break;
            case multiplayer.MultiUserObjectType.PRANK_CAN:
               multiplayer.PrankCan(multiUserObject).setObjectClicks(Number(arg1));
               multiplayer.PrankCan(multiUserObject).setPrank(arg2,arg3);
               break;
            default:
               utils.Logger.log("MultiUserObjectManager :: Unknown object type : " + type,utils.Logger.ERROR);
         }
         return multiUserObject;
      }
   }
   static function objectClicked(id, total)
   {
      if(typeof id == "string")
      {
         id = Number(id);
      }
      if(typeof total == "string")
      {
         total = Number(total);
      }
      var _loc3_ = multiplayer.MultiUserObjectManager.mGroup.getElementByID(id);
      _loc3_.objectClicked(total);
   }
   static function removeObject(id)
   {
      if(typeof id == "string")
      {
         id = Number(id);
      }
      if(multiplayer.MultiUserObjectManager.mGroup.getTotalGroupElements() < 2)
      {
         multiplayer.MultiUserObjectManager.stopCreateForNewUser();
      }
      var _loc2_ = multiplayer.MultiUserObjectManager.mGroup.getElementByID(id);
      _loc2_.removeObject();
      multiplayer.MultiUserObjectManager.mGroup.removeElement(id);
   }
   static function sendAction(id, params)
   {
      utils.Logger.log("MultiUserObjectManager :: Sending Action *******\nred5 : " + multiplayer.MultiUserObjectManager.mBaseScope.camera.scene.red5 + "\nserver : " + multiplayer.MultiUserObjectManager.mBaseScope.server + "\nid : " + id + "\nparams: " + params,utils.Logger.VERBOSE);
      if(multiplayer.MultiUserObjectManager.mBaseScope.camera.scene.red5 && multiplayer.MultiUserObjectManager.mBaseScope.server)
      {
         var _loc1_ = params.slice();
         var _loc3_ = _loc1_[0];
         _loc1_.unshift(id);
         _loc1_[0] = _loc3_;
         _loc1_[1] = id;
         multiplayer.MultiUserObjectManager.mBaseScope.server.call("emotion",null,"multiUserObjectAction",_loc1_.join(", "));
      }
   }
   static function setLeaderUserName(id, name)
   {
      if(typeof id == "string")
      {
         id = Number(id);
      }
      var _loc2_ = multiplayer.MultiUserObjectManager.mGroup.getElementByID(id);
      _loc2_.setLeaderUserName(name);
   }
   static function setFortune(id, fortune)
   {
      if(typeof id == "string")
      {
         id = Number(id);
      }
      var _loc2_ = multiplayer.MultiUserObjectManager.mGroup.getElementByID(id);
      _loc2_.setFortune(fortune);
   }
   static function setPrank(id, prank, frame)
   {
      if(typeof id == "string")
      {
         id = Number(id);
      }
      var _loc2_ = multiplayer.MultiUserObjectManager.mGroup.getElementByID(id);
      _loc2_.setPrank(prank,frame);
   }
   static function startCreateForNewUser()
   {
      var _loc4_ = multiplayer.MultiUserObjectManager.mNewUserData.id;
      var _loc5_ = multiplayer.MultiUserObjectManager.mNewUserData.params;
      var _loc2_ = multiplayer.MultiUserObjectManager.mGroup.getElementByID(_loc4_);
      if(_loc4_ != undefined && _loc5_ != undefined && _loc2_ != undefined && _loc2_ != null)
      {
         multiplayer.MultiUserObjectManager.mCreateForNewUserTimer = _global.setTimeout(Delegate.create(multiplayer.MultiUserObjectManager,multiplayer.MultiUserObjectManager.startCreateForNewUser),multiplayer.MultiUserObjectManager.CREATE_FOR_NEW_USER_UPDATE);
         var _loc6_ = _loc2_.getType();
         var _loc3_ = _loc5_.slice();
         switch(_loc6_)
         {
            case multiplayer.MultiUserObjectType.FORTUNE_COOKIE:
               _loc3_.push(_loc2_.getObjectClickTotal());
               _loc3_.push(_loc2_.getLeaderUserName());
               _loc3_.push(multiplayer.FortuneCookie(_loc2_).getFortune());
               break;
            case multiplayer.MultiUserObjectType.PRANK_CAN:
               _loc3_.push(_loc2_.getObjectClickTotal());
               _loc3_.push(multiplayer.PrankCan(_loc2_).getPrank());
               _loc3_.push(multiplayer.PrankCan(_loc2_).getCanFrame());
               break;
            default:
               utils.Logger.log("MultiUserObjectManager :: Unknown object type : " + _loc6_,utils.Logger.ERROR);
         }
         multiplayer.MultiUserObjectManager.sendAction(_loc4_,_loc3_);
      }
      else
      {
         utils.Logger.log("MultiUserObjectManager :: Aborting create of null object.",utils.Logger.ERROR);
      }
   }
   static function stopCreateForNewUser()
   {
      _global.clearTimeout(multiplayer.MultiUserObjectManager.mCreateForNewUserTimer);
      multiplayer.MultiUserObjectManager.mCreateForNewUserTimer = null;
      multiplayer.MultiUserObjectManager.mNewUserData = null;
   }
   static function getElementsOfType(type)
   {
      return multiplayer.MultiUserObjectManager.mGroup.getGroup(type);
   }
}
