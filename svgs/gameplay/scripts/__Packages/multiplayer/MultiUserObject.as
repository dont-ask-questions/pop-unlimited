class multiplayer.MultiUserObject
{
   var mScope;
   var mPosition;
   var mBaseScope;
   var mID;
   var mType;
   var mLeaderUserName;
   var mAllowMultipleInstances = false;
   var mClickTotal = 0;
   function MultiUserObject(scope)
   {
      this.mScope = scope;
      this.mPosition = new flash.geom.Point(0,0);
   }
   function setBaseScope(scope)
   {
      this.mBaseScope = scope;
   }
   function setPosition(x, y)
   {
      this.mPosition.x = x;
      this.mPosition.y = y;
   }
   function setID(id)
   {
      this.mID = id;
   }
   function setType(type)
   {
      this.mType = type;
   }
   function getType()
   {
      return this.mType;
   }
   function setHand()
   {
      this.mBaseScope.useArrow();
   }
   function setArrow()
   {
      this.mBaseScope.pointer.gotoAndStop("arrow");
   }
   function popup(path, showClose)
   {
      this.mBaseScope.popup(path,showClose,showClose,!showClose);
   }
   function sendAction(params)
   {
      multiplayer.MultiUserObjectManager.sendAction(this.mID,params);
   }
   function objectClicked(total)
   {
      this.mClickTotal = total;
   }
   function getObjectClickTotal()
   {
      return this.mClickTotal;
   }
   function removeObject()
   {
      this.mScope = null;
      this.mBaseScope = null;
   }
   function allowMultipleInstances()
   {
      return this.mAllowMultipleInstances;
   }
   function broadcastUserName()
   {
      var _loc2_ = this.mBaseScope.camera.scene.char.avatar.FunBrain_so;
      var _loc3_ = "";
      if(_loc2_.data.firstName != null && _loc2_.data.firstName != undefined && _loc2_.data.lastName != null && _loc2_.data.lastName != undefined)
      {
         _loc3_ = _loc2_.data.firstName + " " + _loc2_.data.lastName;
      }
      utils.Logger.log("MultiUserObject :: Broadcasting user name : " + _loc3_,utils.Logger.ALL);
      this.sendAction(["setLeaderUserName",_loc3_]);
   }
   function setLeaderUserName(name)
   {
      this.mLeaderUserName = name;
   }
   function getLeaderUserName()
   {
      return this.mLeaderUserName;
   }
}
