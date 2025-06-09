if(_root.camera.scene.char.avatar.overpantsFrame == "grass")
{
   btnPutOn._visible = false;
}
else
{
   btnTakeOff._visible = false;
}
btnPutOn.onRelease = function()
{
   _root.camera.scene.char.avatar.overpantsFrame = "grass";
   _root.camera.scene.char.avatar.setParts();
   _root.camera.scene.char.avatar.savePartsToSO();
   this._visible = false;
   btnTakeOff._visible = true;
   _root.camera.scene.init();
};
btnTakeOff.onRelease = function()
{
   _root.camera.scene.char.avatar.overpantsFrame = 1;
   _root.camera.scene.char.avatar.setParts();
   _root.camera.scene.char.avatar.savePartsToSO();
   this._visible = false;
   btnPutOn._visible = true;
   _root.camera.scene.init();
};
interactive = true;
