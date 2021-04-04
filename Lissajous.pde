oscilator oscis[];
int n=6;
int start=0;
PGraphics lissi;
int bgc=25;
float timeP=60;
float amplitude;
int total;
int thickness;
float time=0;
float increment=1;

void setup()
{ 
  size(5000,5000);
  
  //swaps and makes larger no to be n
  if(n<start)
  {
    int temp=start;
    start=n;
    n=temp;
  }
  
  //initializes important variables
  total=n-start;
  thickness=width/(10*total);
  oscis=new oscilator[total];
  lissi=createGraphics(width,height);
  amplitude=width/(2*(total+1))-thickness;
  
  //initializes all the waves with different time period
  for(int i=0;i<total;i++)
  {
    float x= (i+1.5)*(width-thickness)/(total+1);
    float y= (i+1.5)*(height-thickness)/(total+1);    
    oscis[i]=new oscilator(new PVector(x,y),amplitude,timeP*(i+start+increment),0,0);
  }
  background(bgc);
  
  //prepares the background for graphic
  lissi.beginDraw();
  lissi.background(bgc);
  lissi.endDraw();
}
void draw()
{
  
  time+=1;//increments time
  
  lissi.colorMode(HSB,360,100,100);
  lissi.beginDraw();
  
  for(int i=0;i<total;i++)
  {
    for(int j=0;j<total;j++)
    {
      //draws points for the corresponding lissajous
      lissi.strokeWeight(0.5*thickness);
      lissi.stroke(colorMap(i+j,total));
      lissi.point(oscis[i].getX(),oscis[j].getY());
    }
  }
  //checks if the slowest completes(-ve value should not exceed +value)
  if(time>(timeP*max(abs(start-1),n)*((max(abs(start-1),n))==1?1:(n-increment))))
  {
    time=0;
    //saves the final result
    saveFrame("/Result.png");
    lissi.background(bgc);
  }
  
  lissi.endDraw();
  
  background(lissi);
  for(int i=0;i<total;i++)
  {
    
    //guidelines
    colorMode(RGB,255);
    noFill();
    stroke(255,100);
    strokeWeight(0.3*thickness);
    line(oscis[i].getX()-oscis[i].pos.x+width/(2*(total+1)),oscis[i].getY(),width,oscis[i].getY());
    line(oscis[i].getX(),oscis[i].getY()-oscis[i].pos.y+height/(2*(total+1)),oscis[i].getX(),height);
    
    //making first row and first column of circles
    colorMode(HSB,360,100,100);
    strokeWeight(0.5*thickness);
    stroke(colorMap(i*2,total));
    circle(oscis[i].pos.x,height/(2*(total+1)),2*oscis[i].amp);
    circle(width/(2*(total+1)),oscis[i].pos.y,2*oscis[i].amp);
    
    //marking points on first row and column of circles
    stroke(0);
    strokeWeight(0.8*thickness);
    point(oscis[i].getX()-oscis[i].pos.x+width/(2*(total+1)),oscis[i].getY());
    point(oscis[i].getX(),oscis[i].getY()-oscis[i].pos.y+height/(2*(total+1)));
    
    //Writing time period on circles
    textAlign(CENTER);
    textSize(amplitude/2);
    text(start+i+1,oscis[i].pos.x,(height/(2*(total+1)))+amplitude/4);
    text(start+i+1,(width/(2*(total+1))),oscis[i].pos.y+amplitude/4);
   
  }
  
  //making points on intersection of guidelines
   stroke(0);
   strokeWeight(0.8*thickness);
  for(int i=0;i<total;i++)
  {  
     for(int j=0;j<total;j++)
     {
        point(oscis[i].getX(),oscis[j].getY());
     }
  }
  //noLoop();
}

//function to get color from index of lissajous
int colorMap(int c,int total_)
{
  return color(map(c,0,(total==1?1:total_-1)*2,20,360),30,100);
}

//takes screenshot on clicking on screen
void mousePressed()
{
  saveFrame("/Screenshot.png");
}
