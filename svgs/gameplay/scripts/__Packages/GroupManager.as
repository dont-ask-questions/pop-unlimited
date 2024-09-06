class GroupManager
{
   var mGroups;
   var mLastAutoID = 0;
   var mAllowOverwrite = false;
   function GroupManager()
   {
      this.mGroups = new Array();
   }
   function addElement(element, elementID, groupID)
   {
      var _loc5_ = true;
      if(groupID == undefined)
      {
         groupID = 0;
      }
      if(elementID == undefined)
      {
         elementID = this.mLastAutoID++;
      }
      if(this.mAllowOverwrite)
      {
         _loc5_ = true;
      }
      else if(this.getElementByID(elementID,groupID) == null)
      {
         _loc5_ = true;
      }
      if(_loc5_)
      {
         if(this.mGroups[groupID] == undefined)
         {
            this.mGroups[groupID] = new Array();
         }
         var _loc3_ = new Object();
         _loc3_.id = elementID;
         _loc3_.groupID = groupID;
         _loc3_.element = element;
         this.mGroups[groupID].push(_loc3_);
         return elementID;
      }
      trace("GroupManager :: Element " + elementID + " already exists and is not overwritable.");
      return null;
   }
   function allowElementOverwrite(allow)
   {
      if(allow == undefined)
      {
         allow = true;
      }
      this.mAllowOverwrite = allow;
   }
   function clear()
   {
      this.mGroups = new Array();
   }
   function getGroup(groupID)
   {
      var _loc2_ = this.getAllElementsInternal(groupID,true);
      return _loc2_;
   }
   function getTotalGroupElements(groupID)
   {
      var _loc2_ = this.mGroups[groupID];
      if(groupID == undefined)
      {
         _loc2_ = this.getAllElementsInternal();
      }
      if(_loc2_ == undefined)
      {
         return 0;
      }
      return _loc2_.length;
   }
   function setGroup(groupID, elements)
   {
      this.mGroups[groupID] = elements;
   }
   function removeElement(id, groupID)
   {
      if(groupID != undefined)
      {
         this.removeGroupedElement(id,groupID);
      }
      else
      {
         var _loc3_ = undefined;
         var _loc2_ = 0;
         while(_loc2_ < this.mGroups.length)
         {
            _loc3_ = this.findElementByID(id,this.mGroups[_loc2_],true);
            if(_loc3_ != null)
            {
               return undefined;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function getRandomElement(groupID)
   {
      var _loc2_ = this.getGroupInternal(groupID);
      var _loc3_ = _loc2_[Math.floor(Math.random() * _loc2_.length)];
      return _loc3_.element;
   }
   function removeGroupedElement(id, groupID)
   {
      this.getElementIndex(id,groupID,true);
   }
   function getElementByIndex(index, groupID)
   {
      if(groupID == undefined)
      {
         groupID = 0;
      }
      return this.getGroupedElementByIndex(index,groupID);
   }
   function getGroupedElementByIndex(index, groupID)
   {
      if(groupID == undefined)
      {
         trace("GroupManager :: No Group id specified for getGroupedElementByIndex, exiting...");
         return null;
      }
      return this.mGroups[groupID][index].element;
   }
   function getElementByID(id, groupID)
   {
      var _loc3_ = undefined;
      if(groupID != undefined)
      {
         return this.findElementByID(id,this.mGroups[groupID],false);
      }
      var _loc2_ = 0;
      while(_loc2_ < this.mGroups.length)
      {
         _loc3_ = this.findElementByID(id,this.mGroups[_loc2_],false);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         _loc2_ = _loc2_ + 1;
      }
      trace("GroupManager :: " + id + " is new or does not refer to an element.");
      return null;
   }
   function getElementIndex(id, groupID, remove)
   {
      if(groupID != undefined)
      {
         return this.findElementIndex(id,this.mGroups[groupID],remove);
      }
      var _loc2_ = 0;
      if(_loc2_ < this.mGroups.length)
      {
         return this.findElementIndex(id,this.mGroups[_loc2_],remove);
      }
      trace("GroupManager :: " + id + " is new or does not refer to an element.");
      return null;
   }
   function getNextGroupID()
   {
      return this.mGroups.length;
   }
   function getNextElementID(groupID)
   {
      if(groupID == undefined)
      {
         groupID = 0;
      }
      if(this.mGroups[groupID] == undefined)
      {
         return 0;
      }
      return this.mGroups[groupID].length;
   }
   function groupedElementApply(id, groupID, elementMethod, elementArgs)
   {
      var _loc3_ = this.getElementByID(id,groupID);
      var _loc2_ = _loc3_[elementMethod];
      _loc2_.apply(this,elementArgs);
   }
   function elementApply(id, elementMethod, elementArgs)
   {
      this.groupedElementApply(id,0,elementMethod,elementArgs);
   }
   function groupApply(groupID, elementMethod, elementArgs)
   {
      var _loc4_ = this.getGroupInternal(groupID);
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc3_ = _loc4_[_loc2_].element;
         _loc5_ = _loc3_[elementMethod];
         _loc5_.apply(_loc3_,elementArgs);
         _loc2_ = _loc2_ + 1;
      }
   }
   function applyToAll(elementMethod, elementArgs)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.mGroups.length)
      {
         this.groupApply(_loc2_,elementMethod,elementArgs);
         _loc2_ = _loc2_ + 1;
      }
   }
   function groupApplyToElement(groupID, elementMethod)
   {
      var _loc3_ = this.getGroupInternal(groupID);
      var _loc4_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         _loc4_ = _loc3_[_loc2_].element;
         elementMethod.apply(this,[_loc4_]);
         _loc2_ = _loc2_ + 1;
      }
   }
   function getGroupApplyResults(groupID, elementMethod, elementArgs)
   {
      var _loc6_ = new Array();
      var _loc4_ = this.getGroupInternal(groupID);
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc3_ = _loc4_[_loc2_].element;
         _loc5_ = _loc3_[elementMethod];
         _loc6_.push(_loc5_.apply(_loc3_,elementArgs));
         _loc2_ = _loc2_ + 1;
      }
      return _loc6_;
   }
   function deleteAllElements()
   {
      this.mGroups = new Array();
   }
   function getAllElements()
   {
      var _loc4_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < this.mGroups.length)
      {
         var _loc2_ = 0;
         while(_loc2_ < this.mGroups[_loc3_].length)
         {
            _loc4_.push(this.mGroups[_loc3_][_loc2_].element);
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc4_;
   }
   function getElementsOfKind(groupID, elementMethod, elementArgs, returnVal, equalityFunction)
   {
      var _loc6_ = this.getGroupInternal(groupID);
      var _loc5_ = new Array();
      var _loc2_ = undefined;
      var _loc4_ = undefined;
      var _loc8_ = undefined;
      var _loc7_ = undefined;
      var _loc3_ = 0;
      while(_loc3_ < _loc6_.length)
      {
         _loc2_ = _loc6_[_loc3_].element;
         _loc4_ = _loc2_[elementMethod];
         if(equalityFunction)
         {
            _loc8_ = _loc2_[equalityFunction];
            _loc7_ = _loc4_.apply(_loc2_,elementArgs);
            if(_loc8_.apply(_loc2_,[_loc7_,returnVal]))
            {
               _loc5_.push(_loc2_);
            }
         }
         else if(_loc4_.apply(_loc2_,elementArgs) == returnVal)
         {
            _loc5_.push(_loc2_);
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc5_;
   }
   function setElementsPropertyValue(groupID, property, value)
   {
      var _loc3_ = this.getGroupInternal(groupID);
      var _loc7_ = new Array();
      var _loc4_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         _loc4_ = _loc3_[_loc2_].element;
         _loc4_[property] = value;
         _loc2_ = _loc2_ + 1;
      }
   }
   function getElementsWithPropertyValue(groupID, property, value)
   {
      var _loc4_ = this.getGroupInternal(groupID);
      var _loc5_ = new Array();
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc3_ = _loc4_[_loc2_].element;
         if(_loc3_[property] == value)
         {
            _loc5_.push(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function getGroupWithPropertyValue(groupID, property, value)
   {
      var _loc4_ = this.getGroupInternal(groupID);
      var _loc5_ = new GroupManager();
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_.length)
      {
         _loc3_ = _loc4_[_loc2_].element;
         if(_loc3_[property] == value)
         {
            _loc5_.addElement(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   function getGroupInternal(groupID)
   {
      return this.getAllElementsInternal(groupID,false);
   }
   function getAllElementsInternal(groupID, onlyElements)
   {
      var _loc4_ = new Array();
      var _loc3_ = undefined;
      if(groupID != undefined)
      {
         _loc3_ = this.mGroups[groupID];
         var _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(onlyElements)
            {
               _loc4_.push(_loc3_[_loc2_].element);
            }
            else
            {
               _loc4_.push(_loc3_[_loc2_]);
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      else
      {
         var _loc5_ = 0;
         while(_loc5_ < this.mGroups.length)
         {
            _loc3_ = this.mGroups[_loc5_];
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               if(onlyElements)
               {
                  _loc4_.push(_loc3_[_loc2_].element);
               }
               else
               {
                  _loc4_.push(_loc3_[_loc2_]);
               }
               _loc2_ = _loc2_ + 1;
            }
            _loc5_ = _loc5_ + 1;
         }
      }
      return _loc4_;
   }
   function findElementIndex(id, group, remove)
   {
      var _loc3_ = undefined;
      var _loc1_ = 0;
      while(_loc1_ < group.length)
      {
         _loc3_ = group[_loc1_];
         if(id == _loc3_.id)
         {
            if(remove)
            {
               group.splice(_loc1_,1);
            }
            return _loc1_;
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
   function findElementByID(id, group, remove)
   {
      var _loc2_ = undefined;
      var _loc1_ = 0;
      while(_loc1_ < group.length)
      {
         _loc2_ = group[_loc1_];
         if(id == _loc2_.id)
         {
            if(remove)
            {
               group.splice(_loc1_,1);
            }
            return _loc2_.element;
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
}
