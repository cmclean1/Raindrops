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
int wut = 0;
int time = 2000;
int score;
int lives;
int maxLives = 2;
int Time = 2000;
boolean Intro = false;
boolean logo = false;
boolean ifreset = true;
int introTime;
int whichIntro = 0;
int location = 0;
PFont  font = createFont("Gabriola-48.vlw", 10);
String[] introString = {
  "You are the fate of the world", "You don't remember much", "but only one word rings through your head:"
};
void setup()
{
  size(500, 500);
  r = new Raindrop[1];
  c = new Catcher();
  gameRain = new Raindrop[1];
  gameCatch = new Catcher();
  gameRain[0] = new Raindrop();
  r[0] = new Raindrop();
  menulight = new Lightning(500);
  storyMode = new Button(width/2+30, "Story Mode", 0);
  timeAttack = new Button(width/2+60, "Time Attack", 0);
  survival = new Button(width/2+90, "Survival", 1);
  credits = new Button(width/2+120, "Credits", 4, false);
  back = new Button(width/2+50, "Back", 0);
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
      reset();
      surviveMode();
    }
  }
}
void reset()
{
  if (ifreset)
  {
    score = 0;
  }
  ifreset = false;
}
void gameOver()
{
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(50);
  noLoop();
  text("GAME OVER", width/2, height/2);
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
void mouseClicked()
{
  credits.ifClicked();
  back.ifClicked();
  survival.ifClicked();
}

