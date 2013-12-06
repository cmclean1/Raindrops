int storyLoc = 2;
int storyDay = 0;
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
  upgrade();
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
      gameRain[i].checkCatcher(storyCatch);
    }
    if (rainTimer.go())
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop());
    }
    storyCatch.display();
    if (gameCatch.checkLightning(gameLight) == false)
    {
      storyCatch.move();
    }
    if (lives >= storyLives)
    {
      gameOver = true;
    }
    gameLight.appear();
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
  lightDown.display();
  catchSpeed.display();
  catchHandle.display();
  catchMagnet.display();
  catchHarvest.display();
  buyShip.display();
  powerUp.display();
  portalGun.display();
  lifeUp.display();
  lowerScreen.display();
  moreUp.display();
  rainSlow.display();
  catchCustom.display();
  noLoss.display();
  fill(0);
  stroke(0, 0, 255);
  rect(390, 440, 100, 50);
  rect(10, 10, 50, 25);
  fill(0, 0, 255);
  textAlign(CENTER);
  textSize(10);
  text("NEXT DAY", 440, 465);
  text("MENU", 25, 25);
  textSize(15);
  text("DAY " + storyDay, 50, 440);
}

