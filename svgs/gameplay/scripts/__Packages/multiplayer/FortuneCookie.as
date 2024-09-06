class multiplayer.FortuneCookie extends multiplayer.MultiUserObject
{
   var mContainer;
   var mLoader;
   var mPosition;
   var mBaseScope;
   var mLeaderUserName;
   var mFortuneText;
   var mObjectClicked = false;
   static var COOKIE_ASSET_PATH = "externalAssets/multiUserObject/fortuneCookie.swf";
   static var POPUP_PATH = "FortuneCookie/fortuneCookie.swf";
   static var TOTAL_CLICKS = 3;
   static var FORTUNES = ["You will see a friend soon.","Creativity is the path to success.","Someone is thinking about you.","Friendship should never be taken for granted.","Helping others is its own reward.","Practice makes perfect.","Coconut milk makes booga sharks happy.","Open more cookies&#44; get more fortunes!","Someone misses you.","Phew! It was getting hot in there.","You will discover a hidden talent.","When times are difficult&#44; you will find strength.","Love is on the rise!","The shortest distance between 2 points is a straight line.","Homework is neither home&#44; nor work. Discuss!","You will succeed in achieving your goals!","An opportunity will present itself soon. Go for it!","Smile! Even an evil genius like Dr. Hare smiles.","A bad start doesn\'t dictate a bad ending.","Time will tell you everything.","No one likes problems. Everyone likes solutions.","Help I am a prisoner in a Fortune Cookie Factory.","Bald is beautiful&#44; just ask ask Director D.","A lotus flower is only as beautiful as the beholder (I have no clue what that means).","Have a nice day! :)","Give a man a fish stick and he\'ll be full for a day&#44; teach a man to buy fish sticks and he\'ll be full for the rest of his life.","Stop and smell the roses&#44; but watch out for thorns.","Your future is only as bright as your today.","Dare to be yourself&#44; and you\'ll be happy.","Popularity shatters. Integrity remains unbroken.","Life is a race&#44; but some of us have better running shoes.","Life is like a raisin.  You shrivel up and get old.","Think of your freckles as a close friend and you will never be alone.","Your future is like honey. It will be sticky at times but very sweet.","Beware of eating dog food. It will give you bad breath.","You will find lots of chewing gum in your future...under your desk.","Look for the good in others and you will see the good in yourself.","Someone secretly admires you and you will never know who.","Help someone when they are low and it will make you feel high.","This fortune cookie is inhabited by a family of ants.","Watch out for a man wearing a yellow hat with a monkey.","When life throws you a punch in the face&#44; duck!","Always take time to smell the chocolate chip cookies.","Beware of Ninjas on bicycles.","This fortune cookie is about 20 years old.  Don\'t eat it.","You shouldn\'t believe everything you read.","Don\'t take advice from someone in a clown suit.","Smile at someone and then see what happens.","If life hands you a lemon&#44; add sugar&#44; cold water&#44; and then sell it at a lemonade stand.","Life is like riding a bicycle so don\'t forget to wear a helmet.","Don\'t waste your time chasing after fruitless dreams.  Instead dream about chasing wasted fruit.","The Obstacle is the Path.","Captain Crawfish will return.","If you keep throwing dirt at others soon you\'ll have no ground to stand on.","A person who is wise&#44; knows they are foolish.","The answers to all your questions can be found within...or on the internet.","Make like a banana and split!","Will you choose to be famous or infamous?","Hazmat Hermit was here!","The Black Widow stole your fortune.","A tough choice lies in your future.","Zeus is watching&#44; so be nice!","Believe in yourself and others will believe in you.","Why would you trust your future to a fortune cookie?","A man who runs behind a car gets exhausted. A man who runs in front of a car gets tired.","Save the planet&#44; recycle this fortune."];
   function FortuneCookie(scope)
   {
      super(scope);
      utils.Logger.log("FortuneCookie :: new FortuneCookie : " + scope,utils.Logger.ALL);
      var _loc3_ = scope.getNextHighestDepth();
      this.mContainer = scope.createEmptyMovieClip("container" + _loc3_,_loc3_);
      this.mLoader = new MovieClipLoader();
      this.mLoader.addListener(this);
      utils.Utils.init();
   }
   function removeObject()
   {
      super.removeObject();
      this.mLoader.removeListener(this);
      this.mLoader = null;
      this.removeContainer();
   }
   function removeContainer()
   {
      this.mContainer.removeMovieClip();
      this.mContainer = null;
   }
   function show()
   {
      this.mLoader.loadClip(multiplayer.FortuneCookie.COOKIE_ASSET_PATH,this.mContainer);
      return this.mContainer;
   }
   function onLoadInit(clip)
   {
      clip._x = this.mPosition.x;
      clip._y = this.mPosition.y - clip._height * 0.5;
      clip.objectClip.art.onPress = Delegate.create(this,this.pressEvent);
      clip.objectClip.art.onRollOver = Delegate.create(this,this.rollOverEvent);
      clip.objectClip.art.onRollOut = clip.objectClip.art.onDragOut = Delegate.create(this,this.rollOutEvent);
      this.setObjectClicks(this.mClickTotal);
      utils.Logger.log("FortuneCookie :: load complete " + clip + " Pos : " + this.mPosition,utils.Logger.ALL);
   }
   function onLoadError(clip)
   {
      utils.Logger.log("FortuneCookie :: load error",utils.Logger.ERROR);
   }
   function showFortune()
   {
      var _loc2_ = this.mBaseScope.camera.scene.char.avatar.FunBrain_so;
      _loc2_.data.MultiUserObject_Leader_Name = this.mLeaderUserName;
      _loc2_.data.MultiUserObject_Fortune = this.mFortuneText;
      _loc2_.flush();
      utils.Utils.addEventListener("PopupLoadComplete",Delegate.create(this,this.fortunePopupLoadedEvent));
      utils.Utils.popup(this.mBaseScope,multiplayer.FortuneCookie.POPUP_PATH,true);
   }
   function getFortune()
   {
      return this.mFortuneText;
   }
   function getRandomFortune()
   {
      return multiplayer.FortuneCookie.FORTUNES[utils.Utils.getRandomNumber(0,multiplayer.FortuneCookie.FORTUNES.length,Math.floor)];
   }
   function fortunePopupLoadedEvent(event)
   {
      super.sendAction(["removeObject"]);
   }
   function objectClicked(total)
   {
      super.objectClicked(total);
      this.setObjectClicks(total);
      if(this.mObjectClicked && multiplayer.FortuneCookie.TOTAL_CLICKS - total <= 0)
      {
         this.showFortune();
      }
   }
   function setObjectClicks(total)
   {
      super.objectClicked(total);
      var _loc3_ = " clicks needed!";
      if(multiplayer.FortuneCookie.TOTAL_CLICKS - total == 1)
      {
         _loc3_ = " click left!";
      }
      this.mContainer.objectClip.label.text = multiplayer.FortuneCookie.TOTAL_CLICKS - total + _loc3_;
   }
   function setFortune(fortune)
   {
      this.mFortuneText = fortune;
   }
   function pressEvent()
   {
      if(!this.mObjectClicked)
      {
         super.sendAction(["objectClicked",this.mClickTotal + 1]);
         this.mObjectClicked = true;
      }
   }
   function rollOverEvent()
   {
      caurina.transitions.Tweener.addTween(this.mContainer,{time:0.75,_xscale:120,_yscale:120,transition:"easeOutElastic"});
      super.setHand();
   }
   function rollOutEvent()
   {
      caurina.transitions.Tweener.addTween(this.mContainer,{time:0.25,_xscale:100,_yscale:100,transition:"linear"});
      super.setArrow();
   }
}
