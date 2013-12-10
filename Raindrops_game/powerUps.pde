String powerText = " ";
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
}
