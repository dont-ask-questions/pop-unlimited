logWWW("***gameplay frame 11");
camera.scene.init();
if(camera.scene.PartyRoom)
{
   navBar.btnSave._visible = false;
   navBar.roomName.roomNameTxt.text = camera.scene.char.avatar.FunBrain_so.data.partyRoom;
}
else
{
   navBar.roomName._visible = false;
}
