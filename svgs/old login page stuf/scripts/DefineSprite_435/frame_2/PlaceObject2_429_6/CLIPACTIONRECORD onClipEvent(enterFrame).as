onClipEvent(enterFrame){
   if(BallSelected != true)
   {
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
         }
      }
      if(HeadedUp != true)
      {
         _Y = _Y + VelocityY * secsPerStep;
         VelocityY -= Acceleration * secsPerStep;
         if(VelocityY < 0 and _Y < StableY)
         {
            HeadedUp = true;
            VelocityY = - EaseVelocity - (random(10) + 8) * 0.2;
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
            VelocityY = EaseVelocity + (random(10) + 8) * 0.2;
            EaseVelocity -= 1;
            if(EaseVelocity < EaseVelocityConstant)
            {
               EaseVelocity = EaseVelocityConstant;
            }
         }
      }
   }
   else
   {
      if(BallSelectedInitiated != true)
      {
         VelocityY = 4;
         BallSelectedInitiated = true;
      }
      _Y = _Y + VelocityY * secsPerStep;
      VelocityY -= Acceleration * secsPerStep;
      if(VelocityY < 0.5 and AscentHasStarted != true)
      {
         AscentHasStarted = true;
         VelocityY = -40;
         if(_parent.GenderAlreadySelected != true)
         {
            _parent.GenderAlreadySelected = true;
            _parent.GlassBallGirlClip.BallSelected = true;
            CoolHissSound = new Sound();
            CoolHissSound.attachSound("CoolHissSound.wav");
            CoolHissSound.setPan((_X - 250) / 5 * 2);
            CoolHissSound.start();
         }
      }
      if(_Y < -1000)
      {
         _parent._parent.nextFrame();
      }
   }
}
