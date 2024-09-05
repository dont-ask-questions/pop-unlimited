if(itemFrame == "sillyString")
{
   stop();
   sillyString1.pointCount = sillyString2.pointCount = 20;
   sillyString1.span = sillyString2.span = 0;
   sillyString1.wait = sillyString2.wait = 4;
   sillyString1.lineColor = 4325332;
   sillyString2.lineColor = 16735231;
   sillyString1.onEnterFrame = sillyString2.onEnterFrame = function()
   {
      this.wait = this.wait + 1;
      if(this.wait > 4)
      {
         this.wait = 0;
         this.span = this.span + 1;
         this.pointCount = this.pointCount - 1;
         if(this.pointCount < 1)
         {
            gotoAndStop("saluteend");
            play();
         }
         pt = this.createEmptyMovieClip("pt" + this.pointCount,this.pointCount);
         pt.num = this.pointCount;
         pt.velX = - (Math.random() * 20 + 10);
         pt.velY = Math.random() * 20 - 20;
         pt.accelY = 0.7;
         pt.life = 100;
         pt.onEnterFrame = function()
         {
            this.velY += this.accelY;
            this._x += this.velX;
            this._y += this.velY;
            this.life -= 3;
            if(this.life <= 0)
            {
               this._parent.span--;
               this.removeMovieClip();
            }
         };
      }
      this.clear();
      this.lineAlpha = 100;
      this.lineWidth = 6;
      this.lineStyle(this.lineWidth,this.lineColor,this.lineAlpha,false,"normal","none");
      this.moveTo(0,0);
      i = this.pointCount;
      while(i < this.pointCount + this.span - 1)
      {
         curPt = this["pt" + i];
         nextPt = this["pt" + (i + 1)];
         midX = (curPt._x + nextPt._x) / 2;
         midY = (curPt._y + nextPt._y) / 2;
         this.curveTo(curPt._x,curPt._y,midX,midY);
         this.lineAlpha -= 20;
         this.lineStyle(this.lineWidth,this.lineColor,this.lineAlpha,false,"normal","none");
         i++;
      }
   };
}
else if(itemFrame == "sponsorSpyNext")
{
   stop();
   sillyString1._x -= 30;
   sillyString1._y -= 18;
   sillyString1.count = 0;
   sillyString1.onEnterFrame = function()
   {
      this.count = this.count + 1;
      f = this.attachMovie("Flame","f" + this.count,this.count);
      f._xscale = f._yscale = Math.random() * 50 + 75;
      f._rotation = Math.random() * 360;
      f.vx = -10 - Math.random() * 4;
      f.vy = -5 - Math.random() * 2;
      f.onEnterFrame = function()
      {
         this.vy -= 0.4;
         this.vx *= 0.95;
         this.vy *= 0.95;
         this._x += this.vx;
         this._y += this.vy;
      };
   };
}
else if(itemFrame == "photdogShooter1" || itemFrame == "pHotdogShooter2" || itemFrame == "pHotDogShooter3" || itemFrame == "pHotdogShooter4")
{
   stop();
   sillyString1.pointCount = 20;
   sillyString1.span = 0;
   sillyString1.wait = 4;
   if(itemFrame == "photdogShooter1")
   {
      sillyString1.lineColor = 13244431;
   }
   else if(itemFrame == "pHotdogShooter2")
   {
      sillyString1.lineColor = 16247563;
   }
   else if(itemFrame == "pHotDogShooter3")
   {
      sillyString1.lineColor = 9315590;
   }
   else if(itemFrame == "pHotdogShooter4")
   {
      sillyString1.lineColor = 6684466;
   }
   else
   {
      sillyString1.lineColor = 0;
   }
   sillyString1._x = -110;
   sillyString1._y = -85;
   sillyString1.onEnterFrame = function()
   {
      this.wait = this.wait + 1;
      if(this.wait > 4)
      {
         this.wait = 0;
         this.span = this.span + 1;
         this.pointCount = this.pointCount - 1;
         if(this.pointCount < 1)
         {
            gotoAndStop("saluteend");
            play();
         }
         pt = this.createEmptyMovieClip("pt" + this.pointCount,this.pointCount);
         pt.num = this.pointCount;
         pt.velX = - (Math.random() * 20 + 10);
         pt.velY = Math.random() * 20 - 20;
         pt.accelY = 0.7;
         pt.life = 100;
         pt.onEnterFrame = function()
         {
            this.velY += this.accelY;
            this._x += this.velX;
            this._y += this.velY;
            this.life -= 3;
            if(this.life <= 0)
            {
               this._parent.span--;
               this.removeMovieClip();
            }
         };
      }
      this.clear();
      this.lineAlpha = 100;
      this.lineWidth = 6;
      this.lineStyle(this.lineWidth,this.lineColor,this.lineAlpha,false,"normal","none");
      this.moveTo(0,0);
      i = this.pointCount;
      while(i < this.pointCount + this.span - 1)
      {
         curPt = this["pt" + i];
         nextPt = this["pt" + (i + 1)];
         midX = (curPt._x + nextPt._x) / 2;
         midY = (curPt._y + nextPt._y) / 2;
         this.curveTo(curPt._x,curPt._y,midX,midY);
         this.lineAlpha -= 20;
         this.lineStyle(this.lineWidth,this.lineColor,this.lineAlpha,false,"normal","none");
         i++;
      }
   };
}
else if(itemFrame == "sponsorMirrorMirror_mirror")
{
   stop();
   item.active_obj.setNewText();
   if(_parent._xscale > 0 && item.active_obj.mc_textBubble.textBubbleInstance.tf._xscale < 0 || _parent._xscale < 0 && item.active_obj.mc_textBubble.textBubbleInstance.tf._xscale > 0)
   {
      item.active_obj.mc_textBubble.textBubbleInstance.tf._xscale *= -1;
   }
   item.active_obj.mc_textBubble._xscale = item.active_obj.mc_textBubble._yscale = 0;
   item.active_obj.mc_textBubble._visible = true;
   sillyString1.animationCounter = 0;
   sillyString1.pauseCounter = 0;
   sillyString1.onEnterFrame = function()
   {
      if(this.animationCounter < 5)
      {
         this._parent.item.active_obj.mc_textBubble._xscale = this._parent.item.active_obj.mc_textBubble._yscale = 100 * Math.sin(this.animationCounter / 5 * 3.141592653589793 / 2);
         this.animationCounter = this.animationCounter + 1;
      }
      else if(this.pauseCounter < 155)
      {
         this.pauseCounter = this.pauseCounter + 1;
      }
      else if(this.animationCounter < 10)
      {
         this._parent.item.active_obj.mc_textBubble._xscale = this._parent.item.active_obj.mc_textBubble._yscale = 100 * Math.sin(this.animationCounter / 5 * 3.141592653589793 / 2);
         this.animationCounter = this.animationCounter + 1;
      }
      else
      {
         delete onEnterFrame;
         item.active_obj.mc_textBubble._visible = false;
         gotoAndStop("saluteend");
         play();
      }
   };
}
else if(itemFrame == "ad_dowk3_smoothie")
{
   stop();
   var animDuration = item.active_obj.animDuration;
   item.active_obj.drink();
   head.eyes.gotoAndStop("closed");
   head.mouth.gotoAndPlay("ooh");
   sillyString1.animationCounter = 0;
   sillyString1.onEnterFrame = function()
   {
      this.animationCounter = this.animationCounter + 1;
      if(this.animationCounter >= animDuration)
      {
         delete onEnterFrame;
         gotoAndStop("saluteend");
         play();
      }
   };
}
else if(itemFrame == "wkcream")
{
   stop();
   sillyString1.drawCircle = function(mc, radius, color)
   {
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      var _loc6_ = 0;
      var _loc7_ = 0;
      var _loc8_ = undefined;
      var _loc9_ = undefined;
      var _loc5_ = 1.5707963267948966;
      var _loc1_ = _loc5_;
      mc.beginFill(color,100);
      mc.moveTo(radius,0);
      while(_loc1_ <= 6.283185307179586)
      {
         _loc4_ = radius * Math.cos(_loc1_);
         _loc3_ = radius * Math.sin(_loc1_);
         _loc8_ = radius * Math.cos(_loc1_ - _loc5_ / 2);
         _loc9_ = radius * Math.sin(_loc1_ - _loc5_ / 2);
         mc.curveTo(2 * _loc8_ - 0.5 * (_loc4_ + _loc6_),2 * _loc9_ - 0.5 * (_loc3_ + _loc7_),_loc4_,_loc3_);
         _loc6_ = _loc4_;
         _loc7_ = _loc3_;
         _loc1_ += _loc5_;
      }
      mc.endFill();
   };
   sillyString1.count = 1;
   sillyString1.sample = sillyString1.createEmptyMovieClip("sample",1);
   sillyString1.drawCircle(sillyString1.sample,800 / this._xscale,16777215);
   sillyString1.sample._visible = false;
   sillyString1.pts = [];
   sillyString1.theta = 0;
   sillyString1.wait = 0;
   sillyString1.onEnterFrame = function()
   {
      var _loc2_ = undefined;
      var _loc3_ = this.pts.length - 1;
      while(_loc3_ >= 0)
      {
         _loc2_ = this.pts[_loc3_];
         _loc2_.vy += 0.5;
         _loc2_._x += _loc2_.vx;
         _loc2_._y += _loc2_.vy;
         _loc2_.vx *= 0.95;
         _loc2_.vy *= 0.95;
         if(_loc2_._xscale <= 110)
         {
            _loc2_._xscale = _loc2_._yscale += 2;
         }
         _loc3_ = _loc3_ - 1;
      }
      if(_loc2_._xscale > 100)
      {
         _loc2_.removeMovieClip();
         this.pts.shift();
         if(this.count > 22 && this.pts.length == 0)
         {
            this._parent.gotoAndPlay("saluteend");
         }
      }
      if(this.wait++ >= 2)
      {
         this.wait = 0;
         if(this.count++ <= 22)
         {
            this.theta += 0.1;
            _loc2_ = this.sample.duplicateMovieClip("pt" + this.count,this.count++);
            _loc2_.vx = -18 - 2 * Math.random();
            _loc2_.vy = -20 + 2 * Math.random() + 2 * Math.sin(this.theta);
            _loc2_._xscale = _loc2_._yscale = 48;
            this.pts.push(_loc2_);
         }
      }
   };
}
