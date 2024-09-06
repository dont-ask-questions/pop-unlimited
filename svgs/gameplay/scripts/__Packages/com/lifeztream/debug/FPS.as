class com.lifeztream.debug.FPS
{
   static var data;
   static var movieFPS;
   static var lowestFPS;
   static var highestFPS;
   static var averageFPS;
   static var CONTAINER;
   static var TEXTFIELD;
   static var intervalID;
   static var BITMAP;
   static var currentFPS;
   static var count;
   static var median;
   static var log;
   static var timeElapsed;
   static var cTime;
   static var VERSION = "1.2";
   static var ALIGN = "left";
   static var AUTHOR = "(c) 2006-2007 Copyright by Wissarut Pimanmassuriya | lifeztream.com | wissar_p@hotmail.com";
   static var _isExpand = false;
   static var intervaltimes = 4;
   static var isCreated = false;
   static var WIDTH = 100;
   static var HEIGHT = 60;
   static var BORDER = 2;
   static var saveTimer = 5;
   function FPS()
   {
   }
   static function start(setfps, align)
   {
      _root.trc("FPS start");
      if(!com.lifeztream.debug.FPS.isCreated)
      {
         com.lifeztream.debug.FPS.data = _root.traceSO.data.FPS = new Object();
         com.lifeztream.debug.FPS.ALIGN = align != undefined ? align : "left";
         com.lifeztream.debug.FPS.movieFPS = setfps;
         com.lifeztream.debug.FPS.lowestFPS = com.lifeztream.debug.FPS.highestFPS = com.lifeztream.debug.FPS.averageFPS = setfps;
         com.lifeztream.debug.FPS.reset();
         mx.transitions.OnEnterFrameBeacon.init();
         MovieClip.addListener(com.lifeztream.debug.FPS);
         com.lifeztream.debug.FPS.CONTAINER = _level0.createEmptyMovieClip("FPSCONTAINER",_root.getNextHighestDepth());
         com.lifeztream.debug.FPS.CONTAINER.onUnload = function()
         {
            com.lifeztream.debug.FPS.stop();
         };
         var _loc2_ = com.lifeztream.debug.FPS.CONTAINER.createEmptyMovieClip("bitmap",2);
         _loc2_.onRelease = function()
         {
            com.lifeztream.debug.FPS.isExpand = !com.lifeztream.debug.FPS.isExpand;
            com.lifeztream.debug.FPS.CONTAINER.swapDepths(_root.getNextHighestDepth());
         };
         _loc2_.useHandCursor = false;
         com.lifeztream.debug.FPS.TEXTFIELD = com.lifeztream.debug.FPS.CONTAINER.createTextField("FPSFIELD",25,0,0,10,10);
         com.lifeztream.debug.FPS.TEXTFIELD.autoSize = true;
         var _loc3_ = new TextFormat("Georgia",10,10395294);
         com.lifeztream.debug.FPS.TEXTFIELD._x = com.lifeztream.debug.FPS.BORDER;
         com.lifeztream.debug.FPS.TEXTFIELD._y = com.lifeztream.debug.FPS.BORDER;
         com.lifeztream.debug.FPS.TEXTFIELD.setNewTextFormat(_loc3_);
         com.lifeztream.debug.FPS.TEXTFIELD.selectable = false;
         com.lifeztream.debug.FPS.intervalID = setInterval(com.lifeztream.debug.FPS.update,1000 / com.lifeztream.debug.FPS.intervaltimes);
         com.lifeztream.debug.FPS.isCreated = true;
         com.lifeztream.debug.FPS.isExpand = true;
      }
   }
   static function stop()
   {
      com.lifeztream.debug.FPS.isCreated = false;
      MovieClip.removeListener(com.lifeztream.debug.FPS);
      com.lifeztream.debug.FPS.CONTAINER.FPSFIELD.removeTextField();
      com.lifeztream.debug.FPS.BITMAP.dispose();
      clearInterval(com.lifeztream.debug.FPS.intervalID);
   }
   static function update()
   {
      com.lifeztream.debug.FPS.currentFPS = com.lifeztream.debug.FPS.count * com.lifeztream.debug.FPS.intervaltimes;
      com.lifeztream.debug.FPS.count = 0;
      com.lifeztream.debug.FPS.calcValues();
      com.lifeztream.debug.FPS.createLog();
      com.lifeztream.debug.FPS.drawData();
      com.lifeztream.debug.FPS.saveData();
   }
   static function get isExpand()
   {
      return com.lifeztream.debug.FPS._isExpand;
   }
   static function set isExpand(b)
   {
      com.lifeztream.debug.FPS._isExpand = b;
      if(b)
      {
         com.lifeztream.debug.FPS.WIDTH = 200;
         com.lifeztream.debug.FPS.HEIGHT = 120;
      }
      else
      {
         com.lifeztream.debug.FPS.WIDTH = 100;
         com.lifeztream.debug.FPS.HEIGHT = 60;
      }
   }
   static function tostring()
   {
      return "com.lifeztream.debug.FPS, version:" + com.lifeztream.debug.FPS.VERSION;
   }
   static function reset()
   {
      com.lifeztream.debug.FPS.count = 0;
      com.lifeztream.debug.FPS.currentFPS = 0;
      com.lifeztream.debug.FPS.median = com.lifeztream.debug.FPS.movieFPS;
      com.lifeztream.debug.FPS.log = new Array();
      com.lifeztream.debug.FPS.timeElapsed = 0;
      com.lifeztream.debug.FPS.cTime = 0;
      com.lifeztream.debug.FPS.saveTimer = 5;
   }
   static function onEnterFrame()
   {
      com.lifeztream.debug.FPS.timeElapsed = getTimer() - com.lifeztream.debug.FPS.cTime;
      com.lifeztream.debug.FPS.cTime = getTimer();
      com.lifeztream.debug.FPS.count = com.lifeztream.debug.FPS.count + 1;
   }
   static function drawData()
   {
      com.lifeztream.debug.FPS.BITMAP.dispose();
      var _loc4_ = new flash.geom.Matrix();
      _loc4_.translate(com.lifeztream.debug.FPS.BORDER,20);
      com.lifeztream.debug.FPS.BITMAP = new flash.display.BitmapData(com.lifeztream.debug.FPS.WIDTH,com.lifeztream.debug.FPS.HEIGHT,false,4079166);
      com.lifeztream.debug.FPS.BITMAP.draw(new flash.display.BitmapData(com.lifeztream.debug.FPS.WIDTH - com.lifeztream.debug.FPS.BORDER * 2,com.lifeztream.debug.FPS.HEIGHT - com.lifeztream.debug.FPS.BORDER - 20,false,1184274),_loc4_);
      com.lifeztream.debug.FPS.BITMAP.setPixel(com.lifeztream.debug.FPS.BORDER - 1,com.lifeztream.debug.FPS.HEIGHT - com.lifeztream.debug.FPS.BORDER - com.lifeztream.debug.FPS.getPointerHeight(com.lifeztream.debug.FPS.movieFPS),65535);
      var _loc3_ = 0;
      if(com.lifeztream.debug.FPS.log.length > (com.lifeztream.debug.FPS.WIDTH - com.lifeztream.debug.FPS.BORDER * 2) / 2)
      {
         i = com.lifeztream.debug.FPS.log.length - (com.lifeztream.debug.FPS.WIDTH - com.lifeztream.debug.FPS.BORDER * 2) / 2;
      }
      else
      {
         var i = 0;
      }
      i;
      while(i < com.lifeztream.debug.FPS.log.length)
      {
         var _loc2_ = com.lifeztream.debug.FPS.BORDER + _loc3_ * 2;
         if(com.lifeztream.debug.FPS.log[i] > com.lifeztream.debug.FPS.movieFPS * 0.7)
         {
            var _loc1_ = 32256;
         }
         else if(com.lifeztream.debug.FPS.log[i] > com.lifeztream.debug.FPS.movieFPS * 0.5)
         {
            _loc1_ = 16777088;
         }
         else
         {
            _loc1_ = 16711680;
         }
         com.lifeztream.debug.FPS.BITMAP.setPixel(_loc2_,com.lifeztream.debug.FPS.HEIGHT - com.lifeztream.debug.FPS.BORDER - com.lifeztream.debug.FPS.getPointerHeight(com.lifeztream.debug.FPS.log[i]),_loc1_);
         _loc3_ = _loc3_ + 1;
         i++;
      }
      com.lifeztream.debug.FPS.CONTAINER.bitmap.attachBitmap(com.lifeztream.debug.FPS.BITMAP,10);
      com.lifeztream.debug.FPS.TEXTFIELD.text = "FPS : " + com.lifeztream.debug.FPS.currentFPS + ", TE : " + com.lifeztream.debug.FPS.timeElapsed + " ms.,  A : " + com.lifeztream.debug.FPS.averageFPS + ", L : " + com.lifeztream.debug.FPS.lowestFPS + ", H : " + com.lifeztream.debug.FPS.highestFPS;
      if(com.lifeztream.debug.FPS.ALIGN == "left")
      {
         com.lifeztream.debug.FPS.CONTAINER._x = 0;
      }
      else if(com.lifeztream.debug.FPS.ALIGN == "right")
      {
         com.lifeztream.debug.FPS.CONTAINER._x = 1010 - com.lifeztream.debug.FPS.WIDTH;
      }
   }
   static function getPointerHeight(n)
   {
      var _loc1_ = com.lifeztream.debug.FPS.HEIGHT - com.lifeztream.debug.FPS.BORDER - 20;
      var _loc2_ = com.lifeztream.debug.FPS.movieFPS + 10;
      return Math.round(_loc1_ * (n / _loc2_));
   }
   static function createLog()
   {
      if(com.lifeztream.debug.FPS.log.length >= Math.floor(com.lifeztream.debug.FPS.WIDTH - com.lifeztream.debug.FPS.BORDER * 2))
      {
         com.lifeztream.debug.FPS.log.shift();
         com.lifeztream.debug.FPS.log.push(com.lifeztream.debug.FPS.currentFPS);
      }
      else
      {
         com.lifeztream.debug.FPS.log.push(com.lifeztream.debug.FPS.currentFPS);
      }
   }
   static function calcValues()
   {
      if(com.lifeztream.debug.FPS.lowestFPS > com.lifeztream.debug.FPS.currentFPS)
      {
         com.lifeztream.debug.FPS.lowestFPS = com.lifeztream.debug.FPS.currentFPS;
      }
      if(com.lifeztream.debug.FPS.highestFPS < com.lifeztream.debug.FPS.currentFPS)
      {
         com.lifeztream.debug.FPS.highestFPS = com.lifeztream.debug.FPS.currentFPS;
      }
      var _loc2_ = com.lifeztream.debug.FPS.log.length;
      var _loc3_ = 0;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_)
      {
         _loc3_ += com.lifeztream.debug.FPS.log[_loc1_];
         _loc1_ = _loc1_ + 1;
      }
      com.lifeztream.debug.FPS.averageFPS = Math.floor(_loc3_ / _loc2_);
   }
   static function saveData()
   {
      com.lifeztream.debug.FPS.saveTimer--;
      if(com.lifeztream.debug.FPS.saveTimer < 0)
      {
         com.lifeztream.debug.FPS.saveDataFunction();
         com.lifeztream.debug.FPS.saveTimer = 5;
      }
   }
   static function saveDataFunction()
   {
      com.lifeztream.debug.FPS.data.scene = _root.ClusterName + " " + _root.SceneName;
      com.lifeztream.debug.FPS.data.averageFPS = com.lifeztream.debug.FPS.averageFPS;
      com.lifeztream.debug.FPS.data.lowestFPS = com.lifeztream.debug.FPS.lowestFPS;
      com.lifeztream.debug.FPS.data.highestFPS = com.lifeztream.debug.FPS.highestFPS;
      _root.traceSO.flush();
   }
}
