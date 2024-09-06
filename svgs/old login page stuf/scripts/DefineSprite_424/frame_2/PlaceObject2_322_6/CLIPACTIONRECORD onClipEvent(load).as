onClipEvent(load){
   VelocityY = -60;
   Friction = 0.95;
   secsPerStep = 0.95;
   Acceleration = 4;
   InitialY = _Y;
   StableY = -40;
   HeadedUp = true;
   FirstPass = true;
   EaseVelocity = 5;
   EaseVelocityConstant = 1.5;
   ShakeCycle = false;
   ShakeIteration = 0;
   ShakeMax = 200;
   CrateExplosionInitialization = false;
   MaxExplosionShakeCount = 25;
   particleCount = 0;
}
