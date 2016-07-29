import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.spi.*; 
import ddf.minim.signals.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 
import ddf.minim.ugens.*; 
import ddf.minim.effects.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Raindrops_game extends PApplet {

//imports stuff for sound






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
Upgrade catchUp, lightDown, catchSpeed, catchHandle, buyShip, rainRefine, powerUp, lifeUp, catchHarvest, portalGun, lowerScreen, moreUp, rainUp, catchCustom, noLoss;
//                                                                  ^         ^                                                     ^
int score;
PFont  font;
int lives;
int maxLives = 10;//max lives in time/survival mode
int storyLives = 10;//max lives in story mode (can change)
int introTime;//changes the text that shows during the intro
int whichIntro = 0;//decides which text ti show
int location = 0;//decides which screen to be on
int timeLeft;//used for time attack mode
int totalRain;//total raindrops collected in story mode
int totalTimeLeft;//used for time attack mode
String[] loadStory;//an array of text created from the txt file made from String saveStory
String[] allScores;
String[] storyScores;
String[] timeScores;
String[] survivalScores;
String saveStory;//a string of text that will be turned into an array saved into a txt file
boolean paused = false;//decide if game is paused or not
boolean gameOver = false;//decide if gameover conditions are met
String[] introString = {
  "You are the fate of the world", "You don't remember much", "but only one word rings through your head:"
};
//arrays and variables for catcher/raindrop color customization. each Color array # corresponds to its Name array #
int[]   catcherColor = {
  color(255), color(0, 0, 255), color(0, 255, 0), color(255, 0, 0), color(20), color(255, 5), color(245, 185, 234), color(255, 255, 0), color(255, 0, 255)
};
;
int[] rainColor = {
  color(0, 0, 255), color(255), color(0, 255, 0), color(255, 0, 0), color(20), color(0, 0, 255, 50), color(100, 73, 18)
};
String[] catcherName = {
  "White", "Blue", "Green", "Red", "Dark", "Ghost", "Fabulous", "Yellow", "Purple"
};
int catcherWhich = 0;//decides which catcher and rain color to pick
int rainWhich = 0;
String[] rainName= {
  "Normal", "Pure", "Slime", "Blood", "Dark", "Transparent", "Dirty"
};
public void setup()
{
  font = loadFont("Gabriola-48.vlw");
  // textFont(font);
  
  //load numbers from text file
  loadStory = loadStrings("story.txt");
  //numbers from text file can be accessed like this:
  totalRain = PApplet.parseInt(loadStory[15]);
  storyDay = PApplet.parseInt(loadStory[16]);
  allScores = loadStrings("highScores.txt");
  timeScores = new String[10];
  for (int i = 0; i < 10; i++)
  {
    timeScores[i] = allScores[i];
  }
  r = new Raindrop[1];
  c = new Catcher(250);
  r[0] = new Raindrop(c);
  gameRain = new Raindrop[1];
  gameCatch = new Catcher(400);
  storyCatch = new Catcher(250);
  gameRain[0] = new Raindrop(gameCatch);
  menulight = new Lightning(500);
  gameLight = new Lightning(5000);
  storyLight = new Lightning(5000);
  storyMode = new Button(width/2+30, "Story Mode", 3, true);
  timeAttack = new Button(width/2+60, "Time Attack", 2, true);
  survival = new Button(width/2+90, "Survival", 1, true);
  credits = new Button(width/2+120, "Credits", 4, false);
  back = new Button(width/2, "Back", 0, false);

  catchUp = new Upgrade(0, 0, 5, 12, "Bigger Catcher", 0); 
  catchSpeed = new Upgrade(0, 75, 10, 8, "Max Speed", 1); 
  catchHandle = new Upgrade(0, 150, 10, 8, "Acceleation", 2); 
  lowerScreen = new Upgrade(0, 225, 10, 8, "Lower Position", 10); 
  catchCustom = new Upgrade(0, 300, 1, 30, "Customize Catcher", 13);

  rainUp = new Upgrade(150, 5, 5, 10, "Bigger Drops", 12); 
  lightDown = new Upgrade(150, 75, 5, 10, "Less Lighting", 3); 
  rainRefine = new Upgrade(150, 150, 1, 15, "Refine Raindrops", 5); 
  catchHarvest = new Upgrade(150, 225, 5, 10, "Raindrop Refine Chance", 8); 
  lifeUp = new Upgrade(150, 300, 5, 10, "More Lives", 8); 

  powerUp = new Upgrade(300, 5, 1, 30, "Power Ups", 6);
  moreUp = new Upgrade(300, 75, 5, 10, "Power Up Frequency", 11); 
  noLoss = new Upgrade(300, 150, 7, 12, "Chance to keep Life", 14); 
  portalGun = new Upgrade(300, 225, 1, 30, "Portals", 9); 
  buyShip = new Upgrade(300, 300, 10, 20, "Ship Part", 4);

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
//shows logo for 5 seconds anc plays gunshot effect then goes to intro
public void Logo()
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
    rain.setGain(-15);//starts rain effect
    rain.loop();
  }
}
//plays intro then goes to menu screen
public void intro()
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
    player.setGain(0);//play music
    player.loop();
  }
}

