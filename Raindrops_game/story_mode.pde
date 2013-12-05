int storyLoc;
void storyMode()
{
  if (storyLoc = 1)
  {
    storyPlay();
  }
  if (storyLoc = 2)
  {
    upGrade();
  }
}
void storyPlay()
{
  textAlign(LEFT);
  textSize(15);
  text("Score: " + score, 420, 50);
  text("Lives: " + (maxLives-lives), 50, 50);
  textSize(10);
  fill(255, 0, 0);
  // text("Press \"P\"  to pause", 10, 20);
  textAlign(RIGHT);
  text("Press \"R\"  to end early", 495, 20);
  if (location == 1)
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
void upGrade()
{
}

