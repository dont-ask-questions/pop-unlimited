if(_root.island != "Early")
{
   btnPutOn._visible = btnTakeOff._visible = false;
}
if(_root.camera.scene.char.avatar.packFrame == "jet")
{
   btnPutOn._visible = false;
}
else
{
   btnTakeOff._visible = false;
}
btnPutOn.onRelease = function()
{
   _root.camera.scene.char.avatar.packFrame = "jet";
   _root.camera.scene.char.avatar.setParts();
   _root.camera.scene.char.avatar.savePartsToSO();
   this._visible = false;
   btnTakeOff._visible = true;
};
btnTakeOff.onRelease = function()
{
   _root.camera.scene.char.avatar.packFrame = 1;
   _root.camera.scene.char.avatar.setParts();
   _root.camera.scene.char.avatar.savePartsToSO();
   this._visible = false;
   btnPutOn._visible = true;
};
interactive = true;
