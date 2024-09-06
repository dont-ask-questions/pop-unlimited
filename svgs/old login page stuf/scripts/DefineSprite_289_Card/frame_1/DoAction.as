function initChars()
{
   char.createBackPlayer();
   char.avatar.nextFrame();
   nextFrame();
}
stop();
char._alpha = 0;
char._xscale = -300;
var colors = [16768981,16764057,16108912,14193168,9321734,3394560,3381504,39372,3355596,13743099,10053324,16776960,16763955,16724736,16751052,16724889,52428,13421772];
var newRandomName = _root.camera.scene.char.avatar.generateName();
ThisFirstName = newRandomName.first;
ThisLastName = newRandomName.last;
nameFld.text = ThisFirstName + "\n" + ThisLastName;
trace("new name generated : " + newRandomName.first + " " + newRandomName.last);
bgNum = Math.ceil(Math.random() * bg._totalframes);
bg.gotoAndStop(bgNum);
var loader = new MovieClipLoader();
loader.loadClip("char.swf",char);
this.createEmptyMovieClip("loadCheck",1);
loadCheck.onEnterFrame = function()
{
   if(char.loadingFinished)
   {
      delete this.onEnterFrame;
      initChars();
      removeMovieClip(loadCheck);
   }
};
