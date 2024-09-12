class com.poptropica.sections.quidget.PopQuizModel extends Object
{
   var _quizDataHash;
   static var _instance;
   function PopQuizModel()
   {
      super();
      this._quizDataHash = {};
   }
   static function getInstance()
   {
      if(com.poptropica.sections.quidget.PopQuizModel._instance == undefined)
      {
         com.poptropica.sections.quidget.PopQuizModel._instance = new com.poptropica.sections.quidget.PopQuizModel();
         mx.events.EventDispatcher.initialize(com.poptropica.sections.quidget.PopQuizModel._instance);
      }
      return com.poptropica.sections.quidget.PopQuizModel._instance;
   }
   function dispatchEvent()
   {
   }
   function addEventListener(pEventType, callingObj)
   {
   }
   function removeEventListener(pEventType, callingObj)
   {
   }
   function loadQuizXml(id, xmlPath)
   {
      if(this._quizDataHash[id] != undefined)
      {
         this.dispatchQuizXmlLoaded(id);
      }
      else
      {
         var _loc2_ = new XML();
         _loc2_.ignoreWhite = true;
         _loc2_.onLoad = com.poptropica.util.EventDelegate.create(this,this.onXmlLoaded,_loc2_,id);
         _loc2_.load(xmlPath);
      }
   }
   function onXmlLoaded(o, xml, id)
   {
      o = com.realeyes.util.xml.TranslateXMLtoObj.getInstance().parseToObject(xml);
      this._quizDataHash[id] = o;
      if(o.question != undefined)
      {
         this.dispatchQuizXmlLoaded(id);
      }
      else
      {
         this.dispatchEvent({type:"quizXmlLoadError",id:id});
      }
   }
   function dispatchQuizXmlLoaded(id)
   {
      this.dispatchEvent({type:"quizXmlLoaded",id:id,data:this._quizDataHash[id]});
   }
   function getAnsweredStr(id, answerNum, context)
   {
      var _loc7_ = this._quizDataHash[id];
      if(_loc7_ == undefined)
      {
         return "Loading...";
      }
      var _loc10_ = 1;
      var _loc5_ = "";
      for(var _loc9_ in _loc7_)
      {
      }
      switch(context)
      {
         case "quilt":
            if(_loc7_.result.rolloverSelf == undefined && _loc7_.result.rolloverFriend == undefined)
            {
               _loc5_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? _loc7_.result.friend : _loc7_.result.self;
            }
            else
            {
               _loc5_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? _loc7_.result.rolloverFriend : _loc7_.result.rolloverSelf;
            }
            break;
         case undefined:
         case "":
         case "welcomeBack":
            _loc5_ += _loc7_.result.friend;
      }
      _loc5_ = _loc5_.split("{answer}").join(String(_loc7_.answer[answerNum]));
      _loc5_ = _loc5_.split("{friend}").join(com.poptropica.sections.friendsHub.FriendsModel.getInstance().currentUserAvatarName);
      var _loc4_ = _loc5_.split("[");
      if(_loc4_.length > 1)
      {
         _loc5_ = "";
         var _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            var _loc3_ = _loc4_[_loc2_ + 1].split("]");
            var _loc6_ = _loc3_[0].split(",")[answerNum];
            _loc5_ += String(_loc4_[_loc2_]) + String(_loc6_) + String(_loc3_[1]);
            _loc2_ += 2;
         }
      }
      return _loc5_;
   }
   function getGenericQuestionAnswer(id, answerNum)
   {
      var _loc7_ = this._quizDataHash[id];
      if(_loc7_ == undefined)
      {
         return "Loading...";
      }
      var _loc10_ = _loc7_.question;
      var _loc6_ = "";
      _loc6_ += !com.poptropica.sections.friendsHub.FriendsModel.getInstance().isCurrentUserSelf ? _loc7_.result.friend : _loc7_.result.self;
      _loc6_ = _loc6_.split("{answer}").join(String(_loc7_.answer[answerNum]));
      _loc6_ = _loc6_.split("{friend}").join("Friend - ");
      var _loc4_ = _loc6_.split("[");
      if(_loc4_.length > 1)
      {
         _loc6_ = "";
         var _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            var _loc3_ = _loc4_[_loc2_ + 1].split("]");
            var _loc5_ = _loc3_[0].split(",")[answerNum];
            _loc6_ += String(_loc4_[_loc2_]) + String(_loc5_) + String(_loc3_[1]);
            _loc2_ += 2;
         }
      }
      var _loc9_ = {};
      _loc9_.question = _loc10_;
      _loc9_.answer = _loc6_;
      return _loc9_;
   }
   function get quizDataHash()
   {
      return this._quizDataHash;
   }
}
