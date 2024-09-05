function startBubble()
{
   if(randomInteger(0,1))
   {
      activeBubble = actionBubble;
   }
   else
   {
      activeBubble = cutBubble;
   }
   if(_parent._parent._xscale > 0)
   {
      finalScale = finalScaleMagnitude;
   }
   else
   {
      finalScale = - finalScaleMagnitude;
   }
   bubbleTime = 0;
   bubbleCurrentPause = 0;
   activeBubble._x = startX;
   activeBubble._y = startY;
   activeBubble.onEnterFrame = animateBubble;
}
function animateBubble()
{
   if(bubbleCurrentPause == 0)
   {
      activeBubble._x = startX + deltaMagnitudeX * Math.sin(bubbleTime * bubbleSpeed);
      activeBubble._y = startY + deltaMagnitudeY * Math.sin(bubbleTime * bubbleSpeed);
      activeBubble._xscale = finalScale * Math.sin(bubbleTime * bubbleSpeed);
      activeBubble._yscale = finalScaleMagnitude * Math.sin(bubbleTime * bubbleSpeed);
      bubbleTime++;
      if(bubbleTime > bubbleIntervals)
      {
         finalX = activeBubble._x;
         finalY = activeBubble._y;
         bubbleCurrentPause = bubbleTotalPause;
      }
   }
   else
   {
      bubbleCurrentPause--;
      if(bubbleCurrentPause <= 0)
      {
         bubbleCurrentPause = 0;
         activeBubble._xscale = activeBubble._yscale = 0;
         delete activeBubble.onEnterFrame;
      }
   }
}
function abortAnimation()
{
   bubbleCurrentPause = 0;
   actionBubble._xscale = actionBubble._yscale = 0;
   delete actionBubble.onEnterFrame;
   cutBubble._xscale = cutBubble._yscale = 0;
   delete cutBubble.onEnterFrame;
}
function randomInteger(lowNumber, highNumber)
{
   return Math.floor(Math.random() * (1 + highNumber - lowNumber)) + lowNumber;
}
var startX = 19.2;
var startY = 57.5;
var deltaMagnitudeX = -200;
var deltaMagnitudeY = 150;
var deltaX = deltaMagnitudeX;
var deltaY = deltaMagnitudeY;
var finalScaleMagnitude = 250;
var finalScale = finalScaleMagnitude;
var bubbleTime = 0;
var bubbleIntervals = 8;
var bubbleSpeed = 3.141592653589793 / (2 * bubbleIntervals);
var bubbleTotalPause = 15;
var bubbleCurrentPause = 0;
var finalX;
var finalY;
var maxShakeX = 50;
var maxShakeY = 50;
actionBubble._xscale = actionBubble._yscale = 0;
cutBubble._xscale = cutBubble._yscale = 0;
