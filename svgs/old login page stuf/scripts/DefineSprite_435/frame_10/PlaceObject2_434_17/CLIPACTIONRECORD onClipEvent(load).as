onClipEvent(load){
   VelocityY = -60;
   Friction = 0.95;
   secsPerStep = 0.95;
   Acceleration = 4;
   InitialY = _Y;
   StableY = -70;
   HeadedUp = true;
   FirstPass = true;
   EaseVelocity = 5;
   EaseVelocityConstant = 1.5;
   xRest = -150;
   yRest = 70;
   BallSelectedInitiated = false;
}
