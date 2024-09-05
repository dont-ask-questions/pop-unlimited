class com.poptropica.views.FriendsView extends com.poptropica.mvc.AbstractView
{
   var _content_mc;
   var _friends_mc;
   var _model;
   function FriendsView(m, c, target, depth)
   {
      super(m,c);
      com.poptropica.util.Debug.trace("FriendsView::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._content_mc = target.createEmptyMovieClip("friends__content_mc",depth);
      this.make();
      com.poptropica.controllers.PopController(c).setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
   }
   function update(pO, pInfoObj)
   {
      com.poptropica.util.Debug.trace("FriendsView::update() pInfoObj._type",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      var _loc0_ = null;
      if((_loc0_ = pInfoObj._type) !== com.poptropica.models.PopUpdateNotificationTypes.SUBSECTION_CHANGE)
      {
      }
   }
   function make(sName)
   {
      com.poptropica.util.Debug.trace("FriendsView::make()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._friends_mc = this._content_mc.attachMovie("LibFriends","friends_mc",1,{_y:45,_x:14});
   }
   function clear()
   {
      com.poptropica.util.Debug.trace("FriendsView::clear()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._model.removeObserver(this);
   }
}
