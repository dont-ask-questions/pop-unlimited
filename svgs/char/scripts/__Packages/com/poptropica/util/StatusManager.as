class com.poptropica.util.StatusManager
{
   var savedMouseX;
   var savedMouseY;
   var myInt;
   var dispatchEvent;
   static var instance;
   var mouseCheckWaitTime = 600000;
   function StatusManager()
   {
      var _loc2_ = com.poptropica.models.PopModel.getInstance().isRegistered;
      if(_loc2_)
      {
         this.startTimeoutActivityCheck();
      }
   }
   static function getInstance()
   {
      if(com.poptropica.util.StatusManager.instance == undefined)
      {
         com.poptropica.util.StatusManager.instance = new com.poptropica.util.StatusManager();
      }
      return com.poptropica.util.StatusManager.instance;
   }
   function startTimeoutActivityCheck()
   {
      var _loc2_ = com.poptropica.views.PointerView.getInstance().pointer_mc;
      this.savedMouseX = _loc2_._x;
      this.savedMouseY = _loc2_._y;
      this.myInt = setInterval(this,"checkMousePosition",this.mouseCheckWaitTime);
   }
   function checkMousePosition()
   {
      var _loc2_ = com.poptropica.views.PointerView.getInstance().pointer_mc;
      if(_loc2_._x == this.savedMouseX && _loc2_._y == this.savedMouseY)
      {
         this.checkStatus();
      }
      else
      {
         this.savedMouseX = _loc2_._x;
         this.savedMouseY = _loc2_._y;
      }
   }
   function checkStatus(callback)
   {
      var _this = this;
      var _loc2_ = new LoadVars();
      var receiver = new LoadVars();
      receiver.onLoad = function(success)
      {
         if(success)
         {
            if(receiver.answer == "ok")
            {
               if(callback)
               {
                  callback();
               }
            }
            else
            {
               _this.showStatusPopup(receiver.answer,receiver.message);
            }
         }
         else
         {
            callback();
         }
      };
      var _loc3_ = com.poptropica.models.PopModel.getInstance();
      _loc2_.login = _loc3_.poptropica_user.login;
      _loc2_.pass_hash = _loc3_.poptropica_user.password_hash;
      _loc2_.dbid = parseInt(_loc3_.db_id);
      if(_loc2_.login)
      {
         _loc2_.sendAndLoad(com.poptropica.models.PopModelConst.prefix + "/status.php",receiver,"POST");
      }
      else
      {
         clearInterval(this.myInt);
      }
   }
   function statusOK()
   {
      this.dispatchEvent({target:this,type:"status_ok"});
   }
   function showStatusPopup(_type, _message)
   {
      flash.external.ExternalInterface.call("console.log","STATUS NOT OK: " + _type + " : " + _message);
      var _loc1_ = {type:_type,message:_message};
      com.poptropica.controllers.PopController.getInstance().showFrameworkPopup("popups/status.swf",_loc1_,true);
   }
}
