class Button {
  int y;
  String message;
  int changeLoc;
  int recWidth;
  boolean mode;
  Button(int _y, String _message, int _changeLoc)
  {
    y = _y;
    message = _message;
    changeLoc = _changeLoc;
    recWidth = 85;
    mode = true;
  }
  Button(int _y, String _message, int _changeLoc, boolean _mode)
  {
    y = _y;
    message = _message;
    changeLoc = _changeLoc;
    recWidth = 85;
    mode = false;
  }
  void display()
  {
    textAlign(CENTER);
    noFill();
    rectMode(CENTER);
    stroke(0, 0, 255);
    rect(width/2, y-5, recWidth, 25);
    fill(0, 0, 255);
    if (clicked())
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
      if (mode)
      {
        score = 0;
        gameCatch = new Catcher();
        timeLeft = 120000;
        startTime = millis();
        totalTimeLeft = millis() + timeLeft;
        while (gameRain.length >= 1)
        {
          gameRain = (Raindrop[]) shorten(gameRain);
        }
        lives = 0;
        player.close();
        player = minim.loadFile("play.mp3");
        player.play();
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

