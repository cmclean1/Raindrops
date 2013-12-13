//imports stuff for sound
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
//one raindrop array for the menu, and one for the actual game
Raindrop[] r;
Raindrop[] gameRain;
// variables needed for music and sound effects
Minim minim; //music
AudioPlayer player;
Minim rainminim;//rain effect
AudioPlayer rain;
Minim lightminim;//lightning effect
AudioPlayer lightPlayer;
Minim gunminim;//gun shot effect
AudioPlayer gunPlayer;

Button storyMode, timeAttack, survival, credits, back;
//one catcher for the menu, one for survival/time attack mode, and one for story mode
Catcher c, gameCatch, storyCatch;
//lightning for menu, survival/time attack and story mode
Lightning menulight, gameLight, storyLight;
//timer for falling rain
Timer rainTimer;
Upgrade catchUp, lightDown, catchSpeed, catchHandle, buyShip, catchMagnet, powerUp, lifeUp, catchHarvest, portalGun, lowerScreen, moreUp, rainUp, catchCustom, noLoss;
int score;
PFont  font;
int lives;
int maxLives = 10;
int storyLives = 10;
int introTime;
int whichIntro = 0;
int location = -2;
int timeLeft;
int startTime;
int totalRain;
int totalTimeLeft;
String[] loadStory;
String saveStory;
boolean paused = false;
boolean gameOver = false;
String[] introString = {
  "You are the fate of the world", "You don't remember much", "but only one word rings through your head:"
};
//arrays and variables for catcher/raindrop color customization
color[]   catcherColor = {
  color(255), color(0, 0, 255), color(0, 255, 0), color(255, 0, 0), color(20), color(255, 5), color(245, 185, 234)
};
;
color[] rainColor = {
  color(0, 0, 255), color(255), color(0, 255, 0), color(255, 0, 0), color(20), color(0, 0, 255, 50), color(100, 73, 18)
};
String[] catcherName = {
  "White", "Blue", "Green", "Red", "Dark", "Ghost", "Fabulous"
};
int catcherWhich = 0;
int rainWhich = 0;
String[] rainName= {
  "Normal", "Pure", "Slime", "Blood", "Dark", "Transparent", "Dirty"
};
void setup()
{
  font = loadFont("Gabriola-48.vlw");
 // textFont(font);
  size(500, 500);
  //load numbers from text file
  loadStory = loadStrings("story.txt");
  //numbers from text file can be accessed like this:
  totalRain = int(loadStory[15]);
  storyDay = int(loadStory[16]);

  r = new Raindrop[1];
  c = new Catcher(400);
  r[0] = new Raindrop();
  gameRain = new Raindrop[1];
  gameCatch = new Catcher(400);
  storyCatch = new Catcher(250);
  gameRain[0] = new Raindrop();
  menulight = new Lightning(500);
  gameLight = new Lightning(5000);
  storyLight = new Lightning(5000);
  storyMode = new Button(width/2+30, "Story Mode", 3, true);
  timeAttack = new Button(width/2+60, "Time Attack", 2, true);
  survival = new Button(width/2+90, "Survival", 1, true);
  credits = new Button(width/2+120, "Credits", 4, false);
  back = new Button(width/2, "Back", 0, false);
  catchUp = new Upgrade(0, 0, 5, 10, 2, "Bigger Catcher", 0); 
  catchSpeed = new Upgrade(0, 75, 10, 10, 2, "Max Speed", 1); 
  catchHandle = new Upgrade(0, 150, 10, 10, 2, "Acceleation", 2); 
  lowerScreen = new Upgrade(0, 225, 10, 10, 2, "Lower Position", 10); 
  catchCustom = new Upgrade(0, 300, 1, 10, 2, "Customize Catcher", 13);

  rainUp = new Upgrade(150, 5, 5, 10, 2, "Bigger Drops", 12); 
  lightDown = new Upgrade(150, 75, 5, 10, 2, "Less Lighting", 3); 
  catchMagnet = new Upgrade(150, 150, 5, 10, 2, "Attractive Catcher", 5); 
  catchHarvest = new Upgrade(150, 225, 5, 10, 2, "Raindrop Refine", 8); 
  lifeUp = new Upgrade(150, 300, 5, 10, 2, "More Lives", 8); 

  powerUp = new Upgrade(300, 5, 1, 10, 2, "Power Ups", 6);
  moreUp = new Upgrade(300, 75, 5, 10, 2, "Power Up Frequency", 11); 
  noLoss = new Upgrade(300, 150, 7, 10, 2, "Chance to keep Life", 14); 
  portalGun = new Upgrade(300, 225, 1, 10, 15, "Portals", 9); 
  buyShip = new Upgrade(300, 300, 10, 10, 2, "Ship Part", 4);

  rainTimer = new Timer(2000);
  minim = new Minim(this);
  rainminim = new Minim(this);
  gunminim = new Minim(this);
  player = minim.loadFile("Water.wav");
  rain = rainminim.loadFile("rain.mp3");
  lightminim = new Minim(this);
  lightPlayer = lightminim.loadFile("blast.wav");
  gunPlayer = gunminim.loadFile("gun.mp3");
}
//shows logo for 5 seconds then goes to intro
void Logo()
{
  if (millis() < 5000)
  {
    gunPlayer.play();
    imageMode(CENTER);
    image(loadImage("logo.png"), width/2, height/2);
  }
  else
  {
    location = -1;    
    introTime = millis()+4000;
    rain.setGain(-15);
    rain.loop();
  }
}
//plays intro then goes to menu screen
void intro()
{
  if (whichIntro <=2)
  {
    textSize(20);
    fill(255);
    text(introString[whichIntro], 10, 50);
  }
  if (millis() >= introTime)
  {
    introTime+=4000;
    whichIntro++;
  }
  if (whichIntro > 2)
  {
    textAlign(CENTER);
    textSize(40);
    fill(0, 0, 255);
    text("WATER", width/2, height/2);
  }
  if (whichIntro >3)
  {
    location = 0;    
    player.setGain(0);
    player.loop();
  }
}