public void draw()
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
  if (location == 4 || location == 0)//location 4 is credits, location 0 is main menu
  {
    c.display();//display catcher
    c.autoMove(r);//automatically move catcher (explained in class)
    for (int i = 0; i < r.length; i++)//display raindrops
    {
      r[i].display();
      r[i].move();
      r[i].checkCatcher();
    }
    if (rainTimer.go())//add new raindrop to the array every two seconds
    {
      r = (Raindrop[]) append(r, new Raindrop(c));
    }
  }
  if (location == 0)//main menu
  {
    textSize(40);
    fill(0, 0, 255);
    textAlign(CENTER);
    text("WATER", width/2, height/2);//title
    storyMode.display();//display buttons for gamemodes and credits
    timeAttack.display();
    survival.display();
    credits.display();
    menulight.appear();//display lightning
  }
  if (location == 4)
  {
    back.display();//back button from credits
    textSize(15);
    fill(0, 0, 255);
    textAlign(CORNER);
    text("Coding: Clayton McLean \nMusic: Clayton Mclean, Beyonce, Lil Mama \nSound Effects: The Internet \nArt: Clayton McLean \nDesign: Clayton McLean \nProduced By: Clayton McLean \nSpecial Thanks to: Creators of Processing and Jesus and Jah \nAnything and Everything else: Clayton McLean", 15, 25);
  }
  fill(255);//this fill can access each game mode
  if (location == 1)
  {
    textAlign(LEFT);
    textSize(15);
    text("Score: " + score, 420, 50);//display score
    if (!gameOver)//play game if gameover is false
    {
      gameLight.appear();
      surviveMode();
    }
    else//show gameOver if gameover is true
    {
      gameOver();
    }
  }
  if (location == 2)
  {
    textAlign(LEFT);
    textSize(15);
    text("Score: " + score, 420, 50);//display score
    if (!gameOver)//play game if gameover is false
    {
      gameLight.appear();
      timeMode();
    }
    else
    {
      gameOver();//show gameOver if gameover is true
    }
  }
  if (location == 3)//play story mode
  {
    storyMode();
  }
  textAlign(CENTER);
  textSize(20);
  if (displayRefine && millis() < refineTime+2000)//display text if you catch a refined raindrop for 2 seconds
  {
    fill(255);
    text(powerText, width/2, height/2);//refineText doesn't exist because I only want one to display. even if both are caught in succession
  }
  else
  {
    displayRefine = false;///keeps powerText from displaying all the time
  }
  if (displayPower && millis() < powerTime+2000)
  {
    text(powerText, width/2, height/2);
  }
  else
  {
    displayPower = false;
  }
  if (goPower)
  {
    fill(255);
    rect(0, 490, ((powerTime+10000-millis())*width)/(10000), 10);
    if (millis() >  powerTime+10000)
    {
      goPower = false;
    }
  }
}
public void stop()//necessary to stop sound files from playing
{
  player.close();
  minim.stop();
  super.stop();
}
public void gameOver()
{
  if (gameOver)//displays if gameover is true
  {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(50);
    text("GAME OVER", width/2, height/2);
    textSize(20);
    text("Press ENTER to return to menu", width/2, height/2+50);
  }
}
public void timeMode()//game over will happen when 120 seconds are up
{
  textAlign(LEFT);
  textSize(15);
  text("Time: " + PApplet.parseInt(timeLeft/1000+1), 50, 50);//display how much time left in seconds
  textSize(10);
  fill(255, 0, 0);
  textAlign(RIGHT);
  text("Press \"R\"  to end early", 495, 20);
  if (location == 2)
  {
    for (int i = 0; i < gameRain.length; i++)//display drops
    {
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher();
    }
    if (rainTimer.go())//add another raindrop to the array every 2 seconds
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop(gameCatch));
    }
    gameCatch.display();
    if (gameCatch.checkLightning(gameLight) == false)//catcher will only move if lightning is not appearing
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
public void surviveMode()//ten lives, game over will happen if all lives are lost
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
      gameRain[i].checkCatcher();
    }
    if (rainTimer.go())//add another raindrop to the array every 2 seconds
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop(gameCatch));
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
public void keyPressed()
{
  if (location == 1 || location == 2 || location == 3)
  {
    if (keyCode == ENTER)//returns to menu screen, or upprade menu if on story mode
    {
      if (location == 3 && buyShip.bought == 10)
      {
        catchUp.bought = 0;
        catchSpeed.bought = 0;
        catchHandle.bought = 0;
        lightDown.bought = 0;
        buyShip.bought = 0;
        rainRefine.bought = 0;
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
        r[0] = new Raindrop(c);
        rainTimer.startTime = millis() + rainTimer.howmuchTime;
      }
      if (lives >= maxLives || timeLeft <= 0)
      {
        if (location == 1 || location == 2)
        {
          location = 0;
          minim.stop();//resets music
          player = minim.loadFile("Water.wav");
          player.loop();
        }
        else if (location == 3 && storyLoc == 1)
        {
          //story mode is automatically saved onto story.txt every time a day ends
          storyLoc = 2;
          storyDay++;
          saveStory =   catchUp.bought + "," + catchSpeed.bought + "," + catchHandle.bought + "," + lightDown.bought + "," + buyShip.bought+ "," + rainRefine.bought+ "," + powerUp.bought+ "," + lifeUp.bought+ "," + catchHarvest.bought+ "," + portalGun.bought+ "," + lowerScreen.bought+ "," + moreUp.bought+ "," + rainUp.bought+ "," + catchCustom.bought+ "," + noLoss.bought + "," + totalRain + "," + storyDay ;
          String[] save = split(saveStory, ",");
          saveStrings("story.txt", save);
          minim.stop();//resets music
          player = minim.loadFile("Water.wav");
          player.loop();
        }
        c = new Catcher(400);//resets menu screen and restarts menu music
        r = new Raindrop[1];
        r[0] = new Raindrop(c);
        rainTimer.startTime = millis() + rainTimer.howmuchTime;
        gameOver = false;
      }
    }
    else if (key == 'r' || key == 'R')//ends a game early by forcing the game over requirements to become true
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
public void mouseClicked()
{
  if (location == 0)//keeps buttons from activating on the credits screen
  {
    storyMode.ifClicked();
    credits.ifClicked();
    survival.ifClicked();
    timeAttack.ifClicked();
  }
  if (location == 4)
  {
    back.ifClicked();
  }
  catchUp.buy();
  lowerScreen.buy();
  moreUp.buy();
  rainRefine.buy();
  portalGun.buy();
  powerUp.buy();
  lightDown.buy();
  catchSpeed.buy();
  catchHandle.buy();
  catchHarvest.buy();
  lifeUp.buy();
  noLoss.buy();
  buyShip.buy();
  catchCustom.buy();
  rainUp.buy();
  if (storyLoc == 2)
  {
    if (mouseX > 390 && mouseX < 490 && mouseY > 440 && mouseY < 490)
    {
      storyLoc = 1;
      storyCatch = new Catcher(250);
      totalTimeLeft = millis() + timeLeft;
      while (gameRain.length >= 1)
      {
        gameRain = (Raindrop[]) shorten(gameRain);//gives the array a length of 1 again
      }
      lives = 0;
      player.close();
      player = minim.loadFile("play" + PApplet.parseInt(random(1, 4)) + ".mp3");
      player.loop();
    }
    if (mouseX > 430 && mouseX < 480 && mouseY > 10 && mouseY < 35)//resets story mode to the beginning
    {
      catchUp.bought = 0;
      catchSpeed.bought = 0;
      catchHandle.bought = 0;
      lightDown.bought = 0;
      buyShip.bought = 0;
      rainRefine.bought = 0;
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
      r[0] = new Raindrop(c);
      rainTimer.startTime = millis() + rainTimer.howmuchTime;
      ;
    }
    if (mouseX > 10 && mouseX < 60 && mouseY > 10 && mouseY < 35)//goes back to main menu
    {
      storyLoc = 1;
      location = 0;
      c = new Catcher(400);
      r = new Raindrop[1];
      r[0] = new Raindrop(c);
      rainTimer.startTime = millis() + rainTimer.howmuchTime;
    }
    if (mouseX > 50 && mouseX <50+80  && mouseY > 450 && mouseY < 490 && catchCustom.bought >= 1)//go to custimization screen if customization upgrade is bought
    {
      storyLoc = 3;
    }
  }
  if (storyLoc == 3)
  {
    if (mouseX > 10 && mouseX < 60 && mouseY > 10 && mouseY < 35)//goes back to upgrade screen if on customization screen
    {
      storyLoc = 2;
    }
  }
}
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
  public void display()
  {
    textAlign(CENTER);
    noFill();
    rectMode(CENTER);
    stroke(0, 0, 255);
    rect(width/2, y-5, recWidth, 25);
    fill(0, 0, 255);
    if (clicked())//text will highlight in white if mouse is over the button
    {
      fill(255);
    }
    textSize(15);
    text(message, width/2, y);
  }
  public void ifClicked()
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
        totalTimeLeft = millis() + timeLeft;
        while (gameRain.length >= 1)
        {
          gameRain = (Raindrop[]) shorten(gameRain);
        }
        lives = 0;
        minim.stop();
        player = minim.loadFile("play" + PApplet.parseInt(random(1, 4)) + ".mp3");
        player.loop();
      }
    }
  }
  public boolean clicked()
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
class Catcher
{
  PVector loc;
  PVector vel;
  PVector acc;
  int d;
  float yLoc;
  float initialX;
  float maxSpeed;
  float maxAcc;
  int nextRain = 0;
  boolean iCaughtIt = false;
  int c;
  Catcher(int _yLoc)
  {
    c = catcherColor[catcherWhich];//fills with customized color from story mode. normal color is the first option 
    yLoc = _yLoc;
    loc = new PVector(width/2, yLoc);
    maxAcc = .1f;
    maxSpeed = 5;
    acc = new PVector(0, 0);
    initialX = loc.x;
    vel = new PVector(0, 0);
    d = 20;
  }
  public void display()
  {
    fill(c);
    ellipse(loc.x, loc.y, d, d);
  }
  public void autoMove(Raindrop[] wut)//automove will make the catcher move to where the raindrop will be when it is the same height as the catcher, the exact time it gets there
  {
    acc.set(0, 0);//acceleration is unecessary
    nextRain = 0;//nextRain lets the catcher know which raindrop to look for

    while (wut[nextRain].caught == true || wut[nextRain].miss == true)//nextRain is decided by finding out which raindrop has not been caught or missed
    {
      nextRain++;
      if (nextRain >= wut.length)
      {
        return;
      }
    }
    if (iCaughtIt == true)//makes each raindrop change their starting point. necessary for when there are more than one raindrops on the screen
    {
      wut[nextRain].checkheight();
      wut[nextRain].dropheight = loc.y;
    }
    iCaughtIt = false;//iCaughtIt makes the previous if statement happen only once
    /*the long equation is a kinematic equation that finds out how fast the catcher needs to be in order to reach the raindrop in time
     it is basically the raindrop distance between the raindrop and the catcher divided by the distance the raindrop takes to reach the y location of the catcher
     */
    vel.set((wut[nextRain].loc.x-initialX)/wut[nextRain].distance, 0);
    loc.add(vel);
  }
  public void move()//regular movement
  {
    if (keyPressed && keyCode == LEFT)
    {
      acc.set(-maxAcc, 0);
    }
    else if (keyPressed && keyCode == RIGHT)
    {
      acc.set(maxAcc, 0);
    }
    else
    {
      acc.set(0, 0);
    }
    if (portalGun.bought == 1 && location == 3)//if portalGun upgrade is bought (story mode only) the catcher can pass through the edge and go on the other side
    {
      portal();
    }
    else // if not, it simply hits rthe edge
    {
      wallStop();
    }
    vel.add(acc);
    if (vel.x > maxSpeed)//makes sure the catcher does not exceed a certain speed
    {
      vel.set(maxSpeed, 0);
    }
    else if (vel.x < -maxSpeed)
    {
      vel.set(-maxSpeed, 0);
    }
    loc.add(vel);
  }
  public boolean checkLightning(Lightning l)//if lightning appears, then the catcher can't move
  {
    if (l.show == true)
    {
      acc.set(0, 0);
      vel.set(0, 0);
      return true;
    }
    else
    {
      return false;
    }
  }
  public void wallStop()
  {
    if (loc.x >= width-(d/2))//the catcher will crash into an edge and slowly come back out (hence the loc.x-- and lox.x++)
    {
      vel.x = 0;
      acc.x = 0;
      loc.x--;
    }
    else if (loc.x <= d/2)
    {
      vel.x = 0;
      acc.x = 0;
      loc.x++;
    }
  }
  public void portal()//the catcher will appear on the other side if it goes off the edge
  {
    if (loc.x >= width+(d/2))
    {
      loc.x = -d/2;
    }
    else if (loc.x <= -d/2)
    {
      loc.x=width+(d/2);
    }
  }
}
class Lightning
{

