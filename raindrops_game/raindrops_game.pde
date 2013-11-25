Raindrop[] r;
Catcher c;
int wut = 0;
int time;
void setup()
{
  size(500, 500);
  r = new Raindrop[50];

  c = new Catcher();
}
void draw()
{
  background(0);
  r[wut] = new Raindrop();
  for (int i = 0; i < wut; i++)
  {
    r[i].display();
    r[i].move();
  }
  if (millis() >= time)
  {
    wut++;
    if(wut >= 50)
    {
      wut = 0;
    }
    time+=2000;
  }
  c.move();
  c.display();
}

