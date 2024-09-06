function changePart(clip, part, capsPart)
{
   var _loc2_ = gend.toLowerCase();
   if(Key.isDown(17))
   {
      tmpArray = char.avatar["normal" + _loc2_ + part].concat(clip["rad" + _loc2_ + part]);
   }
   else
   {
      tmpArray = char.avatar["normal" + _loc2_ + part];
   }
   i = 0;
   while(i < tmpArray.length)
   {
      if(tmpArray[i] == char.avatar[part + "Frame"])
      {
         tmpPos = i;
      }
      i++;
   }
   tmpPos++;
   if(tmpPos >= tmpArray.length)
   {
      tmpPos = 0;
   }
   char.avatar[part + "Frame"] = tmpArray[tmpPos];
   char.avatar.setParts();
   char.action("pop");
   char.avatar.savePartsToSO();
   NameTagClip.char.avatar[part + "Frame"] = tmpArray[tmpPos];
   NameTagClip.char.avatar.setParts();
}
function changeColor(part, capsPart)
{
   tmpArray = char.avatar["normal" + capsPart + "Colors"];
   i = 0;
   while(i < tmpArray.length)
   {
      if(tmpArray[i] == char.avatar[part + "Color"])
      {
         tmpPos = i;
      }
      i++;
   }
   tmpPos++;
   if(tmpPos >= tmpArray.length)
   {
      tmpPos = 0;
   }
   char.avatar[part + "Color"] = tmpArray[tmpPos];
   NameTagClip.char.avatar[part + "Color"] = tmpArray[tmpPos];
   if(part == "skin")
   {
      rgb = char.avatar.hexToRgb(char.avatar.skinColor);
      red = rgb.red * 0.8;
      green = rgb.green * 0.8;
      blue = rgb.blue * 0.8;
      char.avatar.lineColor = char.avatar.rgbToHex(red,green,blue);
      NameTagClip.char.avatar.lineColor = char.avatar.rgbToHex(red,green,blue);
   }
   char.action("pop");
   char.avatar.savePartsToSO();
   NameTagClip.char.avatar.setParts();
}
function googleMap()
{
   TrackingPixel = "http://notify.maps.poptropica.com/addusertoque.php?t=3&b=poptropica&a=" + NameTagClip.ThisFirstName + "%20" + NameTagClip.ThisLastName;
   getURL("javascript: loadTrackingPixel(\'" + TrackingPixel + "\')","");
}
stop();
if(gender == 0)
{
   gend = "Girl";
}
else
{
   gend = "Boy";
}
_root.CharacterGrade = CharacterGrade;
_root.CharacterGender = CharacterGender;
changeBtns._visible = false;
btnChangeChar.startX = btnChangeChar._x;
btnChangeChar._x = -100;
btnChangeChar.onEnterFrame = function()
{
   if(this._x < this.startX)
   {
      this._x += (this.startX - this._x) / 4;
   }
   else
   {
      delete this.onEnterFrame;
   }
};
btnChangeChar.onRollOver = _root.useArrow;
btnChangeChar.onRelease = function()
{
   this._visible = false;
   changeBtns._alpha = 0;
   changeBtns.startX = changeBtns._x;
   changeBtns._x -= 100;
   changeBtns.ready = false;
   changeBtns._visible = true;
   changeBtns.onEnterFrame = function()
   {
      this._x += (this.startX - this._x) / 4;
      if(this._alpha < 100)
      {
         this._alpha += 5;
      }
      else
      {
         delete this.onEnterFrame;
      }
   };
   if(changed == false)
   {
      changed = true;
      EventToTrack = "ChangeCharacterClicked";
      loadVariablesNum("/brain/track.php?scene=" + _root.SceneName + "&event=" + EventToTrack + "&grade=" + CharacterGrade + "&gender=" + CharacterGender + "&lang=" + _root.CharacterLanguage + "&brain=Poptropica&randomNumber=" + random(10000),0);
   }
};
changeBtns.btnChange.onRollOver = _root.useArrow;
changeBtns.btnChange.onRelease = function()
{
   char.createNewPlayer(gender);
   char.avatar.FunBrain_so.data.age = age;
   char.avatar.FunBrain_so.flush();
   char.avatar.setParts();
   char.action("pop");
   gotoAndStop("card");
   play();
};
changeBtns.btnSkinColor.onRollOver = _root.useArrow;
changeBtns.btnSkinColor.onRelease = function()
{
   changeColor("skin","Skin");
};
changeBtns.btnHair.onRollOver = _root.useArrow;
changeBtns.btnHair.onRelease = function()
{
   changePart(char.avatar.hair,"hair","Hair");
};
changeBtns.btnHairColor.onRollOver = _root.useArrow;
changeBtns.btnHairColor.onRelease = function()
{
   changeColor("hair","Hair");
};
changeBtns.btnEyes.onRollOver = _root.useArrow;
changeBtns.btnEyes.onRelease = function()
{
   if(char.avatar.eyesFrame == 3)
   {
      char.avatar.eyesFrame = 1;
      NameTagClip.char.avatar.eyesFrame = 1;
   }
   else
   {
      char.avatar.eyesFrame = 3;
      NameTagClip.char.avatar.eyesFrame = 3;
   }
   char.avatar.setParts();
   char.action("pop");
   char.avatar.savePartsToSO();
   NameTagClip.char.avatar.setParts();
};
changeBtns.btnMouth.onRollOver = _root.useArrow;
changeBtns.btnMouth.onRelease = function()
{
   changePart(char.avatar.head,"mouth","Mouth");
};
changeBtns.btnShirt.onRollOver = _root.useArrow;
changeBtns.btnShirt.onRelease = function()
{
   changePart(char.avatar.body,"shirt","Shirt");
};
changeBtns.btnPants.onRollOver = _root.useArrow;
changeBtns.btnPants.onRelease = function()
{
   changePart(char.avatar.body,"pants","Pants");
};
NameTagClip.VelocityY = 0;
NameTagClip.Friction = 0.35;
NameTagClip.secsPerStep = 0.95;
NameTagClip.Acceleration = 3;
NameTagClip.Ground = 295;
NameTagClip.InitialY = NameTagClip._y;
NameTagClip.DoneMoving = false;
NameTagClip.onEnterFrame = function()
{
   if(this.DoneMoving != true)
   {
      this._y += this.VelocityY * this.secsPerStep;
      if(this._y > this.Ground)
      {
         changeBtns.ready = true;
         if(this.VelocityY > 7)
         {
            this._y = this.Ground - 1;
            this.VelocityY = (- this.VelocityY) * this.Friction;
         }
         else
         {
            this.VelocityY = 0;
            this._y = this.Ground;
            this.DoneMoving = true;
         }
      }
      else
      {
         this.VelocityY += this.Acceleration * this.secsPerStep;
      }
   }
};
