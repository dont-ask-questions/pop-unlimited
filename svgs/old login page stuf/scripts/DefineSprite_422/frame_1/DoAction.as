NumberOfSplinters = 32;
var secsPerStep = 0.95;
var Acceleration = 3;
SplintersInitialized = false;
createEmptyMovieClip("timer_mc",_parent._parent.getNextHighestDepth());
timer_mc.onEnterFrame = function()
{
   if(SplintersInitialized != true)
   {
      SplintersInitialized = true;
      j = 1;
      while(j < NumberOfSplinters + 1)
      {
         XVariance = - eval("s" + j)._x;
         if(XVariance < 0)
         {
            eval("s" + j).RotationSpeed = random(30);
         }
         else
         {
            eval("s" + j).RotationSpeed = - random(30);
         }
         eval("s" + j).VelocityY = - (random(30) + 15);
         eval("s" + j).VelocityX = XVariance / 3 + random(4);
         j++;
      }
   }
   else
   {
      j = 1;
      while(j < NumberOfSplinters + 1)
      {
         eval("s" + j)._y += eval("s" + j).VelocityY * secsPerStep;
         eval("s" + j)._x -= eval("s" + j).VelocityX * secsPerStep;
         eval("s" + j).VelocityY += Acceleration * secsPerStep;
         eval("s" + j)._rotation += eval("s" + j).RotationSpeed;
         j++;
      }
   }
};
