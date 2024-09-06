function moveBalls(j)
{
   if(this.BallHasBeenSelected != true)
   {
      angle = 0;
      var _loc2_ = 0;
      while(_loc2_ < totalBalls)
      {
         xLoc = Math.cos(angle + j) * hSpace;
         yLoc = Math.sin(angle + j) * vSpace;
         angle += 0.017453292519943295 * (360 / totalBalls);
         this["gbc_mc" + _loc2_]._x = xLoc + xSpacer;
         this["gbc_mc" + _loc2_]._y = yLoc + ySpacer;
         this["shdw_mc" + _loc2_]._x = xLoc + xSpacer + 18;
         this["shdw_mc" + _loc2_]._y = yLoc + 395;
         this["shdw_mc" + _loc2_].LastY = this["shdw_mc" + _loc2_]._y;
         topY = ySpacer - vSpace;
         bottomY = ySpacer + vSpace;
         totalSize = vSpace * 2;
         currentY = Math.round(this["gbc_mc" + _loc2_]._y - topY);
         scaler = currentY / totalSize * 100;
         this["gbc_mc" + _loc2_]._alpha = scaler - 2;
         this["shdw_mc" + _loc2_]._alpha = this["gbc_mc" + _loc2_]._y / 5;
         scaler -= 100;
         if(scaler < 0)
         {
            scaler *= -1;
         }
         scaler = Math.round(scalingPerc * (scaler / 100));
         scaler = 100 - scaler;
         this["gbc_mc" + _loc2_]._xscale = scaler;
         this["gbc_mc" + _loc2_]._yscale = scaler;
         this["shdw_mc" + _loc2_]._xscale = scaler;
         this["shdw_mc" + _loc2_]._yscale = scaler;
         _loc2_ = _loc2_ + 1;
      }
   }
   else
   {
      _loc2_ = 0;
      while(_loc2_ < totalBalls)
      {
         this["gbc_mc" + _loc2_]._y += this["gbc_mc" + _loc2_].VelocityY * this.secsPerStep;
         this["gbc_mc" + _loc2_]._x += this["gbc_mc" + _loc2_].VelocityX;
         if(_loc2_ != SelectedBall)
         {
            this["gbc_mc" + _loc2_].VelocityY += this.Acceleration * this.secsPerStep;
            if(this["gbc_mc" + _loc2_]._y > this["shdw_mc" + _loc2_]._y - 40)
            {
               this["gbc_mc" + _loc2_]._y = this["shdw_mc" + _loc2_]._y - 40;
               this["gbc_mc" + _loc2_].VelocityY = (- this["gbc_mc" + _loc2_].VelocityY) * 0.75;
            }
         }
         else
         {
            if(BallSelectedInitiated != true)
            {
               this.Acceleration = 0.7;
               this["gbc_mc" + _loc2_].VelocityY = 4;
               BallSelectedInitiated = true;
            }
            this["gbc_mc" + _loc2_]._y += this["gbc_mc" + _loc2_].VelocityY * this.secsPerStep;
            this["gbc_mc" + _loc2_].VelocityY -= this.Acceleration * this.secsPerStep;
            if(this["gbc_mc" + _loc2_].VelocityY < 0.5 and AlreadySelected != true)
            {
               AlreadySelected = true;
               this["gbc_mc" + _loc2_].VelocityY = -20;
               CoolHissSound = new Sound();
               CoolHissSound.attachSound("CoolHissSound.wav");
               CoolHissSound.setPan((_X - 250) / 5 * 2);
               CoolHissSound.start();
            }
            if(this["gbc_mc" + _loc2_]._y < -100)
            {
               nextFrame();
               removeMovieClip(this["gbc_mc" + _loc2_]);
            }
         }
         this["shdw_mc" + _loc2_]._x = this["gbc_mc" + _loc2_]._x + 18;
         this["shdw_mc" + _loc2_]._y = this["shdw_mc" + _loc2_].LastY;
         _loc2_ = _loc2_ + 1;
      }
   }
}
function TriggerSelectedBall(WhichBall)
{
   char.avatar.FunBrain_so.data.age = age = 15 - WhichBall;
   char.avatar.FunBrain_so.flush();
   BallHasBeenSelected = true;
   Acceleration = 4;
   var _loc2_ = 0;
   while(_loc2_ < this.totalBalls)
   {
      if(_loc2_ == WhichBall)
      {
         SelectedBall = WhichBall;
      }
      else
      {
         this["gbc_mc" + _loc2_].VelocityY = - random(20) + -20;
         this["gbc_mc" + _loc2_].VelocityX = (ScreenCenter - this["gbc_mc" + _loc2_]._x) * -0.15;
      }
      _loc2_ = _loc2_ + 1;
   }
}
var totalBalls = 10;
var scalingPerc = 25;
var hSpace = 120;
var vSpace = 30;
var xSpacer = 383;
var ySpacer = -100;
var angle = 0;
var j = 0;
var VelocityY = 28;
var Friction = 0.75;
var secsPerStep = 0.95;
var Acceleration = 1.5;
MaxDiff = 200;
StableY = 270;
HeadedUp = true;
FirstPass = true;
EaseVelocity = 5;
EaseVelocityConstant = 1.5;
BallHasBeenSelected = false;
ScreenCenter = 375;
xRest = 50;
yRest = 380;
BallSelectedInitiated = false;
var i = 0;
while(i < totalBalls)
{
   xLoc = Math.cos(angle) * hSpace;
   yLoc = Math.sin(angle) * vSpace;
   var ball_mc = this.attachMovie("GlassBallClip_mc","gbc_mc" + i,this.getNextHighestDepth(),{_x:xLoc + xSpacer,_y:yLoc + ySpacer,Age:15 - i});
   ball_mc.num = i;
   angle += 0.017453292519943295 * (360 / totalBalls);
   i++;
}
var i = 0;
while(i < totalBalls)
{
   VelocityY = 0;
   xLoc = Math.cos(angle) * hSpace;
   yLoc = Math.sin(angle) * vSpace + 200;
   this.attachMovie("Shadow_mc","shdw_mc" + i,this.getNextHighestDepth(),{_x:xLoc + xSpacer,_y:yLoc + ySpacer});
   angle += 0.017453292519943295 * (360 / totalBalls);
   this["shdw_mc" + i]._alpha = 0;
   i++;
}
this.createEmptyMovieClip("timer_mc",this.getNextHighestDepth());
timer_mc.onEnterFrame = function()
{
   if(BallHasBeenSelected != true)
   {
      if(FirstPass == true)
      {
         ySpacer += VelocityY * secsPerStep;
         VelocityY += Acceleration * secsPerStep;
         if(VelocityY > 0 and ySpacer > StableY)
         {
            SelectYourAgeClip.play();
            FirstPass = false;
            HeadedUp = false;
            VelocityY = 9;
            Acceleration = 1.2;
            Friction = 0.75;
            MouseIsBeingRead = true;
         }
      }
      if(HeadedUp != true)
      {
         ySpacer += VelocityY * secsPerStep;
         VelocityY -= Acceleration * secsPerStep;
         if(VelocityY < 0 and ySpacer < StableY)
         {
            HeadedUp = true;
            VelocityY = - EaseVelocity;
            EaseVelocity -= 2;
            if(EaseVelocity < EaseVelocityConstant)
            {
               EaseVelocity = 0;
            }
            Acceleration = EaseVelocity * 0.1;
         }
      }
      else if(HeadedUp == true and FirstPass != true)
      {
         ySpacer += VelocityY * secsPerStep;
         VelocityY += Acceleration * secsPerStep;
         if(VelocityY > 0 and ySpacer > StableY)
         {
            HeadedUp = false;
            VelocityY = EaseVelocity;
            VelocityY = 2;
            EaseVelocity -= 2;
            if(EaseVelocity < EaseVelocityConstant)
            {
               EaseVelocity = 0;
            }
         }
      }
      if(MouseIsBeingRead == true)
      {
         if(_xmouse > xSpacer)
         {
            diff = _xmouse - xSpacer;
            if(diff > MaxDiff)
            {
               diff = MaxDiff;
            }
            j += diff * 0.0009;
         }
         if(_xmouse < xSpacer)
         {
            diff = xSpacer - _xmouse;
            if(diff > MaxDiff)
            {
               diff = MaxDiff;
            }
            j -= diff * 0.0009;
         }
      }
      else
      {
         diff = -55;
         j -= diff * 0.0009;
      }
   }
   moveBalls(j);
};
