function getUniqueQueryString()
{
   return "";
}
stop();
var queryString = getUniqueQueryString();
var success;
var sPath = LOAD_PATH + "avatar_head.swf" + queryString;
success = loader.loadClip(sPath,avatar.head);
