function initChars()
{
   char1.createNPC(0,0,0,0,"random");
   char1.avatar.nextFrame();
   char1.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   char2.createNPC(0,0,0,0,"random");
   char2.avatar.nextFrame();
   char2.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   char3.createNPC(0,0,0,0,"random");
   char3.avatar.nextFrame();
   char3.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   char4.createNPC(0,0,0,0,"random");
   char4.avatar.nextFrame();
   char4.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   char5.createNPC(0,0,0,0,"random");
   char5.avatar.nextFrame();
   char5.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   char6.createNPC(0,0,0,0,"random");
   char6.avatar.nextFrame();
   char6.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   char7.createNPC(0,0,0,0,"random");
   char7.avatar.nextFrame();
   char7.maxSpeed = this._xscale / 7 + Math.round(Math.random() * 4);
   _root.nextFrame();
}
stop();
charChecker.onEnterFrame = function()
{
   c = 1;
   while(c <= 7)
   {
      curChar = this._parent["char" + c];
      curLoader = this._parent["loader" + c];
      if(curChar._x > stampedeTarget)
      {
         delete curChar.onEnterFrame;
         curLoader.unloadClip(curChar);
      }
      c++;
   }
};
var Chars = new Array();
var loader1 = new MovieClipLoader();
loader1.loadClip("char.swf",char1);
Chars.push(char1);
var loader2 = new MovieClipLoader();
loader2.loadClip("char.swf",char2);
Chars.push(char2);
var loader3 = new MovieClipLoader();
loader3.loadClip("char.swf",char3);
Chars.push(char3);
var loader4 = new MovieClipLoader();
loader4.loadClip("char.swf",char4);
Chars.push(char4);
var loader5 = new MovieClipLoader();
loader5.loadClip("char.swf",char5);
Chars.push(char5);
var loader6 = new MovieClipLoader();
loader6.loadClip("char.swf",char6);
Chars.push(char6);
var loader7 = new MovieClipLoader();
loader7.loadClip("char.swf",char7);
Chars.push(char7);
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
