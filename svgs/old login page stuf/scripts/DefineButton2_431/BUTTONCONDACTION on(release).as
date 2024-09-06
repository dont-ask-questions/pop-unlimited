on(release){
   BallSelected = true;
   MakeBallPop();
   nextFrame();
   _parent._parent.SelectYourGenderClip.gotoAndPlay("ReverseCourse");
   _parent._parent.gender = 0;
   _parent._parent.char.avatar.gender = 0;
   _parent._parent.char.createNewPlayer(0);
   _parent._parent.char.avatar.setParts();
}
