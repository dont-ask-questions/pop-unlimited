function createNewPlayer(gend, col, norm)
{
   avatar.FunBrain_so.clear();
   avatar.FunBrain_so.data.Registred = false;
   avatar.createRandomParts(gend,norm);
   if(col)
   {
      avatar.changeSkinColor(col);
   }
   avatar.savePartsToSO();
   avatar.saveVisited("0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0");
}
function createNPC(mLeft, mRight, mUp, mDown, type, gend, norm, skinCol, hairCol, eyesF, mouthF, marksF, facialF, hairF, shirtF, pantsF, packF, itemF, overshirtF, overpantsF)
{
   this.npc = true;
   this.ground = this._y;
   if(mLeft == 0 && mRight == 0 && mUp == 0 && mDown == 0)
   {
      Static = true;
   }
   maxLeft = this._x - mLeft;
   maxRight = this._x + mRight;
   maxUp = this._y - mUp;
   maxDown = this._y + mDown;
   switch(type)
   {
      case "random":
         avatar.createRandomParts(gend,norm);
         break;
      case "specific":
         avatar.createSpecificParts(gend,norm,skinCol,hairCol,eyesF,mouthF,marksF,facialF,hairF,shirtF,pantsF,packF,itemF,overshirtF,overpantsF);
         break;
      default:
         avatar.mouthFrame = 1;
   }
}
function createBackPlayer()
{
   avatar.loadPartsFromSO();
   if(avatar.lineWidth != 4)
   {
      avatar.lineWidth = 4;
      avatar.savePartsToSO();
   }
}
function createChoicePlayer(gend, col, norm)
{
   avatar.createRandomParts(gend,norm);
   avatar.changeSkinColor(col);
}
function createMultiPlayer(look)
{
   avatar.setLook(look.split(","));
   if(avatar.packFrame == "jet")
   {
      avatar.packFrame = 1;
   }
   if(avatar.itemFrame == 2)
   {
      avatar.itemFrame = 1;
   }
}
function createMegaLSO()
{
   trace("CREATIN MEGA LSO!");
   var _loc3_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ < 1000)
   {
      _loc3_ = new Array();
      var _loc1_ = 0;
      while(_loc1_ < 50)
      {
         _loc3_.push(Math.random() * 1000);
         _loc1_ = _loc1_ + 1;
      }
      avatar.FunBrain_so.data["testArray_" + _loc2_] = _loc3_;
      avatar.checkLSOStoreResult(avatar.FunBrain_so.flush());
      _loc2_ = _loc2_ + 1;
   }
}
function createLongLSO()
{
   loadScene("GlobalDespicableMe_Entrance");
   var _loc1_ = 0;
   while(_loc1_ < 4500)
   {
      avatar.FunBrain_so.data["testVar_" + _loc1_] = _loc1_;
      _loc1_ = _loc1_ + 1;
   }
}
stop();
loadingFinished = true;
avatar.body.skinShape._xscale = avatar.body.skinShape._yscale = 98;
