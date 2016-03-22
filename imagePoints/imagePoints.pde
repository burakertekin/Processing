int width = 2560/2;
int height = 1600/2;
String filename = "forest1.jpg";

void settings()
{
  size(width, height);
}

class points
{
  //coordinate and index values
  float x;
  float y;
  color col;
}

//image object
PImage img, img2;

//dynamic array of points to be drawn
ArrayList<points> pts = new ArrayList<points>();
ArrayList<points> linePts = new ArrayList<points>();

//division size for pts and lines
int div = 100;

//geometry size
float circleSize = 6;
float lineThickness = 0.7;

void setup()
{
  smooth(4);
  //loading the image
  img = loadImage(filename);
  img.resize(width, height);
  
  //black and white filter
  //img.filter(THRESHOLD, 0.2);
  
  //gray filter
  //img.filter(GRAY);
  
  //blur filter
  //img.filter(BLUR, 6);
  
  //erode filter
  //img.filter(ERODE);
  
  //dilate filter
  //img.filter(DILATE);
  
  //cartoonish look
  //img.filter(POSTERIZE, 2);
  
  //negative
  //img.filter(INVERT);
  
  //no animation
  noLoop();
}

void fillArray()
{
  pts.clear();
  img.loadPixels();
  int count = 0;
  for(int i =0; i<width; ++i)
  {
    for(int j=0; j<height; ++j)
    {
      color c = img.get(i,j);
      if(blue(c) < 100 && red(c) < 100 && green(c) < 100)
      {
        points temp = new points();
        temp.x = i;
        temp.y = j;
        temp.col = c;
        pts.add(temp);
        if(count % div == 0)
        {
          linePts.add(temp);
        }
        ++count;
      }
    }
  }
  //pixel count of black pixels
  print("pixel count: " + count + "\n");
}

void draw()
{
  background(155);
  //color of the circles
  //fill (#2822F0);
  //color of the lines
  stroke (#DBEBFF);
  strokeWeight (lineThickness);
  
  //show image
  img2 = loadImage(filename);
  img2.resize(width, height);
  tint(255,177);
  //image(img2, 0, 0);
  
  fillArray(); //<>//
  drawLines();
  linePts.clear();
  drawCircles();
  
}

void drawLines()
{
  for(int i = 0; i < linePts.size(); ++i)
  {
    points temp1 = linePts.get(i);
    float x1 = temp1.x;
    float y1 = temp1.y;
 
    for(int j = i+1; j < linePts.size(); ++j)
    {
      points temp2 = linePts.get(j);
      float x2 = temp2.x;
      float y2 = temp2.y;
 
      float distance = dist (x1, y1, x2, y2);
 
      if (distance > 10 && distance < 30)
      {
        line (x1, y1, x2, y2);
      }
    }
  }
}
 
void drawCircles()
{
  for(int i = 0; i < pts.size(); i += div)
  {
    points temp = pts.get(i);
    float x = temp.x;
    float y = temp.y;
    linePts.add(temp);
    
    color asd = complement(temp.col);
    
    println(red(temp.col));
    fill(red(asd), green(asd), blue(asd));
   
    ellipse (x, y, circleSize, circleSize);
  }
}

color complement(color original)
{
  float R = red(original);
  float G = green(original);
  float B = blue(original);
  float minRGB = min(R,min(G,B));
  float maxRGB = max(R,max(G,B));
  float minPlusMax = minRGB + maxRGB;
  color complement = color(minPlusMax-R, minPlusMax-G, minPlusMax-B);
  return complement;
}