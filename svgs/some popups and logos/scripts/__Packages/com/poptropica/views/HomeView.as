class com.poptropica.views.HomeView extends com.poptropica.mvc.AbstractView
{
   var _content_mc;
   var _currentSubSectionName;
   var _subView;
   var _model;
   var _controller;
   var _nav_mc;
   static var sectionNames = ["welcome_back","profile"];
   function HomeView(m, c, target, depth)
   {
      super(m,c);
      com.poptropica.util.Debug.trace("HomeView::()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._content_mc = target.createEmptyMovieClip("home__content_mc",depth);
      this.makeNav(this._content_mc,0);
      var _loc3_ = com.poptropica.views.HomeView.sectionNames[0];
      this.setSubSectionView(_loc3_);
      this.updateNavBar(_loc3_);
      com.poptropica.controllers.PopController(c).setSectionStatus(com.poptropica.sections.SectionStatus.SECTION_READY);
   }
   function update(pO, pInfoObj)
   {
      com.poptropica.util.Debug.trace("HomeView::update() pInfoObj._type",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      switch(pInfoObj._type)
      {
         case com.poptropica.models.PopUpdateNotificationTypes.SUBSECTION_CHANGE:
            var _loc3_ = String(pInfoObj._data);
            this.updateNavBar(_loc3_);
            this.removeSubSectionView();
            this.setSubSectionView(_loc3_);
            break;
         case com.poptropica.models.PopUpdateNotificationTypes.SET_PATH:
            var _loc2_ = String(pInfoObj._data).split("/");
            if(_loc2_[0] == "dailypop" && this._currentSubSectionName != _loc2_[1])
            {
               this.updateNavBar(_loc2_[1]);
               this.removeSubSectionView();
               this.setSubSectionView(_loc2_[1]);
            }
      }
   }
   function setSubSectionView(pSName)
   {
      com.poptropica.util.Debug.trace("HomeView::setSubSectionView()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      switch(pSName)
      {
         case "welcome_back":
            this._subView = new com.poptropica.views.home.WelcomeBackView(this._model,this._controller,this._content_mc,1);
            break;
         case "profile":
            break;
         default:
            this._subView = new com.poptropica.views.home.WelcomeBackView(this._model,this._controller,this._content_mc,1);
      }
      this._currentSubSectionName = pSName;
   }
   function updateNavBar(sName)
   {
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      _loc3_ = 0;
      while(_loc3_ < com.poptropica.views.HomeView.sectionNames.length)
      {
         _loc2_ = this._nav_mc["nav" + _loc3_];
         if(com.poptropica.views.HomeView.sectionNames[_loc3_] == sName)
         {
            _loc2_.selected = true;
            _loc2_.gotoAndStop(2);
         }
         else
         {
            _loc2_.selected = false;
            _loc2_.enabled = true;
            _loc2_.gotoAndStop(1);
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function removeSubSectionView()
   {
      com.poptropica.util.Debug.trace("HomeView::removeSubSectionView()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      if(this._subView != undefined)
      {
         this._subView.clear();
         delete this._subView;
      }
   }
   function makeNav(target, depth)
   {
      com.poptropica.util.Debug.trace("HomeView::makeNav()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this._nav_mc = target.attachMovie("LibSubNav","store__nav_mc",depth,{_x:10,_y:10});
      this._nav_mc.nav0.onRelease = com.poptropica.util.EventDelegate.create(this,this.itemClick,0);
      this._nav_mc.nav1.onRelease = com.poptropica.util.EventDelegate.create(this,this.itemClick,1);
      this._nav_mc.nav0.onRollOver = this._nav_mc.nav0.onDragOver = com.poptropica.util.EventDelegate.create(this,this.navItemRollOver,this._nav_mc.nav0);
      this._nav_mc.nav1.onRollOver = this._nav_mc.nav1.onDragOver = com.poptropica.util.EventDelegate.create(this,this.navItemRollOver,this._nav_mc.nav1);
      this._nav_mc.nav0.onRollOut = this._nav_mc.nav0.onDragOut = this._nav_mc.nav0.onReleaseOutside = com.poptropica.util.EventDelegate.create(this,this.navItemRollOut,this._nav_mc.nav0);
      this._nav_mc.nav1.onRollOut = this._nav_mc.nav1.onDragOut = this._nav_mc.nav1.onReleaseOutside = com.poptropica.util.EventDelegate.create(this,this.navItemRollOut,this._nav_mc.nav1);
   }
   function itemClick(index)
   {
      if(index == 1)
      {
         var _loc4_ = com.poptropica.models.PopModel.getInstance().getCampaignName();
         var _loc3_ = com.poptropica.events.trackEvents.WelcomeEvent.EVENT_NAME;
         var _loc2_ = com.poptropica.events.trackEvents.WelcomeEvent.PROFILE_TAB_CLICKED;
         com.poptropica.controllers.PopController.getInstance().track(_loc4_,_loc3_,_loc2_);
      }
      com.poptropica.controllers.PopController(this._controller).setSubSection(com.poptropica.views.HomeView.sectionNames[index]);
   }
   function clear()
   {
      com.poptropica.util.Debug.trace("HomeView::clear()",com.poptropica.util.Debug.VERBOSE_MESSAGE);
      this.removeSubSectionView();
      this._model.removeObserver(this);
      this._nav_mc.removeMovieClip();
   }
   function navItemRollOver(item)
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("click");
      if(item.selected)
      {
         return undefined;
      }
      item.gotoAndStop(2);
   }
   function navItemRollOut(item)
   {
      com.poptropica.controllers.PopController.getInstance().setPointerDisplay("arrow");
      if(item.selected)
      {
         return undefined;
      }
      item.gotoAndStop(1);
   }
}
