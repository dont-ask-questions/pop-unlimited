class com.poptropica.controllers.commands.ExtractVariablesFromGameplayCommand extends com.poptropica.controllers.commands.CommandDispatcher
{
   function ExtractVariablesFromGameplayCommand()
   {
      super();
      com.poptropica.util.Debug.trace("ExtractVariablesFromGameplayCommand::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
   function exec()
   {
      com.poptropica.util.Debug.trace("ExtractVariablesFromGameplayCommand::exec()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.models.PopModel.getInstance().camera = _root.gameplay_container_mc.camera;
      com.poptropica.models.PopModel.getInstance().avatar = _root.gameplay_container_mc.camera.scene.char.avatar;
      com.poptropica.models.PopModel.getInstance().roomName = _root.gameplay_container_mc.camera.scene.roomName;
      com.poptropica.models.PopModel.getInstance().db_id = _root.gameplay_container_mc.camera.scene.char.avatar.FunBrain_so.data.dbid;
      var _loc6_ = _root.gameplay_container_mc.camera.scene.char.avatar.loadLogin();
      var _loc5_ = _root.gameplay_container_mc.camera.scene.char.avatar.FunBrain_so.data.password;
      var _loc4_ = _root.gameplay_container_mc.camera.scene.char.avatar.FunBrain_so.data.age;
      var _loc8_ = _loc4_ - 5;
      var _loc3_ = "M";
      if(_root.gameplay_container_mc.camera.scene.char.avatar.FunBrain_so.data.gender == 0)
      {
         _loc3_ = "F";
      }
      var _loc7_ = "en_us";
      var _loc2_ = new com.poptropica.models.vo.PoptropicaUserVO(_loc6_,_loc5_,_loc4_,_loc8_,_loc3_,_loc7_);
      com.poptropica.models.PopModel.getInstance().poptropica_user = _loc2_;
      com.poptropica.util.Debug.trace("-> PopModel.getInstance().poptropica_user ",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.util.Debug.trace("   login=" + _loc2_.login,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.util.Debug.trace("   password_hash=" + _loc2_.password_hash,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.util.Debug.trace("   age=" + _loc2_.age,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.util.Debug.trace("   grade=" + _loc2_.grade,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.util.Debug.trace("   gender=" + _loc2_.gender,com.poptropica.util.Debug.VERBOSE_MESSAGE);
      com.poptropica.util.Debug.trace("   language" + _loc2_.language,com.poptropica.util.Debug.VERBOSE_MESSAGE);
   }
}
