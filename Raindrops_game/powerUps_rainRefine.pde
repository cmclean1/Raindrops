void goPower()
{
  displayPower = true;
  powerTime = millis();
  goPower = true;
  whichPower = int(random(4));
  if (whichPower == 0)
  {
    powerText = "Bigger Catcher!";
  }
  if(whichPower == 1)
  {
    powerText = "No Lightning!";
  }
  if(whichPower == 2)
  {
    powerText = "Invincible!";
  }
  if(whichPower == 3)
  {
    powerText = "Auto Move!";
  }
}
String powerText = " ";
boolean displayRefine;
int refineTime;
void goRefine()
{
  displayRefine = true;
  refineTime = millis();
  int random = int(random(3));
  if (random == 0)
  {
    totalRain+=9;//it adds less than what the text says since it already adds one when you originally catch it
    powerText = "+10 Raindrops!";
  }
  if (random == 1)
  {
    totalRain+=4;
    powerText = "+5 Raindrops!";
  }
  if (random == 2)
  {
    totalRain+=1;
    powerText = "+2 Raindrops!";
  }
}
void powerUps()
{
  if (whichPower == 0 && goPower)
  {
    storyCatch.d = 35+(catchUp.bought*5);
    gameCatch.d = 35;
  }
}

