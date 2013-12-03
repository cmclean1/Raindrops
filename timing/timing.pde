color c;
void setup()
{
  size(500, 500);
  c = color(random(255), random(255), random(255));
}
void draw()
{
  background(c);
  if (frameCount%200 == 0)
  {
    c = color(random(255), random(255), random(255));
  }
  textAlign(CENTER);
  text(frameCount, width/2, height/2);
}

