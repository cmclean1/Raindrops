Raindrop r;
Catcher c;
void setup()
{
  // frameRate(5);
  size(500, 500);
  r = new Raindrop();
  c = new Catcher();
}
void draw()
{
  background(0);
  r.display();
  r.move();
  c.move();
  c.display();
}

