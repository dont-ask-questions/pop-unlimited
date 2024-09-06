function init(buttons)
{
   btnNum = _root.MMOGames.length;
   var _loc3_ = 0;
   while(_loc3_ < _root.MMOGames.length)
   {
      var _loc4_ = this.attachMovie("_gameBtn","btn" + (_loc3_ + 1),_loc3_,{_y:_loc3_ * shiftY});
      _loc4_.label.text = _root.MMOGamesNames[_loc3_];
      _loc4_.gameNum = _loc3_;
      _loc4_.onPress = function()
      {
         _root.hideMenu();
         if(_root.camera.scene.red5)
         {
            if(_root.server)
            {
               _root.server.call("battle",null,_root.camera.scene.char.targetPlayer.login,this.gameNum.toString(),"invite");
            }
         }
      };
      _loc4_.onRollOver = _root.useArrow;
      _loc3_ = _loc3_ + 1;
   }
}
function animateIn()
{
   i = 1;
   while(i <= _root.MMOGames.length)
   {
      btn = this["btn" + i];
      btn.startY = btn._y;
      btn._y += 40;
      btn._alpha = 0;
      btn._xscale = btn._yscale = 0;
      btn._rotation = Math.random() * 360 - 180;
      btn.onEnterFrame = function()
      {
         this._alpha += (100 - this._alpha) / 2;
         this._xscale = this._yscale += (100 - this._xscale) / 2;
         this._rotation += (- this._rotation) / 2;
         this._y += (this.startY - this._y) / 2;
      };
      i++;
   }
}
stop();
shiftY = -18;
clipHeight = 10;
init();
