function jump()
{
   hurting = false;
   ground = baseGround;
   jumping = true;
   vSpeed = mouseY / 8;
   if(swimming)
   {
      vSpeed = -20;
      splash(40,30);
   }
   if(vSpeed < highJump)
   {
      vSpeed = highJump;
   }
   else if(vSpeed > minJump)
   {
      vSpeed = minJump;
   }
   if(_parent.useTargetControl && vSpeed > minJump - 6)
   {
      vSpeed = minJump - 6;
   }
   speed = mouseX / 20;
   if(Math.abs(speed) > 0)
   {
      this._xscale = (- charScale) * speed / Math.abs(speed);
   }
   if(Math.abs(speed) >= walkMaxSpeed * 2 && !gliding && !isCreature)
   {
      spin = fastSpin;
   }
   else if(Math.abs(speed) > 4 && !gliding && !isCreature)
   {
      spin = slowSpin;
   }
   else
   {
      spin = 0;
   }
}
function horMove()
{
   if(rolling == false && hurting == false)
   {
      speed += accel;
   }
   if(Math.abs(speed) < 0.1)
   {
      speed = 0;
   }
   else if(Math.abs(speed) >= maxSpeed)
   {
      if(charState != "push")
      {
         runWait += 1;
      }
      if(speed < 0)
      {
         speed = - maxSpeed;
      }
      else
      {
         speed = maxSpeed;
      }
   }
   if(currentHit != null)
   {
      ground = currentHit._y + (this._x - currentHit._x) * Math.tan(currentHit._rotation * 3.141592653589793 / 180);
      if(_parent.useTargetControl)
      {
         this._x += speed * Math.cos(currentHit._rotation * 3.141592653589793 / 180);
      }
      else
      {
         this._x += speed * Math.cos(currentHit._rotation * 3.141592653589793 / 180) * speedFactor;
      }
      if(Math.abs(currentHit.speed) > 0)
      {
         this._x += currentHit.speed;
      }
      this._rotation = 0;
   }
   else if(_parent.useTargetControl)
   {
      this._x += speed;
   }
   else
   {
      this._x += speed * speedFactor;
   }
   if(!foreigner)
   {
      avatar.head._x -= Math.abs(speed * 2);
      avatar.hair._x += Math.abs(speed);
   }
   if(!_parent.useTargetControl && speedFactor > 1 && Math.abs(speed * speedFactor) > runMaxSpeed)
   {
      blur.blurX = (Math.abs(speed * speedFactor) - runMaxSpeed) * 4;
      this.filters = filtersArray;
   }
   else if(speedFactor > 1)
   {
      blur.blurX = 0;
      this.filters = filtersArray;
   }
}
function verMove()
{
   this._y += vSpeed;
   if(this._y + vSpeed < ground - 10)
   {
      if(_root.navBar.btnGrapple._visible && !hurting)
      {
         _root.navBar.grappleHit._visible = true;
      }
      else if(hurting)
      {
         _root.navBar.grappleHit._visible = false;
      }
      if(_parent.diving && mouseFollow && !hurting || diving && (mouseFollow || targetHor || targetVer) && !hurting)
      {
         if(avatar._currentframe < 626 || avatar._currentframe > 652)
         {
            avatar.gotoAndPlay("swim");
         }
         spin = 0;
         avatar._rotation += (-5 * vSpeed - avatar._rotation) / 4;
         if(Math.abs(mouseX) > 20)
         {
            this._xscale = (- charScale) * mouseX / Math.abs(mouseX);
         }
         if(mouseY < -120)
         {
            vAccel = -0.8;
         }
         else if(mouseY > -10)
         {
            vAccel = _parent.gravity + gravityOffset;
         }
         else
         {
            vAccel = 0;
            vSpeed *= 0.7;
         }
         if(vSpeed < -15)
         {
            vSpeed = -15;
         }
      }
      else if(soaring && mouseFollow && !hurting)
      {
         if(vAccel < 0 && (avatar._currentframe < 1285 || avatar._currentframe > 1296))
         {
            avatar.gotoAndPlay("soar");
         }
         else if(vAccel == _parent.gravity && avatar._currentframe < 1297)
         {
            avatar.gotoAndPlay("soardown");
         }
         spin = 0;
         avatar._rotation += (- Math.abs(2 * speed) - avatar._rotation) / 4;
         if(Math.abs(mouseX) > 20)
         {
            this._xscale = (- charScale) * mouseX / Math.abs(mouseX);
         }
         if(mouseY < -120)
         {
            vAccel = -1.5;
         }
         else if(mouseY > -10)
         {
            vAccel = 1.5;
         }
         else
         {
            vAccel = 0;
            vSpeed *= 0.7;
         }
         if(vSpeed < -15)
         {
            vSpeed = -15;
         }
         if(Math.abs(speed) > 10 || vSpeed < -10 || _parent.gravity == 0)
         {
            wind();
         }
         avatar.pack._rotation += - Math.abs(speed) + Math.random() * 4 - 2;
         if(_parent.gravity == 0)
         {
            speed *= 0.8;
            vSpeed *= 0.8;
         }
      }
      if(jumping == false)
      {
         jumping = true;
         charState = "jump";
         avatar.gotoAndPlay("falling" + animationFrameSuffix);
         if(hurting)
         {
            maxSpeed = runMaxSpeed;
         }
         else if(Math.abs(speed) > 6)
         {
            maxSpeed = Math.abs(speed);
         }
         else
         {
            maxSpeed = walkMaxSpeed;
         }
      }
      if(vSpeed + vAccel < maxVSpeed)
      {
         if(gliding && vSpeed > 0 && currentSpecialHit == null && !hurting)
         {
            vSpeed += 0.3;
         }
         else
         {
            vSpeed += vAccel;
         }
      }
      if(vSpeed < - maxVSpeed - 8)
      {
         vSpeed = - maxVSpeed - 8;
      }
      if(!foreigner)
      {
         avatar.head._y -= vSpeed * 0.5;
         avatar.hair._y -= vSpeed;
         avatar.pack._y -= vSpeed;
      }
      pushLeft = false;
      pushRight = false;
      rolling = false;
      avatar.foot1.inner._rotation = avatar.foot2.inner._rotation = 0;
   }
   else
   {
      if(currentHit == null)
      {
         avatar.foot1.inner._rotation = avatar.foot2.inner._rotation = 0;
      }
      else if(_xscale / Math.abs(_xscale) * currentHit._rotation < 0)
      {
         avatar.foot1.inner._rotation = avatar.foot2.inner._rotation += (_xscale / Math.abs(_xscale) * currentHit._rotation - avatar.foot1.inner._rotation) / 2;
      }
      else
      {
         avatar.foot1.inner._rotation = avatar.foot2.inner._rotation += (_xscale / Math.abs(_xscale) * currentHit._rotation / 2 - avatar.foot1.inner._rotation) / 2;
      }
      if(spin == 0)
      {
         hurting = false;
      }
      falling = false;
      if(jumping == true)
      {
         jumping = false;
         if(swimming)
         {
            avatar.gotoAndPlay("treadland");
         }
         else if(avatar._rotation < 0 && spin > 1)
         {
            rolling = true;
            avatar.gotoAndPlay("roll" + animationFrameSuffix);
         }
         else if(avatar._rotation > 0 && spin < -1)
         {
            rolling = true;
            avatar.gotoAndPlay("roll" + animationFrameSuffix);
         }
         else if(Math.abs(speed) > 4 && !isCreature)
         {
            avatar.gotoAndPlay("land2" + animationFrameSuffix);
         }
         else
         {
            avatar.gotoAndPlay("land1" + animationFrameSuffix);
         }
         if(_root.navBar.btnGrapple._visible)
         {
            _root.navBar.grappleHit._visible = false;
         }
      }
      vSpeed = 0;
      avatar._y = avatarStartY + Math.abs(avatar._rotation / 18);
      this._y = ground;
      roll();
   }
}
function roll()
{
   if(spin < -1)
   {
      if(avatar._rotation < 0 && avatar._rotation > -45)
      {
         spin = Math.round(avatar._rotation / 2);
      }
      else
      {
         spin = (- fastSpin) * 1.2;
      }
   }
   else if(spin > 1)
   {
      if(avatar._rotation > 0 && avatar._rotation < 45)
      {
         spin = Math.round(avatar._rotation / 2);
      }
      else
      {
         spin = fastSpin * 1.2;
      }
   }
   else
   {
      rolling = false;
      spin = 0;
      if(Math.abs(avatar._rotation) > 0.1)
      {
         avatar._rotation -= avatar._rotation / 4;
      }
      else
      {
         avatar._rotation = 0;
      }
   }
}
function dust()
{
   if(this._visible && (charState == "run" || charState == "skid") && Math.abs(speed) > 2 && !npc)
   {
      i = 0;
      while(i < 1)
      {
         var _loc3_ = _parent.bg.attachMovie("Dust","dust" + _parent.bg.getNextHighestDepth(),_parent.bg.getNextHighestDepth());
         _loc3_.xVel = Math.random() * 4 - 2;
         _loc3_.yVel = (- Math.random()) * 2 - 2;
         _loc3_._x = this._x + Math.random() * 20 - 10;
         _loc3_._y = this._y;
         _loc3_._xscale = _loc3_._yscale = Math.random() * 50 + 50;
         i++;
      }
   }
}
function wind()
{
   i = 0;
   while(i < 2)
   {
      var _loc3_ = _parent.attachMovie("Dust","dust" + _parent.getNextHighestDepth(),_parent.getNextHighestDepth());
      _loc3_.xVel = (- speed) / 2;
      _loc3_.yVel = (- vSpeed) / 2;
      _loc3_._x = this._x + Math.random() * 20 - 10;
      _loc3_._y = this._y - 50 + Math.random() * 40 - 20;
      _loc3_._xscale = _loc3_._yscale = Math.random() * 30 + 50;
      i++;
   }
}
function thud()
{
   i = 0;
   while(i < 10)
   {
      var _loc3_ = _parent.attachMovie("Dust","dust" + _parent.getNextHighestDepth(),_parent.getNextHighestDepth());
      _loc3_.xVel = Math.random() * 20 - 10;
      _loc3_.yVel = Math.random() * 6 - 3;
      _loc3_._x = this._x + Math.random() * 20 - 10;
      _loc3_._y = this._y - 65 + Math.random() * 10 - 5;
      _loc3_._xscale = _loc3_._yscale = Math.random() * 30 + 20;
      _loc3_._alpha = 40;
      i++;
   }
}
function splash(offset, num)
{
   i = 0;
   while(i < num)
   {
      var _loc3_ = _parent.bg.attachMovie("Drip","splash" + _parent.bg.getNextHighestDepth(),_parent.bg.getNextHighestDepth());
      _loc3_.xVel = Math.random() * 10 - 5;
      _loc3_.yVel = (- Math.abs(vSpeed)) / 3 + Math.random() * 8 - 8;
      _loc3_._x = this._x + Math.random() * 20 - 10;
      _loc3_._y = _loc3_.startY = this._y - offset + Math.random() * offset / 2 - offset / 4;
      _loc3_._xscale = _loc3_._yscale = Math.random() * 50 + 50;
      _loc3_._alpha = Math.random() * 50 + 25;
      _loc3_.onEnterFrame = doDrip;
      i++;
   }
}
function doDrip()
{
   this.yVel += 1;
   this._x += this.xVel;
   this._y += this.yVel;
   this._xscale = this._yscale -= 4;
   if(this._xscale < 0)
   {
      this.removeMovieClip();
   }
}
function makeBubbles()
{
   function doWater()
   {
      this._xscale = this._yscale += 1;
      if(this.velY > -10)
      {
         this.velY -= 1;
      }
      this._y += this.velY;
      this._alpha -= 2;
      if(this._alpha <= 0)
      {
         this.removeMovieClip();
      }
   }
   w = 1;
   while(w <= 3)
   {
      waterBubble = _parent.attachMovie("WaterBubble","waterBubble" + _parent.getNextHighestDepth(),_parent.getNextHighestDepth());
      waterBubble._x = this._x - 30 + Math.random() * 60;
      waterBubble._y = this._y - 80 + Math.random() * 60;
      waterBubble._xscale = waterBubble._yscale = Math.random() * 50 + 50;
      waterBubble.velY = 0;
      waterBubble.onEnterFrame = doWater;
      w++;
   }
}
function makePaint()
{
   b = 1;
   while(b <= 10)
   {
      paint = _parent.createEmptyMovieClip("paint" + _parent.getNextHighestDepth(),_parent.getNextHighestDepth());
      paint.loadMovie("popups/paint.swf");
      b++;
   }
}
function jet()
{
   i = 0;
   while(i < 2)
   {
      var _loc3_ = _parent.attachMovie("Dust","dust" + _parent.getNextHighestDepth(),_parent.getNextHighestDepth());
      _loc3_.xVel = Math.random() * 2 - 1;
      _loc3_.yVel = Math.random() * 2 + 6;
      _loc3_._x = this._x + this._xscale / 6 + Math.random() * 10 - 5;
      _loc3_._y = this._y - 30;
      _loc3_._xscale = _loc3_._yscale = Math.random() * 50 + 100;
      i++;
   }
}
function up()
{
   if(charState != "jump" && Math.abs(avatar._rotation) < 10)
   {
      charState = "jump";
      if(swimming)
      {
         avatar.gotoAndPlay("treadjump");
         jumpSpeed = Math.abs(speed);
      }
      else if((leftIsDown || rightIsDown) && !isCreature)
      {
         avatar.gotoAndPlay("jump2" + animationFrameSuffix);
         jumpSpeed = Math.abs(speed);
      }
      else
      {
         avatar.gotoAndPlay("jump1" + animationFrameSuffix);
         jumpSpeed = 0;
      }
   }
}
function climb()
{
   if(charState != "climb")
   {
      charState = "climb";
      avatar.gotoAndPlay("climb");
      climbing = true;
   }
   if(this.jumping || this.dropping)
   {
      this.speed = 0;
      this.jumping = false;
      this.dropping = false;
   }
   avatar.play();
   if(this._y - climbSpeed > currentSpecialHit._y - currentSpecialHit._height / 2 || currentSpecialHit.base)
   {
      this._y -= climbSpeed;
   }
   rolling = false;
   vSpeed = 0;
}
function climbDown()
{
   if(charState != "climbDown")
   {
      charState = "climbDown";
      avatar.gotoAndPlay("climbdown");
      climbing = true;
   }
   if(this.jumping || this.dropping || this.rolling)
   {
      this.speed = 0;
      this.jumping = false;
      this.dropping = false;
   }
   this._y += climbSpeed * 1.5;
   rolling = false;
   vSpeed = 0;
}
function down()
{
   dropping = true;
   currentHit = null;
   ground = baseGround;
}
function duck()
{
   hurting = false;
   if(ducking == false)
   {
      ducking = true;
      charState = "duck";
      if((leftIsDown || rightIsDown || spin != 0) && !isCreature)
      {
         rolling = true;
         avatar.gotoAndPlay("duckroll" + animationFrameSuffix);
         spin = fastSpin;
         if(Math.abs(speed) < 12 && rightIsDown)
         {
            speed = 12;
         }
         if(Math.abs(speed) < 12 && leftIsDown)
         {
            speed = -12;
         }
      }
      else
      {
         avatar.gotoAndPlay("duck" + animationFrameSuffix);
      }
   }
   if(Math.abs(spin) < 12)
   {
      accel = 0;
      speed *= drag;
   }
}
function leftRight(neg)
{
   if(neg < 0)
   {
      pushRight = false;
   }
   else
   {
      pushLeft = false;
   }
   if(jumping)
   {
      accel = 2 * highAccel * neg;
   }
   else if(charState != "duck")
   {
      accel = highAccel * neg;
   }
   if(charState != "jump")
   {
      this._xscale = (- charScale) * neg;
   }
   if(charState != "jump" && charState != "duck" && charState != "climb" && charState != "climbDown")
   {
      if(Math.abs(speed) < 3)
      {
         speed = 3 * neg;
      }
      if(speed * neg < 0)
      {
         speed *= drag;
      }
      if(swimming)
      {
         if(charState != "swim")
         {
            charState = "swim";
            avatar.gotoAndPlay("swim");
            maxSpeed = walkMaxSpeed;
         }
      }
      else if(pushLeft == true || pushRight == true)
      {
         accel = lowAccel * neg;
         if(charState != "push")
         {
            charState = "push";
            avatar.gotoAndPlay("push");
            maxSpeed = walkMaxSpeed;
         }
      }
      else if(maxSpeed > walkMaxSpeed + 4)
      {
         if(charState != "run")
         {
            charState = "run";
            avatar.gotoAndPlay("run" + animationFrameSuffix);
         }
      }
      else
      {
         accel = highAccel * neg;
         if(charState != "walk")
         {
            charState = "walk";
            avatar.gotoAndPlay("walk" + animationFrameSuffix);
         }
      }
   }
}
function halted()
{
   pushLeft = false;
   pushRight = false;
   accel = 0;
   if(charState != "jump" && charState != "duck" && charState != "smashed")
   {
      if(swimming)
      {
         if(charState != "tread")
         {
            charState = "tread";
            avatar.gotoAndPlay("tread");
         }
      }
      else if(Math.abs(speed) > skidSpeed && charState != "skid")
      {
         charState = "skid";
         avatar.gotoAndPlay("skid" + animationFrameSuffix);
      }
      else if(charState != "skid" && charState != "action" && charState != "stand" && charState != "climb" && charState != "climbDown")
      {
         charState = "stand";
         if(stat == "thinking")
         {
            avatar.gotoAndPlay("think");
         }
         else
         {
            avatar.gotoAndPlay("stand" + animationFrameSuffix);
         }
         if(_root.camera.scene.red5 && isChar)
         {
            if(_root.server)
            {
               _root.server.call("saveXY",null,Math.round(_X),Math.round(_Y));
            }
         }
      }
   }
   if(jumping == false && ducking == false)
   {
      if(Math.abs(speed) > walkMaxSpeed)
      {
         speed *= drag + (1 - drag) / 2;
      }
      else
      {
         speed *= drag;
      }
   }
   if(Math.abs(speed) < 1)
   {
      runWait = 0;
   }
}
function blink()
{
   if(Math.random() * 120 < 1 && this.avatar.head.eyes._currentframe < 4 && this.avatar.head.eyes.pupils._currentframe < 3 && charState == "stand" && !noBlink)
   {
      avatar.head.eyes.gotoAndPlay("blink");
      avatar.head.eyelashes.gotoAndPlay("blink");
   }
}
function chooseTarget()
{
   if(!engaged && !following && charState == "stand" && Math.random() * 120 < 1)
   {
      targetX = maxLeft + (maxRight - maxLeft) * Math.random();
      targetY = maxUp + (maxDown - maxUp) * Math.random();
      targetHor = true;
      targetVer = true;
      if(_parent.char.targetPlayer == this)
      {
         _root.hideMenu();
      }
   }
}
function clickTarget(tX, tY)
{
   tracking = false;
   trackingClip = false;
   targetHor = true;
   targetVer = true;
   targetX = tX;
   targetY = tY;
}
function clickClipTarget(clip)
{
   targetHor = true;
   targetVer = true;
   trackingClip = true;
   tracking = false;
   targetClip = clip;
   targetX = targetClip._x;
   targetY = targetClip._y;
   if(!npc)
   {
      _parent.useTargetControl = true;
   }
}
function targetControl()
{
   mouseX = targetX - this._x;
   if(flying)
   {
      mouseY = targetY - this._y - 80;
   }
   else
   {
      mouseY = targetY - this._y - 20;
   }
   if(following && !targeted && !engaged)
   {
      targetX = targetPlayer._x + 80 * Math.abs(targetPlayer._xscale) / targetPlayer._xscale;
      targetY = targetPlayer._y;
      if(Math.abs(this._x - targetX) < 100)
      {
         maxSpeed += (walkMaxSpeed - maxSpeed) / 4;
      }
      else
      {
         maxSpeed = targetPlayer.maxSpeed;
      }
   }
   if(trackingClip)
   {
      targetX = targetClip._x;
      targetY = targetClip._y;
      if((Math.abs(this._x - targetX) < 200 || npc) && !canRun)
      {
         maxSpeed += (walkMaxSpeed - maxSpeed) / 4;
      }
      else
      {
         maxSpeed = runMaxSpeed;
      }
      if(!targetHor && !targetVer && (charState == "stand" || charState == "tread" || charState == "climb" || charState == "climbDown"))
      {
         trackingClip = false;
         if(!npc)
         {
            _parent.useTargetControl = false;
         }
         if(targetClip.targetFunction != null && isChar)
         {
            targetClip.targetFunction();
         }
         if(reachedTargetFunction != null)
         {
            reachedTargetFunction();
         }
      }
   }
   else if(tracking)
   {
      targetX = targetPlayer._x - 110 * Math.abs(targetPlayer._xscale) / targetPlayer._xscale;
      targetY = targetPlayer._y;
      if(Math.abs(this._x - targetX) < 200)
      {
         maxSpeed += (walkMaxSpeed - maxSpeed) / 4;
      }
      else
      {
         maxSpeed = runMaxSpeed;
      }
      if(Math.abs(this._x - targetX) < padding && Math.abs(this._y - targetY) < padding * 2 && targetPlayer.speed == 0 && targetPlayer.vSpeed == 0 && charState == "stand" || charState == "push" && Math.abs(this._x - targetX) < 120)
      {
         if(charState == "push")
         {
            targetX = this._x;
            targetY = this._y;
         }
         tracking = false;
         this._xscale = (- this.charScale) * targetPlayer._xscale / Math.abs(targetPlayer._xscale);
         if(targetPlayer.engaged == false)
         {
            drag = baseDrag;
            if(targetPlayer.targetFunction != null && isChar)
            {
               targetPlayer.targetFunction();
            }
            if(reachedTargetFunction != null)
            {
               reachedTargetFunction();
            }
            targetPlayer.engaged = true;
            switch(targetPlayer.interaction)
            {
               case "none":
                  break;
               case "costume":
                  if(this._name == "char" || _root.camera.scene.red5 == undefined)
                  {
                     _root.popup("wardrobe.swf",false);
                     _root.useWardrobe = false;
                     _root.navBar.wardrobeSelect._visible = false;
                     _root.navBar.wardrobeDim._visible = false;
                  }
                  break;
               case "statement":
                  _root.responding = true;
                  _root.showSay(this,this.talkyText);
                  break;
               case "phrase":
                  if(this._name == "char" || _root.camera.scene.red5 == undefined)
                  {
                     _root.responding = true;
                     _root.showSay(targetPlayer,targetPlayer.talkyText);
                  }
                  break;
               case "chat":
                  if(this._name == "char" || _root.camera.scene.red5 == undefined)
                  {
                     _root.showChat(_root.camera.scene.char);
                     _root.loadChat(targetPlayer);
                  }
                  break;
               case "friend":
                  _root.showMenu(targetPlayer,true,true);
                  break;
               default:
                  if(_root.camera.scene.red5)
                  {
                     if(actionMMO == "comeup")
                     {
                        actionMMO = null;
                        if(_root.server && isChar)
                        {
                           _root.server.call("saveXY",null,Math.round(_X),Math.round(_Y));
                        }
                        if(targetPlayer.stat == "busy" || targetPlayer.stat == "thinking")
                        {
                           if(_root.userIsFriend(targetPlayer.login))
                           {
                              _root.showSay(targetPlayer,"Sorry, I\'m busy\nright now");
                           }
                           else
                           {
                              _root.showSay(targetPlayer,"I\'m busy, but \nyou can still Friend me.");
                              targetPlayer.sayFunction = function()
                              {
                                 delete targetPlayer.sayFunction;
                                 _root.showMenu(targetPlayer,true);
                              };
                           }
                        }
                        else if(!(targetPlayer.stat == "sudoku" || targetPlayer.stat == "hoopshot" || targetPlayer.stat == "skydive" || targetPlayer.stat == "paintwar" || targetPlayer.stat == "quizgame" || targetPlayer.stat == "dotgame" || targetPlayer.stat == "balloongame" || targetPlayer.stat == "boggle" || targetPlayer.stat == "kidcatcher" || targetPlayer.stat == "hex" || targetPlayer.stat == "thinking"))
                        {
                           if(disableMMOMenu)
                           {
                              disableMMOMenu = false;
                           }
                           else
                           {
                              _root.showMenu(targetPlayer);
                           }
                        }
                     }
                  }
                  else
                  {
                     _root.showMenu(targetPlayer);
                  }
            }
         }
      }
   }
   if(Math.abs(this._x - targetX) < padding || jumping)
   {
      targetHor = false;
   }
   else
   {
      targetHor = true;
   }
   if(Math.abs(this._y - targetY) < padding)
   {
      targetVer = false;
   }
   else if(tracking && Math.abs(this._y - targetY) < padding * 2)
   {
      targetVer = false;
   }
   else if(tracking || following)
   {
      targetVer = true;
   }
   if(targetX < this._x && targetHor == true)
   {
      leftIsDown = true;
   }
   else
   {
      leftIsDown = false;
   }
   if(targetX > this._x && targetHor == true)
   {
      rightIsDown = true;
   }
   else
   {
      rightIsDown = false;
   }
   if((targetY < this._y - padding && !_parent.common || (targetY < this._y - padding * 6 || (climbing || flying || (_parent.diving || diving)) && targetY < this._y)) && Math.abs(this._x - targetX) < padding * 12 && targetVer)
   {
      upIsDown = true;
   }
   else
   {
      upIsDown = false;
   }
   if(targetY > this._y + padding && Math.abs(this._x - targetX) < padding * 6 && targetVer == true)
   {
      downIsDown = true;
   }
   else
   {
      downIsDown = false;
   }
   if(jumping && airControl && !hurting && !pushLeft && !pushRight && !_parent.common)
   {
      maxSpeed = runMaxSpeed;
      speed = mouseX / 10;
   }
}
function mouseControl()
{
   mouseX = _parent._xmouse - this._x;
   mouseY = _parent._ymouse - this._y;
   if((mouseX < -60 || leftIsDown && mouseX < 0) && mouseFollow && (!climbing || _root.pointer.directional._rotation == 180 || _root.pointer.directional._rotation == 0))
   {
      targetHor = true;
      leftIsDown = true;
      if(pushLeft || pushRight)
      {
         maxSpeed = walkMaxSpeed;
      }
      else
      {
         maxSpeed = Math.abs(mouseX / 15);
      }
      if(maxSpeed > runMaxSpeed)
      {
         maxSpeed = runMaxSpeed;
      }
      else if(maxSpeed < walkMaxSpeed)
      {
         maxSpeed = walkMaxSpeed;
      }
   }
   else if((mouseX > 60 || rightIsDown && mouseX > 0) && mouseFollow && (!climbing || _root.pointer.directional._rotation == 180 || _root.pointer.directional._rotation == 0))
   {
      targetHor = true;
      leftIsDown = false;
      if(pushLeft || pushRight)
      {
         maxSpeed = walkMaxSpeed;
      }
      else
      {
         maxSpeed = Math.abs(mouseX / 15);
      }
      if(maxSpeed > runMaxSpeed)
      {
         maxSpeed = runMaxSpeed;
      }
      else if(maxSpeed < walkMaxSpeed)
      {
         maxSpeed = walkMaxSpeed;
      }
      rightIsDown = true;
   }
   else
   {
      targetHor = false;
      leftIsDown = false;
      rightIsDown = false;
   }
   if((mouseY < -120 || upIsDown && mouseY < -65 && (Math.abs(mouseX) < 60 || flying)) && mouseFollow)
   {
      targetVer = true;
      upIsDown = true;
      downIsDown = false;
   }
   else if((mouseY > -10 || downIsDown && mouseY > -65 && Math.abs(mouseX) < 60 && !flying) && mouseFollow)
   {
      targetVer = true;
      upIsDown = false;
      downIsDown = true;
   }
   else
   {
      targetVer = false;
      upIsDown = false;
      downIsDown = false;
   }
   if(jumping && airControl && !hurting && !pushLeft && !pushRight)
   {
      maxSpeed = runMaxSpeed;
      speed = mouseX / 20;
   }
}
function playerMovement()
{
   if(_parent.diving || diving)
   {
      diveWait++;
      speed *= 0.9;
      vSpeed *= 0.9;
      if(Math.random() * 30 < 1)
      {
         makeBubbles();
      }
   }
   if(_parent.bgBitmap && (avatar.facialFrame == "chameleon" || avatar.overpantsFrame == "chameleon"))
   {
      if(Math.abs(speed) < 1 && vSpeed == 0)
      {
         if(chamAlpha > 0)
         {
            chamAlpha -= 10;
            chamPoint1.x = this._x;
            chamPoint1.y = this._y - 40;
            chamPoint2.x = this._x - 10;
            chamPoint2.y = this._y - 70;
            chamPoint3.x = this._x + 10;
            chamPoint3.y = this._y - 70;
            c = 1;
            while(c <= 3)
            {
               if(this["chamPoint" + c].x < 1)
               {
                  this["chamPoint" + c].x = 1;
               }
               else if(this["chamPoint" + c].x > _parent.rightLimit - 4)
               {
                  this["chamPoint" + c].x = _parent.rightLimit - 4;
               }
               if(this["chamPoint" + c].y < 1)
               {
                  this["chamPoint" + c].y = 1;
               }
               else if(this["chamPoint" + c].y > _parent.downLimit - 4)
               {
                  this["chamPoint" + c].y = _parent.downLimit - 4;
               }
               this["chamColorNum" + c] = _parent.bgBitmap.getPixel(this["chamPoint" + c].x,this["chamPoint" + c].y).toString(16);
               if(this["chamColorNum" + c] == 0)
               {
                  this["chamColorNum" + c] = _parent.bgBitmap2.getPixel(this["chamPoint" + c].x - _parent.bg.half2._x,this["chamPoint" + c].y - _parent.bg.half2._y).toString(16);
               }
               if(this["chamColorNum" + c] == 0)
               {
                  this["chamColorNum" + c] = _parent.bgBitmap3.getPixel(this["chamPoint" + c].x - _parent.bg.half3._x,this["chamPoint" + c].y - _parent.bg.half3._y).toString(16);
               }
               this["chamColor" + c] = "0x" + this["chamColorNum" + c];
               setChamColor = new Color(avatar.head.facial["color" + c]);
               setChamColor.setRGB(this["chamColor" + c]);
               setChamColor = new Color(avatar.body.overpants["color" + c]);
               setChamColor.setRGB(this["chamColor" + c]);
               c++;
            }
            setSkinColor = new Color(avatar.head.eyes.eyelids.skinShape);
            setSkinColor.setRGB(chamColor3);
         }
      }
      else if(chamAlpha < 100)
      {
         chamAlpha += 10;
      }
      else
      {
         chamAlpha = 100;
         setSkinColor = new Color(avatar.head.eyes.eyelids.skinShape);
         setSkinColor.setRGB(avatar.skinColor);
      }
      avatar.head.facial.overlay._alpha = avatar.body.overpants.overlay._alpha = avatar.head.eyes.eyelids.overlay._alpha = avatar.lineAlpha = avatar.body.overshirt._alpha = avatar.pack._alpha = avatar.item._alpha = avatar.hand1.skinShape._alpha = avatar.hand2.skinShape._alpha = avatar.foot1.inner.skinShape._alpha = avatar.foot2.inner.skinShape._alpha = chamAlpha;
   }
   else if(chamAlpha < 100)
   {
      setSkinColor = new Color(avatar.head.eyes.eyelids.skinShape);
      setSkinColor.setRGB(avatar.skinColor);
      chamAlpha = 100;
      avatar.head.eyes.eyelids.overlay._alpha = avatar.lineAlpha = avatar.body.overshirt._alpha = avatar.pack._alpha = avatar.item._alpha = avatar.hand1.skinShape._alpha = avatar.hand2.skinShape._alpha = avatar.foot1.inner.skinShape._alpha = avatar.foot2.inner.skinShape._alpha = chamAlpha;
   }
   if(!_parent.pausedGame)
   {
      if(npc && Static != true)
      {
         chooseTarget();
      }
      if(_parent.useTargetControl || noHits || npc)
      {
         targetControl();
      }
      else
      {
         mouseControl();
      }
      horMove();
      avatar._rotation -= spin;
      if(climbing)
      {
         roll();
      }
      else
      {
         verMove();
      }
      dust();
      blink();
      if(upIsDown)
      {
         if(canClimb)
         {
            climb();
         }
         else if(flying && vSpeed >= -12 && !hurting)
         {
            if(jumping == false)
            {
               ground = baseGround;
               jumping = true;
               charState = "jump";
               avatar.gotoAndPlay("falling");
               vSpeed -= 10;
            }
            if(mouseY < -120)
            {
               vAccel = -1.5;
            }
            else
            {
               vAccel = 0;
               vSpeed *= 0.7;
            }
            if(vSpeed < -10)
            {
               vSpeed = -10;
            }
            if(Math.abs(mouseX) > 20)
            {
               this._xscale = (- charScale) * mouseX / Math.abs(mouseX);
            }
            jet();
         }
         else if((_parent.diving || diving) && !hurting)
         {
            if(!jumping)
            {
               ground = baseGround;
               jumping = true;
               charState = "jump";
               avatar.gotoAndPlay("tread");
               vSpeed -= 8;
            }
            if(!mouseFollow)
            {
               if(mouseY < -120)
               {
                  vAccel = -0.8;
               }
               if(vSpeed < -15)
               {
                  vSpeed = -15;
               }
            }
         }
         else if(soaring && !hurting)
         {
            if(!jumping)
            {
               ground = baseGround;
               jumping = true;
               charState = "jump";
               avatar.gotoAndPlay("soar");
               vSpeed -= 10;
            }
            if(!mouseFollow)
            {
               if(mouseY < -120)
               {
                  vAccel = -1.5;
               }
               if(vSpeed < -15)
               {
                  vSpeed = -15;
               }
            }
         }
         else
         {
            up();
            vAccel = _parent.gravity + gravityOffset;
         }
      }
      else if(downIsDown)
      {
         if(!swimming)
         {
            if(canClimb && climbBase != true)
            {
               climbDown();
            }
            else if(_parent.useTargetControl || canDrop)
            {
               down();
            }
            else if(jumping == false)
            {
               hit._yscale = 50;
               duck();
               climbing = false;
            }
         }
         vAccel = _parent.gravity + gravityOffset;
      }
      else
      {
         hit._yscale = 100;
         dropping = false;
         if(charState == "duck" && Math.abs(spin) < 24)
         {
            avatar.play();
         }
         ducking = false;
         vAccel = _parent.gravity + gravityOffset;
      }
      if(leftIsDown)
      {
         leftRight(-1);
      }
      else if(rightIsDown)
      {
         leftRight(1);
      }
      else
      {
         halted();
      }
   }
   if(!_root.loadProgress._visible && warping)
   {
      if(this._alpha < 100)
      {
         this._alpha += 10;
      }
      else
      {
         this._alpha = 100;
         glow.strength -= 0.1;
         this.filters = filtersArray;
         if(glow.strength <= 0)
         {
            warping = false;
            avatar.FunBrain_so.data.timeWarp = false;
            glow = null;
            this.filters = filtersArray;
            avatar.setParts();
         }
      }
   }
   swapCharDepths();
   dir = Math.abs(this._xscale) / this._xscale;
   if(flames)
   {
      flames._xscale = 100 * dir;
   }
}
function setGlow()
{
   warping = true;
   glow.strength = 2;
   this.filters = filtersArray;
   this._alpha = 0;
}
function action(frameName)
{
   if(charState != "jump")
   {
      if(onEnterFrame == undefined && actionFrame == "sit")
      {
         return undefined;
      }
      actionFrame = frameName;
      charState = "action";
      avatar.gotoAndPlay(frameName);
   }
}
function changeSkinColor(newColor)
{
   avatar.skinColor = newColor;
   rgb = avatar.hexToRgb(avatar.skinColor);
   red = rgb.red * 0.8;
   green = rgb.green * 0.8;
   blue = rgb.blue * 0.8;
   avatar.lineColor = avatar.rgbToHex(red,green,blue);
   avatar.savePartsToSO();
   avatar.setParts();
   action("pop");
}
function followPlayer(targetChar)
{
   following = true;
   targetHor = true;
   targetVer = true;
   targetPlayer = targetChar;
   baseGround = targetChar.baseGround;
}
function swapCharDepths()
{
   if(npc && !isMasked)
   {
      if(this._y > _parent.char._y + 10 && this.getDepth() < _parent.char.getDepth())
      {
         this.swapDepths(_parent.char);
      }
      else if(this._y <= _parent.char._y + 10 && this.getDepth() > _parent.char.getDepth())
      {
         this.swapDepths(_parent.char);
      }
   }
}
function grappleShoot()
{
   grappling = false;
   _root.takeClick._visible = true;
   _parent.panChar = _parent.hook;
   _parent.hook._visible = true;
   avatar.body.overshirt._visible = false;
   _parent.hook._x = this._x;
   _parent.hook._y = this._y - 50;
   _parent.hook.radians = Math.atan((_parent._ymouse - this._y + 50) / (_parent._xmouse - this._x));
   if(_parent._xmouse - this._x > 0)
   {
      _parent.hook.radians += 3.141592653589793;
   }
   _parent.hook.onEnterFrame = function()
   {
      this._rotation += 20;
      this._x += -50 * Math.cos(this.radians);
      this._y += -50 * Math.sin(this.radians);
      drawLine();
      if(this._x < 0 || this._x > _parent.rightLimit || this._y < 0 || this._y > _parent.downLimit)
      {
         clearGrapple();
      }
      this.coordinates.x = 0;
      this.coordinates.y = 0;
      this.localToGlobal(this.coordinates);
      if(this._y > baseGround)
      {
         this.onEnterFrame = grappleCheck;
         _parent.panChar = _parent.char;
         _root.takeClick._visible = false;
         this._y = baseGround;
         this.currentHit = null;
      }
      for(var _loc5_ in this._parent)
      {
         var _loc4_ = this._parent[_loc5_];
         if(_loc4_.id == "hit" && (_loc4_.funcName == "platformHit" || _loc4_.funcName == "platformMovingHit" || _loc4_.funcName == "ceilingHit" || _loc4_.funcName == "wallHit" || _loc4_.funcName == "grappleHit"))
         {
            if(_loc4_.hitTest(this.coordinates.x,this.coordinates.y,true))
            {
               this.onEnterFrame = grappleCheck;
               _parent.panChar = _parent.char;
               _root.takeClick._visible = false;
               this.currentHit = null;
               if(_loc4_.funcName == "platformHit" || _loc4_.funcName == "platformMovingHit")
               {
                  this._y = _loc4_._y + (this._x - _loc4_._x) * Math.tan(_loc4_._rotation * 3.141592653589793 / 180);
                  this.currentHit = _loc4_;
                  this.startX = this._x - _loc4_._x;
               }
            }
         }
         else if(_loc4_.id == "hit" && _loc4_.funcName == "enemyHit" && _loc4_.comicSound == "zap")
         {
            if(_loc4_.hit.hitTest(this))
            {
               _loc4_.chooseTarget();
               clearGrapple();
               _root.showSound("zap",this._x,this._y);
            }
         }
      }
   };
}
function grapple()
{
   if(grappling)
   {
      if(this.currentHit.funcName == "platformMovingHit")
      {
         this._x = this.currentHit._x + this.startX;
         this._y = this.currentHit._y;
      }
      this.delX = this._x - _X;
      this.delY = this._y - (_Y - 50);
      this.dist = Math.sqrt(this.delX * this.delX + this.delY * this.delY);
      this.radians = Math.atan(this.delY / this.delX);
      if(this.delX > 0)
      {
         this.radians += 3.141592653589793;
      }
      this.accelX = -3 * Math.cos(this.radians);
      this.accelY = -3 * Math.sin(this.radians);
      maxSpeed = 30;
      speed += this.accelX;
      vSpeed += this.accelY;
      drawLine();
      if(mouseFollow || !jumping || this.dist < 50 || hurting)
      {
         clearGrapple();
      }
   }
   else
   {
      clearGrapple();
   }
}
function grappleCheck()
{
   if(this.currentHit.funcName == "platformMovingHit")
   {
      this._x = this.currentHit._x + this.startX;
      this._y = this.currentHit._y;
   }
   drawLine();
   if(jumping && !grappling)
   {
      grappling = true;
      mouseFollow = false;
      airControl = false;
      maxSpeed = runMaxSpeed;
      this.onEnterFrame = grapple;
   }
   if(hurting)
   {
      clearGrapple();
   }
}
function groundCheck()
{
   drawLine();
   if(!jumping)
   {
      this.onEnterFrame = grappleCheck;
   }
}
function drawLine()
{
   grappleX = _X + _xscale / charScale * avatar.body._x * 0.36;
   grappleY = _Y + avatar._y + avatar.body._y * 0.36;
   _parent.lines.clear();
   _parent.lines.lineStyle(4,0,50);
   _parent.lines.moveTo(_parent.hook._x,_parent.hook._y);
   _parent.lines.lineTo(grappleX,grappleY);
   _parent.lines.lineStyle(2,16777215,50);
   _parent.lines.moveTo(_parent.hook._x,_parent.hook._y);
   _parent.lines.lineTo(grappleX,grappleY);
}
function clearGrapple()
{
   _root.navBar.grappleHit._visible = false;
   grappling = false;
   _parent.panChar = this;
   _root.takeClick._visible = false;
   if(_parent.hook._visible)
   {
      _parent.hook.onEnterFrame = function()
      {
         this._rotation += (- this._rotation) / 4;
         this.delX = this._x - _X;
         this.delY = this._y - (_Y - 50);
         this.dist = Math.sqrt(this.delX * this.delX + this.delY * this.delY);
         this.radians = Math.atan(this.delY / this.delX);
         if(this.delX > 0)
         {
            this.radians += 3.141592653589793;
         }
         if(this.dist > 100)
         {
            this._x += 100 * Math.cos(this.radians);
            this._y += 100 * Math.sin(this.radians);
            drawLine();
         }
         else
         {
            delete this.onEnterFrame;
            this._visible = false;
            avatar.body.overshirt._visible = true;
            _parent.lines.clear();
         }
      };
   }
}
function paintPink()
{
   delete _parent.char.onPress;
   if(!_parent.common)
   {
      delete _parent.char.onRollOver;
   }
   _parent.char.targetPlayer = this;
   _root.useWardrobe = false;
   _root.usePinkPainter = false;
   _root.navBar.wardrobeSelect._visible = false;
   _root.navBar.wardrobeDim._visible = false;
   this.avatar.hairFrame = "sponsorFLoct2";
   this.avatar.shirtFrame = "sponsorFLoct2";
   this.avatar.pantsFrame = "sponsorFLoct2";
   this.avatar.setParts();
   this.action("pop");
}
function accessCharOutfit()
{
   _root.accessCharOutfit = true;
   _root.isModel = true;
   _root.modelLook = this.avatar.getLook().split(",");
   if(_root.usePinkPainter)
   {
      this.paintPink();
   }
   else if(_root.useSelectCharacter)
   {
      _root.selectedCharacter = this;
      _root.selectCharacter();
   }
   else if(_root.useWardrobe && !isCreature && !foreigner)
   {
      this._parent.char.targetPlayer = this;
      _root.popup("wardrobe.swf",false);
      _root.useWardrobe = false;
      _root.navBar.wardrobeSelect._visible = false;
      _root.navBar.wardrobeDim._visible = false;
   }
   else
   {
      _root.useWardrobe = false;
      _root.navBar.wardrobeSelect._visible = false;
      _root.navBar.wardrobeDim._visible = false;
      _root.hideMenu();
      _root.hideChat();
      _root.responding = false;
      if(this._parent.red5)
      {
         if(!npc)
         {
            if(_root.server)
            {
               _root.server.call("actUser",null,this.login,"comeup");
            }
         }
         else if(_root.server)
         {
            _root.server.call("actUser",null,this._name,"npcact");
         }
      }
      else
      {
         _root.hideSay(this._parent.char.targetPlayer);
         _root.hideSay(this._parent.char);
         this._parent.char.targetHor = true;
         this._parent.char.targetVer = true;
         this._parent.char.tracking = true;
         this._parent.char.targetPlayer = this;
         this._parent.useTargetControl = true;
         targeted = true;
      }
   }
}
function hitTests()
{
   if(_parent.pausedGame == false && (Math.abs(speed) > 0 || Math.abs(vSpeed) > 0 || Math.abs(currentHit.speed) > 0) || isPlayer && _parent.useMouse != true || init)
   {
      for(var _loc4_ in _parent)
      {
         var _loc3_ = _parent[_loc4_];
         if(_loc3_.xHitOffset == undefined)
         {
            _loc3_.xHitOffset = 0;
         }
         if(_loc3_.yHitOffset == undefined)
         {
            _loc3_.yHitOffset = 0;
         }
         if(_loc3_.id == "hit" && _loc3_ != this)
         {
            var _loc0_ = null;
            if((_loc0_ = _loc3_.funcName) === "ceilingHit")
            {
               ceilingHit(_loc3_);
               continue;
            }
            if(_loc0_ === "enemyHit")
            {
               enemyHit(_loc3_,_loc3_.hitSpin,_loc3_.hitVSpeed,_loc3_.hitSpeed,_loc3_.comicSound);
               continue;
            }
            if(_loc0_ === "itemHit")
            {
               itemHit(_loc3_);
               continue;
            }
            if(_loc0_ === "objectHit")
            {
               objectHit(_loc3_);
               continue;
            }
            if(_loc0_ === "springLineHit")
            {
               springLineHit(_loc3_,_loc3_.radius,_loc3_.lineColor);
               continue;
            }
            if(_loc0_ === "wallHit")
            {
               wallHit(_loc3_);
               continue;
            }
            if(_loc3_.hitTest(this.coordinates.x + _loc3_.xHitOffset,this.coordinates.y + _loc3_.yHitOffset,true))
            {
               switch(_loc3_.funcName)
               {
                  case "climbHit":
                     climbHit(_loc3_);
                     break;
                  case "climbTopHit":
                     climbTopHit(_loc3_);
                     break;
                  case "cloudHit":
                     cloudHit(_loc3_,_loc3_.friction);
                     break;
                  case "exitHit":
                     exitHit(_loc3_);
                     break;
                  case "floatHit":
                     floatHit(_loc3_);
                     break;
                  case "groundHit":
                     groundHit(_loc3_,_loc3_.friction);
                     break;
                  case "platformHit":
                     platformHit(_loc3_,_loc3_.friction);
                     break;
                  case "platformMovingHit":
                     platformHit(_loc3_,_loc3_.friction);
                     break;
                  case "riverHit":
                     riverHit(_loc3_);
                     break;
                  case "splashHit":
                     splashHit(_loc3_,_loc3_.offset,_loc3_.num);
                     break;
                  case "springHit":
                     springHit(_loc3_,_loc3_.vSpeed);
                     break;
                  case "swimHit":
                     swimHit(_loc3_);
                     break;
                  case "diveHit":
                     diveHit(_loc3_);
                     break;
                  case "teleportHit":
                     teleportHit(_loc3_,_loc3_.xPos,_loc3_.yPos);
                     break;
                  case "wallAngleHit":
                     wallAngleHit(_loc3_);
                     break;
                  case "windColumnHit":
                     windColumnHit(_loc3_);
               }
            }
            else if(currentHit == _loc3_)
            {
               switch(_loc3_.funcName)
               {
                  case "cloudHit":
                     cloudOff();
                     break;
                  case "groundHit":
                     platformOff();
                     break;
                  case "platformHit":
                     platformOff();
                     break;
                  case "platformMovingHit":
                     platformMovingOff(_loc3_);
                     break;
                  case "platformTurningHit":
                     platformOff();
                     break;
                  case "swimHit":
                     platformOff();
               }
            }
            else if(currentSpecialHit == _loc3_)
            {
               switch(_loc3_.funcName)
               {
                  case "climbHit":
                     climbOff();
                     break;
                  case "cloudHit":
                     cloudOff();
                     break;
                  case "floatHit":
                     floatOff();
                     break;
                  case "riverHit":
                     floatOff();
                     break;
                  case "splashHit":
                     currentSpecialHit = null;
                     break;
                  case "springLineHit":
                     springLineOff();
                     break;
                  case "windColumnHit":
                     floatOff();
                     break;
                  case "diveHit":
                     diveOff();
               }
            }
         }
      }
   }
}
function ceilingHit(hitClip)
{
   if(this.vSpeed < 0)
   {
      if(Math.abs(hitClip._rotation) > 0)
      {
         if(hitClip.hitTest(this.coordinates.x,this.coordinates.y - 90,true))
         {
            this.vSpeed = 5;
            thud();
         }
      }
      else if(hitClip.hitTest(this.hit))
      {
         this.vSpeed = 5;
         thud();
      }
   }
}
function climbHit(hitClip)
{
   if(!this.hurting && !this.dontClimb && (this.rolling || this.jumping || this.upIsDown || this.downIsDown || hitClip._rotation != 0))
   {
      if(hitClip.base)
      {
         this.climbBase = true;
      }
      else
      {
         this.climbBase = false;
      }
      currentSpecialHit = hitClip;
      this.canClimb = true;
      hitClip.climbX = hitClip._x - (this._y - hitClip._y) * Math.tan(hitClip._rotation * 3.141592653589793 / 180);
      this.avatar._rotation = this.charScale / this._xscale * hitClip._rotation;
      if(this.upIsDown || this.downIsDown || hitClip._rotation != 0)
      {
         this._x += (hitClip.climbX - this._x) / 4;
      }
      if(this.jumping && this.climbBase == false)
      {
         this.climb();
         this._x = hitClip.climbX;
      }
      if(this.rolling)
      {
         this.climbDown();
         this._x = hitClip.climbX;
      }
   }
}
function climbOff()
{
   currentSpecialHit = null;
   this.canClimb = false;
   this.climbing = false;
   if(this.charState == "climb" || this.charState == "climbDown")
   {
      this.charState = null;
   }
}
function cloudHit(hitClip, friction)
{
   if(this.vSpeed > 18 && this.springing == false)
   {
      this.springing = true;
      this.avatar.gotoAndPlay("falling");
   }
   if(springing)
   {
      currentSpecialHit = hitClip;
      this.vSpeed *= 0.8;
      hitClip.delY = this._y - hitClip._y;
      this.vAccel = (- hitClip.delY) / 20 - _parent.gravity;
   }
   else if(this.vSpeed >= 0)
   {
      currentHit = hitClip;
      this.drag = friction;
   }
}
function cloudOff(hitClip)
{
   currentSpecialHit = null;
   currentHit = null;
   this.ground = _parent.baseGround;
   this.vAccel = _parent.gravity;
   this.springing = false;
}
function climbTopHit(hitClip)
{
   if(this.jumping == false && this.dropping == false)
   {
      this.climbing = false;
      this.ground = _parent.baseGround;
      this.jumping = true;
      this.charState = "jump";
      this.avatar.gotoAndPlay("climbtop");
      this.vSpeed = -15;
   }
}
function enemyHit(hitClip, hitSpin, hitVSpeed, hitSpeed, comicSound)
{
   if(this.isPlayer && this.charState != "smashed" && !this.hurting && hitClip.hit.hitTest(this.avatar.hit))
   {
      hitClip.chooseTarget();
      this.hurting = true;
      this.ground = _parent.baseGround;
      this.jumping = true;
      this.charState = "jump";
      this.avatar.gotoAndPlay("hurt");
      if(hitSpin != 0)
      {
         this.spin = hitSpin;
      }
      if(hitVSpeed != 0)
      {
         this.vSpeed = hitVSpeed;
      }
      if(this._x < hitClip._x + hitClip.hit._x)
      {
         this.speed = - hitSpeed;
      }
      else
      {
         this.speed = hitSpeed;
      }
      if(comicSound != null && comicSound != undefined)
      {
         _root.showSound(comicSound,this._x,this._y - 50);
      }
   }
}
function hitChar(hitSpin, hitVSpeed, hitSpeed, comicSound)
{
   this.hurting = true;
   this.ground = _parent.baseGround;
   this.jumping = true;
   this.charState = "jump";
   this.avatar.gotoAndPlay("hurt");
   if(hitSpin != 0)
   {
      this.spin = hitSpin;
   }
   if(hitVSpeed != 0)
   {
      this.vSpeed = hitVSpeed;
   }
   this.speed = hitSpeed;
   if(comicSound != null && comicSound != undefined)
   {
      _root.showSound(comicSound,this._x,this._y - 50);
   }
}
function loadScene(sceneName, xPos, yPos, islandName)
{
   trace("AS3Embassy :: LoadScene : " + arguments);
   if(!_root.gWaitingOnServer)
   {
      if(islandName == undefined)
      {
         islandName = _root.island;
      }
      if(this.avatar.isRegistred())
      {
         this.avatar.updateIslandData(islandName,Delegate.create(this,loadSceneInternal,sceneName,xPos,yPos,islandName));
      }
      else
      {
         loadSceneInternal(sceneName,xPos,yPos,islandName);
      }
   }
   else
   {
      _root.gServerOperationComplete = Delegate.create(this,loadScene,sceneName,xPos,yPos,islandName);
   }
}
function loadSceneInternal(sceneName, xPos, yPos, islandName)
{
   trace("hits.as AS3Embassy :: loadSceneInternal : " + arguments);
   this.avatar.checkLSOStoreResult(this.avatar.FunBrain_so.flush(),"SceneLoad");
   var _loc6_ = "POST";
   var _loc7_ = "base.php";
   if(_root._url.substr(0,_root._url.indexOf(":")) == "file" || _root._url.substr(0,_root._url.indexOf(".")) == "http://feta" || _root._url.substr(0,_root._url.indexOf(".")) == "http://localhost/pop/base")
   {
      _loc6_ = "GET";
      _loc7_ = "base.html";
   }
   this.avatar.FunBrain_so.data[sceneName + "xPos"] = xPos;
   this.avatar.FunBrain_so.data[sceneName + "yPos"] = yPos;
   this.createEmptyMovieClip("loader_mc",this.getNextHighestDepth());
   if(islandName == undefined)
   {
      islandName = _root.island;
   }
   loader_mc.room = sceneName;
   loader_mc.island = islandName;
   loader_mc.getURL(_loc7_,"_self",_loc6_);
   this.avatar.checkForNewIslandStart(islandName,sceneName);
}
function exitRoom(clip)
{
   if(this.avatar.FunBrain_so.data.dontReturn == true)
   {
      this.avatar.FunBrain_so.data.dontReturn = false;
      this.avatar.FunBrain_so.flush();
   }
   trace("exitRoom: desc " + clip.desc);
   if(!_root.gWaitingOnServer)
   {
      if(this.avatar.isRegistred())
      {
         _root.logWWW("avatar is registered, clipisle is " + clip.island + ", rootisle is " + _root.island);
         var _loc4_ = clip.island;
         if(_loc4_ == undefined)
         {
            _loc4_ = _root.island;
         }
         this.avatar.updateIslandData(_loc4_,Delegate.create(this,exitRoomInternal,clip));
      }
      else
      {
         exitRoomInternal(clip);
      }
   }
   else
   {
      _root.gServerOperationComplete = Delegate.create(this,exitRoom,clip);
      trace("server op active, storing callback : " + _root.gServerOperationComplete);
   }
}
function exitRoomInternal(clip)
{
   _root.logWWW("exitRoomInternal() clipisle " + clip.island + ", rootisle " + _root.island + " desc : " + clip.desc + " desctype: " + typeof desc);
   if(this.isPlayer)
   {
      if(clip._name.substr(0,5) == "adHit")
      {
         if(!transitToken.data.returnQuest)
         {
            transitToken.data.returnQuest = {};
         }
         transitToken.data.returnQuest.scene = _root.islandMain;
         transitToken.data.returnQuest.island = _root.island;
         transitToken.data.returnQuest.xPos = _root.char._x;
         transitToken.data.returnQuest.yPos = _root.char._y;
         transitToken.data.returnQuest.dir = _root.char._xscale >= 0 ? "right" : "left";
      }
      var _loc4_ = SharedObject.getLocal("Backup","/");
      this.avatar.checkLSOStoreResult(this.avatar.FunBrain_so.flush(),"ExitRoom");
      if(_root.server)
      {
         _root.server.close();
      }
      if(!_root.camera.scene.pausedGame)
      {
         _root.pauseGame();
      }
      _root.takeClick._visible = true;
      var _loc5_ = clip.island;
      if(_loc5_ == undefined)
      {
         _loc5_ = _root.island;
      }
      var _loc8_ = "POST";
      var _loc9_ = "base.php";
      if(_root._url.substr(0,_root._url.indexOf(":")) == "file" || _root._url.substr(0,_root._url.indexOf(".")) == "http://feta" || _root._url.substr(0,_root._url.indexOf(".")) == "http://localhost/pop/base")
      {
         _loc8_ = "GET";
         _loc9_ = "base.html";
      }
      if(clip.desc == "leftAd")
      {
         var _loc6_ = this.avatar.FunBrain_so.data.leftExit[0];
         var _loc11_ = this.avatar.FunBrain_so.data.leftExit[1];
         var _loc10_ = this.avatar.FunBrain_so.data.leftExit[2];
         if(utils.Utils.isNull(_loc6_))
         {
            if(!utils.Utils.isNull(_loc4_.data.leftExit))
            {
               _loc6_ = _loc4_.data.leftExit;
               _root.trackCampaign("","Debugging","LeftExitRecovered");
            }
            else
            {
               _root.trackCampaign("","Debugging","LeftExitLost");
            }
         }
         if(utils.Utils.isNull(_loc11_))
         {
            if(!utils.Utils.isNull(_loc4_.data.leftExitX))
            {
               _loc11_ = _loc4_.data.leftExitX;
            }
         }
         if(utils.Utils.isNull(_loc10_))
         {
            if(!utils.Utils.isNull(_loc4_.data.leftExitY))
            {
               _loc10_ = _loc4_.data.leftExitY;
            }
         }
         this.avatar.FunBrain_so.data[_loc6_ + "xPos"] = _loc11_;
         this.avatar.FunBrain_so.data[_loc6_ + "yPos"] = _loc10_;
         checkStatusBeforeLoad(_loc8_,_loc9_,_loc6_,_loc5_);
      }
      else if(clip.desc == "rightAd")
      {
         var _loc7_ = this.avatar.FunBrain_so.data.rightExit[0];
         var _loc13_ = this.avatar.FunBrain_so.data.rightExit[1];
         var _loc14_ = this.avatar.FunBrain_so.data.rightExit[2];
         if(utils.Utils.isNull(_loc7_))
         {
            if(!utils.Utils.isNull(_loc4_.data.rightExit))
            {
               _loc7_ = _loc4_.data.rightExit;
               _root.trackCampaign("","Debugging","RightExitRecovered");
            }
            else
            {
               _root.trackCampaign("","Debugging","RightExitLost");
            }
         }
         if(utils.Utils.isNull(_loc13_))
         {
            if(!utils.Utils.isNull(_loc4_.data.rightExitX))
            {
               _loc13_ = _loc4_.data.rightExitX;
            }
         }
         if(utils.Utils.isNull(_loc14_))
         {
            if(!utils.Utils.isNull(_loc4_.data.rightExitY))
            {
               _loc14_ = _loc4_.data.rightExitY;
            }
         }
         this.avatar.FunBrain_so.data[_loc7_ + "xPos"] = _loc13_;
         this.avatar.FunBrain_so.data[_loc7_ + "yPos"] = _loc14_;
         checkStatusBeforeLoad(_loc8_,_loc9_,_loc7_,_loc5_);
      }
      else if(clip.desc[0].substr(0,2) != "Ad")
      {
         this.avatar.FunBrain_so.data[_root.desc + "xPos"] = clip._x;
         this.avatar.FunBrain_so.data[_root.desc + "yPos"] = clip._y - 30;
         if(clip.desc[1] != undefined)
         {
            this.avatar.FunBrain_so.data[clip.desc[0] + "xPos"] = clip.desc[1];
            this.avatar.FunBrain_so.data[clip.desc[0] + "yPos"] = clip.desc[2];
         }
         trace("AS3Embassy :: exitting to scene!!!!!!! : " + clip.desc[0]);
         checkStatusBeforeLoad(_loc8_,_loc9_,clip.desc[0],_loc5_);
      }
      else
      {
         this.avatar.FunBrain_so.data[clip.desc[0] + "xPos"] = clip.desc[1];
         this.avatar.FunBrain_so.data[clip.desc[0] + "yPos"] = clip.desc[2];
         this.avatar.FunBrain_so.data.leftExit = clip.leftExit;
         this.avatar.FunBrain_so.data.rightExit = clip.rightExit;
         _loc4_.data.leftExit = clip.leftExit[0];
         _loc4_.data.leftExitX = clip.leftExit[1];
         _loc4_.data.leftExitY = clip.leftExit[2];
         _loc4_.data.rightExit = clip.rightExit[0];
         _loc4_.data.rightExitX = clip.rightExit[1];
         _loc4_.data.rightExitY = clip.rightExit[2];
         _loc4_.flush();
         _root.logWWW("exitRoomInternal() checking status before load");
         checkStatusBeforeLoad(_loc8_,_loc9_,clip.desc[0],_loc5_);
      }
      this.avatar.FunBrain_so.data.dir = Math.abs(this._xscale) / this._xscale;
      var _loc12_ = loader_mc.room;
      if(_loc12_ == undefined)
      {
         _loc12_ = clip.desc[0];
      }
      _root.logWWW("checking for new island start");
      this.avatar.checkForNewIslandStart(_loc5_,_loc12_);
   }
}
function checkStatusBeforeLoad(method, url, room, island)
{
   var _loc2_ = com.poptropica.models.PopModel.getInstance().isRegistered;
   if(_loc2_)
   {
      var _loc3_ = com.poptropica.util.StatusManager.getInstance();
      _loc3_.checkStatus(Delegate.create(this,doNewSceneLoad,method,url,room,island));
   }
   else
   {
      doNewSceneLoad(method,url,room,island);
   }
}
function doNewSceneLoad(method, url, room, island)
{
   _root.logWWW("doNewSceneLoad(), room = " + room + ", island = " + island + " loadSceneAS3 method : " + _root.loadSceneAS3 + " : " + loadSceneAS3);
   var _loc6_ = this.createEmptyMovieClip("loader_mc",this.getNextHighestDepth());
   var _loc8_ = undefined;
   var _loc7_ = undefined;
   var _loc9_ = undefined;
   var _loc10_ = false;
   if(room == "return")
   {
      if(transitToken.data.returnQuest)
      {
         _loc10_ = true;
         room = transitToken.data.returnQuest.scene;
         island = transitToken.data.returnQuest.island;
         _loc8_ = transitToken.data.returnQuest.xPos;
         _loc7_ = transitToken.data.returnQuest.yPos;
         _loc9_ = transitToken.data.returnQuest.dir;
         transitToken.data.returnQuest = null;
         delete transitToken.data.returnQuest;
         transitToken.flush();
      }
      else
      {
         room = _root.islandMain;
      }
   }
   if(island == undefined)
   {
      island = _root.island;
   }
   if(room.indexOf(".") == -1)
   {
      trace("doNewSceneLoad() loading pop1 scene : " + room + " island : " + island);
      trace("hits.as changes token since new scene is also AS2");
      trace("token before");
      for(var _loc3_ in transitToken.data)
      {
         trace(_loc3_ + " equalto " + transitToken.data[_loc3_]);
      }
      if(transitToken.data.nextScene)
      {
         transitToken.data.nextScene = room;
      }
      if(transitToken.data.nextIsland)
      {
         transitToken.data.nextIsland = island;
      }
      trace("token after");
      for(_loc3_ in transitToken.data)
      {
         trace(_loc3_ + " equalto " + transitToken.data[_loc3_]);
      }
      trace("now post isle (from _root) and scene (from door) " + island + " " + room);
      _loc6_.room = room;
      _loc6_.island = island;
      _loc6_.getURL(url,"_self",method);
   }
   else
   {
      if(!_loc10_)
      {
         _loc8_ = avatar.FunBrain_so.data[room + "xPos"];
         _loc7_ = avatar.FunBrain_so.data[room + "yPos"];
         _loc9_ = _root.char._xscale >= 0 ? "right" : "left";
      }
      trace("doNewSceneLoad()  loading as3 scene : " + room + " island : " + island + " method : " + _root.loadSceneAS3);
      _root.loadSceneAS3(room,_loc8_,_loc7_,_loc9_);
   }
}
function exitHit(hitClip)
{
   if(currentExitHit != hitClip)
   {
      currentExitHit = hitClip;
      trace("exitHit " + hitClip.desc);
      exitRoom(hitClip);
   }
}
function floatHit(hitClip)
{
   currentSpecialHit = hitClip;
   this.ground = _parent.baseGround;
   this.jumping = true;
   if(this.charState != "jump")
   {
      this.charState = "jump";
      if(Math.abs(this.spin) > 0)
      {
         this.avatar.gotoAndStop("spinning");
      }
      else
      {
         this.avatar.gotoAndPlay("falling");
      }
   }
   this.vAccel = _parent.gravity - (hitClip._height - (hitClip._y - this._y)) / 200 - this.vSpeed / 40;
}
function floatOff()
{
   currentSpecialHit = null;
   this.vAccel = _parent.gravity;
   this.ground = _parent.baseGround;
}
function groundHit(hitClip, friction)
{
   if(this.vSpeed >= 0)
   {
      currentHit = hitClip;
      this.drag = friction;
   }
}
function itemHit(hitClip)
{
   if(_root.sceneIsVisible)
   {
      if(hitClip.hit.hitTest(this.hit) && !this.npc && this.isChar)
      {
         this.speed = 0;
         this.vSpeed = 0;
         var _loc4_ = hitClip.item;
         this.avatar.getItem(_loc4_);
         _root.pickedItem = _loc4_;
         _root.popup("getcard.swf");
         if(hitClip.getItemFunction)
         {
            hitClip.getItemFunction();
         }
         if(_loc4_ == 5)
         {
            this.avatar.packFrame = "jet";
            this.avatar.setParts();
            this.avatar.savePartsToSO();
         }
         hitClip._visible = false;
         hitClip.id = null;
         hitClip.removeMovieClip();
      }
   }
}
function objectHit(hitClip)
{
   if(currentHit != hitClip.groundClip && hitClip.hit.hitTest(this.hit))
   {
      currentObjectHit = hitClip;
      if(this._x > hitClip._x && this.speed < 0)
      {
         this._x += (hitClip._x + (hitClip.hit._width / 2 - 1) + (this.hit._width / 2 - 1) - this._x) / 4;
         this.pushLeft = true;
         hitClip.speed = this.speed;
      }
      else if(this._x <= hitClip._x && this.speed > 0)
      {
         this._x += (hitClip._x - (hitClip.hit._width / 2 - 1) - (this.hit._width / 2 - 1) - this._x) / 4;
         this.pushRight = true;
         hitClip.speed = this.speed;
      }
   }
   else if(currentObjectHit == hitClip)
   {
      currentObjectHit = null;
      this.pushLeft = this.pushRight = false;
   }
}
function platformHit(hitClip, friction)
{
   if((this.vSpeed >= 0 || this.vSpeed > -1 && this.diving) && !this.dropping)
   {
      currentHit = hitClip;
      if(!this.targetPlayer.engaged)
      {
         this.drag = friction;
      }
      this.swimming = false;
   }
}
function platformOff()
{
   currentHit = null;
   this.ground = _parent.baseGround;
   this.swimming = false;
}
function platformMovingOff(hitClip)
{
   currentHit = null;
   this.speed += hitClip.speed;
   this.ground = _parent.baseGround;
}
function riverHit(hitClip)
{
   if(currentSpecialHit != hitClip)
   {
      splash(40,30);
      currentSpecialHit = hitClip;
      this.ground = _parent.baseGround;
      this.jumping = true;
      this.avatar.gotoAndPlay("falling");
      this.vAccel = 0;
      this.spin = 0;
   }
   this.speed += (hitClip.speed - this.speed) / 4;
   this._rotation += (10 * Math.cos(0.02 * (this._x - hitClip._x)) - this._rotation) / 8;
   this.avatar._rotation += (- this.avatar._rotation) / 8;
   if(this.upIsDown)
   {
      this.vSpeed = -22;
      this.avatar.gotoAndPlay("falling");
      this.airControl = true;
   }
   else
   {
      this.airControl = false;
      this.vSpeed = 0;
      this._y += (4 * (this.hit._height - 55) - 20 + hitClip._y + 10 * Math.sin(0.02 * (this._x - hitClip._x)) - this._y) / 8;
   }
}
function splashHit(hitClip, offset, num)
{
   if(currentSpecialHit != hitClip)
   {
      splash(offset,num);
      currentSpecialHit = hitClip;
   }
}
function springHit(hitClip, bounce)
{
   if(this.vSpeed >= 0)
   {
      this.ground = _parent.baseGround;
      this.jumping = true;
      this.charState = "jump";
      if(Math.abs(this.spin) > 0)
      {
         this.avatar.gotoAndStop("spinning");
      }
      else
      {
         this.avatar.gotoAndPlay("falling");
      }
      this._y = hitClip._y + (this._x - hitClip._x) * Math.tan(hitClip._rotation * 3.141592653589793 / 180);
      if(hitClip._rotation == 0)
      {
         this.vSpeed = bounce;
      }
      else
      {
         this.airControl = false;
         hitClip.radians = 3.141592653589793 * hitClip._rotation / 180 + 1.5707963267948966;
         this.vSpeed = bounce * Math.sin(hitClip.radians);
         this.speed = bounce * Math.cos(hitClip.radians);
      }
      hitClip.bounceFunction();
   }
}
function springLineHit(hitClip, radius, lineColor)
{
   if(radius == undefined)
   {
      radius = 100;
   }
   if(lineColor == undefined)
   {
      lineColor = 16777215;
   }
   if(hitClip.hit.hitTest(this.coordinates.x,this.coordinates.y,true))
   {
      falling = true;
      currentSpecialHit = hitClip;
      hitClip.delX = this._x - hitClip._x;
      hitClip.delY = this._y - hitClip._y;
      this.vAccel = (- hitClip.delY) / 20 - _parent.gravity;
      hitClip.spinChange = 90 - Math.abs(Math.abs(this.avatar._rotation) - 90);
      this.avatar._y = this.avatarStartY + hitClip.spinChange / 3;
      if(this.avatar._rotation > 0 && this.spin + hitClip.spinChange / 30 < 30)
      {
         this.spin += hitClip.spinChange / 30;
      }
      else if(this.avatar._rotation < 0 && this.spin - hitClip.spinChange / 30 > -30)
      {
         this.spin -= hitClip.spinChange / 30;
      }
      else if(this.avatar._rotation == 0)
      {
         this.spin += Math.random() * 2 - 1;
      }
      if(this.springing == false)
      {
         this.springing = true;
         this.avatar.gotoAndPlay("falling");
      }
      if(Math.abs(this.avatar._rotation) > 0)
      {
         hitClip.spread = 10 + hitClip.spinChange / 3;
      }
      else
      {
         hitClip.spread = 10;
      }
      hitClip.hit.clear();
      hitClip.hit.lineStyle(3,lineColor);
      hitClip.hit.beginFill(lineColor,0);
      hitClip.hit.moveTo(- radius,0);
      hitClip.hit.lineTo((hitClip.delX - hitClip.spread - radius) / 2,(hitClip.delY + 2) / 2);
      hitClip.hit.curveTo(hitClip.delX - hitClip.spread,hitClip.delY + 2,hitClip.delX,hitClip.delY + 2);
      hitClip.hit.curveTo(hitClip.delX + hitClip.spread,hitClip.delY + 2,(hitClip.delX + hitClip.spread + radius) / 2,(hitClip.delY + 2) / 2);
      hitClip.hit.lineTo(radius,0);
      hitClip.hit.lineStyle(3,lineColor,0);
      hitClip.hit.endFill();
      for(var _loc6_ in hitClip)
      {
         var _loc5_ = hitClip[_loc6_];
         if(_loc5_ instanceof MovieClip && _loc5_ != hitClip.hit)
         {
            if(_loc5_._x < hitClip.delX)
            {
               _loc5_._y = hitClip.delY * (_loc5_._x + radius) / (hitClip.delX + radius);
               _loc5_._rotation = Math.atan(hitClip.delY / (hitClip.delX + radius)) * 180 / 3.141592653589793;
            }
            else
            {
               _loc5_._y = hitClip.delY * (_loc5_._x - radius) / (hitClip.delX - radius);
               _loc5_._rotation = Math.atan(hitClip.delY / (hitClip.delX - radius)) * 180 / 3.141592653589793;
            }
         }
      }
   }
   else if(currentSpecialHit == hitClip)
   {
      currentSpecialHit = null;
      this.vAccel = _parent.gravity;
      this.springing = false;
      hitClip.hit.clear();
      hitClip.hit.lineStyle(3,lineColor);
      hitClip.hit.moveTo(- radius,0);
      hitClip.hit.lineTo(radius,0);
      for(_loc6_ in hitClip)
      {
         _loc5_ = hitClip[_loc6_];
         if(_loc5_ instanceof MovieClip && _loc5_ != hitClip.hit)
         {
            _loc5_._y = 0;
            _loc5_._rotation = 0;
         }
      }
   }
}
function swimHit(hitClip)
{
   if(currentHit != hitClip)
   {
      splash(40,30);
      currentHit = hitClip;
      this.swimming = true;
      this.drag = baseDrag;
   }
}
function diveHit(hitClip)
{
   if(currentSpecialHit != hitClip)
   {
      hitClip.doHit(this);
      splash(40,30);
      currentSpecialHit = hitClip;
      this.diveWait = 0;
      this.diving = true;
      if(this.buoyancy == undefined)
      {
         this.buoyancy = 0;
      }
      this.gravityOffset = this.buoyancy;
      this.vSpeed *= 0.2;
      if(!this.currentHit)
      {
         this.avatar.gotoAndStop("spinning");
         this.avatar.head.eyes.gotoAndStop("closed");
         this.avatar.head.mouth.gotoAndPlay("ooh");
      }
   }
}
function diveOff()
{
   if(this.diveWait != undefined && this.diveWait < 10)
   {
      return undefined;
   }
   currentSpecialHit = null;
   this.diving = false;
   this.gravityOffset = 0;
   splash(20,30);
   if(upIsDown)
   {
      vSpeed = -12;
   }
   if(!this.currentHit)
   {
      this.avatar.gotoAndPlay("falling");
      this.avatar._rotation = 0;
   }
}
function teleportHit(hitClip, xPos, yPos)
{
   this._x = xPos;
   this._y = yPos;
   this.speed = 0;
   this.vSpeed = 1;
   this.airControl = false;
}
function wallAngleHit(hitClip)
{
   radians = hitClip._rotation * 3.141592653589793 / 180;
   tangent = Math.tan(radians);
   if((this.speed < 0 || this.jumping) && this._x > hitClip._x - (this._y - hitClip._y) * tangent)
   {
      this._x = hitClip._x - (this._y - hitClip._y) * tangent + hitClip._xscale / 2 / Math.cos(radians) + (4 * (this.mouseX > 0) - 2);
      this.pushLeft = true;
      this.speed = 0;
      this.accel = 0;
   }
   else if((this.speed > 0 || this.jumping) && this._x <= hitClip._x - (this._y - hitClip._y) * tangent)
   {
      this._x = hitClip._x - (this._y - hitClip._y) * tangent - hitClip._xscale / 2 / Math.cos(radians) + (4 * (this.mouseX > 0) - 2);
      this.pushRight = true;
      this.speed = 0;
      this.accel = 0;
   }
}
function wallHit(hitClip)
{
   if(hitClip.hitTest(this.hit))
   {
      currentWallHit = hitClip;
      if(this._x > hitClip._x && (this.speed < 0 || currentHit.speed < 0))
      {
         this._x = hitClip._x + (hitClip._width / 2 - 1) + (this.hit._width / 2 - 1);
         this.pushLeft = true;
         this.speed = 0;
         this.accel = 0;
      }
      else if(this._x <= hitClip._x && (this.speed > 0 || currentHit.speed > 0))
      {
         this._x = hitClip._x - (hitClip._width / 2 - 1) - (this.hit._width / 2 - 1);
         this.pushRight = true;
         this.speed = 0;
         this.accel = 0;
      }
      if(jumping)
      {
         avatar.head._x = avatar.neck._x - 17;
         avatar.hair._x = avatar.head._x + 11;
      }
   }
   else if(currentWallHit == hitClip)
   {
      currentWallHit = null;
      this.pushLeft = this.pushRight = false;
   }
}
function windColumnHit(hitClip)
{
   currentSpecialHit = hitClip;
   this.ground = _parent.baseGround;
   this.jumping = true;
   if(this.charState != "jump")
   {
      this.charState = "jump";
      if(Math.abs(this.spin) > 0)
      {
         this.avatar.gotoAndStop("spinning");
      }
      else
      {
         this.avatar.gotoAndPlay("falling");
      }
   }
   if(currentHit != null)
   {
      this.vSpeed = -10;
   }
   this.vAccel = _parent.gravity - 3 + (hitClip._y - this._y) / hitClip._height * 3;
}
function electrify(newColor)
{
   function fspark()
   {
      this._alpha -= 10;
      if(this._alpha <= 0)
      {
         delete this.onEnterFrame;
         this.removeMovieClip();
      }
   }
   var _loc4_ = new flash.filters.GlowFilter(newColor,1,100,100,1,1,true);
   var _loc3_ = new flash.filters.GlowFilter(newColor,1,20,20,1,1);
   var _loc2_ = new flash.filters.GlowFilter(16777215,1,8,8,1,1,true);
   this.filters = [_loc4_,_loc2_,_loc3_];
   avatar.createEmptyMovieClip("sparks",avatar.getNextHighestDepth());
   avatar.sparks.count = 0;
   avatar.sparks._y = -40;
   avatar.sparks.onEnterFrame = function()
   {
      this.count = this.count + 1;
      spark = this.createEmptyMovieClip("spark" + this.count,this.count);
      spark.nextX = Math.random() * 120 - 60;
      spark.nextY = Math.random() * 280 - 140;
      spark.lineStyle(1,16777215);
      spark.moveTo(spark.nextX,spark.nextY);
      i = 1;
      while(i <= 3)
      {
         spark.nextX += Math.random() * 24 - 12;
         spark.nextY += Math.random() * 24 - 12;
         spark.lineTo(spark.nextX,spark.nextY);
         i++;
      }
      spark.onEnterFrame = fspark;
   };
}
function unElectrify()
{
   avatar.sparks.removeMovieClip();
   this.filters = null;
}
function phantom(alphaAmount, phantomColor)
{
   if(phantomColor == undefined)
   {
      phantomColor = 10274524;
   }
   var _loc2_ = new flash.filters.GlowFilter(phantomColor,1,10,10,2,1);
   this.filters = [_loc2_];
   if(this._alpha != 0)
   {
      this._alpha = alphaAmount;
   }
}
function unPhantom()
{
   this.filters = null;
   if(this._alpha != 0)
   {
      this._alpha = 100;
   }
}
function showBalloon(balloonFrame, ball)
{
   if(_parent == _root.camera.scene || _parent.balloonCard)
   {
      var _loc6_ = "balloon";
      if(balloonFrame != undefined)
      {
      }
      hideBalloon();
      balloonName = this._name + "Balloon";
      if(!_parent.balloonDepth)
      {
         _parent.balloonDepth = 20000;
      }
      do
      {
         _parent.balloonDepth = _parent.balloonDepth + 1;
      }
      while(_parent.getInstanceAtDepth(_parent.balloonDepth));
      
      balloon = _parent.createEmptyMovieClip(balloonName,_parent.balloonDepth);
      var _loc5_ = new MovieClipLoader();
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function()
      {
         balloon.char = char;
         balloon.balloonFrame = balloonFrame;
         balloon.shape.gotoAndStop(balloonFrame);
      };
      _loc5_.addListener(_loc4_);
      _loc5_.loadClip("popups/balloon.swf",balloon);
   }
}
function hideBalloon()
{
   this.balloon.string.removeMovieClip();
   this.balloon.removeMovieClip();
}
function showCounterBalloon(clip)
{
   hideBalloon();
   _parent.lastBalloon._visible = true;
   _parent.lastBalloon._x = clip._x;
   clip._visible = false;
   _parent.lastBalloon = clip;
   balloonName = _name + "Balloon";
   balloon = _parent.createEmptyMovieClip(balloonName,_parent.getNextHighestDepth());
   var _loc4_ = new MovieClipLoader();
   var _loc3_ = new Object();
   _loc3_.onLoadInit = function()
   {
      balloon.char = char;
      balloon.balloonFrame = _root.char.avatar.FunBrain_so.data.counterBalloonFrame;
      balloon.shape.gotoAndStop(_root.char.avatar.FunBrain_so.data.counterBalloonFrame);
   };
   _loc4_.addListener(_loc3_);
   _loc4_.loadClip("popups/counter/balloon.swf",balloon);
}
function showHalo()
{
   avatar.head.halo = attachMovie("Halo","halo",1,{_x:-5,_y:-110});
}
function hideHalo()
{
   avatar.head.halo.removeMovieClip();
}
function motionBlur()
{
   var blur_motion = new flash.filters.BlurFilter(0,0,1);
   this.filters = [blur_motion];
   createEmptyMovieClip("blur_mc",this.getNextHighestDepth());
   blur_mc.onEnterFrame = function()
   {
      blur_motion.blurX = Math.abs(speed * 3);
      blur_motion.blurY = Math.abs(vSpeed * 3);
      filters = [blur_motion];
   };
}
function unMotionBlur()
{
   blur_mc.removeMovieClip();
   this.filters = null;
}
function torch()
{
   function flare()
   {
      this._x -= speed;
      this._y -= vSpeed;
      this.vy -= 0.3;
      this._y += this.vy;
      this._xscale = this._yscale -= 5;
      if(this._xscale <= 0)
      {
         delete this.onEnterFrame;
         this.removeMovieClip();
      }
   }
   var _loc3_ = new flash.filters.GlowFilter(16768081,1,100,100,1,1,true);
   var _loc4_ = new flash.filters.GlowFilter(16737792,1,10,10,1,1,true);
   var _loc2_ = new flash.filters.GlowFilter(16768081,1,18,18,1,1);
   this.filters = [_loc3_,_loc4_,_loc2_];
   var _loc5_ = new flash.filters.BlurFilter(6,6,1);
   this.createEmptyMovieClip("flames",-50000);
   flames.count = 0;
   flames.onEnterFrame = function()
   {
      this.count = this.count + 1;
      flame = this.createEmptyMovieClip("flame" + this.count,this.count);
      flame._x = Math.random() * 12 - 6 + 0.36 * dir * avatar.hair._x;
      flame._y = Math.random() * 10 - 35 + 0.36 * avatar.hair._y - 0.36 * avatar.hair._height / 2;
      flame._rotation = (- speed) * 4;
      flame._xscale = flame._yscale = Math.random() * 40 + 80;
      flame.vy = 0;
      flame.lineStyle(16,16768081);
      flame.moveTo(0,0);
      flame.lineTo(0,-6);
      flame.onEnterFrame = flare;
   };
}
function unTorch()
{
   delete flames.onEnterFrame;
   glowChange.removeMovieClip();
   this.filters = null;
}
function bigHead(newScale)
{
   avatar.head._xscale = avatar.head._yscale = avatar.hair._xscale = avatar.hair._yscale = newScale;
   avatar.follow(avatar.head,avatar.neck,-17,-72 * (newScale / 100),1.4,0.4);
}
function unBigHead()
{
   avatar.head._xscale = avatar.head._yscale = avatar.hair._xscale = avatar.hair._yscale = 100;
   avatar.follow(avatar.head,avatar.neck,-17,-72,1.4,0.4);
}
function showFollower(followerFrame)
{
   if(_parent == _root.camera.scene || _parent.followerCard)
   {
      hideFollower();
      followerName = this._name + "Follower";
      follower = _parent.createEmptyMovieClip(followerName,_parent.getNextHighestDepth());
      var _loc5_ = new MovieClipLoader();
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function()
      {
         follower.char = char;
         follower.followerFrame = followerFrame;
         follower.shape.gotoAndStop(followerFrame);
      };
      _loc5_.addListener(_loc4_);
      _loc5_.loadClip("popups/follower.swf",follower);
   }
}
function hideFollower()
{
   this.follower.removeMovieClip();
}
function bobbleHead()
{
   if(_parent == _root.camera.scene)
   {
      newScale = 125;
      avatar.head._xscale = avatar.head._yscale = avatar.hair._xscale = avatar.hair._yscale = newScale;
      avatar.follow(avatar.head,avatar.neck,-17,-72,0.5,0.8,true);
   }
}
function unBobbleHead()
{
   if(_parent == _root.camera.scene)
   {
      avatar.head._rotation = avatar.hair._rotation = 0;
      avatar.head._xscale = avatar.head._yscale = avatar.hair._xscale = avatar.hair._yscale = 100;
      avatar.follow(avatar.head,avatar.neck,-17,-72,1.4,0.4);
   }
}
function makeCentaur()
{
   avatar.shirtFrame = "centaur";
   avatar.setParts();
   newFoot2 = avatar.foot2.duplicateMovieClip("newFoot2",avatar.getNextHighestDepth());
   newFoot1 = avatar.foot1.duplicateMovieClip("newFoot1",avatar.getNextHighestDepth());
   newLeg2 = avatar.leg2.duplicateMovieClip("newLeg2",avatar.getNextHighestDepth());
   newLeg1 = avatar.leg1.duplicateMovieClip("newLeg1",avatar.getNextHighestDepth());
   avatar.walk(newFoot1,newLeg1);
   avatar.walk(newFoot2,newLeg2);
   createEmptyMovieClip("mirrorNewLegs",getNextHighestDepth());
   mirrorNewLegs.onEnterFrame = function()
   {
      mirror(avatar.newFoot1,avatar.foot1);
      mirror(avatar.newFoot2,avatar.foot2);
      mirror(avatar.newLeg1,avatar.leg1);
      mirror(avatar.newLeg2,avatar.leg2);
   };
   avatar.colorSkin(avatar.newFoot1.inner);
   avatar.colorSkin(avatar.newFoot2.inner);
}
function mirror(clip, targ)
{
   clip._rotation = targ._rotation;
   clip._x = targ._x + 70;
   clip._y = targ._y;
}
function motionTrail()
{
   function fade()
   {
      this._alpha -= 20;
      if(this._alpha <= 0)
      {
         this.myBitmap.dispose();
         delete this.myBitmap;
         delete this.onEnterFrame;
         this.removeMovieClip();
      }
   }
   var blur_motionTrail = new flash.filters.BlurFilter(0,0,1);
   createEmptyMovieClip("blur_mc",this.getNextHighestDepth());
   createEmptyMovieClip("trailTimer",this.getNextHighestDepth());
   trailSize = 200;
   var translateMatrix = new flash.geom.Matrix();
   translateMatrix.translate(trailSize / 2,trailSize - 40);
   trailTimer.onEnterFrame = function()
   {
      num = _parent.getNextHighestDepth();
      _parent["trailBitmap" + num] = new flash.display.BitmapData(trailSize,trailSize,true,16777215);
      bit = _parent["trailBitmap" + num];
      cont = _parent.createEmptyMovieClip("trail" + num,_parent.getNextHighestDepth());
      bit.draw(this._parent,translateMatrix);
      cont.attachBitmap(bit,cont.getNextHighestDepth());
      cont.myBitmap = bit;
      cont._x = _X - trailSize / 2;
      cont._y = _Y - trailSize + 40;
      if(_xscale < 0)
      {
         cont._xscale *= -1;
         cont._x += trailSize;
      }
      cont._alpha = 50;
      blur_motionTrail.blurX = Math.abs(speed);
      blur_motionTrail.blurY = Math.abs(vSpeed);
      cont.filters = [blur_motionTrail];
      cont.onEnterFrame = fade;
   };
}
function unMotionTrail()
{
   trailTimer.removeMovieClip();
}
function shrink()
{
   if(_parent == _root.camera.scene)
   {
      this.charScale = this._yscale = 50;
      this._xscale = 50 * Math.abs(this._xscale) / this._xscale;
   }
}
function unShrink()
{
   if(_parent == _root.camera.scene)
   {
      this.charScale = this._yscale = 100;
      this._xscale = 100 * Math.abs(this._xscale) / this._xscale;
   }
}
function grow()
{
   if(_parent == _root.camera.scene)
   {
      this.charScale = this._yscale = 150;
      this._xscale = 150 * Math.abs(this._xscale) / this._xscale;
   }
}
function unGrow()
{
   if(_parent == _root.camera.scene)
   {
      this.charScale = this._yscale = 100;
      this._xscale = 100 * Math.abs(this._xscale) / this._xscale;
   }
}
function upsideDown()
{
   newHead = avatar.createEmptyMovieClip("newHead",avatar.getNextHighestDepth());
   var _loc2_ = new MovieClipLoader();
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function()
   {
      avatar.colorSkin(avatar.newHead.headSkin);
      avatar.colorSkin(avatar.newHead.eyes.eyelids);
      avatar.colorHair(avatar.newHead.marks);
      avatar.colorSkin(avatar.newHead.marks);
      avatar.colorHair(avatar.newHead.facial);
      avatar.colorSkin(avatar.newHead.facial);
      avatar.follow(avatar.newHead,avatar.hand1,0,0,1.4,0.4);
   };
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip("avatar_head.swf",newHead);
}
function unUpsideDown()
{
   if(_parent == _root.camera.scene)
   {
      avatar.head._rotation = avatar.hair._rotation = 0;
      avatar.head._xscale = avatar.head._yscale = avatar.hair._xscale = avatar.hair._yscale = 100;
      avatar.follow(avatar.head,avatar.neck,-17,-72,1.4,0.4);
   }
}
function floatParticle(asset)
{
   trace("FloatParticle() " + asset);
   if(_parent._name != "scene")
   {
      return undefined;
   }
   gFloatParticleAsset = asset;
   if(gFloatParticleAsset == undefined)
   {
      gFloatParticleAsset = "heart";
   }
   if(!gFloatParticleActive)
   {
      unFloatParticle();
      gFloatParticleActive = true;
      gFloatParticleContainer = this._parent.createEmptyMovieClip("floatParticles" + this._name,this._parent.getNextHighestDepth());
      gClipLoaderListener = new Object();
      gClipLoaderListener.onLoadInit = function(clip)
      {
         setupFloatParticle(clip);
      };
      gClipLoader = new MovieClipLoader();
      gClipLoader.addListener(gClipLoaderListener);
      gFloatParticleInt = _global.setInterval(mx.utils.Delegate.create(this,createFloatParticle),200);
   }
   else
   {
      unFloatParticle();
   }
}
function unFloatParticle()
{
   gFloatParticleContainer.removeMovieClip();
   gFloatParticleActive = false;
   _global.clearInterval(gFloatParticleInt);
   gClipLoader.removeListener(gClipLoaderListener);
   gClipLoaderListener = null;
   gClipLoader = null;
   gFloatParticleContainer = null;
}
function createFloatParticle()
{
   var _loc3_ = gFloatParticleContainer.getNextHighestDepth();
   var _loc2_ = gFloatParticleContainer.createEmptyMovieClip("floatParticle" + _loc3_,_loc3_);
   var _loc5_ = utils.Utils.getRandomNumber(-12,12);
   var _loc4_ = utils.Utils.getRandomNumber(-12,12);
   _loc2_._x = this._x - this.avatar.body._width * 0.4 + _loc5_;
   _loc2_._y = this._y - this.avatar.body._height + _loc4_;
   if(gFloatParticleAsset == undefined || gFloatParticleAsset == "undefined")
   {
      gFloatParticleAsset = "heart";
   }
   gClipLoader.loadClip("externalAssets/" + gFloatParticleAsset + ".swf",_loc2_);
}
function setupFloatParticle(clip)
{
   clip.art._xscale = clip.art._yscale = 0;
   var _loc3_ = utils.Utils.getRandomNumber(1,2);
   var _loc5_ = utils.Utils.getRandomNumber(50,90);
   var _loc4_ = _loc3_ * 0.75;
   caurina.transitions.Tweener.addTween(clip.art,{_y:-100,_xscale:_loc5_,_yscale:_loc5_,time:_loc3_,transition:"easeOutSine",onComplete:mx.utils.Delegate.create(this,removeClip),onCompleteParams:[clip]});
   caurina.transitions.Tweener.addTween(clip.art,{delay:_loc4_,_alpha:0,time:_loc3_ - _loc4_,transition:"easeOutSine"});
}
function removeClip(clip)
{
   clip.removeMovieClip();
}
function startLightning(singleBolt)
{
   if(gLightningActive || _root.camera.scene.common || this._name != "char")
   {
      return undefined;
   }
   gLightningActive = true;
   if(singleBolt)
   {
      gTotalBolt = 1;
   }
   else
   {
      gTotalBolt = 8;
      fx.FullScreen.fadeColorScreen(true,0.75,0,0,_root.navBar,0,60);
   }
   gLightning = new fx.Lightning(_root.navBar);
   gLightningClip = gLightning.getClip();
   gCameraX = _root.camera._x;
   gCameraY = _root.camera._y;
   gLightningClip.onEnterFrame = function()
   {
      gLightning.updatePosition(_root.camera._x - gCameraX,_root.camera._y - gCameraY);
      gCameraX = _root.camera._x;
      gCameraY = _root.camera._y;
   };
   if(!singleBolt)
   {
      setTimeout(nextBolt,1200);
      fx.FullScreen.shake(true,_root.camera.scene,[-8,8],0.1);
   }
   else
   {
      nextBolt();
      gLightningActive = false;
   }
}
function nextBolt()
{
   fx.FullScreen.clear(1);
   var _loc3_ = function()
   {
      fx.FullScreen.fadeColorScreen(false,0.3,0.05,1,_root.navBar,16777215,100);
   };
   setTimeout(_loc3_,50);
   gLightning.create(Math.random() * 640,-240,0.02,0.21);
   gTotalBolt--;
   if(gTotalBolt != 0)
   {
      setTimeout(nextBolt,utils.Utils.getRandomNumber(300,750));
   }
   else if(gTotalBolt == 0)
   {
      var _loc2_ = function()
      {
         fx.FullScreen.shake(false,_root.camera.scene);
         fx.FullScreen.fadeColorScreen(false,0.5,0,0);
         setTimeout(endLightning,600);
      };
      setTimeout(_loc2_,1200);
   }
}
function endLightning()
{
   gLightningClip.onEnterFrame = null;
   gLightning.destroy();
   gLightningActive = false;
   gLightningClip = null;
}
function makeItSnow()
{
   if(gSnowing)
   {
      gSnowing = false;
      gSnowClip.onEnterFrame = null;
      gSnow.destroy();
   }
   else
   {
      gSnowing = true;
      var xBoost = 1.1;
      var yBoost = 1.05;
      gSnow = new fx.Snow(_root.navBar,gTotalSnowFlakes,gBoxOffset,_root.camera.scene._height);
      gSnowClip = gSnow.getMC();
      gCameraX = _root.camera._x;
      gCameraY = _root.camera._y;
      gSnowClip.onEnterFrame = function()
      {
         gSnow.update((gCameraX - _root.camera._x) * xBoost,(gCameraY - _root.camera._y) * yBoost);
         gCameraX = _root.camera._x;
         gCameraY = _root.camera._y;
      };
   }
}
function beginAsteroidShower()
{
   if(gAsteroidsFalling)
   {
      clearTimeout(gAsteroidStartTimer);
      clearTimeout(gAsteroidEndTimer);
      gAsteroidsFalling = false;
      gAsteroidsClip.onEnterFrame = null;
      gAsteroids.destroy();
      fx.FullScreen.shake(false,_root.camera.scene);
      fx.FullScreen.fadeColorScreen(false,0.5,0,2);
   }
   else
   {
      gAsteroidsFalling = true;
      char.action("angry");
      fx.FullScreen.shake(true,_root.camera.scene,[-10,10],0.2);
      fx.FullScreen.fadeColorScreen(true,0.75,0,2,_root.navBar,9961729,50);
      gAsteroidStartTimer = setTimeout(asteroidShower,2500);
      gAsteroidEndTimer = setTimeout(beginAsteroidShower,8000);
   }
}
function asteroidShower()
{
   var xBoost = 1.1;
   var yBoost = 1.05;
   gAsteroids = new fx.Asteroids(_root.navBar,20,gBoxOffset,_root.camera.scene);
   gAsteroidsClip = gAsteroids.getMC();
   gCameraX = _root.camera._x;
   gCameraY = _root.camera._y;
   gAsteroidsClip.onEnterFrame = function()
   {
      gAsteroids.update((gCameraX - _root.camera._x) * xBoost,(gCameraY - _root.camera._y) * yBoost);
      gCameraX = _root.camera._x;
      gCameraY = _root.camera._y;
   };
}
function createDropParticle(asset)
{
   if(_parent._name != "scene")
   {
      return undefined;
   }
   if(gParticleActive)
   {
      destroyParticles();
   }
   gParticleActive = true;
   gParticleAsset = asset;
   gParticleContainer = this._parent.createEmptyMovieClip("particles" + this._name,this._parent.getNextHighestDepth());
   gParticleClipLoaderListener = new Object();
   gParticleClipLoaderListener.onLoadInit = function(clip)
   {
      setupParticles(clip);
   };
   gParticleClipLoader = new MovieClipLoader();
   gParticleClipLoader.addListener(gParticleClipLoaderListener);
   gParticleInt = _global.setTimeout(mx.utils.Delegate.create(this,createParticle),500);
}
function destroyParticles()
{
   gParticleContainer.removeMovieClip();
   _global.clearTimeout(gParticleInt);
   gParticleClipLoader.removeListener(gParticleClipLoaderListener);
   gParticleClipLoaderListener = null;
   gParticleClipLoader = null;
   gParticleContainer = null;
   gParticleActive = false;
}
function createParticle()
{
   if(!checkForValidOutfit(this.avatar.shirtFrame))
   {
      destroyParticles();
      return undefined;
   }
   if(Math.abs(this.speed) > 0)
   {
      var _loc4_ = gParticleContainer.getNextHighestDepth();
      var _loc3_ = gParticleContainer.createEmptyMovieClip("particle" + _loc4_,_loc4_);
      var _loc6_ = utils.Utils.getRandomNumber(-20,20);
      var _loc5_ = utils.Utils.getRandomNumber((- this._height) * 0.5,this._height * 0.15);
      _loc3_._x = this._x - this._width * 0.5 + _loc6_;
      _loc3_._y = this._y - this._height * 0.5 + _loc5_;
      gParticleClipLoader.loadClip(gParticleAsset,_loc3_);
   }
   gParticleInt = _global.setTimeout(mx.utils.Delegate.create(this,createParticle),utils.Utils.getRandomNumber(100,600));
}
function setupParticles(clip)
{
   var _loc3_ = utils.Utils.getRandomNumber(4,6);
   var _loc6_ = utils.Utils.getRandomNumber(30,80);
   var _loc4_ = _loc3_ * 0.8;
   var _loc5_ = 480;
   var _loc7_ = utils.Utils.getRandomNumber(5,60);
   clip.art._rotation = utils.Utils.getRandomNumber(0,360);
   clip.art._xscale = clip.art._yscale = _loc6_;
   if(!this.jumping)
   {
      _loc3_ = utils.Utils.getRandomNumber(1,2);
      _loc5_ = - (clip._y - this._y);
      _loc4_ = _loc3_ + 1;
   }
   caurina.transitions.Tweener.addTween(clip.art,{_rotation:_loc7_,_y:_loc5_,time:_loc3_,transition:"easeOutSine"});
   caurina.transitions.Tweener.addTween(clip.art,{delay:_loc4_,_alpha:0,time:1,transition:"easeOutSine",onComplete:mx.utils.Delegate.create(this,removeClip),onCompleteParams:[clip]});
}
function checkForValidOutfit(outfit)
{
   var _loc1_ = 0;
   while(_loc1_ < gValidOutfits.length)
   {
      if(outfit == gValidOutfits[_loc1_])
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function beginLoopShower()
{
   if(gLoopsFalling)
   {
      clearTimeout(gLoopsStartTimer);
      clearTimeout(gLoopsEndTimer);
      gLoopsFalling = false;
      gLoopsClip.onEnterFrame = null;
      gLoops.destroy();
   }
   else
   {
      gLoopsFalling = true;
      gLoopsStartTimer = setTimeout(loopShower,200);
      gLoopsEndTimer = setTimeout(beginLoopShower,8000);
   }
}
function loopShower()
{
   var xBoost = 1.1;
   var yBoost = 1.05;
   gLoops = new fx.Asteroids(_root.navBar,20,gBoxOffset,_root.camera.scene,"externalAssets/loop.swf");
   gLoops.allowExplosions(false);
   gLoops.allowTrail(false);
   gLoopsClip = gLoops.getMC();
   gCameraX = _root.camera._x;
   gCameraY = _root.camera._y;
   gLoopsClip.onEnterFrame = function()
   {
      gLoops.update((gCameraX - _root.camera._x) * xBoost,(gCameraY - _root.camera._y) * yBoost);
      gCameraX = _root.camera._x;
      gCameraY = _root.camera._y;
   };
   setTimeout(applyEffectToChars,1000,paintChar);
}
function applyEffectToChars(effect, excludeChar)
{
   var _loc3_ = undefined;
   var _loc2_ = 0;
   while(_loc2_ <= _root.gCharList.length)
   {
      _loc3_ = _root.gCharList[_loc2_];
      if(_loc3_ != _root.char || _loc3_ == _root.char && !excludeChar)
      {
         effect.apply(_loc3_,[]);
      }
      _loc2_ = _loc2_ + 1;
   }
}
function applyEffectToCharsInRange(range, effect, excludeChar)
{
   var _loc3_ = undefined;
   var _loc4_ = 0;
   while(_loc4_ <= _root.gCharList.length)
   {
      _loc3_ = _root.gCharList[_loc4_];
      if(_loc3_ != _root.char || _loc3_ == _root.char && !excludeChar)
      {
         var _loc5_ = new flash.geom.Point(_loc3_._x,_loc3_._y);
         var _loc6_ = new flash.geom.Point(this._x,this._y);
         if(Math.abs(flash.geom.Point.distance(_loc6_,_loc5_)) <= range)
         {
            effect.apply(_loc3_,[]);
         }
      }
      _loc4_ = _loc4_ + 1;
   }
}
function callFunctionOnChars(effect, args, excludeChar, chars)
{
   var _loc2_ = undefined;
   if(chars == undefined)
   {
      chars = _root.gCharList;
   }
   var _loc3_ = 0;
   while(_loc3_ <= chars.length)
   {
      _loc2_ = chars[_loc3_];
      var _loc4_ = _loc2_[effect];
      if(_loc2_ != _root.char || _loc2_ == _root.char && !excludeChar)
      {
         _loc4_.apply(_loc2_,args);
      }
      _loc3_ = _loc3_ + 1;
   }
}
function callFunctionOnCharsInRange(range, effect, args, excludeChar, chars)
{
   var _loc3_ = undefined;
   if(chars == undefined)
   {
      chars = _root.gCharList;
   }
   var _loc4_ = 0;
   while(_loc4_ <= chars.length)
   {
      _loc3_ = chars[_loc4_];
      if(_loc3_ != _root.char || _loc3_ == _root.char && !excludeChar)
      {
         var _loc5_ = new flash.geom.Point(_loc3_._x,_loc3_._y);
         var _loc7_ = new flash.geom.Point(this._x,this._y);
         var _loc6_ = _loc3_[effect];
         if(Math.abs(flash.geom.Point.distance(_loc7_,_loc5_)) <= range)
         {
            _loc6_.apply(_loc3_,args);
         }
      }
      _loc4_ = _loc4_ + 1;
   }
}
function warp(warpIn, callback, clip)
{
   var _loc4_ = new flash.filters.GlowFilter(16777215,1,40,40,60,1,true);
   var _loc2_ = new flash.filters.GlowFilter(16777215,1,40,40,0,1,true);
   if(clip == undefined)
   {
      clip = this;
   }
   caurina.transitions.properties.FilterShortcuts.init();
   if(warpIn)
   {
      clip._alpha = 0;
      clip.filters = [_loc4_];
      caurina.transitions.Tweener.addTween(clip,{transition:"liner",delay:WARP_DELAY,_alpha:100,time:WARP_TIME});
      if(callback == undefined)
      {
         caurina.transitions.Tweener.addTween(clip,{transition:"liner",delay:WARP_DELAY,_filter:_loc2_,time:WARP_TIME});
      }
      else
      {
         caurina.transitions.Tweener.addTween(clip,{transition:"liner",delay:WARP_DELAY,_filter:_loc2_,time:WARP_TIME,onComplete:callback});
      }
   }
   else
   {
      clip.filters = [_loc2_];
      caurina.transitions.Tweener.addTween(clip,{transition:"liner",delay:WARP_DELAY,_filter:_loc4_,time:WARP_TIME});
      if(callback == undefined)
      {
         caurina.transitions.Tweener.addTween(clip,{transition:"liner",delay:WARP_DELAY + 0.25,_alpha:0,time:WARP_TIME});
      }
      else
      {
         caurina.transitions.Tweener.addTween(clip,{transition:"liner",delay:WARP_DELAY + 0.25,_alpha:0,time:WARP_TIME,onComplete:callback});
      }
   }
   var _loc5_ = function()
   {
      clip.filters = null;
   };
   setTimeout(_loc5_,(WARP_TIME + WARP_DELAY) * 1000);
}
function paintChar(color)
{
   if(color == undefined)
   {
      var _loc3_ = [12076612,6824864,15300159,2657598,1471460,16566607];
      color = _loc3_[Math.floor(Math.random() * _loc3_.length)];
   }
   var _loc2_ = new flash.geom.ColorTransform();
   _loc2_.rgb = color;
   _loc2_.redMultiplier = _loc2_.redOffset / 255;
   _loc2_.greenMultiplier = _loc2_.greenOffset / 255;
   _loc2_.blueMultiplier = _loc2_.blueOffset / 255;
   _loc2_.redOffset /= 4;
   _loc2_.greenOffset /= 4;
   _loc2_.blueOffset /= 4;
   var _loc5_ = new flash.geom.Transform(this);
   _loc5_.colorTransform = _loc2_;
}
function atomPower()
{
   if(this.avatar.itemFrame != "pAtomGlowStick" && _parent._name == "scene")
   {
      unAtomPower();
      return undefined;
   }
   atomGlow();
   if(gAtomicFieldContainer != null)
   {
      gAtomicFieldContainer.removeMovieClip();
   }
   gAtomicClipLoaderListener = new Object();
   gAtomicClipLoaderListener.onLoadInit = function(clip)
   {
      setupAtomicField(clip);
   };
   gAtomicClipLoader = new MovieClipLoader();
   gAtomicClipLoader.addListener(gAtomicClipLoaderListener);
   gAtomicFieldContainer = this.createEmptyMovieClip("atomicField",this.getNextHighestDepth());
   gAtomicClipLoader.loadClip("externalAssets/atomicField.swf",gAtomicFieldContainer);
}
function unAtomPower()
{
   this.filters = [];
   gAtomicFieldContainer.removeMovieClip();
   gAtomicFieldContainer = null;
}
function atomGlow()
{
   var _loc3_ = new flash.filters.GlowFilter(65280,1,100,100,1.2,1,true);
   var _loc2_ = new flash.filters.GlowFilter(65280,1,20,20,1);
   var _loc4_ = new flash.filters.GlowFilter(16776960,1,6,6,4,1,true);
   this.filters = [_loc3_,_loc2_,_loc4_];
}
function setupAtomicField(clip)
{
   clip._x -= clip._width * 0.5;
   clip._y -= clip._height * 1.2;
}
function atomBlast()
{
   if(_parent._name == "scene" && gAtomicFieldContainer != null)
   {
      caurina.transitions.Tweener.addTween(gAtomicFieldContainer.art,{time:2,_xscale:450,_yscale:450,transition:"easeOutSine",onComplete:mx.utils.Delegate.create(this,irradiateChars)});
      caurina.transitions.Tweener.addTween(gAtomicFieldContainer.art,{delay:2,time:1,_xscale:100,_yscale:100,transition:"easeOutElastic"});
   }
}
function irradiateChars()
{
   applyEffectToCharsInRange(400,atomGlow,true);
}
function beginLavaShower()
{
   if(gLavaFalling)
   {
      clearTimeout(gLavaStartTimer);
      clearTimeout(gLavaEndTimer);
      gLavaFalling = false;
      gLavaClip.onEnterFrame = null;
      gLava.destroy();
      fx.FullScreen.shake(false,_root.camera.scene);
   }
   else
   {
      gLavaFalling = true;
      char.action("proud");
      fx.FullScreen.shake(true,_root.camera.scene,[-10,10],0.2);
      gLavaStartTimer = setTimeout(lavaShower,200);
      gLavaEndTimer = setTimeout(beginLavaShower,8000);
   }
}
function lavaShower()
{
   var xBoost = 1;
   var yBoost = 1;
   gLava = new fx.Asteroids(_root.navBar,20,gBoxOffset,_root.camera.scene,"externalAssets/lava.swf");
   gLava.allowExplosions(false);
   gLava.allowTrail(true);
   gLavaClip = gLava.getMC();
   gCameraX = _root.camera._x;
   gCameraY = _root.camera._y;
   gLavaClip.onEnterFrame = function()
   {
      gLava.update((gCameraX - _root.camera._x) * xBoost,(gCameraY - _root.camera._y) * yBoost);
      gCameraX = _root.camera._x;
      gCameraY = _root.camera._y;
   };
}
function makeSumo()
{
   listener.onLoadInit = function()
   {
      setFatBody();
   };
   loader.loadClip(LOAD_PATH + "avatar_body.swf",avatar.fatBody);
}
function unMakeSumo()
{
   this.charScale = this._yscale = 100;
   this._xscale = this.dir * this.charScale;
   delete this.avatar.body.onEnterFrame;
   this.avatar.oldBody._visible = true;
   this.avatar.body._name = "fatBody";
   this.avatar.oldBody._name = "body";
   this.avatar.fatBody._visible = false;
   this.avatar.fatBody._alpha = 0;
   this.avatar.setParts(true);
}
function setFatBody()
{
   this.charScale = this._yscale = 120;
   this._xscale = this.dir * this.charScale;
   this.avatar.fatBody._visible = true;
   this.avatar.fatBody._alpha = 100;
   this.avatar.fatBody._xscale = 200;
   this.avatar.fatBody._yscale = 150;
   this.avatar.fatBody.vx = 0;
   this.avatar.fatBody.vy = 0;
   this.avatar.fatBody.damp = 0.75;
   this.avatar.fatBody.k = 0.5;
   this.avatar.fatBody._x = this.avatar.body._x;
   this.avatar.fatBody._y = this.avatar.body._y;
   this.avatar.body._visible = false;
   this.avatar.body._name = "oldBody";
   this.avatar.fatBody._name = "body";
   this.avatar.setParts(true);
   this.avatar.body.onEnterFrame = function()
   {
      this.ax = (this._parent.oldBody._x - this._x) * this.k;
      this.ay = (this._parent.oldBody._y - this._y) * this.k;
      this.vx += this.ax;
      this.vy += this.ay;
      this.vx *= this.damp;
      this.vy *= this.damp;
      this._x += this.vx;
      this._y += this.vy;
      this._rotation = this._parent.body._rotation;
   };
}
function sumoStomp()
{
   fx.FullScreen.shake(true,_root.camera.scene,[-8,8],0.08);
   setTimeout(endSumoStomp,800);
}
function endSumoStomp()
{
   fx.FullScreen.shake(false,_root.camera.scene);
}
function starPower()
{
   if(_parent._name != "scene")
   {
      unStarPower();
      return undefined;
   }
   if(gStarContainer != null)
   {
      gStarContainer.removeMovieClip();
   }
   gStarContainer = this._parent.createEmptyMovieClip("starPowerContainer" + this._name,this._parent.getNextHighestDepth());
   gStarContainer.onEnterFrame = mx.utils.Delegate.create(this,starCreator);
   createStar(true);
}
function starCreator()
{
   var _loc2_ = 0;
   var _loc6_ = 10;
   var _loc3_ = 5;
   var _loc4_ = 2;
   for(var _loc5_ in gStarContainer)
   {
      if(gStarContainer[_loc5_].special)
      {
         gStarContainer[_loc5_]._alpha = 80;
         setupStarPower(gStarContainer[_loc5_],true);
      }
      else
      {
         gStarContainer[_loc5_]._alpha -= _loc3_;
      }
      if(!still)
      {
         gStarContainer[_loc5_].moved = false;
      }
      gStarContainer[_loc5_].art._rotation += _loc4_;
      if(gStarContainer[_loc5_]._alpha < 0)
      {
         gStarContainer[_loc5_].removeMovieClip();
      }
      else
      {
         _loc2_ = _loc2_ + 1;
      }
   }
   if(gStarTimer > STAR_WAIT && _loc2_ < _loc6_ && (Math.abs(this.speed) > 2 || Math.abs(this.vSpeed) > 2))
   {
      createStar();
      gStarTimer = 0;
   }
   else
   {
      gStarTimer++;
   }
}
function unStarPower()
{
   gStarContainer.removeMovieClip();
   gStarContainer = null;
}
function setupStarPower(clip, special)
{
   var _loc3_ = Math.abs(_root.camera.scene.char.charScale) / 100;
   var _loc5_ = 75 * _loc3_;
   var _loc4_ = 125 * _loc3_;
   clip._x = _root.camera.scene.char._x - _loc5_;
   clip._y = _root.camera.scene.char._y - _loc4_;
   clip.special = special;
   clip._xscale = clip._yscale = Math.abs(_root.camera.scene.char.charScale);
}
function createStar(special)
{
   var _loc3_ = gStarContainer.getNextHighestDepth();
   var _loc5_ = gStarContainer.createEmptyMovieClip("star" + _loc3_,_loc3_);
   var _loc2_ = new Object();
   var _loc4_ = new MovieClipLoader();
   _loc2_.onLoadInit = mx.utils.Delegate.create(this,setupStarPower,special);
   _loc4_.addListener(_loc2_);
   _loc4_.loadClip("externalAssets/starPower.swf",_loc5_);
}
function sparklePower()
{
   if(_parent._name != "scene")
   {
      unSparklePower();
      return undefined;
   }
   if(gSparkleContainer != null)
   {
      gSparkleContainer.removeMovieClip();
   }
   gSparkleContainer = this._parent.createEmptyMovieClip("sparklePowerContainer" + this._name,this._parent.getNextHighestDepth());
   gSparkleCounter = 0;
   gSparkleContainer.onEnterFrame = mx.utils.Delegate.create(this,sparkleCreator);
}
function sparkleCreator()
{
   if(gSparkleCounter == gSparkleWait)
   {
      createSparkle();
      gSparkleCounter = 0;
   }
   else
   {
      gSparkleCounter++;
   }
}
function unSparklePower()
{
   gSparkleContainer.removeMovieClip();
   gSparkleContainer = null;
}
function setupSparklePower(clip)
{
   var _loc8_ = Math.abs(_root.camera.scene.char.charScale) / 100;
   var _loc5_ = _root.camera.scene.char._width * 0.25;
   var _loc4_ = _root.camera.scene.char._height * 0.5;
   clip._x = _root.camera.scene.char._x - _loc5_ + utils.Utils.getRandomNumber((- _loc5_) * 2,_loc5_ * 2);
   clip._y = _root.camera.scene.char._y - _loc4_ + utils.Utils.getRandomNumber((- _loc4_) * 1.5,_loc4_);
   clip._xscale = clip._yscale = Math.abs(_root.camera.scene.char.charScale);
   clip.art._xscale = clip.art._yscale = clip.art._alpha = 0;
   caurina.transitions.Tweener.addTween(clip.art,{transition:"easeInOutSine",time:1,_rotation:utils.Utils.getRandomNumber(360,720)});
   caurina.transitions.Tweener.addTween(clip.art,{transition:"easeInSine",_alpha:100,_xscale:100,_yscale:100,time:0.25});
   caurina.transitions.Tweener.addTween(clip.art,{transition:"easeOutSine",delay:0.25,_alpha:0,_xscale:0,_yscale:0,time:0.75,onComplete:mx.utils.Delegate.create(this,removeClip,clip)});
}
function createSparkle(special)
{
   var _loc3_ = gSparkleContainer.getNextHighestDepth();
   var _loc5_ = gSparkleContainer.createEmptyMovieClip("star" + _loc3_,_loc3_);
   var _loc2_ = new Object();
   var _loc4_ = new MovieClipLoader();
   _loc2_.onLoadInit = mx.utils.Delegate.create(this,setupSparklePower);
   _loc4_.addListener(_loc2_);
   _loc4_.loadClip("externalAssets/sparkle.swf",_loc5_);
}
function beginLionRoar()
{
   if(gLionRoar)
   {
      clearTimeout(gLionRoarEndTimer);
      gLionRoar = false;
      fx.FullScreen.shake(false,_root.camera.scene);
   }
   else
   {
      gLionRoar = true;
      char.action("proud");
      char.avatar.head.mouth.action("cry");
      gAsteroidStartTimer = setTimeout(lionRoar,400);
      gLionRoarEndTimer = setTimeout(beginLionRoar,2000);
   }
}
function lionRoar()
{
   char.avatar.head.mouth.gotoAndPlay("cry");
   fx.FullScreen.shake(true,_root.camera.scene,[10,-10],0.2);
   _root.showSound("raarr",char._x,char._y - 135,4);
}
function carryHead()
{
   avatar.follow(avatar.head,avatar.hand1,0,0,1.4,0.4);
   avatar.hair._alpha = 0;
}
function unCarryHead()
{
   avatar.follow(avatar.head,avatar.neck,-17,-72,1.4,0.4);
   avatar.hair._alpha = 100;
   avatar.head._rotation = 0;
}
function beginAlvinYell()
{
   if(gAlvinYell)
   {
      clearTimeout(gAlvinYellEndTimer);
      gAlvinYell = false;
      fx.FullScreen.shake(false,_root.camera.scene);
   }
   else
   {
      gAlvinYell = true;
      char.action("proud");
      char.avatar.head.mouth.action("cry");
      gAsteroidStartTimer = setTimeout(alvinYell,400);
      gAlvinYellEndTimer = setTimeout(beginAlvinYell,2000);
   }
}
function alvinYell()
{
   char.avatar.head.mouth.gotoAndPlay("cry");
   fx.FullScreen.shake(true,_root.camera.scene,[10,-10],0.2);
   _root.showSound("Alvin",char._x,char._y - 135,4);
}
function crispy(aColor)
{
   var _loc1_ = new Color(char.avatar.head.eyes.eyelids.skinShape);
   _loc1_.setRGB(aColor);
   char.avatar.head.eyes.filters = [new flash.filters.DropShadowFilter(3.5,90,aColor,1,0,0,5)];
   if(char.avatar.hairFrame != "store_smolder")
   {
      char.avatar.FunBrain_so.data.crispyHair = char.avatar.hairFrame;
      char.avatar.hairFrame = "store_smolder";
   }
   applyCrispy(char,true);
}
function unCrispy()
{
   char.avatar.head.eyes.filters = [];
   if(char.avatar.hairFrame == "store_smolder" && char.avatar.FunBrain_so.data.crispyHair != undefined)
   {
      char.avatar.hairFrame = char.avatar.FunBrain_so.data.crispyHair;
   }
   applyCrispy(char,false);
}
function applyCrispy(aChar, aDarken)
{
   var _loc1_ = getCrispyColor(aChar.avatar.skinColor,aDarken);
   if(_loc1_ != -1)
   {
      aChar.avatar.lineColor = aChar.avatar.skinColor = _loc1_;
      aChar.avatar.doColors();
   }
}
function getCrispyColor(aColor, aDarken)
{
   if(aDarken)
   {
      return 16280084;
   }
   var _loc3_ = _root.char.avatar.specialAbility.length;
   if(_loc3_ != undefined && _loc3_ != 0)
   {
      var _loc2_ = 0;
      while(_loc2_ != _loc3_)
      {
         if(_root.char.avatar.specialAbility[_loc2_] == "crispy")
         {
            return _root.char.avatar.specialAbilityParams[_loc2_][0];
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   return -1;
}
function clone()
{
   unclone();
}
function unClone()
{
   trailTimer.removeMovieClip();
   _root.camera.scene.bg.clips.removeMovieClip();
   _root.camera.scene.adArea.clips.removeMovieClip();
}
isPlayer = true;
if(this._name == "char")
{
   isChar = true;
}
var npc;
if(isChar != true && _parent.home != true && interaction != "none")
{
   if(_parent.red5 && this._name.substr(0,4) == "char")
   {
      if(!npc)
      {
         this.onRollOver = function()
         {
            _root.useArrow();
            _root.navBar.userInfo.showInfo(this.login,this.avatar.getLook(),this.battleRanking);
         };
         this.onRollOut = function()
         {
            _root.navBar.userInfo.hideInfo();
         };
      }
   }
   else
   {
      this.onRollOver = _root.useArrow;
   }
   this.onPress = function()
   {
      if(_root.usePinkPainter)
      {
         paintPink();
      }
      else if(_root.useSelectCharacter)
      {
         _root.selectedCharacter = this;
         _root.selectCharacter();
      }
      else if(_root.useWardrobe && !isCreature && !foreigner && this.avatar._visible && this.avatar._alpha != 0)
      {
         if(_parent._name == "scene")
         {
            _parent.char.targetPlayer = this;
         }
         else
         {
            _root.char.targetPlayer = this;
         }
         _root.popup("wardrobe.swf",false);
         _root.useWardrobe = false;
         _root.navBar.wardrobeSelect._visible = false;
         _root.navBar.wardrobeDim._visible = false;
      }
      else
      {
         _root.useWardrobe = false;
         _root.navBar.wardrobeSelect._visible = false;
         _root.navBar.wardrobeDim._visible = false;
         _root.hideMenu();
         _root.hideChat();
         _root.responding = false;
         if(_parent.red5)
         {
            if(!npc)
            {
               if(_root.server)
               {
                  _root.server.call("actUser",null,this.login,"comeup");
               }
            }
            else if(_root.server)
            {
               _root.server.call("actUser",null,this._name,"npcact");
            }
         }
         else
         {
            _root.hideSay(_parent.char.targetPlayer);
            _root.hideSay(_parent.char);
            _parent.char.targetHor = true;
            _parent.char.targetVer = true;
            _parent.char.tracking = true;
            _parent.char.trackingClip = false;
            _parent.char.targetPlayer = this;
            _parent.useTargetControl = true;
            targeted = true;
         }
      }
   };
}
if(false && isChar)
{
   this.onRollOver = function()
   {
      _root.useArrow();
      _root.navBar.userInfo.showInfo(this.avatar.loadLogin(),this.avatar.getLook());
   };
   this.onRollOut = function()
   {
      _root.navBar.userInfo.hideInfo();
   };
}
onMouseDown = function()
{
   if(!_root.takeClick._visible)
   {
      airControl = true;
   }
};
baseGround = _parent.baseGround;
padding = 20;
fastSpin = 24;
slowSpin = 12;
highJump = -26;
minJump = -12;
if(_parent.useTargetControl)
{
   lowJump = -26;
}
else
{
   lowJump = -22;
}
walkMaxSpeed = 6;
runMaxSpeed = 20;
maxVSpeed = 30;
climbSpeed = 8;
lowAccel = 0.5;
highAccel = 1;
skidSpeed = 10;
avatarStartY = avatar._y;
dir = 1;
charScale = this._yscale;
charState = null;
speed = 0;
maxSpeed = walkMaxSpeed;
accel = 0;
drag = baseDrag;
vSpeed = 0;
gravityOffset = 0;
vAccel = _parent.gravity + gravityOffset;
ground = baseGround;
spin = 0;
jumping = false;
airControl = false;
falling = false;
runWait = 0;
dropping = false;
jumpSpeed = 0;
pushLeft = false;
pushRight = false;
canClimb = false;
climbing = false;
climbBase = false;
dropWait = 0;
leftIsDown = false;
rightIsDown = false;
upIsDown = false;
downIsDown = false;
var coordinates = new Object();
targetX = this._x;
targetY = this._y;
mouseX = 0;
mouseY = 0;
targetHor = false;
targetVer = false;
var targetPlayer = null;
var targetClip = null;
var targetFunction = null;
var sayFunction = null;
var reachedTargetFunction = null;
tracking = false;
trackingClip = false;
rolling = false;
hurting = false;
ducking = false;
springing = false;
flying = false;
soaring = false;
gliding = false;
engaged = false;
mouseFollow = false;
swimming = false;
targeted = false;
speedFactor = 1;
animationFrameSuffix = "";
buoyancy = -0.8;
actionFrame = "";
actionMMO = null;
var glow = new flash.filters.GlowFilter(16777215,1,100,100,0,1,true);
var blur = new flash.filters.BlurFilter(0,0,1);
filtersArray = [glow,blur];
var chamPoint1 = new flash.geom.Point();
var chamPoint2 = new flash.geom.Point();
var chamPoint3 = new flash.geom.Point();
chamColorNum1 = 0;
chamColorNum2 = 0;
chamColorNum3 = 0;
chamColor1 = 0;
chamColor2 = 0;
chamColor3 = 0;
chamAlpha = 100;
grappling = false;
_parent.hook._visible = false;
var currentHit = null;
var currentSpecialHit = null;
var currentExitHit = null;
var currentObjectHit = null;
var currentWallHit = null;
var statusManager = com.poptropica.util.StatusManager.getInstance();
var transitToken = SharedObject.getLocal("TransitToken","/");
char = this;
var gClipLoader;
var gClipLoaderListener;
var gFloatParticleContainer;
var gFloatParticleInt;
var gFloatParticleActive = false;
var gFloatParticleAsset;
var gLightning;
var gTotalBolt = 8;
var gLightningActive = false;
var gLightningClip;
var gBoxOffset = 350;
var gSnow;
var gSnowClip;
var gTotalSnowFlakes = 150;
var gSnowing = false;
var gAsteroids;
var gAsteroidsClip;
var gAsteroidsFalling = false;
var gAsteroidEndTimer;
var gAsteroidStartTimer;
var gCameraX;
var gCameraY;
var gParticleContainer;
var gParticleInt;
var gParticleAsset;
var gValidOutfits = ["pEarthKnight","pGirlKnight"];
var gParticleActive = false;
var gParticleClipLoader;
var gParticleClipLoaderListener;
var gLoops;
var gLoopsClip;
var gLoopsFalling = false;
var gLoopsEndTimer;
var gLoopsStartTimer;
var WARP_DELAY = 1.2;
var WARP_TIME = 0.5;
var gAtomicFieldContainer;
var gAtomicClipLoader;
var gAtomicClipLoaderListener;
var gLava;
var gLavaClip;
var gLavaFalling = false;
var gLavaEndTimer;
var gLavaStartTimer;
var gStarContainer = null;
var STAR_WAIT = 1;
var gStarTimer = 0;
var gSparkleContainer = null;
var gSparkleWait = 1;
var gSparkleCounter = 0;
var gLionRoar = false;
var gLionRoarEndTimer;
var gAlvinYell = false;
var gAlvinYellEndTimer;
loadingFinished = false;
var loader = new MovieClipLoader();
var listener = new Object();
listener.onLoadInit = function()
{
   nextFrame();
};
listener.onLoadError = function(mc, errCode, httpStatus)
{
   trace(_name + " err " + errCode + " while loading " + mc);
};
loader.addListener(listener);
