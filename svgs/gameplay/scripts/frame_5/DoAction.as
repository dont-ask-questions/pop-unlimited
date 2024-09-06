logWWW("***gameplay frame 5");
if(!camera.scene.ad && !camera.scene.home)
{
   stop();
   if(camera.scene.common)
   {
      btnPause._visible = false;
   }
   else
   {
      navBar.userInfo._visible = false;
      navBar.emotions._visible = false;
   }
   if(camera.scene.char.avatar.loadLogin() != "" && camera.scene.char.avatar.loadLogin() != undefined)
   {
      if(camera.scene.char.avatar.loadLogin().substr(0,5) != "GUEST")
      {
         navBar.btnSave.saved = true;
         navBar.btnSave.saveText.nextFrame();
      }
      play();
   }
   else
   {
      var login = "GUEST" + random(10000000);
      camera.scene.char.avatar.saveLogin(login);
      camera.scene.char.avatar.FunBrain_so.data.Registred = false;
      nextFrame();
   }
   navBar.btnTime._visible = false;
   navBar.btnVentMap._visible = false;
   navBar.btnSuperPower._visible = false;
   navBar.btnGrapple._visible = false;
   if(camera.scene.char.avatar.FunBrain_so.data.soaring && island == "Super")
   {
      camera.scene.char.soaring = true;
   }
   else
   {
      camera.scene.char.soaring = false;
      navBar.btnSuperPower.superGlow._visible = false;
   }
   if((island == "Time" || island == "FactMonster") && camera.scene.char.avatar.checkItem(33))
   {
      navBar.btnTime._visible = true;
   }
   if(desc == "Vent" && camera.scene.char.avatar.checkItem(43))
   {
      navBar.btnVentMap._visible = true;
   }
   if(island == "Super" && camera.scene.char.avatar.checkEvent("haveSuperPower"))
   {
      navBar.btnSuperPower._visible = true;
   }
   if(island == "Spy" && camera.scene.char.avatar.overshirtFrame == "grappleTie" && !camera.scene.common && !globalScene)
   {
      navBar.btnGrapple._visible = true;
   }
   if(globalScene)
   {
      navBar.btnSave._visible = false;
   }
}
else
{
   btnPause._visible = false;
   nextFrame();
}
