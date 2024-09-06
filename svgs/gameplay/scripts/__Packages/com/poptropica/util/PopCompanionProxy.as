class com.poptropica.util.PopCompanionProxy
{
   var checkingCommands;
   var receiving_lc;
   var connectID;
   var scope;
   var currentIsland;
   var currentScene;
   var clientObj;
   static var instance;
   var listenerObj = new Object();
   var commandCheckerInterval = 200;
   var connectedInterval = 1000;
   function PopCompanionProxy()
   {
      this.checkingCommands = false;
      this.receiving_lc = new LocalConnection();
      this.receiving_lc.allowDomain("*");
      this.receiving_lc.allowInsecureDomain("*");
   }
   static function getInstance()
   {
      if(com.poptropica.util.PopCompanionProxy.instance == undefined)
      {
         com.poptropica.util.PopCompanionProxy.instance = new com.poptropica.util.PopCompanionProxy();
      }
      return com.poptropica.util.PopCompanionProxy.instance;
   }
   function init(_connectID, _scope)
   {
      this.connectID = _connectID;
      this.scope = _scope;
      this.testForPopCom();
   }
   function sendSceneData(island, desc)
   {
      this.currentIsland = island;
      this.currentScene = desc;
      this.proxySend("broadcastRecieve",new Array(island,desc));
      _global.setTimeout(mx.utils.Delegate.create(this,this.broadcastSelf),this.connectedInterval);
   }
   function broadcastSelf()
   {
      this.sendSceneData(this.currentIsland,this.currentScene);
   }
   function proxySend()
   {
      var _loc3_ = arguments.slice(0);
      var _loc4_ = _loc3_.shift();
      this.receiving_lc.send(this.connectID,"proxyReceive",_loc4_,_loc3_);
   }
   function proxyRecieve()
   {
      var _loc3_ = arguments.slice(0);
      var _loc4_ = String(_loc3_.shift());
      this.clientObj[_loc4_].apply(this.clientObj,arguments);
   }
   function reflectScope(scope)
   {
      var _loc4_ = undefined;
      for(var _loc3_ in scope)
      {
         if(typeof scope[_loc3_] == Function)
         {
            _root.trc(_loc3_);
         }
      }
   }
   function testForPopCom()
   {
      var _loc3_ = SharedObject.getLocal("PopCom","/");
      if(_loc3_.data.password)
      {
         this.checkingCommands = true;
         _global.setTimeout(mx.utils.Delegate.create(this,this.checkForCommands),this.commandCheckerInterval);
      }
   }
   function checkForCommands()
   {
      _global.setTimeout(mx.utils.Delegate.create(this,this.checkForCommands),this.commandCheckerInterval);
      var _loc4_ = SharedObject.getLocal("PopCom","/");
      if(_loc4_.data.inject)
      {
         var _loc5_ = undefined;
         for(var _loc6_ in _loc4_.data.inject)
         {
            if(_loc4_.data.inject[_loc6_] != "undefined")
            {
               _loc5_ = _loc4_.data.inject[_loc6_] + " " + _loc5_;
            }
         }
         _root.parseCmd(_loc5_);
      }
      delete _loc4_.data.inject;
   }
}
