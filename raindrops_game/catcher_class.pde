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
    acc.set(((width/2)-mouseX)/300, 0);
    vel.add(acc);
    loc.add(vel);
  }
}

