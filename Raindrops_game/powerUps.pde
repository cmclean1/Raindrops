//powerups do not work at the time
/*;
boolean displayPower;
int powerTime;
void goPower()
{
  displayPower = true;
  powerTime = millis();
  int random = int(random(1));
  if (random == 0)
  {
    score+=9;
    powerText = "10 Points!";
  }
  if(random == 1)
  {
    powerText = "Bigger Catcher!";
  }
}*/
String powerText = " ";
boolean displayRefine;
int refineTime;
void goRefine()
{
  displayRefine = true;
  refineTime = millis();
  int random = int(random(3));
  if(random == 0)
  {
    totalRain+=9;//it adds less than what the text says since it already adds one when you originally catch it
    powerText = "+10 Raindrops!";
  }
  if(random == 1)
  {
    totalRain+=4;
    powerText = "+5 Raindrops!";
  }
    if(random == 2)
  {
    totalRain+=1;
    powerText = "+2 Raindrops!";
  }
}
