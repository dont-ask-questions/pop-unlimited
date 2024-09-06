class com.poptropica.util.CursorViewChanger
{
   var _arrayOfMC;
   var _frameOfOverEffect;
   var gotoAndStop;
   var _frameOfOutEffect;
   static var instance;
   function CursorViewChanger()
   {
      this._arrayOfMC = new Array();
   }
   static function getInstance()
   {
      com.poptropica.util.CursorViewChanger.instance = com.poptropica.util.CursorViewChanger.instance != undefined ? com.poptropica.util.CursorViewChanger.instance : new com.poptropica.util.CursorViewChanger();
      return com.poptropica.util.CursorViewChanger.instance;
   }
   function addElement(pTarget, pFrameOfOverEffect)
   {
      pTarget._frameOfOverEffect = pFrameOfOverEffect;
      pTarget._frameOfOutEffect = pTarget._currentframe;
      pTarget.onRollOver = pTarget.onDragOver = function()
      {
         if(this._frameOfOverEffect)
         {
            this.gotoAndStop(this._frameOfOverEffect);
         }
         com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
      };
      pTarget.onRollOut = pTarget.onDragOut = pTarget.onReleaseOutside = function()
      {
         if(["_frameOfOverEffect"])
         {
            this.gotoAndStop(this._frameOfOutEffect);
         }
         com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
      };
      this._arrayOfMC.push(pTarget);
      this.cleanUpArray();
   }
   function removeElement(pTarget)
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfMC.length)
      {
         if(this._arrayOfMC[_loc2_] == pTarget)
         {
            delete pTarget.onRollOver;
            delete pTarget.onDragOver;
            delete pTarget.onRollOut;
            delete pTarget.onDragOut;
            delete pTarget.onReleaseOutside;
            this._arrayOfMC.splice(_loc2_,1);
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function cleanUpArray()
   {
      var _loc2_ = 0;
      while(_loc2_ < this._arrayOfMC.length)
      {
         if(!this._arrayOfMC[_loc2_])
         {
            this._arrayOfMC.splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
