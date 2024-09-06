logWWW("***gameplay frame 4");
camera.scene.panChar = camera.scene.char;
coordinate(camera.scene);
if(FunBrain_so.data.dir != undefined)
{
   camera.scene.char._xscale = camera.scene.char.charScale * FunBrain_so.data.dir;
}
if(FunBrain_so.data[desc + "xPos"] != undefined)
{
   camera.scene.char._x = FunBrain_so.data[desc + "xPos"];
}
if(FunBrain_so.data[desc + "yPos"] != undefined)
{
   camera.scene.char._y = FunBrain_so.data[desc + "yPos"];
}
setPosition(camera);
if(camera.scene.useScalePan != true)
{
   camera.onEnterFrame = pan;
}
else
{
   camera.onEnterFrame = scalePan;
}
nextFrame();
