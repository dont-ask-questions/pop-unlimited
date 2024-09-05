function action()
{
   if(_parent.fangState1 == 1)
   {
      _parent.fangState1 = 0;
      gotoAndStop("grow");
      play();
   }
   else
   {
      _parent.fangState1 = 1;
      gotoAndStop("retract");
      play();
   }
}
stop();
if(_parent.fangState1 == 0)
{
   gotoAndStop("growEnd");
}
else
{
   gotoAndStop("retractEnd");
}
