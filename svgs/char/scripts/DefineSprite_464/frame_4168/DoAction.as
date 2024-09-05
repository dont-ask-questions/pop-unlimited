sweat.onEnterFrame = function()
{
   randX = Math.random() * 100 - 50;
   randY = Math.random() * 4 - 2;
   particles(sweat,randX,randY,-4,4,-8,0,80,4,100,2,1,1);
};
