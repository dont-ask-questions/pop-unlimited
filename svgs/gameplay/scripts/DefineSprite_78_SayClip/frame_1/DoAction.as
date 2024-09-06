function sizeBubbles()
{
   txtBox._x = fld._x + fld._width / 2;
   txtBox._y = fld._y + fld._height / 2;
   txtBox._width = fld._width + padding * 2;
   txtBox._height = fld._height + padding * 2;
   clipHeight = txtBox._height;
}
padding = 10;
clipHeight = txtBox._height;
fld.autoSize = "center";
