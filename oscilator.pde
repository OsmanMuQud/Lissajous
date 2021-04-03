class oscilator
{
  PVector pos;
  float amp=0;
  float t_period;
  float offsetY=0;
  float offsetX=0;
  oscilator(PVector pos_,float amp_,float t_period_,float offsetY_,float offsetX_)
  {
    pos=pos_;
    amp=amp_;
    t_period=t_period_;
    offsetY=offsetY_;
    offsetX=offsetX_;
  }
  float getY()
  {
    return(pos.y+amp*sin((2*PI/t_period)*time+offsetY));
  }
  float getX()
  {
    return(pos.x+amp*cos((2*PI/t_period)*time+offsetX));
  }
}
