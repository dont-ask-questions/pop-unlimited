scene = _parent._parent._parent._parent._parent;
char = _parent._parent._parent._parent;
avatarScale = 0.36;
gravity = 1.5;
size = 10;
onEnterFrame = function()
{
   if(Math.random() < 0.05 && !scene.pausedGame && char._yscale > 80)
   {
      drip = scene.createEmptyMovieClip("drip" + scene.getNextHighestDepth(),scene.getNextHighestDepth());
      drip.lineStyle(1,16777215,35);
      drip.beginFill(7905314);
      drip.moveTo(0,0);
      drip.curveTo(size * 0.7,size,0,size);
      drip.curveTo((- size) * 0.7,size,0,0);
      if(char._xscale < 0 || char.avatar._xscale < 0)
      {
         dir = -1;
      }
      else
      {
         dir = 1;
      }
      scaleMag = char.charScale / 100;
      drip._x = char._x + scaleMag * (dir * char.avatar._x + dir * avatarScale * char.avatar.head._x + dir * avatarScale * this._x);
      drip._y = char._y + scaleMag * (char.avatar._y + avatarScale * char.avatar.head._y + avatarScale * this._y);
      drip._xscale = drip._yscale = Math.random() * 30 + 80;
      drip.vy = 0;
      drip.gravity = gravity;
      drip.char = char;
      if(char.ground)
      {
         drip.ground = char.ground;
      }
      else
      {
         drip.ground = char._y;
      }
      drip.onEnterFrame = function()
      {
         this.vy += this.gravity;
         this._y += this.vy;
         if(this._y > this.ground)
         {
            this.removeMovieClip();
         }
      };
   }
};
