class Catcher
{
  PVector loc;
  PVector vel;
  PVector acc;
  int d;
  float initialX;
  int nextRain = 0;
  boolean iCaughtIt = false;
  Catcher()
  {
    loc = new PVector(width/2, 400);
    acc = new PVector(0, 0);
    initialX = loc.x;
    vel = new PVector(0, 0);
    d = 20;
  }
  void display()
  {
    fill(255);
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
      acc.set(-0.1, 0);
    }
    else if (keyPressed && keyCode == RIGHT)
    {
      acc.set(0.1, 0);
    }
    else
    {
      acc.set(0, 0);
    }
    if (loc.x >= width-(d/2) || loc.x <= d/2 )
    {
      vel.x = 0;
      acc.x = 0;
      if (loc.x >= width-(d/2))
      {
        loc.x --;
      }
      else
      {
        loc.x++;
      }
    }
    vel.add(acc);
    loc.add(vel);
  }
  boolean checkLightning(Lightning l)
  {
    if(l.show == true)
    {
      acc.set(0,0);
      vel.set(0,0);
      return true;
    }
    else
    {
      return false;
    }
  }
}

