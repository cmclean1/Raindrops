int changeCar;
int whichScore = 1;
boolean goKey = true;
boolean newScore = true;
char[] a = new char[3];
void highscores()
{
  if (newScore)
  {
    textSize(30);
    text("New Highscore!", width/2, height/2+100);
    textSize(15);
    text("Type Initials Here:", width/2, height/2+130);
    fill(255);
    text(inputScore(), width/2, height/2+150);
  }
}
String inputScore()
{
  String yes;
  if (keyPressed && key != CODED && key != ENTER)//keeps non-character letters from being pressed
  {
    if (goKey)
    {
      goKey = false;
      if (changeCar == 0)
      {
        a[0] = key;
      }
      if (changeCar == 1)
      {        
        a[1] = key;
      }
      if (changeCar == 2)
      {        
        a[2] = key;
      }
      changeCar++;
      if (changeCar >2)
      {
        changeCar = 0;
      }
    }
  }
  else
  {
    goKey = true;
  }
  yes = new String(a);
  timeScores[whichScore] = yes;
  timeScores[whichScore-1] = timeScores[whichScore-1].valueOf(score);
  return yes;
}

