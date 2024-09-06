function init()
{
   i = 1;
   while(i <= 3)
   {
      txtBox = this["txtBox" + i];
      txtBox.num = i;
      txtBox.onPress = function()
      {
         fld = _parent.chat["fld" + this.num];
         var _loc4_ = _root.camera.scene.char.targetPlayer;
         if(_root.camera.scene.red5 && (_loc4_.login != undefined || _loc4_._name == "char"))
         {
            if(_root.server)
            {
               if(fld.quest_id == -2)
               {
                  _root.server.call("battle",null,_loc4_.login,fld.game,"start");
               }
               else
               {
                  _root.server.call("chat",null,_loc4_.login,fld.htmlText,fld.quest_id);
               }
            }
         }
         else if(_root.responding)
         {
            _root.showSay(_loc4_,fld.htmlText,this.num);
         }
         else
         {
            _root.showSay(_root.camera.scene.char,fld.htmlText,this.num);
         }
         _root.hideChat();
      };
      i++;
   }
}
function sizeBubbles()
{
   if(fld1.length == 0 || fld1.text == "undefined")
   {
      fld1.htmlText = "";
      adText._y += 30;
      txtBox1._visible = false;
      fld1._visible = false;
      txtBox1._height = 30;
   }
   else
   {
      txtBox1._x = fld1._x + fld1._width / 2;
      txtBox1._y = fld1._y + fld1._height / 2;
      txtBox1._width = fld1._width + padding * 2;
      txtBox1._height = fld1._height + padding * 2;
   }
   fld2._y = fld1._y + fld1._height + padding * 2.5;
   if(fld2.length == 0 || fld2.text == "undefined")
   {
      fld2.htmlText = "";
      adText._y += 20;
      txtBox2._visible = false;
      fld2._visible = false;
      txtBox2._height = 20;
      txtBox3.onPress();
   }
   else
   {
      txtBox2._x = fld2._x + fld2._width / 2;
      txtBox2._y = fld2._y + fld2._height / 2;
      txtBox2._width = fld2._width + padding * 2;
      txtBox2._height = fld2._height + padding * 2;
   }
   fld3._y = fld2._y + fld2._height + padding * 2.5;
   txtBox3._x = fld3._x + fld3._width / 2;
   txtBox3._y = fld3._y + fld3._height / 2;
   txtBox3._width = fld3._width + padding * 2;
   txtBox3._height = fld3._height + padding * 2;
   clipHeight = txtBox1._height + txtBox2._height + txtBox3._height;
}
var padding = 10;
init();
sizeBubbles();
