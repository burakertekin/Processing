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
  float prevX = 0;
  float prevY = 0;
  if(turn>1)
  {
    float angle = TWO_PI/6;
    for(float i=0;i<TWO_PI;i+=angle)
    {
      //algorithm for spheres at hexagon corners
      tempX = cos(i) * circleRadius*(turn-1)/2 + midX;
      tempY = sin(i) * circleRadius*(turn-1)/2 + midY;
      ++count;
      drawSphere(tempX, tempY, circleRadius);
      
      if(prevX != 0 && prevY !=0)
      {
        //we have a previous point that we can check
        PVector[] pts = divide(prevX,prevY,tempX,tempY,turn-1);
        for(int k=1;k < pts.length-1;++k)
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
    drawSphere(midX, midY, circleRadius);
    count++;
  }
}

void drawing(int turn)
{
  while(turn>0)
  {
    magic(turn);
    turn--;
  }
  println(count); //<>//
}

void drawSphere(float coord_x, float coord_y, float peri)
{
  ellipse(coord_x, coord_y, peri, peri);
}

void drawingHiTech()
{  
  stroke(random(256),random(256),random(256),random(256));
  drawing(size);
}

void drawingMouseColored()
{
  stroke(pmouseX, pmouseY, mouseX);
  drawing(size);
}

void draw()
{
  drawingHiTech();
  //drawingMouseColored();
  //line(pmouseX, pmouseY, mouseX, mouseY);
}


void setup()
{ 
  //black background
  background(0);
  //do not fill inside the geometries - circles
  noFill();
  //thickness of circles
  strokeWeight(2);
  //white stroke color
  stroke(255,255,255,255);
  //noLoop();
}


void settings()
{
  //setting up the size of the window
  size(width * size, height * size);
}