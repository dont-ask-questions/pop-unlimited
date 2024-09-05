steam.onEnterFrame = function()
{
   particles(steam,neck._x + 55,neck._y - 75,10,12,-2,2,50,4,200,8,-0.5,0.95);
   particles(steam,neck._x - 95,neck._y - 75,-10,-8,-2,2,50,4,200,8,-0.5,0.95);
   if(head.headSkin.red._alpha < 70)
   {
      head.headSkin.red._alpha += 4;
      head.eyes.eyelids.red._alpha += 4;
   }
};