  int random;
  int showTime;
  boolean show = false;
  Lightning(int _random)
  {
    random = _random;
  }
  public boolean chance()
  {
    int show = PApplet.parseInt(random(random));//the lighting has a 1 out of "value of random" chance to appear every frame
    if (show == 0)//the lighting will appear for 1 second
    {
      showTime = millis()+1000;
      return true;
    }
    return false;
  }
  public void appear()
  {
    if (!goPower && whichPower != 1)
    {
      if (chance())
      {
        show = true;
      }
      if (millis() <= showTime && show == true)
      {
        int wut = PApplet.parseInt(random(5));//creates a flashing effect
        if (wut == 0)
        {
          background(255);
        }
        lightPlayer.setGain(-15);//plays the lightning sound effect
        lightPlayer.play();
      }
      else
      {
        show = false;
        showTime+=1000;
      }
      if (lightPlayer.isPlaying() == false)//rewinds the lightning sound effect so it can play again later once it stops playing
      {
        lightPlayer.pause();
        lightPlayer.rewind();
      }
    }
  }
}
boolean displayPower;//decides powerup text
int powerTime;//current millis
boolean goPower;//decide if a powerup is activated or deactivated
int whichPower;//decides which powerup will activate
String powerText = " ";//text that will show up after collecting a powerup or refined raindrop. controlled by displayPower or displayRefine
public void goPower()
{
  displayPower = true;
  powerTime = millis();
  goPower = true;
  whichPower = PApplet.parseInt(random(4));
  if (whichPower == 0)
  {
    powerText = "Bigger Catcher!";
  }
  if (whichPower == 1)
  {
    powerText = "No Lightning!";
  }
  if (whichPower == 2)
  {
    powerText = "Invincible!";
  }
  if (whichPower == 3)
  {
    powerText = "Auto Move!";
  }
}
boolean displayRefine;
int refineTime;
public void goRefine()
{
  displayRefine = true;
  refineTime = millis();
  int random = PApplet.parseInt(random(3));
  if (random == 0)
  {
    totalRain+=9;//it adds one less than what the text says since one is already added when originally caught
    powerText = "+10 Raindrops!";
  }
  if (random == 1)
  {
    totalRain+=4;
    powerText = "+5 Raindrops!";
  }
  if (random == 2)
  {
    totalRain+=1;
    powerText = "+2 Raindrops!";
  }
}
public void powerUps()
{
  if (whichPower == 0 && goPower)
  {
    storyCatch.d = 35+(catchUp.bought*5);//increase catcher diameter by five if whichPower equals 0
  }
}
int lossChance;
class Raindrop
{
  PVector loc;
  PVector vel;
  PVector acc;
  int d;
  boolean caught = false;
  boolean miss = false;
  float changeV;
  float distance;
  float dropheight;
  float initialV;
  float finalV;
  boolean setPower;
  boolean isPower;
  boolean setRefine = true;
  boolean isRefine;
  Catcher catcher;
  Raindrop(Catcher _catcher)//putting the catcher paremeter in the constructor is more effective
  {
    changeV = .1f;
    catcher = _catcher;
    dropheight = catcher.loc.y;
    initialV = 0;
    loc = new PVector(random(d/2, width-d/2), d/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, changeV);
    distance = sqrt(2*dropheight/acc.y);
    finalV = acc.y*distance;
    d = 10;
    caught = false;
    setPower = true;
  }
  public void decideIfPower()
  {
    if (powerChance() && setPower)
    {
      isPower = true;
    }
    setPower = false;
  }
  public void decideIfRefined()//in one frame, it will decide whether to become a refined raindrop or not
  {
    if (refineChance() && setRefine)
    {
      isRefine = true;
    }
    setRefine = false;//keeps the above if statement from happening multiple times
  }
  public void display()
  {
    fill(rainColor[rainWhich]);//fills with customized color
    if (isPower || isRefine)
    {
      fill(random(255), random(255), random(255));
    }
    noStroke();
    ellipse(loc.x, loc.y, d, d);
    triangle(loc.x-d/2, loc.y, loc.x+d/2, loc.y, loc.x, loc.y-(vel.y*5));
  }
  public void move()
  {
    if (!caught && !miss)//if it is either caught or missed, it will move off the screen (i dont know how to use array lists yet)
    {
      acc.set(0, changeV);
      vel.add(acc);
      loc.add(vel);
    }
    else
    {
      acc.set(0, 0);
      vel.set(0, 0);
      loc.y = -100;
    }
  }
  public boolean refineChance()
  {
    int chance = 1;//keeps this function from ever being true if rainRefine hasnt been bought yet
    if (rainRefine.bought > 0)
    {
      chance = PApplet.parseInt(random(10-catchHarvest.bought));
    }
    if (chance == 0)
    {
      return true;
    }
    else
      return false;
  }
  public boolean powerChance()
  {
    int chance = 1;//keeps this from ever being true if powerUp hasnt been bought yer
    if (powerUp.bought > 0)
    {
      chance = PApplet.parseInt(random(11-moreUp.bought));
    }
    if (chance == 0)
    {
      return true;
    }
    else
      return false;
  }
  public void checkCatcher()
  {
    if (dist(loc.x, loc.y, catcher.loc.x, catcher.loc.y) <= (d/2)+(catcher.d/2))
    {
      caught = true;
      score++;
      if (location == 3)//total amount of raindrops collected will increase if in story mode
      {
        totalRain++;
      }
      dropheight = catcher.loc.y;
      catcher.initialX = catcher.loc.x;//changes initial location of the catcher, necessary for equations in automove
      catcher.iCaughtIt= true;
      if (isRefine)
      {
        goRefine();//activates refinery if catched
      }
      if (isPower)
      {
        goPower();//activates powerup if catched
      }
    }
    if (loc.y >= height)
    {
      int lose = 1;
      if (location == 3 && noLoss.bought > 0)//if in story mode, there is a chance to not lose a life
      {
        lose = PApplet.parseInt(random(0, 11-lossChance));
      }
      if (goPower && whichPower == 2)//keeps lives from being lost if invinsible powerup is activated
      {
        lose = 0;
      }
      if (lose != 0)
      {
        lives++;
      }
      miss = true;
    }
  }
  public void checkheight()//changes initial position, distance and initial velocity of raindrop. necessary for catcher automove
  {
    initialV = vel.y;
    dropheight = dist(0, loc.y, 0, c.loc.y);
    distance = (finalV-initialV)/acc.y;
  }
}
int storyLoc = 1;//decides which story menu to be at
int storyDay;//shows how many runs it takes to finish story mode

