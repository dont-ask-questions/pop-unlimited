class com.greensock.plugins.FrameLabelPlugin extends com.greensock.plugins.FramePlugin
{
   var propName;
   var _target;
   var frame;
   static var API = 1;
   function FrameLabelPlugin()
   {
      super();
      this.propName = "frameLabel";
   }
   function onInitTween(target, value, tween)
   {
      if(typeof tween.target != "movieclip")
      {
         return false;
      }
      this._target = MovieClip(target);
      this.frame = this._target._currentframe;
      var _loc2_ = this._target.duplicateMovieClip("tempMC" + Math.round(Math.random() * 999999),this._target._parent.getNextHighestDepth());
      _loc2_.gotoAndStop(value);
      var _loc3_ = _loc2_._currentframe;
      _loc2_.removeMovieClip();
      if(this.frame != _loc3_)
      {
         this.addTween(this,"frame",this.frame,_loc3_,"frame");
      }
      return true;
   }
}
