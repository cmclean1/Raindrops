class Button {
  int y;
  String message;
  int changeLoc;
  int recWidth;
  boolean mode;//mode will decide whether or not the button will lead to a game or not
  Button(int _y, String _message, int _changeLoc, boolean _mode)
  {
    y = _y;
    message = _message;
    changeLoc = _changeLoc;
    recWidth = 85;
    mode = _mode;
  }
  void display()
  {
    textAlign(CENTER);
    noFill();
    rectMode(CENTER);
    stroke(0, 0, 255);
    rect(width/2, y-5, recWidth, 25);
    fill(0, 0, 255);
    if (clicked())//borders will highlight in white if mouse is over the button
    {
      fill(255);
    }
    textSize(15);
    text(message, width/2, y);
  }
  void ifClicked()
  {
    if (clicked())
    {
      location = changeLoc;
      if (mode)//creates starting settings for a game
      {
        score = 0;
        gameCatch = new Catcher(400);
        storyCatch = new Catcher(250);
        timeLeft = 120000;
        startTime = millis();
        totalTimeLeft = millis() + timeLeft;
        while (gameRain.length >= 1)
        {
          gameRain = (Raindrop[]) shorten(gameRain);
        }
        lives = 0;
        player.close();
        player = minim.loadFile("play" + int(random(1,4)) + ".mp3");
        player.loop();
      }
    }
  }
  boolean clicked()
  {
    if (mouseX > width/2-(recWidth/2) && mouseX < width/2+(recWidth/2) && mouseY > (y-5)-(25/2) && mouseY < (y-5)+(25/2))
    { 
      return true;
    }
    else
    {
      return false;
    }
  }
}

