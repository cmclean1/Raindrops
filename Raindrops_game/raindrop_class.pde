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
    changeV = .1;
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
  void decideIfPower()
  {
    if (powerChance() && setPower)
    {
      isPower = true;
    }
    setPower = false;
  }
  void decideIfRefined()//in one frame, it will decide whether to become a refined raindrop or not
  {
    if (refineChance() && setRefine)
    {
      isRefine = true;
    }
    setRefine = false;//keeps the above if statement from happening multiple times
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
  boolean refineChance()
  {
    int chance = 1;//keeps this function from ever being true if rainRefine hasnt been bought yet
    if (rainRefine.bought > 0)
    {
      chance = int(random(10-catchHarvest.bought));
    }
    if (chance == 0)
    {
      return true;
    }
    else
      return false;
  }
  boolean powerChance()
  {
    int chance = 1;//keeps this from ever being true if powerUp hasnt been bought yer
    if (powerUp.bought > 0)
    {
      chance = int(random(11-moreUp.bought));
    }
    if (chance == 0)
    {
      return true;
    }
    else
      return false;
  }
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
        lose = int(random(0, 11-lossChance));
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
  void checkheight()//changes initial position, distance and initial velocity of raindrop. necessary for catcher automove
  {
    initialV = vel.y;
    dropheight = dist(0, loc.y, 0, c.loc.y);
    distance = (finalV-initialV)/acc.y;
  }
}

