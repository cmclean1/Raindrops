Raindrop[] r;

Catcher c;
int wut = 0;
int time = 2000;
int score;
int Time = 2000;
void setup()
{
  size(500, 500);
  r = new Raindrop[1];
  c = new Catcher();
  r[0] = new Raindrop();
}
void draw()
{
  background(0);
  for (int i = 0; i < r.length; i++)
  {
    r[i].display();
    r[i].move();
    r[i].checkCatcher(c);
  }
  if (millis() >= time)
  {
    r = (Raindrop[]) append(r, new Raindrop());
    time+=Time;
  }
  //c.move();
  c.display();
  c.autoMove(r);
  fill(255);
  text("Score: " + score, 420, 50);
}

