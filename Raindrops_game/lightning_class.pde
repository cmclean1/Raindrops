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
    int show = int(random(random));//the lighting has a 1 out of "value of random" chance to appear every frame
    if (show == 0)//the lighting will appear for 1 second
    {
      showTime = millis()+1000;
      return true;
    }
    return false;
  }
  void appear()
  {
    if (!goPower && whichPower != 1)
    {
      if (chance())
      {
        show = true;
      }
      if (millis() <= showTime && show == true)
      {
        int wut = int(random(5));//creates a flashing effect
        if (wut == 0)
        {
          background(255);
        }
        lightPlayer.setGain(-15);//plays the lightning sound effect
        lightPlayer.play();
      }
      else
      {
        show = false;
        showTime+=1000;
      }
      if (lightPlayer.isPlaying() == false)//rewinds the lightning sound effect so it can play again later once it stops playing
      {
        lightPlayer.pause();
        lightPlayer.rewind();
      }
    }
  }
}

