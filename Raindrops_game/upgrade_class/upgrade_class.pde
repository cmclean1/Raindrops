Upgrade wut;
void setup()
{
  size(500, 500);
  wut = new Upgrade(0, 0);
}
void draw()
{
  background(0);
  wut.display();
}
class Upgrade {
  int x;
  int y;
  Upgrade(int _x, int _y)
  {
    x = _x;
    y = _y;
  }
  void display()
  {
    fill(255);
    if (dist(mouseX,mouseY,45+x,65+y) < 15)
    {
      fill(#FF7C00);
    }
    ellipse(45+x, 65+y, 30, 30);
    for (int i = 60; i < 150; i+=10)
    {
      fill(255);
      rect(i+x, 50+y, 5, 30);
    }
    fill(0, 0, 255);
    noStroke();
    ellipse(45+x, 70+y, 10, 10);
    triangle(40+x, 70+y, 50+x, 70+y, 45+x, 55+y);
  }
}

