returningPlayer.btn.onRelease = function()
{
   gotoAndStop("login");
   EventToTrack = "ReturningUserClicked";
   loadVariablesNum("/brain/track.php?scene=" + _root.SceneName + "&event=" + EventToTrack + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000),0);
};
returningPlayer.btn.onRollOver = _root.useArrow;
