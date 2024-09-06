logWWW("***gameplay frame 6");
if(false)
{
   if(camera.scene.red5)
   {
      timeout = setInterval(this,"kick",timeoutInterval);
      var timeoutHandler = new Object();
      timeoutHandler.onMouseMove = timeoutHandler.onKeyUp = function()
      {
         clearInterval(timeout);
         timeout = setInterval(_root,"kick",timeoutInterval);
      };
      Mouse.addListener(timeoutHandler);
      Key.addListener(timeoutHandler);
      if(camera.scene.PartyRoom)
      {
         nextFrame();
      }
      else
      {
         stop();
         var sender = new LoadVars();
         var receiver = new LoadVars();
         receiver.onLoad = function()
         {
            _root.camera.scene.char.avatar.FunBrain_so.data.MMOprefix = this.prefix;
            _root.nextFrame();
         };
         sender.sendAndLoad("/getMMOPrefix.php",receiver,"POST");
      }
   }
   else
   {
      nextFrame();
   }
}
else
{
   nextFrame();
}