public void storyMode()
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
public void storyPlay()//day will end if lives are lost
{
  upgrade();
  powerUps();
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
      gameRain[i].decideIfPower();
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher();
    }
    if (rainTimer.go())
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop(storyCatch));
    }
    storyCatch.display();
    if (goPower && whichPower == 3)//catcher will automove if the automove powerup was caught
    {
      storyCatch.autoMove(gameRain);
    }
    else
    {
      if (gameCatch.checkLightning(gameLight) == false)
      {
        storyCatch.move();
      }
    }
    if (lives >= storyLives)
    {
      gameOver = true;
    }
    gameLight.appear();
  }
}
public void storyOver()
{
  if (gameOver)
  {
    goPower = false;
    displayPower =false;
    displayRefine = false;
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(50);
    text("DAY OVER", width/2, height/2);
    textSize(20);
    text("Press ENTER go to upgrade menu", width/2, height/2+50);
  }
}
public void upGrade()
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
  rainRefine.display();
  catchHarvest.display();
  buyShip.display();
  powerUp.display();
  moreUp.display();
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
  fill(255);
  textAlign(CENTER);
  text("Total Raindrops: " + totalRain, width/2, 30);
  if (buyShip.bought == 10)
  {
    winStory();
  }
}
public void customize()
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
public void winStory()
{
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(20);
  text("You Win! It took you " + storyDay + " days to win!", width/2, height/2);
  textSize(15);
  text("Press enter to go back to main menu", width/2, height/2+20);
}
class Timer
{
  int startTime;//will be current value of millis plus howmuchTime
  int howmuchTime;//interval value
  boolean declareTime = true;//controls when to change value of startTime
  Timer(int _howmuchTime)
  {
    howmuchTime = _howmuchTime;//declare time interval needed in millis
  }
  public boolean go()
  {
    if (ifTime())//if time is up, make declareTime true again so startTime can change value
    {
      declareTime = true;
      return true;
    }
    else
    {
      return false;
    }
  }
  public boolean ifTime()
  {
    if (declareTime == true)
    {
      startTime = millis() + howmuchTime;//startTime becomes current millis plus howmuchTime
      declareTime = false;//keeps this if statement from happening more than once
    }
    if (millis() >= startTime)//return true if time is up
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}
Upgrade wut;

class Upgrade {
  int x;
  int y;
  float cost;
  float costUp;
  int max;
  int bought;
  String name;
  Upgrade(int _x, int _y, int _max, float _costUp, String _name, int currentBought)
  {
    x = _x;
    y = _y;
    max = _max;
    costUp = _costUp;
    name = _name;
    bought = PApplet.parseInt(loadStory[currentBought]);
  }
  public void display()
  {
    cost = (costUp)*(bought+1);
    fill(255);
    textAlign(LEFT);
    textSize(10);
    if (bought != max)
    {
      text(PApplet.parseInt(cost), x+35, y+93);
    }
    else if (bought == max)
    {
      text("ALL BOUGHT", x+30, y+93);
    }
    textSize(8);
    textAlign(LEFT);
    text(name, x+30, y+45);
    if (ifClicked())
    {
      if (totalRain < cost || bought == max)//highlights red if all upgrades are bought or if you don't have enough raindrops
      {
        fill(255, 0, 0);
      }
      else if (totalRain >= cost && bought < max)//highlights orange if conditions are met
      {
        fill(0xffFF7C00);
      }
    }
    ellipse(45+x, 65+y, 30, 30);
    for (int i = 60; i < 60+(max*10); i+=10)//makes rectangles to represent maximum number of total upgrades (white)
    {
      fill(255);
      rect(i+x, 50+y, 5, 30);
    }
    for (int i = 60; i < 60+(bought*10); i+=10)//fills recangles to represent number of bought upgrades (orange)
    {
      fill(0xffFF7C00);
      rect(i+x, 50+y, 5, 30);
    }
    fill(0, 0, 255);
    noStroke();
    ellipse(45+x, 70+y, 10, 10);
    triangle(40+x, 70+y, 50+x, 70+y, 45+x, 55+y);
  }
  public void buy()
  {
    if (ifClicked() && bought < max)
    {
      if (totalRain >= cost)
      {
        totalRain-=cost;
        bought++;
      }
    }
  }
  public boolean ifClicked()//a boolean function that finds out if the mouse is touching the circle
  {
    if (dist(mouseX, mouseY, 45+x, 65+y) < 15 && storyLoc == 2)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

public void upgrade()//increases certain values by a certain increment. only in story mode
{
  //for ever catchUp upgrade bought, catcher diameter will increase by 5
  storyCatch.d = 20+(catchUp.bought*5);
  //for every catchSpeed upgrade bought, maximum catcher speed will incrase by 0.2
  storyCatch.maxSpeed = 5+(catchSpeed.bought*.2f);
  //catcher acceleration will increase by 0.025
  storyCatch.maxAcc = .1f+(catchHandle.bought*.025f);
  //the catchers y position will increase by 25
  storyCatch.loc.y = 250+(lowerScreen.bought*20);
  //lightning chance to appear will decrease by 1000 
  storyLight.random = 5000+(lightDown.bought*1000);
  //amount of lives will increase by 3
  storyLives = 10+(lifeUp.bought*3);
  //chance to keep life will increase by 1
  lossChance = 0+noLoss.bought;
  //raindrop size will increase by 1
  for (int j = 0; j <= gameRain.length-1; j++)
  {
    gameRain[j].d = 10+(rainUp.bought);
  }
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Raindrops_game" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
