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
  if (storyLoc == 3)
  {
    customize();
  }
}
void storyPlay()//day will end if lives are lost
{
  upgrade();
  textAlign(LEFT);
  textSize(15);
  text("Total: " + totalRain, 420, 50);
  text("Lives: " + (storyLives-lives), 50, 50);
  textSize(10);
  fill(255, 0, 0);
  textAlign(RIGHT);

  text("Press \"R\"  to end early", 495, 20);
  if (location == 3)
  {
    for (int i = 0; i < gameRain.length; i++)
    {
      gameRain[i].decideIfRefined();
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher();
    }
    if (rainTimer.go())
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop(storyCatch));
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
    text("Press ENTER go to upgrade menu", width/2, height/2+50);
  }
}
void upGrade()
{
  catchUp.display();
  lightDown.display();
  catchSpeed.display();
  catchHandle.display();
  portalGun.display();
  lifeUp.display();
  lowerScreen.display();
  rainUp.display();
  catchCustom.display();
  noLoss.display();
  //these upgrades don't work yet
  //catchMagnet.display();
  catchHarvest.display();
  buyShip.display();
  //powerUp.display();
  //moreUp.display();
  fill(0);
  stroke(0, 0, 255);
  rect(390, 440, 100, 50);
  rect(10, 10, 50, 25);
  rect(430, 10, 50, 25);
  if (catchCustom.bought >= 1)//display customization button if the upgrade was bought
  {
    rect(50, 450, 80, 40);
  }
  fill(0, 0, 255);
  textAlign(CENTER);
  textSize(10);
  text("NEXT DAY", 440, 465);
  text("MENU", 25, 25);
  text("RESET", 450, 25);
  if (catchCustom.bought >= 1)
  {
    text("CUSTIMIZATION", 90, 475);
  }
  textSize(15);
  text("DAY " + storyDay, 50, 440);
  if (buyShip.bought == 10)
  {
    winStory();
  }
}
void customize()
{
  textSize(10);
  fill(0);
  stroke(0, 0, 255);
  rect(10, 10, 50, 25);
  fill(0, 0, 255);
  text("BACK", 25, 25);
  textSize(15);
  fill(catcherColor[catcherWhich]);
  noStroke();
  ellipse(width/3, height/2, 50, 50);
  text(catcherName[catcherWhich] + " Catcher", width/3, height/2+50);
  fill(rainColor[rainWhich]);
  text(rainName[rainWhich] + " Rain", width-(width/3), height/2+50);
  ellipse(width-(width/3), height/2+10, 30, 30);
  triangle(width-(width/3)-15, height/2+10, width-(width/3)+15, height/2+10, width-(width/3), height/2-30);
  fill(255);
  text("A <", width/3-50, height/2+10);
  text("> D", width/3+50, height/2+10);
  text("J <", width-(width/3)-50, height/2+10);
  text("> L", width-(width/3)+50, height/2+10);
}
void winStory()
{
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(20);
  text("You Win! It took you " + storyDay + " days to win!", width/2, height/2);
  textSize(15);
  text("Press enter to go back to main menu", width/2, height/2+20);
}

