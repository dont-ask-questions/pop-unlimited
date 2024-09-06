class multiplayer.PrankCan extends multiplayer.MultiUserObject
{
   var mBaseScope;
   var mContainer;
   var mLoader;
   var mCanFrame;
   var mPrank;
   var mPosition;
   var showTimer;
   var _alpha;
   var onEnterFrame;
   var labelTimer;
   var label;
   var mObjectClicked = false;
   var mSelf = false;
   static var TOTAL_CLICKS = 2;
   static var ASSET_PATH = "externalAssets/multiUserObject/prankCan.swf";
   function PrankCan(scope)
   {
      super(scope);
      this.mBaseScope = com.poptropica.models.PopModelConst.gameplayMC;
      var _loc5_ = scope.getNextHighestDepth();
      this.mContainer = scope.createEmptyMovieClip("container" + _loc5_,_loc5_);
      this.mLoader = new MovieClipLoader();
      this.mLoader.addListener(this);
      _root.trc("prank can " + _global.can);
      utils.Utils.init();
      if(!_global.can)
      {
         _global.can = this;
      }
      this.mCanFrame = _global.canFrame;
      this.mPrank = _global.prank;
   }
   function removeObject()
   {
      super.removeObject();
      this.mLoader.removeListener(this);
      this.mLoader = null;
      this.removeContainer();
      delete _global.can;
      false;
   }
   function removeContainer()
   {
      this.mContainer.removeMovieClip();
      this.mContainer = null;
      delete _global.can;
   }
   function show(self)
   {
      this.mSelf = self;
      this.mLoader.loadClip(multiplayer.PrankCan.ASSET_PATH,this.mContainer);
      return this.mContainer;
   }
   function onLoadInit(clip)
   {
      clip._alpha = 0;
      if(com.poptropica.models.PopModelConst.gameplayMC.camera.scene.red5 && com.poptropica.models.PopModelConst.gameplayMC.server)
      {
         _root.trc("mSelf " + this.mSelf);
         if(this.mSelf)
         {
            var _loc6_ = _root.camera.scene;
            var _loc5_ = _loc6_.char;
            clip._x = _loc5_._x;
            clip._y = _loc5_._y - 25;
            _loc5_.action("place");
            this.mCanFrame = _global.canFrame;
            this.mPrank = _global.prank;
            clip.objectClip.gotoAndStop(this.mCanFrame);
            clip.objectClip.prank = this.mPrank;
            this.display();
         }
         else
         {
            clip.objectClip.gotoAndStop(this.mCanFrame);
            clip.objectClip.prank = this.mPrank;
            this.display();
            clip._x = this.mPosition.x;
            clip._y = this.mPosition.y + 15;
            this.setObjectClicks(this.mClickTotal);
         }
      }
      else
      {
         _loc6_ = _root.camera.scene;
         _loc5_ = _loc6_.char;
         clip._x = _loc5_._x;
         clip._y = _loc5_._y - 25;
         _loc5_.action("place");
         this.mCanFrame = _global.canFrame;
         this.mPrank = _global.prank;
         clip.objectClip.gotoAndStop(this.mCanFrame);
         clip.objectClip.prank = this.mPrank;
         this.display();
      }
      clip.objectClip.onPress = mx.utils.Delegate.create(this,this.pressEvent);
      clip.objectClip.onRollOver = mx.utils.Delegate.create(this,this.rollOverEvent);
      clip.objectClip.onRollOut = clip.objectClip.onDragOut = mx.utils.Delegate.create(this,this.rollOutEvent);
   }
   function pressEvent()
   {
      this.mContainer.objectClip.onPress = null;
      if(!this.mObjectClicked)
      {
         super.sendAction(["objectClicked",this.mClickTotal + 1]);
         this.mObjectClicked = true;
      }
      if(!com.poptropica.models.PopModelConst.gameplayMC.camera.scene.red5)
      {
         this.showPrank();
      }
   }
   function showPrank()
   {
      _root.trc("show prank");
      this.mContainer.label._visible = false;
      this.mContainer.showTimer = 100;
      this.mContainer.onEnterFrame = mx.utils.Delegate.create(this,this.prankEnterFrame);
      if(!this.mPrank)
      {
         this.mPrank = 1;
      }
      this.mContainer.playPrank(this.mPrank);
      this.mContainer.objectClip.can.can.play();
      this.mContainer.objectClip.can.lid.play();
   }
   function prankEnterFrame()
   {
      this.mContainer.showTimer--;
      if(this.mContainer.showTimer < 0)
      {
         if(com.poptropica.models.PopModelConst.gameplayMC.camera.scene.red5 && com.poptropica.models.PopModelConst.gameplayMC.server)
         {
            super.sendAction(["removeObject"]);
         }
         else
         {
            _global.can.removeObject();
         }
      }
   }
   function display()
   {
      this.mContainer.showTimer = 20;
      this.mContainer.labelTimer = 250;
      this.mContainer.onEnterFrame = function()
      {
         this.showTimer = this.showTimer - 1;
         if(this.showTimer < 0)
         {
            this._alpha = 100;
            if(!com.poptropica.models.PopModelConst.gameplayMC.camera.scene.red5 && !com.poptropica.models.PopModelConst.gameplayMC.server)
            {
               this.onEnterFrame = function()
               {
                  this.labelTimer = this.labelTimer - 1;
                  if(this.labelTimer < 0)
                  {
                     this.label._visible = false;
                     this.onEnterFrame = null;
                  }
               };
            }
            else
            {
               this.onEnterFrame = null;
            }
         }
      };
   }
   function rollOverEvent()
   {
      super.setHand();
   }
   function rollOutEvent()
   {
      super.setArrow();
   }
   function setPrank(_prank, _frame)
   {
      this.mPrank = _prank;
      this.mCanFrame = _frame;
      if(this.mContainer.objectClip)
      {
         this.mContainer.objectClip.gotoAndStop(_frame);
         this.mContainer.prank = _prank;
         _global.can.display();
      }
   }
   function getPrank()
   {
      return this.mPrank;
   }
   function getCanFrame()
   {
      return this.mCanFrame;
   }
   function objectClicked(total)
   {
      super.objectClicked(total);
      this.setObjectClicks(total);
      _root.trc("object clicked " + this.mObjectClicked + " " + total);
      if(this.mObjectClicked && multiplayer.PrankCan.TOTAL_CLICKS - total <= 0)
      {
         _root.trc("should Show Prank");
         this.showPrank();
      }
   }
   function setObjectClicks(total)
   {
      _root.trc("setObjectClicks " + total);
      super.objectClicked(total);
      var _loc4_ = " clicks needed!";
      if(multiplayer.PrankCan.TOTAL_CLICKS - total == 1)
      {
         _loc4_ = " click left!";
      }
      this.mContainer.label.text = multiplayer.PrankCan.TOTAL_CLICKS - total + _loc4_;
   }
}
