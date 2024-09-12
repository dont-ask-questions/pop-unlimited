class com.poptropica.views.home.welcomeBack.ErrorWindow
{
   var _mc;
   var _txt;
   var _showOKBtn;
   var _okBtn;
   var _tf;
   var _bgMC;
   static var OK_CLICK = "ok click";
   function ErrorWindow(pTarget, pText, pDisplayOk)
   {
      com.poptropica.util.Debug.trace("ErrorWindow::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      mx.events.EventDispatcher.initialize(this);
      this._mc = pTarget;
      this._txt = pText;
      this._showOKBtn = pDisplayOk;
      this._okBtn = this._mc.mcBtn;
      this._tf = this._mc.tfMessage;
      this._bgMC = this._mc.mcBG;
      this.init();
   }
   function init()
   {
      this._okBtn._visible = this._showOKBtn;
      this._tf.htmlText = this._txt;
      this._okBtn.onRollOver = this._okBtn.onDragOver = com.poptropica.util.EventDelegate.create(this,this.onOverAction);
      this._okBtn.onRollOut = this._okBtn.onDragOut = com.poptropica.util.EventDelegate.create(this,this.onOutAction);
      this._okBtn.onPress = com.poptropica.util.EventDelegate.create(this,this.onPressAction);
      this._okBtn.stop();
      this._bgMC.onRollOver = this._bgMC.onDragOver = com.poptropica.util.EventDelegate.create(this,this.onBGOverAction);
      this._bgMC.onRollOut = this._bgMC.onDragOut = com.poptropica.util.EventDelegate.create(this,this.onBGOutAction);
      this._mc._alpha = 0;
      com.greensock.TweenLite.to(this._mc,1,{_alpha:100});
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
   function onPressAction()
   {
      trace("ErrorWindow:: setUpInteractivity()");
      this.dispatchEvent({type:com.poptropica.views.home.welcomeBack.ErrorWindow.OK_CLICK,target:this});
   }
   function onOutAction()
   {
      this._okBtn.gotoAndStop(1);
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function onOverAction()
   {
      this._okBtn.gotoAndStop(2);
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
   }
   function onBGOverAction()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function onBGOutAction()
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
   }
   function get mc()
   {
      return this._mc;
   }
}
