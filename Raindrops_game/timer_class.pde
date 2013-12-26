class Timer
{
  int startTime;//will be current value of millis plus howmuchTime
  int howmuchTime;//interval value
  boolean declareTime = true;//controls when to change value of startTime
  Timer(int _howmuchTime)
  {
    howmuchTime = _howmuchTime;//declare time interval needed in millis
  }
  boolean go()
  {
    if (ifTime())//if time is up, make declareTime true again so startTime can change value
    {
      declareTime = true;
      return true;
    }
    else
    {
      return false;
    }
  }
  boolean ifTime()
  {
    if (declareTime == true)
    {
      startTime = millis() + howmuchTime;//startTime becomes current millis plus howmuchTime
      declareTime = false;//keeps this if statement from happening more than once
    }
    if (millis() >= startTime)//return true if time is up
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

