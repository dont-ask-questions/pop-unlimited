class com.poptropica.models.PopAppStates
{
   static var INIT = "init";
   static var RETURN_USER_STANDARD = "return_user_standard";
   static var RETURN_USER_AD_1 = "return_user_advertisement_1";
   static var state_gameplay_dimensions = [{state:com.poptropica.models.PopAppStates.INIT,width:800,height:480},{state:com.poptropica.models.PopAppStates.RETURN_USER_STANDARD,width:640,height:480},{state:com.poptropica.models.PopAppStates.RETURN_USER_AD_1,width:776,height:480}];
   static var state_gameplay_positioning = [{state:com.poptropica.models.PopAppStates.INIT,x:0,y:0},{state:com.poptropica.models.PopAppStates.RETURN_USER_STANDARD,x:249,y:102},{state:com.poptropica.models.PopAppStates.RETURN_USER_AD_1,x:0,y:0}];
   function PopAppStates()
   {
   }
   static function getDimensionsFromState(pState)
   {
      com.poptropica.util.Debug.trace("PopAppStates::getDimensionsFromState() pState=" + pState,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = com.poptropica.models.PopAppStates.state_gameplay_dimensions;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         if(_loc2_[_loc1_].state == pState)
         {
            return {width:_loc2_[_loc1_].width,height:_loc2_[_loc1_].height};
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
   static function getPositioningFromState(pState)
   {
      com.poptropica.util.Debug.trace("PopAppStates::getPositioningFromState() pState=" + pState,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc2_ = com.poptropica.models.PopAppStates.state_gameplay_positioning;
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         if(_loc2_[_loc1_].state == pState)
         {
            return {x:_loc2_[_loc1_].x,y:_loc2_[_loc1_].y};
         }
         _loc1_ = _loc1_ + 1;
      }
      return null;
   }
}
