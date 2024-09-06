btnCelebrate.onPress = function()
{
   switch(Math.ceil(Math.random() * 2))
   {
      case 1:
         _parent._parent.emote("celebrate");
         break;
      case 2:
         _parent._parent.emote("laugh");
   }
};
btnAngry.onPress = function()
{
   switch(Math.ceil(Math.random() * 2))
   {
      case 1:
         _parent._parent.emote("angry");
         break;
      case 2:
         _parent._parent.emote("stomp");
   }
};
btnLaugh.onPress = function()
{
   switch(Math.ceil(Math.random() * 2))
   {
      case 1:
         _parent._parent.emote("score");
         break;
      case 2:
         _parent._parent.emote("proud");
   }
};
btnCry.onPress = function()
{
   switch(Math.ceil(Math.random() * 2))
   {
      case 1:
         _parent._parent.emote("grief");
         break;
      case 2:
         _parent._parent.emote("cry");
   }
};
btnWave.onPress = function()
{
   _parent._parent.emote("wave");
};
