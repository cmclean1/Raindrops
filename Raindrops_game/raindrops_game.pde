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
String[] loadData;
String[] survivalNames = new String[5];
int[] survivalScores = new int[5];
int wut = 0;
int time = 2000;
int score;
int lives;
int maxLives = 10;
int Time = 2000;
boolean Intro = false;
boolean logo = false;
int introTime;
int whichIntro = 0;
int location = 0;
int timeLeft;
int startTime;
int totalTimeLeft;
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
  storyMode = new Button(width/2+30, "Story Mode", 0);
  timeAttack = new Button(width/2+60, "Time Attack", 2);
  survival = new Button(width/2+90, "Survival", 1);
  credits = new Button(width/2+120, "Credits", 4, false);
  back = new Button(width/2, "Back", 0, false);
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
    logo = false;
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
    Intro = false;
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
  if (logo)
  {
    Logo();
  }
  if (Intro && !logo)
  {
    intro();
  }
  if (!Intro)
  {
    if (location == 4 || location == 0)
    {
      for (int i = 0; i < r.length; i++)
      {
        r[i].display();
        r[i].move();
        r[i].checkCatcher(c);
      }
      if (millis() >= time)
      {
        r = (Raindrop[]) append(r, new Raindrop());
        time+=Time;
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
      text("Coding: Clayton McLean \nMusic: Clayton Mclean \nSound Effects: The Internet \nArt: Clayton McLean \nDesign: Clayton McLean \nTesters: Clayton McLean \nProduced By: Clayton McLean \nSpecial Thanks to: Creators of Processing \nAnything and Everything else: Clayton McLean", 15, 25);
    }
    if (location == 1)
    {
      surviveMode();
    }
    if (location == 2)
    {
      timeMode();
    }
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
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(50);
  text("GAME OVER", width/2, height/2);
  textSize(20);
  text("Press ENTER to return to menu \nPress H to view high scores", width/2, height/2+50);
  noLoop();
}
void timeMode()
{
  textAlign(LEFT);
  textSize(15);
  text("Score: " + score, 420, 50);
  text("Time: " + int(timeLeft/1000+1), 50, 50);
  if (location == 2)
  {
    for (int i = 0; i < gameRain.length; i++)
    {
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher(gameCatch);
    }
    if (millis() >= time)
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop());
      time+=Time;
    }
    gameCatch.display();
    gameCatch.move();
    timeLeft = totalTimeLeft-millis();
    if (timeLeft <= 0)
    {
      gameOver();
    }
  }
}
void surviveMode()
{
  textAlign(LEFT);
  textSize(15);
  text("Score: " + score, 420, 50);
  text("Lives: " + (maxLives-lives), 50, 50);
  if (location == 1)
  {
    for (int i = 0; i < gameRain.length; i++)
    {
      gameRain[i].display();
      gameRain[i].move();
      gameRain[i].checkCatcher(gameCatch);
    }
    if (millis() >= time)
    {
      gameRain = (Raindrop[]) append(gameRain, new Raindrop());
      time+=Time;
    }
    gameCatch.display();
    gameCatch.move();
    if (lives >= maxLives)
    {
      gameOver();
    }
  }
}
void keyPressed()
{
  if (keyCode == ENTER)
  {
    if (location == 1 || location == 2)
    {
      if (lives >= maxLives || timeLeft <= 0)
      {
        loop();
        location = 0;
        r = new Raindrop[1];
        c = new Catcher();
        r[0] = new Raindrop();
        time = millis() + Time;
        player.close();
        player = minim.loadFile("Water.wav");
        player.play();
      }
    }
  }
}
void mouseClicked()
{
  credits.ifClicked();
  back.ifClicked();
  survival.ifClicked();
  timeAttack.ifClicked();
}
boolean declareTime = true;
int timePassed;
boolean timePassed(int howMuchTime)
{
  if (declareTime == true)
  {
    timePassed = millis() + howMuchTime;
    declareTime = false;
  }
  if (millis() >= timePassed)
  {
    declareTime = true;
    return true;
  }
  else
  {
    return false;
  }
}

