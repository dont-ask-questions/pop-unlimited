class com.poptropica.util.Observable
{
   var observers;
   var changed = false;
   function Observable()
   {
      this.observers = new Array();
   }
   function addObserver(o)
   {
      if(o == null)
      {
         return false;
      }
      var _loc2_ = 0;
      while(_loc2_ < this.observers.length)
      {
         if(this.observers[_loc2_] == o)
         {
            return false;
         }
         _loc2_ = _loc2_ + 1;
      }
      this.observers.push(o);
      return true;
   }
   function removeObserver(o)
   {
      var _loc3_ = this.observers.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         if(this.observers[_loc2_] == o)
         {
            this.observers.splice(_loc2_,1);
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function notifyObservers(infoObj)
   {
      if(infoObj == undefined)
      {
         infoObj = null;
      }
      if(!this.changed)
      {
         return undefined;
      }
      var _loc3_ = this.observers.slice(0);
      this.clearChanged();
      var _loc2_ = _loc3_.length - 1;
      while(_loc2_ >= 0)
      {
         _loc3_[_loc2_].update(this,infoObj);
         _loc2_ = _loc2_ - 1;
      }
   }
   function clearObservers()
   {
      this.observers = new Array();
   }
   function setChanged()
   {
      this.changed = true;
   }
   function clearChanged()
   {
      this.changed = false;
   }
   function hasChanged()
   {
      return this.changed;
   }
   function countObservers()
   {
      return this.observers.length;
   }
}
