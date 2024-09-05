class com.poptropica.models.LSOManager
{
   var _characterSO;
   var _settingsSO;
   static var instance;
   function LSOManager()
   {
      com.poptropica.util.Debug.trace("LSOManager::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._characterSO = SharedObject.getLocal("Char","/");
      this._settingsSO = SharedObject.getLocal("settings","/");
   }
   static function getInstance()
   {
      if(com.poptropica.models.LSOManager.instance == undefined)
      {
         com.poptropica.models.LSOManager.instance = new com.poptropica.models.LSOManager();
      }
      return com.poptropica.models.LSOManager.instance;
   }
   function getPrefix()
   {
      com.poptropica.util.Debug.trace("LSOManager::getPrefix()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = String(this._settingsSO.data.Prefix);
      return _loc2_;
   }
   function getLastPrefixUpdate()
   {
      com.poptropica.util.Debug.trace("LSOManager::getLastPrefixUpdate()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = Date(this._settingsSO.data.lastPrefixUpdate);
      return _loc2_;
   }
   function setPrefix(pStr)
   {
      this._settingsSO.data.Prefix = pStr;
      this.checkLSOStoreResult(this._settingsSO.flush(),"setPrefix");
   }
   function setLastPrefixUpdate(pDt)
   {
      this._settingsSO.data.lastPrefixUpdate = pDt;
      this.checkLSOStoreResult(this._settingsSO.flush(),"setLastPrefixUpdate");
   }
   function getIsRegistered()
   {
      com.poptropica.util.Debug.trace("LSOManager::getIsRegistered()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = Boolean(this._characterSO.data.Registred);
      if(_loc2_ == null || _loc2_ == undefined)
      {
         _loc2_ = false;
      }
      return _loc2_;
   }
   function getCredits()
   {
      com.poptropica.util.Debug.trace("LSOManager::getCredits()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = this._characterSO.data.credits;
      if(Number(_loc2_) == NaN || _loc2_ == null || _loc2_ == undefined)
      {
         _loc2_ = 0;
      }
      return _loc2_;
   }
   function incrementCredits(pCredits)
   {
      var _loc2_ = Number(this.getCredits());
      _loc2_ += Number(pCredits);
      this._characterSO.data.credits = String(_loc2_);
      this.checkLSOStoreResult(this._characterSO.flush(),"IncrementCredits");
   }
   function setCredits(pCredits)
   {
      this._characterSO.credits = pCredits;
      this.checkLSOStoreResult(this._characterSO.flush(),"SaveCredits");
   }
   function checkLSOStoreResult(result, type)
   {
      if(result != true)
      {
         trace("LSO write failed for part save - type : " + type + " , result : " + result);
      }
   }
}
