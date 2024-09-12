class com.poptropica.views.home.welcomeBack.QuizTab extends com.poptropica.components.tab.TabBase
{
   var _asset;
   var _unansweredQuizzes;
   var _phpResults;
   var _quizObj;
   var _currentQuizJson;
   var _quizId;
   var friendshubBtn;
   function QuizTab(mc)
   {
      super(mc);
      mx.events.EventDispatcher.initialize(this);
      this._asset.mcNoneLeftMsg._visible = false;
      this._asset.mcNoneLeftMsg.btnVisitProfile.onRelease = Delegate.create(this,this.onVisitProfileClick);
      this._asset.btnClose._visible = false;
      this._unansweredQuizzes = [];
      this.showLoading();
   }
   function init()
   {
      this._asset.tfMsg.text = "";
      this._asset.tfMsg._visible = false;
      this._asset.btnClose.onRelease = Delegate.create(this,this.onCloseBtnRelease);
      com.poptropica.util.CursorViewChanger.getInstance().addElement(this._asset.btnClose,2);
      this.getUserQuidgetPhp();
   }
   function onVisitProfileClick()
   {
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().initialUserLogin = com.poptropica.models.PopModelConst.avatar.FunBrain_so.data.login;
      com.poptropica.controllers.PopController.getInstance().link("pop://friendshub");
   }
   function getUserQuidgetPhp()
   {
      this.showLoading();
      var _loc2_ = new LoadVars();
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().populateLoadVarsBase(_loc2_);
      this._phpResults = new LoadVars();
      this._phpResults.onLoad = Delegate.create(this,this.onGetUserQuidgetPhpComplete);
      var _loc4_ = com.poptropica.sections.friendsHub.FriendsModel.getInstance().serverCallPrefix + "/quidgets/get_user_quidget.php";
      _loc2_.sendAndLoad(_loc4_,this._phpResults,"POST");
      for(var _loc3_ in _loc2_)
      {
         trace("[QuizTab] postVars     " + _loc3_ + ": " + _loc2_[_loc3_]);
      }
   }
   function onGetUserQuidgetPhpComplete(success)
   {
      trace("[QuizTab]onGetUserQuidgetPhpComplete. success:" + success);
      for(var _loc2_ in this._phpResults)
      {
         trace("[QuizTab] phpResults     " + _loc2_ + ": " + this._phpResults[_loc2_]);
      }
      if(success)
      {
         var _loc5_ = new asLib.JSON();
         var _loc4_ = this._phpResults.user_quidget_json;
         _loc4_ = _loc4_.split("\\").join("");
         var _loc3_ = _loc5_.parse(_loc4_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            trace("[QuizTab] id:" + _loc2_ + ": " + _loc3_[_loc2_].id);
            this._unansweredQuizzes.push(_loc3_[_loc2_]);
            _loc2_ = _loc2_ + 1;
         }
         if(this._unansweredQuizzes.length > 0)
         {
            this.loadPopQuiz();
         }
         else
         {
            this.showNoneLeftMessage(true);
         }
      }
   }
   function loadPopQuiz()
   {
      trace("[QuizTab] loadPopQuiz(). _asset.content:" + this._asset.content);
      this._asset.content._alpha = 0;
      this._asset.btnClose._visible = false;
      var _loc3_ = new MovieClipLoader();
      var _loc2_ = {};
      _loc3_.addListener(_loc2_);
      _loc2_.onLoadInit = Delegate.create(this,this.onPopQuizLoadInit);
      _loc3_.loadClip("framework/assets/popquiz/pop_quiz_core_assets.swf",this._asset.content);
      this.showLoading();
   }
   function showLoading()
   {
      this._asset.mcNoneLeftMsg._visible = false;
      this._asset.mcLoadingMsg._visible = true;
   }
   function onPopQuizLoadInit(mc)
   {
      trace("[QuizTab] onPopQuizLoadInit. ");
      if(this._quizObj == undefined)
      {
         this._quizObj = new com.poptropica.sections.quidget.PopQuiz(this._asset);
      }
      this._quizObj.addEventListener("popQuizChoiceMade",Delegate.create(this,this.onPopQuizChoiceMade));
      this._quizObj.addEventListener("ready",Delegate.create(this,this.onPopQuizReady));
      this._quizObj.addEventListener("loadError",Delegate.create(this,this.onPopQuizLoadError));
      this._currentQuizJson = this._unansweredQuizzes[0];
      this._quizObj.quizData = this._currentQuizJson;
      this._quizId = this._currentQuizJson.id;
      var _loc2_ = this._currentQuizJson.xml_path;
      this._quizObj.init("welcomeBack",this._quizId,_loc2_);
      com.poptropica.controllers.PopController.getInstance().track("Friends","Impression","","",false,"WelcomeBack",this._unansweredQuizzes[0].quiz_name);
      if(this._quizObj.isAd())
      {
         com.poptropica.controllers.PopController.getInstance().track(this._currentQuizJson.campaign_name,"Impression","","",false,"WelcomeBack",this._currentQuizJson.quiz_name);
      }
   }
   function onPopQuizReady()
   {
      this._asset.mcLoadingMsg._visible = false;
      this._asset.tfMsg._visible = false;
      this._asset.btnClose._visible = true;
      com.greensock.TweenMax.to(this._asset.content,1,{_alpha:100});
   }
   function onPopQuizLoadError()
   {
      this._asset.mcLoadingMsg._visible = false;
      this._asset.tfMsg._visible = true;
      this._asset.tfMsg.text = "Problem loading quiz " + this._quizId + ".";
      this._asset.btnClose._visible = false;
   }
   function onPopQuizChoiceMade(i)
   {
      trace("[QuizTab] popQuizChoiceMade() navbarmc:" + com.poptropica.models.PopModel.getInstance().navbarMC + "\n friendshubBtn:   " + com.poptropica.models.PopModel.getInstance().navbarMC.friendshubBtn);
      this.friendshubBtn = com.poptropica.models.PopModel.getInstance().navbarMC.friendshubBtn;
      var _loc2_ = new flash.geom.Point(this.friendshubBtn._x + 20,this.friendshubBtn._y + 20);
      this.friendshubBtn._parent.localToGlobal(_loc2_);
      var _loc3_ = this._quizObj.getSolutionIcon();
      _loc3_._parent.globalToLocal(_loc2_);
      com.greensock.TweenMax.to(_loc3_,0.3,{delay:0.9,_x:_loc2_.x - 10,_y:_loc2_.y - 15,_xscale:20,_yscale:20,onComplete:this.onAnimateToNavBarComplete,onCompleteScope:this,onCompleteParams:[_loc3_]});
      com.poptropica.controllers.PopController.getInstance().track("Friends","QuidgetAnswered",this._quizObj.answerStr,"",false,"WelcomeBack",this._currentQuizJson.quiz_name);
      if(this._quizObj.isAd())
      {
         com.poptropica.controllers.PopController.getInstance().track(this._currentQuizJson.campaign_name,"QuidgetAnswered",this._quizObj.answerStr,"",false,"WelcomeBack",this._currentQuizJson.quiz_name);
      }
   }
   function onAnimateToNavBarComplete(quidget)
   {
      trace("[QuizTab] onAnimateToNavBarComplete. this:" + this);
      quidget._visible = false;
      com.greensock.TweenMax.delayedCall(0.1,this.popQuizAnimComplete,null,this);
      com.poptropica.sections.friendsHub.FriendsModel.getInstance().dispatchPopQuizAdded();
   }
   function popQuizAnimComplete()
   {
      trace("[QuizTab] popQuizAnimComplete, this:" + this);
      this.nextPopQuiz();
   }
   function setPopQuizAnswer(i)
   {
      trace("[QuizTab] setPopQuizAnswer:" + i);
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = {};
      _loc2_.addListener(_loc3_);
      _loc3_.onLoadInit = this.popQuizAnsweredClipLoaded;
      var _loc4_ = 0;
      _loc2_.loadClip("../pop_quizzes/pop_quiz_assets_" + _loc4_ + ".swf",this._asset.popQuizQuidget.answeredPopQuizContainer);
   }
   function popQuizAnsweredClipLoaded(mc)
   {
      trace("[QuizTab] popQuizAnswerClipLoaded. &&& _quizId:" + this._quizId);
      var _loc3_ = "popQuiz" + this._quizId + "Answered";
      mc.attachMovie(_loc3_,"popQuizAnswered",100);
      mc.popQuizAnswered.gotoAndStop(this._asset.popQuizQuidget.answer + 1);
      mc._visible = false;
   }
   function isQuizLeftToShow()
   {
      return this._unansweredQuizzes.length > 0;
   }
   function nextPopQuiz()
   {
      this._unansweredQuizzes.splice(0,1);
      this._asset.tfMsg._visible = false;
      if(this.isQuizLeftToShow())
      {
         this._asset.mcNoneLeftMsg._visible = false;
         this.loadPopQuiz();
      }
      else
      {
         this.showNoneLeftMessage(false);
      }
      this._asset.content._alpha = 0;
      this._asset.btnClose._visible = false;
   }
   function showNoneLeftMessage(firstLoad)
   {
      trace("[QuizTab] showNoneLeftMessage");
      this._asset.mcNoneLeftMsg._visible = true;
      this._asset.mcLoadingMsg._visible = false;
      this._asset.btnClose._visible = false;
      if(firstLoad)
      {
         this.dispatchEvent({type:"NO_QUIZZES_FIRSTLOAD",target:this});
      }
      else
      {
         this.dispatchEvent({type:"NO_QUIZZES",target:this});
      }
   }
   function onCloseBtnRelease()
   {
      trace("[QuizTab] onCloseBtnRelease");
      this._quizObj.submitAnswer(-1);
      this._asset.tfMsg._visible = true;
      this._asset.tfMsg.text = "Skipping this quiz...";
      this._asset.content._visible = false;
      this._asset.btnClose._visible = false;
   }
}
