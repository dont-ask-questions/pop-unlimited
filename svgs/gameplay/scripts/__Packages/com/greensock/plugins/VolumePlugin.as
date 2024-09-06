class com.greensock.plugins.VolumePlugin extends com.greensock.plugins.TweenPlugin
{
   var propName;
   var overwriteProps;
   var _sound;
   var volume;
   static var API = 1;
   function VolumePlugin()
   {
      super();
      this.propName = "volume";
      this.overwriteProps = ["volume"];
   }
   function onInitTween(target, value, tween)
   {
      if(isNaN(value) || typeof target != "movieclip" && !(target instanceof Sound))
      {
         return false;
      }
      this._sound = typeof target != "movieclip" ? Sound(target) : new Sound(target);
      this.volume = this._sound.getVolume();
      this.addTween(this,"volume",this.volume,value,"volume");
      return true;
   }
   function set changeFactor(n)
   {
      this.updateTweens(n);
      this._sound.setVolume(this.volume);
   }
}
