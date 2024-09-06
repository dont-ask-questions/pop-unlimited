textureNum = Math.ceil(Math.random() * texture._totalframes);
texture.gotoAndStop(textureNum);
cardColor = _parent.colors[Math.floor(Math.random() * _parent.colors.length)];
setColor = new Color(shape);
setColor.setRGB(cardColor);
