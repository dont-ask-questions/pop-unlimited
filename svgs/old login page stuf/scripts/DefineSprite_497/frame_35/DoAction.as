newPlayer.btn.onRelease = function()
{
   gotoAndStop("new");
   EventToTrack = "NewUserClicked";
   loadVariablesNum("/brain/track.php?scene=" + _root.SceneName + "&event=" + EventToTrack + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000),0);
};
newPlayer.btn.onRollOver = _root.useArrow;
