Upgrade wut;
int totalRain = 100;

class Upgrade {
  int x;
  int y;
  float cost;
  float costUp;
  int max;
  int bought;
  String name;
  Upgrade(int _x, int _y, int _max, float _cost, float _costUp, String _name, int currentBought)
  {
    x = _x;
    y = _y;
    max = _max;
    cost = _cost;
    costUp = _costUp;
    name = _name;
    bought = int(loadStory[currentBought]);
  }
  void display()
  {
    fill(255);
    textAlign(LEFT);
    textSize(10);
    if (bought != max)
    {
      text(int(cost), x+35, y+93);
    }
    else if (bought == max)
    {
      text("ALL BOUGHT", x+30, y+93);
    }
    textSize(8);
    textAlign(LEFT);
    text(name, x+30, y+45);
    if (ifClicked())
    {
      if (totalRain < cost || bought == max)
      {
        fill(255, 0, 0);
      }
      else if (totalRain >= cost && bought < max)
      {
        fill(#FF7C00);
      }
    }
    ellipse(45+x, 65+y, 30, 30);
    for (int i = 60; i < 60+(max*10); i+=10)
    {
      fill(255);
      rect(i+x, 50+y, 5, 30);
    }
    for (int i = 60; i < 60+(bought*10); i+=10)
    {
      fill(#FF7C00);
      rect(i+x, 50+y, 5, 30);
    }
    fill(0, 0, 255);
    noStroke();
    ellipse(45+x, 70+y, 10, 10);
    triangle(40+x, 70+y, 50+x, 70+y, 45+x, 55+y);
    fill(0, 0, 255, 100);
  }
  void buy()
  {
    if (ifClicked() && bought < max)
    {
      if (totalRain >= cost)
      {
        totalRain-=cost;
        cost = cost*costUp;
        bought++;
      }
    }
  }
  boolean ifClicked()
  {
    if (dist(mouseX, mouseY, 45+x, 65+y) < 15 && storyLoc == 2)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

void upgrade()
{
  for (int i = 0; i < catchUp.bought; i+=1)
  {
    storyCatch.d = 20+(i*5);
  }
  for (int i = 0; i < catchSpeed.bought; i+=1)
  {
    storyCatch.maxSpeed = 5+(i*.2);
  }
  for (int i = 0; i < catchHandle.bought; i+=1)
  {
    storyCatch.maxAcc = .01+(i*.025);
  }
  for (int i = 0; i < lowerScreen.bought; i+=1)
  {
    storyCatch.loc.y = 250+(i*25);
  }
  for (int i = 0; i < lightDown.bought; i+=1)
  {
    storyLight.random = 5000+(i*1000);
  }
  for (int i = 0; i <= lifeUp.bought; i++)
  {
    storyLives = 10+(i*3);
  }
  for (int i = 0; i <= noLoss.bought; i++)
  {
    lossChance = 0+i;
  }
  for (int i = 0; i <= rainSlow.bought; i++)
  {
    for (int i = 0; i <= gameRain.length; i++)
    {
      gameRain.changeV = .1-(i*.01);
    }
  }
}

