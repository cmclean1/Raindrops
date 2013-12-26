
class Upgrade {
  int x;
  int y;
  float cost;
  float costUp;
  int max;
  int bought;
  String name;
  Upgrade(int _x, int _y, int _max, float _costUp, String _name, int currentBought)
  {
    x = _x;
    y = _y;
    max = _max;
    costUp = _costUp;
    name = _name;
    bought = int(loadStory[currentBought]);
  }
  void display()
  {
    cost = (costUp)*(bought+1);
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
      if (totalRain < cost || bought == max)//highlights red if all upgrades are bought or if you don't have enough raindrops
      {
        fill(255, 0, 0);
      }
      else if (totalRain >= cost && bought < max)//highlights orange if conditions are met
      {
        fill(#FF7C00);
      }
    }
    ellipse(45+x, 65+y, 30, 30);
    for (int i = 60; i < 60+(max*10); i+=10)//makes rectangles to represent maximum number of total upgrades (white)
    {
      fill(255);
      rect(i+x, 50+y, 5, 30);
    }
    for (int i = 60; i < 60+(bought*10); i+=10)//fills recangles to represent number of bought upgrades (orange)
    {
      fill(#FF7C00);
      rect(i+x, 50+y, 5, 30);
    }
    fill(0, 0, 255);
    noStroke();
    ellipse(45+x, 70+y, 10, 10);
    triangle(40+x, 70+y, 50+x, 70+y, 45+x, 55+y);
  }
  void buy()
  {
    if (ifClicked() && bought < max)
    {
      if (totalRain >= cost)
      {
        totalRain-=cost;
        bought++;
      }
    }
  }
  boolean ifClicked()//a boolean function that finds out if the mouse is touching the circle
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

void upgrade()//increases certain values by a certain increment. only in story mode
{
  //for ever catchUp upgrade bought, catcher diameter will increase by 5
  storyCatch.d = 20+(catchUp.bought*5);
  //for every catchSpeed upgrade bought, maximum catcher speed will incrase by 0.2
  storyCatch.maxSpeed = 5+(catchSpeed.bought*.2);
  //catcher acceleration will increase by 0.025
  storyCatch.maxAcc = .1+(catchHandle.bought*.025);
  //the catchers y position will increase by 25
  storyCatch.loc.y = 250+(lowerScreen.bought*20);
  //lightning chance to appear will decrease by 1000 
  storyLight.random = 5000+(lightDown.bought*1000);
  //amount of lives will increase by 3
  storyLives = 10+(lifeUp.bought*3);
  //chance to keep life will increase by 1
  lossChance = 0+noLoss.bought;
  //raindrop size will increase by 1
  for (int j = 0; j <= gameRain.length-1; j++)
  {
    gameRain[j].d = 10+(rainUp.bought);
  }
}

