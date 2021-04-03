class oscilator
{
  PVector pos;
  float amp=0;
  float t_period;
  oscilator(PVector pos_,float amp_,float t_period_)
  {
    pos=pos_;
    amp=amp_;
    t_period=t_period_;
  }
  float getY()
  {
    return(pos.y+amp*sin((2*PI/t_period)*time));
  }
  float getX()
  {
    return(pos.x+amp*cos((2*PI/t_period)*time));
  }
}
