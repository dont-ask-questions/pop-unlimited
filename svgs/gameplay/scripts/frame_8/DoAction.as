function onPartialRegComplete(success)
{
   trace("[frame8.as] onPartialRegComplete");
   if(success)
   {
      trace("[frame8.as] _phpResults.login: " + _phpResults.login);
      lso.data.login = _phpResults.login;
      lso.flush();
      loadUserLocation();
   }
}
function loadUserLocation()
{
   var _loc4_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/get_user_location.php";
   trace("[frame8.as] loadLocation() url: " + _loc4_);
   _loadUserResultVars = new LoadVars();
   _loadUserResultVars.onLoad = Delegate.create(this,onLocationLoaded);
   if(com.poptropica.models.PopModel.getInstance().isPartiallyRegistered)
   {
      _loadUserResultVars.user_location_json = "{\"country_code\":\"-1\",\"state_code\":-1}";
      onLocationLoaded();
   }
   else
   {
      var _loc2_ = new LoadVars();
      _loc2_.login = lso.data.login;
      _loc2_.pass_hash = lso.data.password;
      _loc2_.dbid = lso.data.dbid;
      for(var _loc3_ in _loc2_)
      {
         trace("[frame8.as] " + _loc3_ + " : " + _loc2_[_loc3_]);
      }
      _loc2_.sendAndLoad(_loc4_,_loadUserResultVars,"POST");
   }
}
function onLocationLoaded()
{
   var _loc4_ = _loadUserResultVars.user_location_json;
   trace("[frame8.as] onLocationLoaded() jstr:" + _loc4_);
   var _loc2_ = jsonLib.parse(_loc4_);
   for(var _loc3_ in _loc2_)
   {
      trace("[frame8.as] onLocationLoaded:        " + _loc3_ + " :" + _loc2_[_loc3_]);
   }
   lso.data.countryCode = _loc2_.country_code;
   lso.data.stateCode = _loc2_.state_code;
   lso.flush();
   errorTimer = setInterval(this,"showErrorMessage",errorInterval);
   Connect();
}
stop();
logWWW("***gameplay frame 8");
var _phpResults;
var lso = SharedObject.getLocal("Char","/");
if(false)
{
   trace("[frame8.as] PopModel.getInstance().isRegistered:" + com.poptropica.models.PopModel.getInstance().isRegistered);
   if(com.poptropica.models.PopModel.getInstance().isRegistered || com.poptropica.models.PopModel.getInstance().isPartiallyRegistered)
   {
      loadUserLocation();
   }
   else
   {
      var postVars = new LoadVars();
      _phpResults = new LoadVars();
      _phpResults.onLoad = Delegate.create(this,onPartialRegComplete);
      var url = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/part-register.php";
      postVars.fname = lso.data.firstName;
      postVars.lname = lso.data.lastName;
      postVars.look = camera.scene.char.avatar.loadLook();
      postVars.age = lso.data.age;
      postVars.gender = lso.data.gender != 1 ? "F" : "M";
      postVars.sendAndLoad(url,_phpResults,"POST");
      trace("[frame8.as]  ------------------/part-register.php ----------------");
      for(var i in postVars)
      {
         trace("[frame8.as]  " + i + " : " + postVars[i]);
      }
   }
}
else
{
   play();
}
