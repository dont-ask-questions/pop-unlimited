function initChars()
{
   char.createNewPlayer();
   char.avatar.nextFrame();
   nextFrame();
}
stop();
baseGround = 1000;
gravity = 1.5;
leftLimit = 0;
rightLimit = 800;
upLimit = 0;
downLimit = 480;
useMouse = true;
home = true;
roomName = "Home";
hasItems = false;
var changed = false;
gender = 0;
age = 0;
CrateCanExplode = false;
NumberOfFlipSounds = 4;
stampedeTarget = 850;
var myColors = [1286141];
bg._visible = false;
takeHits.onRollOver = function()
{
   _root.pointer.gotoAndStop(1);
};
var Chars = new Array();
var loader = new MovieClipLoader();
loader.loadClip("char.swf",char);
Chars.push(char);
this.createEmptyMovieClip("loadCheck",1);
loadCheck.onEnterFrame = function()
{
   if(Chars.length <= 0)
   {
      delete this.onEnterFrame;
      initChars();
      removeMovieClip(loadCheck);
   }
   var _loc2_ = 0;
   while(_loc2_ < Chars.length)
   {
      if(Chars[_loc2_].loadingFinished)
      {
         Chars.splice(_loc2_,1);
      }
      _loc2_ = _loc2_ + 1;
   }
};
