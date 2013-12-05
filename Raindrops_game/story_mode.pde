int storyLoc = 1;
int storyDay;
void storyMode()
{
  if (storyLoc == 1)
  {
    if (!gameOver)
    {
      storyPlay();
    }
    else
    {
      storyOver();
    }
  }
  if (storyLoc == 2)
  {
    upGrade();
  }
}
void storyPlay()
{
  textAlign(LEFT);
  textSize(15);
  text("Total: " + totalRain, 420, 50);
  text("Lives: " + (maxLives-lives), 50, 50);
  textSize(10);
  fill(255, 0, 0);
  // text("Press \"P\"  to pause", 10, 20);
  textAlign(RIGHT);
  text("Press \"R\"  to end early", 495, 20);
  if (location == 3)
  {
    for (int i = 0; i < gameRain.length; i++)
    {
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher(gameCatch);
    }
    if (rainTimer.go())
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop());
    }
    gameCatch.display();
    if (gameCatch.checkLightning(gameLight) == false)
    {
      gameCatch.move();
    }
    if (lives >= maxLives)
    {
      gameOver = true;
    }
  }
}
void storyOver()
{
  if (gameOver)
  {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(50);
    text("DAY OVER", width/2, height/2);
    textSize(20);
    text("Press ENTER go to upgrade menu", width/2, height/2+50);// \nPress H to view high scores", width/2, height/2+50);
  }
}
void upGrade()
{
  catchUp.display();
}

