function sizeBubbles()
{
   txtBox1._x = fld1._x + fld1._width / 2;
   txtBox1._y = fld1._y + fld1._height / 2;
   txtBox1._width = fld1._width + padding * 2;
   txtBox1._height = fld1._height + padding * 2;
}
padding = 5;
fld1.autoSize = "center";
