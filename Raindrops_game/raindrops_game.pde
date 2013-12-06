import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Raindrop[] r;
Raindrop[] gameRain;

Minim minim;
Minim rainminim;
AudioPlayer player;
AudioPlayer rain;
Minim lightminim;
AudioPlayer lightPlayer;
Minim gunminim;
AudioPlayer gunPlayer;
Button storyMode, timeAttack, survival, credits, back;
Catcher c;
Catcher gameCatch;
Lightning menulight;
Lightning gameLight;
Timer rainTimer;
Upgrade catchUp, lightDown, catchSpeed, catchHandle, buyShip, catchMagnet, powerUp, lifeUp, catchHarvest, portalGun, lowerScreen, moreUp, rainSlow, catchCustom, noLoss;
String[] loadData;
String[] survivalNames = new String[5];
int[] survivalScores = new int[5];
int time = 2000;
int score;
int lives;
int maxLives = 1;
int Time = 2000;
int introTime;
int whichIntro = 0;
int location = 0;
int timeLeft;
int startTime;
int totalTimeLeft;
boolean paused = false;
boolean gameOver = false;
PFont  font = createFont("Gabriola-48.vlw", 10);
String[] introString = {
  "You are the fate of the world", "You don't remember much", "but only one word rings through your head:"
};
void setup()
{
  size(500, 500);
  loadData = loadStrings("survival.txt");
  for (int i = 0; i <= 8; i+=2)
  {
    survivalNames[i/2]=loadData[i];
  }
  for (int i = 0; i <= 8; i+=2)
  {
    survivalScores[i/2]=int(loadData[i]);
  }
  r = new Raindrop[1];
  c = new Catcher();
  r[0] = new Raindrop();
  gameRain = new Raindrop[1];
  gameCatch = new Catcher();
  gameRain[0] = new Raindrop();
  menulight = new Lightning(500);
  gameLight = new Lightning(2000);
  storyMode = new Button(width/2+30, "Story Mode", 3);
  timeAttack = new Button(width/2+60, "Time Attack", 2);
  survival = new Button(width/2+90, "Survival", 1);
  credits = new Button(width/2+120, "Credits", 4, false);
  back = new Button(width/2, "Back", 0, false);
  catchUp = new Upgrade(0, 0, 5, 10, 2, "Bigger Catcher"); //catcher
  catchSpeed = new Upgrade(0, 75, 5, 10, 2, "Faster Catcher"); // catcher
  catchHandle = new Upgrade(0, 150, 5, 10, 2, "Better Handling"); // catcher
  lowerScreen = new Upgrade(0, 225, 5, 10, 2, "Lower Position"); // catcher
  catchCustom = new Upgrade(0, 300, 5, 10, 2, "Customize Catcher"); // catcher

  rainSlow = new Upgrade(150, 5, 5, 10, 2, "Slower Rain"); // envo
  lightDown = new Upgrade(150, 75, 5, 10, 2, "Less Lighting"); // env
  catchMagnet = new Upgrade(150, 150, 5, 10, 2, "Attractive Catcher"); //catcher/envo
  catchHarvest = new Upgrade(150, 225, 5, 10, 2, "Raindrop Refine"); //catcher/enco
  lifeUp = new Upgrade(150, 300, 5, 10, 2, "More Lives"); // envo

  powerUp = new Upgrade(300, 5, 5, 10, 2, "Power Ups");// once
  moreUp = new Upgrade(300, 75, 5, 10, 2, "Power Up Frequency"); // envo
  noLoss = new Upgrade(300, 150, 5, 10, 2, "Chance to keep Life"); //envo
  portalGun = new Upgrade(300, 225, 5, 10, 2, "Portals"); // once
  buyShip = new Upgrade(300, 300, 5, 10, 2, "Ship Part"); // ult

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
void intro()
{
  textFont(font);
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
    time = millis()+Time;
    player.setGain(0);
    player.loop();
  }
}

void draw()
{
  fill(0, 50);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, height);
  if (location == -2)
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
    //c.move();
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
    text("Coding: Clayton McLean \nMusic: Clayton Mclean \nSound Effects: The Internet \nArt: Clayton McLean \nDesign: Clayton McLean \nProduced By: Clayton McLean \nSpecial Thanks to: Creators of Processing \nAnything and Everything else: Clayton McLean", 15, 25);
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
}
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
    text("Press ENTER to return to menu", width/2, height/2+50);// \nPress H to view high scores", width/2, height/2+50);
  }
}
void timeMode()
{
  textAlign(LEFT);
  textSize(15);
  text("Time: " + int(timeLeft/1000+1), 50, 50);
  textSize(10);
  fill(255, 0, 0);
  // text("Press \"P\"  to pause", 10, 20);
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
    if (rainTimer.go())
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop());
    }
    gameCatch.display();
    if (gameCatch.checkLightning(gameLight) == false)
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
void surviveMode()
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
void keyPressed()
{
  if (location == 1 || location == 2 || location == 3)
  {
    if (keyCode == ENTER)
    {
      if (lives >= maxLives || timeLeft <= 0)
      {
        if (location == 1 || location == 2)
        {
          location = 0;
        }
        if (location == 3)
        {
          storyLoc = 2;
          storyDay++;
        }
        c = new Catcher();
        r = new Raindrop[1];
        r[0] = new Raindrop();
        time = millis() + Time;
        player.close();
        player = minim.loadFile("Water.wav");
        player.play();
        rainTimer.startTime = millis() + rainTimer.howmuchTime;
        gameOver = false;
      }
    }
    else if (key == 'r' || key == 'R')
    {
      lives = maxLives;
      totalTimeLeft = millis();
    }
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
  credits.ifClicked();
  back.ifClicked();
  survival.ifClicked();
  timeAttack.ifClicked();
  storyMode.ifClicked();
  if (mouseX > 390 && mouseX < 490 && mouseY > 440 && mouseY < 490)
  {
    storyLoc = 1;
    gameCatch = new Catcher();
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
  if (mouseX > 10 && mouseX < 60 && mouseY > 10 && mouseY < 35)
  {
    storyLoc = 1;
    location = 0;
    c = new Catcher();
    r = new Raindrop[1];
    r[0] = new Raindrop();
    time = millis() + Time;
    player.close();
    player = minim.loadFile("Water.wav");
    player.play();
    rainTimer.startTime = millis() + rainTimer.howmuchTime;
  }
}

