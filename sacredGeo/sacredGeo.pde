import codeanticode.syphon.*;

SyphonServer server;

PVector[] divide(float x1, float y1, float x2, float y2, int n)
{    
 /**
 * @author Ale Gonzalez
 * @param x1    x-coordinate of the beginning of the segment
 * @param y1    y-coordinate of the beginning of the segment
 * @param x2    x-coordinate of the ending of the segment
 * @param y2    y-coordinate of the ending of the segment
 * @param n     number of parts to divide the segment
 * @return      a PVector array containing the positions of the division points, including the extreme points passed to the method
 */
  float dx = (x2-x1)/n, dy = (y2-y1)/n;
  PVector[] p = new PVector[n+1];
  p[0] = new PVector(x1, y1);
  for (int i = 0; i < n; i++) p[i+1] = new PVector(p[i].x+dx, p[i].y+dy);      
 
  return p;
}

void magic(int turn)
{
  float tempX, tempY;
  float prevX = -5;
  float prevY = -5;
  if(turn>1)
  {
    float angle = TWO_PI/6;
    for(float i=0;i<TWO_PI;i+=angle)
    {
      //algorithm for spheres at hexagon corners
      tempX = cos(i) * circleDistance*(turn-1)/2;
      tempY = sin(i) * circleDistance*(turn-1)/2;
      ++count;
      //drawSphere(tempX, tempY, circleRadius);
      
      if(prevX != -5 && prevY != -5)
      {
        //we have a previous point that we can check
        PVector[] pts = divide(prevX,prevY,tempX,tempY,turn-1);
        for(int k=0;k < pts.length-1;++k)
        {
          ++count;
          drawSphere(pts[k].x, pts[k].y, circleRadius);
        }
        
      }
      //jumping to the next pair
      prevX = tempX;
      prevY = tempY;
      }
    }
  else
  {
    drawSphere(0, 0, circleRadius);
    count++;
  }
}

void drawing(int turn)
{
  while(turn>0)
  {
    stroke(random(256),random(256),random(256),256/(turn*2));
    //stroke(random(256),random(256),random(256),alphaVal);
    magic(turn);
    turn--;
  } //<>//
}

void drawSphere(float coord_x, float coord_y, float peri)
{
  //randomisation of radius and color
  //stroke(random(100),random(100),random(100),random(100));
  //peri = peri * random(0.9  , 1.2);
  //drawing a circle
  ellipse(coord_x, coord_y, peri, peri);
}

void drawingHiTech()
{  
  //stroke(random(256),random(256),random(256),random(256));
  drawing(size);
}

void drawingMouseColored()
{
  stroke(pmouseX, pmouseY, mouseX);
  drawing(size);
}

void draw()
{
  circleRadius = int(64 * sin(radians(frameCount/2)));
  size = int(random(1,20));
  pushMatrix();
  //translating the shape to middle point
  translate(midX,midY);
  rotate(rotator*TWO_PI/360);
  rotator+=rotationSpeed;
  drawingHiTech();
  popMatrix();
  
  
  if(mousePressed)
  {
    clear();
  }
  
  /*
  if(!mousePressed && alphaVal<255)
    ++alphaVal;
  else if(mousePressed && alphaVal>0)
    --alphaVal;
    */
  
  //drawingMouseColored();
  //line(pmouseX, pmouseY, mouseX, mouseY);
  server.sendScreen();
}


void setup()
{ 
  //black background
  background(0);
  //do not fill inside the geometries - circles
  noFill();
  //thickness of circles
  strokeWeight(1);
  //white stroke color
  stroke(255,255,255,255);
  //noLoop();
  //frameRate(1);
  server = new SyphonServer(this, "Processing Syphon");
}


void settings()
{
  //setting up the size of the window
  size(width * size, height * size, P2D);
  PJOGL.profile=1;
}