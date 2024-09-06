play();
MessageStripClip.play();
char._y = this.CrateClip.CrateLastY + 350;
char._x = Stage.width / 2;
char.vSpeed = -26;
char.avatar.normalSkinColors.push(9321734);
char.airControl = false;
bg._visible = true;
EventToTrack = "NewUserSetupCompleted";
CharacterGrade = age - 5;
if(gender == 0)
{
   CharacterGender = "F";
}
else
{
   CharacterGender = "M";
}
loadVariablesNum("/brain/track.php?scene=" + _root.SceneName + "&event=" + EventToTrack + "&grade=" + CharacterGrade + "&gender=" + CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000),0);
