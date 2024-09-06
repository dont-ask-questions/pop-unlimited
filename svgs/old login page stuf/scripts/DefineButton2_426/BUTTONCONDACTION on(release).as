on(release){
   BallSelected = true;
   MakeBallPop();
   nextFrame();
   _parent._parent.SelectYourGenderClip.gotoAndPlay("ReverseCourse");
   _parent._parent.gender = 1;
   _parent._parent.char.createNewPlayer(1);
   _parent._parent.char.avatar.setParts();
}
