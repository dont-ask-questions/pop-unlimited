Star.onEnterFrame = function()
{
   if(Math.random() * 10 < 1)
   {
      star = this.duplicateMovieClip("star" + getNextHighestDepth(),getNextHighestDepth());
      star._x += Math.random() * 80 - 40;
      star._y += Math.random() * 60 - 30;
      star._rotation = Math.random() * 360;
      star._xscale = star._yscale = 0;
      star._alpha = 100;
      star.onEnterFrame = function()
      {
         this._xscale = this._yscale += 10;
         this._alpha -= 5;
         if(this._alpha < 0)
         {
            this.removeMovieClip();
         }
      };
   }
};
