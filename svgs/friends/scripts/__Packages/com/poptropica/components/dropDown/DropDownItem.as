class com.poptropica.components.dropDown.DropDownItem
{
   var _mc;
   var _tfTitle;
   var _onItemPressCallBackFunction;
   var _onItemRollOverFunction;
   var _onItemRollOutFunction;
   var _itemValue;
   var _itemLabel;
   var _isActive;
   var _index;
   var _data;
   static var COLOR_OVER = 0;
   static var COLOR_OUT = 0;
   function DropDownItem()
   {
   }
   function setItemMC($mc)
   {
      this._mc = $mc;
      this._mc.mcBacking.gotoAndStop(1);
      this._tfTitle = this._mc.tfTitle;
      this.isActive = true;
   }
   function set onItemPressCallBackFunction(value)
   {
      this._onItemPressCallBackFunction = value;
   }
   function set onItemRollOverFunction(value)
   {
      this._onItemRollOverFunction = value;
   }
   function set onItemRollOutFunction(value)
   {
      this._onItemRollOutFunction = value;
   }
   function activate()
   {
      this._mc.onRollOver = this._mc.onDragOver = com.poptropica.util.EventDelegate.create(this,this.onOverAction);
      this._mc.onRollOut = this._mc.onDragOut = com.poptropica.util.EventDelegate.create(this,this.onOutAction);
      this._mc.onPress = com.poptropica.util.EventDelegate.create(this,this.onPressAction);
   }
   function deActivate()
   {
      delete this._mc.onRollOver;
      delete this._mc.onDragOver;
      delete this._mc.onRollOut;
      delete this._mc.onDragOut;
      delete this._mc.onPress;
   }
   function onPressAction()
   {
      this.select(true);
   }
   function select(doFunction)
   {
      if(doFunction)
      {
         this._onItemPressCallBackFunction(this);
      }
      this._mc.mcBacking.gotoAndStop(1);
   }
   function onOutAction()
   {
      this._tfTitle._alpha = 60;
      this._tfTitle.textColor = com.poptropica.components.dropDown.DropDownItem.COLOR_OUT;
      this._mc.mcBacking.gotoAndStop(1);
      this._onItemRollOutFunction(this);
   }
   function onOverAction()
   {
      this._tfTitle._alpha = 100;
      this._tfTitle.textColor = com.poptropica.components.dropDown.DropDownItem.COLOR_OVER;
      this._mc.mcBacking.gotoAndStop(2);
      this._onItemRollOverFunction(this);
   }
   function get itemValue()
   {
      return this._itemValue;
   }
   function set itemValue(value)
   {
      if(value != undefined)
      {
         this._itemValue = value;
      }
   }
   function get itemLabel()
   {
      return this._itemLabel;
   }
   function set itemLabel(value)
   {
      if(value != undefined)
      {
         this._itemLabel = value;
         this._tfTitle.text = this._itemLabel;
      }
   }
   function get isActive()
   {
      return this._isActive;
   }
   function set isActive(value)
   {
      this._mc.gotoAndStop(1);
      if(value)
      {
         this._tfTitle.textColor = com.poptropica.components.dropDown.DropDownItem.COLOR_OUT;
         this._tfTitle._alpha = 60;
         this.activate();
      }
      else
      {
         this._tfTitle._alpha = 100;
         this._tfTitle.textColor = com.poptropica.components.dropDown.DropDownItem.COLOR_OVER;
         this.deActivate();
      }
      this._isActive = value;
   }
   function set y(n)
   {
      this._mc._y = n;
   }
   function set visible(b)
   {
      this._mc._visible = b;
   }
   function get height()
   {
      return this._mc._height;
   }
   function get mc()
   {
      return this._mc;
   }
   function get index()
   {
      return this._index;
   }
   function set index(value)
   {
      this._index = value;
   }
   function get data()
   {
      return this._data;
   }
   function set data(value)
   {
      this._data = value;
   }
}
