class com.poptropica.components.tab.TabController
{
   var _asset;
   var _controllers;
   var controller;
   var _openTabNum;
   function TabController(asset)
   {
      this._asset = asset;
   }
   function init(controllers)
   {
      trace("[TabController] _controllers:" + controllers);
      this._controllers = controllers;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < controllers.length)
      {
         _loc3_ = this._asset["btn" + _loc2_];
         _loc3_.controller = this;
         _loc3_.onRelease = function()
         {
            this.controller.tabClick(this);
         };
         _loc3_.onRollOver = this.onBtnRollover;
         _loc3_.onRollOut = function()
         {
            com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
         };
         _loc3_.num = _loc2_;
         controllers[_loc2_].init();
         _loc2_ = _loc2_ + 1;
      }
      this.showTab(0);
   }
   function onBtnRollover()
   {
      this.controller.btnRollover(this);
   }
   function btnRollover(btn)
   {
      if(btn.num != this._openTabNum)
      {
         com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
      }
   }
   function tabClick(btn)
   {
      this.showTab(btn.num);
   }
   function showTab(n)
   {
      this._openTabNum = n;
      var _loc2_ = 0;
      while(_loc2_ < this._controllers.length)
      {
         if(_loc2_ == n)
         {
            this._controllers[_loc2_].show();
            this._asset["btn" + _loc2_]._alpha = 100;
         }
         else
         {
            this._controllers[_loc2_].hide();
            this._asset["btn" + _loc2_]._alpha = 60;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function openNextTab()
   {
      this.showTab(this._openTabNum + 1);
   }
}
