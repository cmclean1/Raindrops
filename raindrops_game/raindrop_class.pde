class Raindrop
{
  PVector loc;
  PVector vel;
  PVector acc;
  int d;
  Raindrop()
  {
    loc = new PVector(random(width), 0);
    vel = new PVector(0, 0);
    acc = new PVector(0, .01);
    d = 10;
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
    vel.add(acc);
    loc.add(vel);
  }
}

