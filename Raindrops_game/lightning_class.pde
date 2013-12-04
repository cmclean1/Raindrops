class Lightning
{

  int random;
  int showTime;
  boolean show = false;
  Lightning(int _random)
  {
    random = _random;
  }
  boolean chance()
  {
    int show = int(random(random));
    if (show == 0)
    {
      showTime = millis()+1000;
      return true;
    }
    return false;
  }
  void appear()
  {
    if (chance())
    {
      show = true;
    }
    if (millis() <= showTime && show == true)
    {
      int wut = int(random(5));
      if (wut == 0)
      {
        background(255);
      }
      lightPlayer.setGain(-15);
      lightPlayer.play();
    }
    else
    {
      show = false;
      showTime+=1000;
    }
    if (lightPlayer.isPlaying() == false)
    {
      lightPlayer.pause();
      lightPlayer.rewind();
    }
  }
}

