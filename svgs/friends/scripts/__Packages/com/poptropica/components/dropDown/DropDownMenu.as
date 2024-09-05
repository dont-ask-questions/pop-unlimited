class com.poptropica.components.dropDown.DropDownMenu
{
   var _numVisibleItems;
   var _firstVisibleItemNum;
   var _mc;
   var _mcArrow;
   var _mcBtn;
   var _mcList;
   var _mcListBg;
   var _mcItemsBox;
   var _scrollBar;
   var _active;
   var _itemArr;
   var _arListData;
   var _selectedItem;
   var _initialLabel = "CHOOSE...";
   var _closed = true;
   var _labelField = "label";
   function DropDownMenu()
   {
      mx.events.EventDispatcher.initialize(this);
      trace("[DropDownMenu] Constructor");
      this._numVisibleItems = 15;
      this._firstVisibleItemNum = 0;
   }
   function dispatchEvent()
   {
   }
   function addEventListener()
   {
   }
   function removeEventListener()
   {
   }
   function setDropDownMC(pDropDownMC)
   {
      trace("[DropDownMenu] setdropDownmc: " + pDropDownMC);
      this._mc = pDropDownMC;
      this._mcArrow = this._mc.mcArrow;
      this._mcBtn = this._mc.mcBtn;
      this._mcList = this._mc.listContainer.createEmptyMovieClip("mcList",this._mc.listContainer.getNextHighestDepth());
      this._mcList._visible = false;
      this._mcListBg = this._mcList.attachMovie("listBg_mc","mcListBg",this._mcList.getNextHighestDepth());
      this._mcListBg.onRollOver = function()
      {
         return false;
      };
      this._mcListBg.onPress = function()
      {
         return false;
      };
      this._mcListBg._width = this._mcBtn._width - 2;
      this._mcItemsBox = this._mcList.createEmptyMovieClip("mcBox",this._mcList.getNextHighestDepth());
      var _loc2_ = this._mcList.attachMovie("scrollBarAsset","scrollBar",this._mcList.getNextHighestDepth());
      _loc2_._y = 18;
      this._scrollBar = new com.poptropica.components.ScrollBarPop();
      this._scrollBar.asset = _loc2_;
      this._scrollBar.addEventListener("change",Delegate.create(this,this.onScrollBarChange));
      this._active = true;
      this.draw();
   }
   function setWidth(n)
   {
      this._mcBtn._width = n;
      this.draw();
   }
   function draw()
   {
      this._scrollBar.x = this._mcBtn._width - 17;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < this._itemArr.length)
      {
         _loc3_ = this._itemArr[_loc2_];
         if(_loc2_ >= this._firstVisibleItemNum && _loc2_ < this._firstVisibleItemNum + this._numVisibleItems)
         {
            _loc3_.y = this._mcBtn._height + _loc3_.height * (_loc2_ - this._firstVisibleItemNum);
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = false;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function onScrollBarChange(e)
   {
      this._firstVisibleItemNum = Math.floor(e.pos / 100 * (this._itemArr.length - this._numVisibleItems));
      this.draw();
   }
   function set labelField(value)
   {
      this._labelField = value;
   }
   function setData(pListData)
   {
      if(this._arListData == undefined)
      {
         this._arListData = new Array();
         this._arListData = pListData;
         this._itemArr = new Array();
         this._mc.tf.text = this._initialLabel;
         var _loc3_ = 0;
         while(_loc3_ < this._arListData.length)
         {
            var _loc4_ = MovieClip(this._mcItemsBox.attachMovie("DropDownItemAsset","mcItem" + _loc3_,this._mcItemsBox.getNextHighestDepth()));
            _loc4_.mcBacking._width = this._mcBtn._width - 10;
            var _loc2_ = new com.poptropica.components.dropDown.DropDownItem();
            _loc2_.setItemMC(_loc4_);
            _loc2_.itemValue = this._arListData[_loc3_].value;
            _loc2_.itemLabel = this._arListData[_loc3_][this._labelField];
            _loc2_.index = _loc3_;
            _loc2_.data = this._arListData[_loc3_];
            _loc2_.onItemPressCallBackFunction = com.poptropica.util.EventDelegate.create(this,this.onItemPress);
            _loc2_.onItemRollOverFunction = com.poptropica.util.EventDelegate.create(this,this.onItemRollOver);
            _loc2_.onItemRollOutFunction = com.poptropica.util.EventDelegate.create(this,this.onItemRollOut);
            this._itemArr.push(_loc2_);
            _loc3_ = _loc3_ + 1;
         }
         if(this._numVisibleItems >= this._itemArr.length)
         {
            this._numVisibleItems = this._itemArr.length;
            this._scrollBar.visible = false;
         }
         this._mcListBg._height = this._itemArr[0].height * (1 + this._numVisibleItems) + 10;
         this._mcList._y = - this._mcList._height;
         this._mcList._visible = true;
         this.activateDropDown();
         this._scrollBar.delta = 100 / (this._arListData.length - this._numVisibleItems);
         this._scrollBar.height = this._mcListBg._height - this._itemArr[0].height - 3;
      }
      this.draw();
   }
   function setItemByValue(n, passive)
   {
      trace("[DropDownMenu] setItemByValue:" + n);
      var _loc2_ = 0;
      while(_loc2_ < this._itemArr.length)
      {
         if(n == this._itemArr[_loc2_].data.val)
         {
            this._itemArr[_loc2_].select(passive);
            this.selectedItem = this._itemArr[_loc2_].data;
            trace("[DropDownMenu] found one:" + this._itemArr[_loc2_]);
            this._firstVisibleItemNum = Math.min(_loc2_ + 1,this._itemArr.length - this._numVisibleItems);
            this._scrollBar.setPos(100 * this._firstVisibleItemNum / (this._itemArr.length - this._numVisibleItems));
            this.draw();
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function onItemPress(pItem)
   {
      trace("[DropDownMenu] onItemPress: this:" + this.setDropDownMC + " selectedItem:" + pItem.data);
      this.selectedItem = pItem.data;
      this.state = true;
      this.dispatchEvent({type:"itemSelected",selectedItem:this.selectedItem});
   }
   function onItemRollOver(pItem)
   {
   }
   function onItemRollOut(pItem)
   {
   }
   function activateDropDown()
   {
      this._mcBtn.onPress = com.poptropica.util.EventDelegate.create(this,this.switchDropDown);
   }
   function switchDropDown()
   {
      this.state = !this.state;
   }
   function changePosition(pTarget, pY, pDuration)
   {
      pDuration = pDuration == undefined ? 1 : pDuration;
      com.greensock.TweenLite.to(pTarget,pDuration,{_y:pY,ease:com.greensock.easing.Strong.easeOut});
   }
   function get state()
   {
      return this._closed;
   }
   function set state(value)
   {
      this._closed = value;
      if(value == false)
      {
         if(this._active)
         {
            this._mcArrow._rotation = 180;
            this.changePosition(this._mcList,0);
            this._mc.swapDepths(this._mc._parent.getNextHighestDepth());
            this.dispatchEvent({type:"open"});
         }
      }
      else
      {
         this._mcArrow._rotation = 0;
         this.changePosition(this._mcList,- this._mcList._height);
         this.dispatchEvent({type:"close"});
      }
   }
   function get selectedItem()
   {
      return this._selectedItem;
   }
   function set selectedItem(value)
   {
      this._selectedItem = value;
      this._mc.tf.text = this._selectedItem[this._labelField];
      var _loc2_ = 0;
      while(_loc2_ < this._arListData.length)
      {
         if(this._selectedItem == this._arListData[_loc2_])
         {
            this._itemArr[_loc2_].isActive = false;
         }
         else
         {
            this._itemArr[_loc2_].isActive = true;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function set initialLabel(s)
   {
      this._initialLabel = s;
   }
   function setVisible(b)
   {
      this._mc._visible = b;
   }
   function set numVisible(n)
   {
      this._numVisibleItems = n;
   }
   function set active(b)
   {
      this._active = b;
      this._mc._alpha = !b ? 50 : 100;
      if(!this._active)
      {
         this.state = true;
      }
   }
}
