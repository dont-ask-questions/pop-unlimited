if(npc && !checkHits)
{
   baseGround = this._y;
}
onEnterFrame = function()
{
   playerMovement();
   if(!npc || following || checkHits)
   {
      hitTests();
   }
};
