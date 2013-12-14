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
  Raindrop(Catcher _catcher)
  {
    changeV = .1;
    catcher = _catcher;
    dropheight = catcher.loc.y;
    initialV = 0;
    loc = new PVector(random(width), d/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, changeV);
    distance = sqrt(2*dropheight/acc.y);
    finalV = acc.y*distance;
    d = 10;
    caught = false;
    setPower = true;
  }
  //powerups don't work
  /*  void decideIfPower()
   {
   if (powerChance() && setPower)
   {
   isPower = true;
   }
   setPower = false;
   }*/
  void decideIfRefined()
  {

    if (refineChance() && setRefine)
    {
      isRefine = true;
    }
    setRefine = false;
  }
  void display()
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
  void move()
  {
    if (!caught && !miss)
    {
      acc.set(0, changeV);
      vel.add(acc);
      loc.add(vel);
    }
    else
    {
      acc.set(0, 0);//if it is either caught or missed, it will move off the screen (i dont know how to use array lists yet)
      vel.set(0, 0);
      loc.y = -100;
    }
  }
  boolean refineChance()
  {
    int wut = int(random(10-catchHarvest.bought));
    if (wut == 0)
    {
      return true;
    }
    else
      return false;
  }
  //powerups don't work
  /* boolean powerChance()
   {
   int wut = int(random(1));
   if (wut == 0)
   {
   return true;
   }
   else
   return false;
   }*/
  void checkCatcher()
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
      //will be implemented when powerups work
      /* if (isPower)
       {
       goPower();
       }*/
      if (isRefine)
      {
        goRefine();
      }
    }
    if (loc.y >= height)
    {
      int lose = 1;
      if (location == 3)//if in story mode, there is a chance to not lose a life
      {
        lose = int(random(0, 11-lossChance));
      }
      if (lose != 0)
      {
        lives++;
      }
      miss = true;
    }
  }
  void checkheight()//changes initial position, distance and initial velocity of raindrop. necessary for automove
  {
    initialV = vel.y;
    dropheight = dist(0, loc.y, 0, c.loc.y);
    distance = (finalV-initialV)/acc.y;
  }
}

