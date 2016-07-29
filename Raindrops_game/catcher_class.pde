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
  color c;
  Catcher(int _yLoc)
  {
    c = catcherColor[catcherWhich];//fills with customized color from story mode. normal color is the first option 
    yLoc = _yLoc;
    loc = new PVector(width/2, yLoc);
    maxAcc = .1;
    maxSpeed = 5;
    acc = new PVector(0, 0);
    initialX = loc.x;
    vel = new PVector(0, 0);
    d = 20;
  }
  void display()
  {
    fill(c);
    ellipse(loc.x, loc.y, d, d);
  }
  void autoMove(Raindrop[] wut)//automove will make the catcher move to where the raindrop will be when it is the same height as the catcher, the exact time it gets there
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
  void move()//regular movement
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
  boolean checkLightning(Lightning l)//if lightning appears, then the catcher can't move
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
  void wallStop()
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
  void portal()//the catcher will appear on the other side if it goes off the edge
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