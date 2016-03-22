boolean drawable = true;


void magic(int turn)
{
  if(turn>1)
  {
    for(int i = 0; i<6; ++i)
    {
      float tempX = cos(i * (PI/3)) * newSize/(turn-1) + midX;
      float tempY = sin(i * (PI/3)) * newSize/(turn-1) + midY;
      ++count;
      drawSphere(tempX, tempY, newSize);
    }
  }
  else
  {
    drawSphere(midX, midY, newSize);
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

void func(int turn, float coord_x, float coord_y, boolean drawable)
{
  if(turn>1 && drawable)
  {
      int nomi = 0;
      while(nomi / (3*(size-1)) != 2)
      {
        //println(nomi);
        float tempX = cos(nomi * (PI/(3*(size-1)))) * newSize/(turn) + midX;
        float tempY = sin(nomi * (PI/(3*(size-1)))) * newSize/(turn) + midY;

        //drawSphere(tempX, tempY, newSize);
        func(turn - 1, tempX, tempY, drawable);
        drawable = false;
        nomi++;
      }
      ++count;
      drawSphere(coord_x, coord_y, newSize);
      drawable = true;
  }
  else
  {
    drawSphere(coord_x, coord_y, newSize);
    ++count;
  }
  println(count);
}
  
void recuFlowerOfLife(int turn, float coord_x, float coord_y)
{
  //stroke(map(random(50),0,50,0,turn*250),55,random(255));
  //drawing surrounding circles
  if(turn > 1)
  {
    for(int i = 0; i < 6; ++i)
    {      
      float tempX = cos(i * (PI/3)) * newSize/2 + coord_x;
      float tempY = sin(i * (PI/3)) * newSize/2 + coord_y;
      print(tempX + " " + tempY + " " + turn + "\n");
      
      recuFlowerOfLife(turn - 1, tempX, tempY);
    }
    //circle of circles
  }
  else
  {
    drawSphere(coord_x, coord_y, turn*newSize);
    ++count;
    print("drew a circle at: " + coord_x + ", " + coord_y + ", " + turn + ", this big " + count + "\n" );
  }
}
void reguSeedOfLife(float coord_x, float coord_y, float bigPeri)
{
  //drawing the surrounding circle
  drawSphere(coord_x,coord_y,bigPeri);
  //calculating the small radius of circles inside
  float smallRadius = bigPeri/4;
  
  //loop for inner circles
  for(int i=0; i<6; ++i)
  {
    //0, 60, 120, 180, 240, 300 - degrees
    drawSphere(cos(i*(PI/3))*smallRadius+coord_x, sin(i*(PI/3))*smallRadius+coord_y, smallRadius*2);
  }
  //center circle
  drawSphere(coord_x, coord_y, smallRadius*2);
}

void drawMagic()
{
  
}

void drawSphere(float coord_x, float coord_y, float peri)
{
  ellipse(coord_x, coord_y, peri, peri);
}

void drawingHiTech()
{  
  //stroke(random(256),random(256),random(256),random(256));
  //recuFlowerOfLife(size, width*size/2, height*size/2);
  //func(size, width*size/2, height*size/2, drawable);
  //reguSeedOfLife(width*size/2,height*size/2,size*64);
  drawing(size);
}

void drawingMouseColored()
{
  stroke(pmouseX, pmouseY, mouseX);
  recuFlowerOfLife(size, width*size/2, height*size/2);
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
  noLoop();
}


void settings()
{
  //setting up the size of the window
  size(width * size, height * size);
}