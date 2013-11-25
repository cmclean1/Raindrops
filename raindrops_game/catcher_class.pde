class Catcher
{
  PVector loc;
  PVector vel;
  PVector acc;
  Catcher()
  {
    loc = new PVector(width/2, 400);
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
  }
  void display()
  {
    fill(255);
    ellipse(loc.x, loc.y, 20, 20);
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
      acc.set(0,0);
    }
    vel.add(acc);
    loc.add(vel);
  }
}

