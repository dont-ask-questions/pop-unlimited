function action()
{
   if(_parent.fangState2 == 1)
   {
      _parent.fangState2 = 0;
      gotoAndStop("grow");
      play();
   }
   else
   {
      _parent.fangState2 = 1;
      gotoAndStop("retract");
      play();
   }
}
stop();
if(_parent.fangState2 == 0)
{
   gotoAndStop("growEnd");
}
else
{
   gotoAndStop("retractEnd");
}
