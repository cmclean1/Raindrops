class Catcher
{
  PVector loc;
  PVector vel;
  PVector acc;
  int d;
  Catcher()
  {
    loc = new PVector(width/2, 400);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
    d = 20;
  }
  void display()
  {
    fill(255);
    ellipse(loc.x, loc.y, d, d);
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
}

