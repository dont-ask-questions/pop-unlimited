function attachLeaf()
{
   i++;
   whichClip = whichItems[random(whichItems.length)];
   curClip = this.attachMovie(whichClip,"leaf" + i,i);
   curClip._x = tip._x;
   curClip._y = tip._y;
   curClip._xscale = curClip._yscale = lineWidth * 5 + 20;
   curClip._rotation = tip._rotation - 90 + Math.random() * randRot - randRot / 2;
   setColor = new Color(curClip);
   randomColor = _parent.myColors[random(_parent.myColors.length)];
   setColor.setRGB(randomColor);
}
function changeDir()
{
   if(lineWidth > 0)
   {
      dir = random(2);
   }
   else
   {
      angleAccel = 6;
   }
}
var whichItems = ["Leaf1","Leaf2","Leaf3"];
tip._visible = false;
randRot = 90;
unitAngle = 3;
vel = 8;
angleVel = 0;
angleAccel = 0.5;
angle = 0;
xPos = 0;
yPos = 0;
vel2 = 0;
i = 0;
lineWidth = 10;
lineStep = 0.2;
var curDir = true;
delx = tip._x - tip2._x;
dely = tip._y - tip2._y;
lineColor = _parent.myColors[random(_parent.myColors.length)];
lineStyle(lineWidth,lineColor,100);
moveTo(tip._x,tip._y);
dir = 0;
this.onEnterFrame = function()
{
   x1 = x2;
   y1 = y2;
   delx = tip._x - tip2._x;
   dely = tip._y - tip2._y;
   angle = tip._rotation * 3.141592653589793 / 180;
   xPos = vel * Math.cos(angle);
   yPos = vel * Math.sin(angle);
   tip._x -= xPos;
   tip._y -= yPos;
   x2 = tip._x;
   y2 = tip._y;
   xMid = (x1 + x2) / 2;
   yMid = (y1 + y2) / 2;
   curveTo(x1,y1,xMid,yMid);
   lineWidth -= lineStep;
   lineStyle(lineWidth,lineColor,100);
   if(dir == 0)
   {
      tip._rotation -= angleVel;
      if(curDir == true)
      {
         attachLeaf();
      }
      curDir = false;
   }
   else
   {
      tip._rotation += angleVel;
      if(curDir == false)
      {
         attachLeaf();
      }
      curDir = true;
   }
   angleVel += angleAccel;
   if(lineWidth < -2.5)
   {
      delete this.onEnterFrame;
      this.cacheAsBitmap = true;
      nextGrowth = _parent.attachMovie("Growth","growth" + _parent.getNextHighestDepth(),_parent.getNextHighestDepth());
      nextGrowth._y = Math.random() * Stage.height - Stage.height / 2;
      nextGrowth._x = this._x;
      nextGrowth._rotation = this._rotation;
   }
};
intID = setInterval(this,"changeDir",100);