void draw()
{
  //creates the effect of a transparent background
  fill(0, 50);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, height);
  if (location == -2)//I put Logo() and Intro() last and didn't feel like changing location to all positive numbers, not that it matters
  {
    Logo();
  }
  if (location == -1)
  {
    intro();
  }
  if (location == 4 || location == 0)
  {
    for (int i = 0; i < r.length; i++)
    {
      r[i].display();
      r[i].move();
      r[i].checkCatcher(c);
    }
    if (rainTimer.go())
    {
      r = (Raindrop[]) append(r, new Raindrop());
    }
    c.display();
    c.autoMove(r);
  }
  fill(255);
  if (location == 0)
  {
    textSize(40);
    fill(0, 0, 255);
    textAlign(CENTER);
    text("WATER", width/2, height/2);
    storyMode.display();
    timeAttack.display();
    survival.display();
    credits.display();
    menulight.appear();
  }
  if (location == 4)
  {
    back.display();
    textSize(15);
    fill(0, 0, 255);
    textAlign(CORNER);
    text("Coding: Clayton McLean \nMusic: Clayton Mclean \nSound Effects: The Internet \nArt: Clayton McLean \nDesign: Clayton McLean \nProduced By: Clayton McLean \nSpecial Thanks to: Creators of Processing and Jesus and Jah \nAnything and Everything else: Clayton McLean", 15, 25);
  }
  if (location == 1)
  {
    textAlign(LEFT);
    textSize(15);
    text("Score: " + score, 420, 50);
    if (!gameOver)
    {
      gameLight.appear();
      surviveMode();
    }
    else
    {
      gameOver();
    }
  }
  if (location == 2)
  {
    textAlign(LEFT);
    textSize(15);
    text("Score: " + score, 420, 50);
    if (!gameOver)
    {
      gameLight.appear();
      timeMode();
    }
    else
    {
      gameOver();
    }
  }
  if (location == 3)
  {
    storyMode();
  }
  textAlign(CENTER);
  textSize(20);
  println(displayRefine);
  if (displayRefine && millis() < refineTime+2000)
  {
    text(powerText, width/2, height/2);
  }
  else
  {
    displayRefine = false;
  }
  //the following will be used for powerups when they actually work
  /*
  textAlign(CENTER);
   textSize(20);
   println(displayPower);
   if (displayPower && millis() < powerTime+2000)
   {
   text(powerText, width/2, height/2);
   }
   else
   {
   displayPower = false;
   }*/
}
//necessary to stop sound files from playing
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
void gameOver()
{
  if (gameOver)
  {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(50);
    text("GAME OVER", width/2, height/2);
    textSize(20);
    text("Press ENTER to return to menu", width/2, height/2+50);
  }
}
void timeMode()//game over will happen when 120 seconds are up
{
  textAlign(LEFT);
  textSize(15);
  text("Time: " + int(timeLeft/1000+1), 50, 50);
  textSize(10);
  fill(255, 0, 0);
  textAlign(RIGHT);
  text("Press \"R\"  to end early", 495, 20);
  if (location == 2)
  {
    for (int i = 0; i < gameRain.length; i++)
    {
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher(gameCatch);
    }
    if (rainTimer.go())//add another raindrop to the array every 2 seconds
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop());
    }
    gameCatch.display();
    if (gameCatch.checkLightning(gameLight) == false)//catcher will only move 
    {
      gameCatch.move();
    }    
    timeLeft = totalTimeLeft-millis();
    if (timeLeft <= 0)
    {
      gameOver = true;
    }
  }
}
void surviveMode()//ten lives, game over will happen if all lives are lost
{
  textAlign(LEFT);
  textSize(15);
  text("Score: " + score, 420, 50);
  text("Lives: " + (maxLives-lives), 50, 50);
  textSize(10);
  fill(255, 0, 0);
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
    if (rainTimer.go())//add another raindrop to the array every 2 seconds
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
void keyPressed()
{
  if (location == 1 || location == 2 || location == 3)
  {
    if (keyCode == ENTER)//returns to menu screen or upprade menu if on story mode
    {
      if (lives >= maxLives || timeLeft <= 0)
      {
        if (location == 1 || location == 2)
        {
          location = 0;
        }
        if (location == 3)
        {
          //story mode is automatically saved onto story.txt every time a day ends
          storyLoc = 2;
          storyDay++;
          saveStory =   catchUp.bought + "," + catchSpeed.bought + "," + catchHandle.bought + "," + lightDown.bought + "," + buyShip.bought+ "," + catchMagnet.bought+ "," + powerUp.bought+ "," + lifeUp.bought+ "," + catchHarvest.bought+ "," + portalGun.bought+ "," + lowerScreen.bought+ "," + moreUp.bought+ "," + rainUp.bought+ "," + catchCustom.bought+ "," + noLoss.bought + "," + totalRain + "," + storyDay ;
          String[] save = split(saveStory, ",");
          saveStrings("story.txt", save);
        }
        c = new Catcher(400);//resets menu screen and restarts menu music
        r = new Raindrop[1];
        r[0] = new Raindrop();
        player.close();//resets music
        player = minim.loadFile("Water.wav");
        player.play();
        rainTimer.startTime = millis() + rainTimer.howmuchTime;
        gameOver = false;
      }
    }
    else if (key == 'r' || key == 'R')//ends a game early by creating the game over requirements
    {
      if (location == 1)
      {
        lives = maxLives;
      }
      else  if (location == 2)
      {
        totalTimeLeft = millis();
      }
      else if (location == 3)
      {
        lives = storyLives;
      }
    }
    //letters A, D, J and L cycle through catcher and raindrop customization colors
    if (key == 'a' || key == 'A')
    {
      if (storyLoc == 3)
      {
        catcherWhich--;
        if (catcherWhich < 0)
        {
          catcherWhich = catcherColor.length-1;
        }
      }
    }
    if (key == 'd' || key == 'D')
    {
      if (storyLoc == 3)
      {
        catcherWhich++;
        if (catcherWhich >= catcherColor.length)
        {
          catcherWhich = 0;
        }
      }
    }
    if (key == 'j' || key == 'J')
    {
      if (storyLoc == 3)
      {
        rainWhich--;
        if (rainWhich < 0)
        {
          rainWhich = rainColor.length-1;
        }
      }
    }
    if (key == 'l' || key == 'L')
    {
      if (storyLoc == 3)
      {
        rainWhich++;
        if (rainWhich >= rainColor.length)
        {
          rainWhich = 0;
        }
      }
    }
    //the following is a pause function I am working on
    /*else if (key == 'p' || key == 'P')
     {
     paused = !paused;
     if (paused)
     {
     loop();
     }
     else
     {
     fill(255, 0, 0);
     textAlign(CENTER);
     textSize(50);
     text("PAUSED", width/2, height/2);
     textSize(20);
     text("Press \"P\" to unpause", width/2, height/2+50);
     noLoop();
     }
     }*/
  }
}
void mouseClicked()
{
  if (location == 0 || location == 4)
  {
    storyMode.ifClicked();
    credits.ifClicked();
    back.ifClicked();
    survival.ifClicked();
    timeAttack.ifClicked();
  }
  catchUp.buy();
  lowerScreen.buy();
  portalGun.buy();
  lightDown.buy();
  catchSpeed.buy();
  catchHandle.buy();
  catchHarvest.buy();
  lifeUp.buy();
  noLoss.buy();
  catchCustom.buy();
  rainUp.buy();
  if (storyLoc == 2)
  {
    if (mouseX > 390 && mouseX < 490 && mouseY > 440 && mouseY < 490)
    {
      storyLoc = 1;
      storyCatch = new Catcher(250);
      startTime = millis();
      totalTimeLeft = millis() + timeLeft;
      while (gameRain.length >= 1)
      {
        gameRain = (Raindrop[]) shorten(gameRain);//gives the array a length of 1 again
      }
      lives = 0;
      player.close();
      player = minim.loadFile("play" + int(random(1, 4)) + ".mp3");
      player.loop();
    }
    if (mouseX > 430 && mouseX < 480 && mouseY > 10 && mouseY < 35)//resets story mode to the beginning
    {
      catchUp.bought = 0;
      catchSpeed.bought = 0;
      catchHandle.bought = 0;
      lightDown.bought = 0;
      buyShip.bought = 0;
      catchMagnet.bought = 0;
      powerUp.bought = 0;
      lifeUp.bought = 0;
      catchHarvest.bought = 0;
      portalGun.bought = 0;
      lowerScreen.bought = 0;
      moreUp.bought = 0;
      rainUp.bought = 0;
      catchCustom.bought = 0;
      noLoss.bought = 0;
      storyDay = 1;
      totalRain = 0;
      storyLoc = 1;
      location = 0;
      c = new Catcher(400);
      r = new Raindrop[1];
      r[0] = new Raindrop();
      rainTimer.startTime = millis() + rainTimer.howmuchTime;
      ;
    }
    if (mouseX > 10 && mouseX < 60 && mouseY > 10 && mouseY < 35)
    {
      storyLoc = 1;
      location = 0;
      c = new Catcher(400);
      r = new Raindrop[1];
      r[0] = new Raindrop();
      rainTimer.startTime = millis() + rainTimer.howmuchTime;
    }
    if (mouseX > 50 && mouseX <50+80  && mouseY > 450 && mouseY < 490 && catchCustom.bought >= 1)
    {
      storyLoc = 3;
    }
  }
  if (storyLoc == 3)
  {
    if (mouseX > 10 && mouseX < 60 && mouseY > 10 && mouseY < 35)
    {
      storyLoc = 2;
    }
  }
}

