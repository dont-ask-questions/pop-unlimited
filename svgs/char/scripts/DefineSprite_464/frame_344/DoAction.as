if(this.loopCry == true)
{
   gotoAndStop("cry");
   play();
}
else
{
   stop();
   _parent.charState = null;
}
