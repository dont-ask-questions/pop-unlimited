waveWait = 5;
Wave.onEnterFrame = function()
{
   waveWait++;
   if(waveWait > 5)
   {
      waveWait = 0;
      wave = this.duplicateMovieClip("wave" + getNextHighestDepth(),getNextHighestDepth());
      wave._alpha = 100;
      wave._xscale = wave._yscale = 0;
      wave.onEnterFrame = function()
      {
         this._xscale = this._yscale += 30;
         this._alpha -= 2;
         if(this._alpha < 0)
         {
            this.removeMovieClip();
         }
      };
   }
};
