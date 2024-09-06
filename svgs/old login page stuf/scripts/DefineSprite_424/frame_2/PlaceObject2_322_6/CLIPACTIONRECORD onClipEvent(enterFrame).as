onClipEvent(enterFrame){
   if(FirstPass == true)
   {
      _Y = _Y + VelocityY * secsPerStep;
      VelocityY += Acceleration * secsPerStep;
      if(VelocityY > 0 and _Y > StableY)
      {
         FirstPass = false;
         HeadedUp = false;
         VelocityY = 9;
         Acceleration = 1.2;
         Friction = 0.75;
         _parent._parent.nextFrame();
      }
   }
   if(HeadedUp != true)
   {
      _Y = _Y + VelocityY * secsPerStep;
      VelocityY -= Acceleration * secsPerStep;
      if(VelocityY < 0 and _Y < StableY)
      {
         HeadedUp = true;
         VelocityY = - EaseVelocity - (random(3) + 1) * 0.2;
         EaseVelocity -= 1;
         if(EaseVelocity < EaseVelocityConstant)
         {
            EaseVelocity = EaseVelocityConstant;
         }
         Acceleration = EaseVelocity * 0.1;
      }
   }
   else if(HeadedUp == true and FirstPass != true)
   {
      _Y = _Y + VelocityY * secsPerStep;
      VelocityY += Acceleration * secsPerStep;
      if(VelocityY > 0 and _Y > StableY)
      {
         HeadedUp = false;
         VelocityY = EaseVelocity + (random(3) + 1) * 0.2;
         EaseVelocity -= 1;
         if(EaseVelocity < EaseVelocityConstant)
         {
            EaseVelocity = EaseVelocityConstant;
         }
      }
   }
   if(ShakeCycle == true)
   {
      _rotation = 0;
      if(ShakeIteration / 2 == int(ShakeIteration / 2))
      {
         _rotation = _rotation + random(4) + 1;
      }
      else
      {
         _rotation = _rotation - (random(4) + 1);
      }
      ShakeIteration += 1;
      if(ShakeIteration >= ShakeDuration and _parent._parent.CrateCanExplode != true)
      {
         ShakeCycle = false;
         _rotation = 0;
      }
      i = 0;
      while(i < 5)
      {
         particleCount += 1;
         curClip = _parent.attachMovie("Particle","particle" + particleCount,particleCount);
         curClip.xVel = _rotation * (Math.random() * 4 - 2);
         curClip.yVel = _rotation * (Math.random() * 4 - 2);
         curClip._x = this._x + Math.random() * 150 - 75;
         curClip._y = this._y + Math.random() * 150 - 75;
         curClip._alpha = Math.random() * 30 + 30;
         curClip.onEnterFrame = function()
         {
            this.xVel *= 0.95;
            this.yVel *= 0.95;
            this._x += this.xVel;
            this._y += this.yVel;
            this._alpha -= 1.5;
            if(this._alpha < 0)
            {
               this.removeMovieClip();
            }
         };
         i++;
      }
   }
   if(random(ShakeMax) == true and ShakeCycle != true)
   {
      ShakeCycle = true;
      ShakeDuration = random(23) + 7;
      ShakeIteration = 0;
   }
   if(_parent._parent.CrateCanExplode == true)
   {
      if(CrateExplosionInitialization != true)
      {
         CrateExplosionInitialization = true;
         ShakeCycle = true;
         CrateExplosionCounter = 0;
      }
      CrateExplosionCounter += 1;
      if(CrateExplosionCounter > MaxExplosionShakeCount)
      {
         _parent._parent.nextFrame();
         _parent.CrateLastY = _Y;
         _parent.nextFrame();
      }
   }
}
