class Timer
{
  int startTime;
  int howmuchTime;
  boolean declareTime = true;
  int passedTime = 0;
  Timer(int _howmuchTime)
  {
    howmuchTime = _howmuchTime;
  }
  boolean go()
  {
    if (ifTime())
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
      startTime = millis() + howmuchTime;
      declareTime = false;
    }
    if (millis() >= startTime)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

