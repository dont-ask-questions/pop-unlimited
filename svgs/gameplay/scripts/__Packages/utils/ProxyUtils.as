class utils.ProxyUtils
{
   function ProxyUtils()
   {
   }
   static function convertEventToServerFormat(event, island)
   {
      return island.toLowerCase() + "_" + event;
   }
   static function convertIslandToAS2Format(island)
   {
      trace("Proxy Utils : converting island to as2 format : " + island);
      if(island.indexOf("_as3") > -1)
      {
         island = island.slice(0,island.length - 4);
      }
      var _loc2_ = island.substr(0,1).toUpperCase() + island.substr(1);
      trace("Proxy Utils : converted island name to : " + _loc2_);
      return _loc2_;
   }
   static function convertIslandToServerFormat(island)
   {
      return island.substr(0,1).toUpperCase() + island.substr(1) + "_as3";
   }
   static function getSceneClassName(scene, island)
   {
      return "game.scenes." + island + "." + scene + "." + (scene.substr(0,1).toUpperCase() + island.substr(1));
   }
   static function getIslandFromAS3Scene(qualifiedSceneName)
   {
      var _loc1_ = qualifiedSceneName.split(".");
      return utils.ProxyUtils.convertIslandToAS2Format(_loc1_[2]);
   }
}
