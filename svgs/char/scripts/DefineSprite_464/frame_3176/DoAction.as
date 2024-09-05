if(_parent._parent.cold)
{
   breath.onEnterFrame = function()
   {
      particles(breath,neck._x - 50,neck._y - 20,-8,-6,2,6,20,1,400,8,-0.5,0.98);
   };
}
