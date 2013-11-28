class Raindrop
{
  PVector loc;
  PVector vel;
  PVector acc;
  int d;
  boolean caught;
  Raindrop()
  {
    loc = new PVector(random(width), d/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, .01);
    d = 10;
    caught = false;
  }
  void display()
  {
    fill(0, 0, 255);

    noStroke();
    ellipse(loc.x, loc.y, d, d);
    triangle(loc.x-d/2, loc.y, loc.x+d/2, loc.y, loc.x, loc.y-(vel.y*5));
  }
  void move()
  {
    if (!caught)
    {
      acc.set(0, 0.1);
      vel.add(acc);
      loc.add(vel);
    }
    else
    {
      acc.set(0,0);
      vel.set(0,0);
      loc.y = -100;
    }
  }
  void checkCatcher(Catcher catcher)
  {
    if (dist(loc.x, loc.y, catcher.loc.x, catcher.loc.y) <= (d/2)+(catcher.d/2))
    {
      caught = true;
      score++;
      Time-=100;
    }
  }
}

