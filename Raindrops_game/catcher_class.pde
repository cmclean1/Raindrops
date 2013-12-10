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
    c = catcherColor[catcherWhich];    
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
  void autoMove(Raindrop[] wut)
  {
    acc.set(0, 0);
    nextRain = 0;
    while (wut[nextRain].caught == true)
    {
      nextRain++;
      if (nextRain >= wut.length)
      {
        return;
      }
    }
    if (iCaughtIt == true)
    {
      wut[nextRain].checkheight();
    }
    iCaughtIt = false;
    vel.set((wut[nextRain].loc.x-initialX)/wut[nextRain].distance, 0);
    loc.add(vel);
  }
  void move()
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
    if (portalGun.bought == 1 && location == 3)
    {
      portal();
    }
    else
    {
      wallStop();
    }
    vel.add(acc);
    if (vel.x > maxSpeed)
    {
      vel.set(maxSpeed, 0);
    }
    else if (vel.x < -maxSpeed)
    {
      vel.set(-maxSpeed, 0);
    }
    loc.add(vel);
  }
  boolean checkLightning(Lightning l)
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
    if (loc.x >= width-(d/2))
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
  void portal()
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

