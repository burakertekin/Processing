String filename = "moss.jpg"; //<>//
PImage img, img2;
int width;
int height;
int pixelCount;
//division size for pts and lines
int div;
int divSize = 15000;
//geometry size
float circleSize = 4;
float lineThickness = 0.7;
int divide = 2;

void settings()
{
  img = loadImage(filename);
  img.resize(img.width/divide, img.height/divide);
  width = img.width;
  height = img.height;
  size(img.width, img.height);
  pixelCount = img.width * img.height;
}

class points
{
  //coordinate and index values
  float x;
  float y;
  color col;
}

//dynamic array of points to be drawn
ArrayList<points> darkPts = new ArrayList<points>();
ArrayList<points> darkLinePts = new ArrayList<points>();
ArrayList<points> lightPts = new ArrayList<points>();
ArrayList<points> lightLinePts = new ArrayList<points>();

void setup()
{
  div = pixelCount / divSize;
  smooth(4);
  //loading the image
  //img = loadImage(filename);
  //img.resize(img.width/2, img.height/2);

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
  darkPts.clear();
  lightPts.clear();
  img.loadPixels();
  int darkcount = 0;
  int lightcount = 0;
  for (int i =0; i<width; ++i)
  {
    for (int j=0; j<height; ++j)
    {
      color c = img.get(i, j);
      if (blue(c) < 125 && red(c) < 125 && green(c) < 125)
      {
        points temp = new points();
        temp.x = i;
        temp.y = j;
        temp.col = c;
        darkPts.add(temp);
        if (darkcount % div == 0)
        {
          darkLinePts.add(temp);
        }
        ++darkcount;
      } 
      else
      {
        points temp = new points();
        temp.x = i;
        temp.y = j;
        temp.col = c;
        lightPts.add(temp);
        if (lightcount % div == 0)
        {
          lightLinePts.add(temp);
        }
        ++lightcount;
      }
    }
  }
  //pixel count of black pixels
  println("dark pixel count: " + darkcount);
  println("light pixel count: " + lightcount);
}

void draw()
{
  background(155);
  //color of the circles
  //fill (#2822F0);
  //color of the lines
  //stroke (#DBEBFF);
  strokeWeight (lineThickness);

  //show image as background - faded
  img2 = loadImage(filename);
  img2.resize(width, height);
  tint(255, 177);
  //image(img2, 0, 0);

  fillArray();
  drawLines(darkLinePts);
  drawLines(lightLinePts);
  darkLinePts.clear();
  lightLinePts.clear();
  //drawCircles(darkPts, darkLinePts);
  //drawCircles(lightPts, lightLinePts);
  
  //save the output
  String outputFile = filename.substring(0,filename.length()-4);
  println("output: " + outputFile + ".jpg");
  save(outputFile+"_lineart.jpg");
}

void drawLines(ArrayList<points> linePts)
{
  for (int i = 0; i < linePts.size(); ++i)
  {
    points temp1 = linePts.get(i);
    float x1 = temp1.x;
    float y1 = temp1.y;
    color c1 = temp1.col;

    for (int j = i+1; j < linePts.size(); ++j)
    {
      points temp2 = linePts.get(j);
      float x2 = temp2.x;
      float y2 = temp2.y;
      color c2 = temp2.col;

      float distance = dist (x1, y1, x2, y2);

      if (distance > 10 && distance < 30)
      {
        stroke(avgColor(c1, c2));
        line (x1, y1, x2, y2);
      }
    }
  }
}

void drawCircles(ArrayList<points> pts, ArrayList<points> linePts)
{
  for (int i = 0; i < pts.size(); i += div)
  {
    points temp = pts.get(i);
    float x = temp.x;
    float y = temp.y;
    linePts.add(temp);

    color asd = complement(temp.col);

    fill(red(asd), green(asd), blue(asd));

    ellipse (x, y, circleSize, circleSize);
  }
}

color complement(color original)
{
  float R = red(original);
  float G = green(original);
  float B = blue(original);
  float minRGB = min(R, min(G, B));
  float maxRGB = max(R, max(G, B));
  float minPlusMax = minRGB + maxRGB;
  color complement = color(minPlusMax-R, minPlusMax-G, minPlusMax-B);
  return complement;
}

color avgColor(color c1, color c2)
{
  float r1 = red(c1);
  float g1 = green(c1);
  float b1 = blue(c1);
  float r2 = red(c2);
  float g2 = green(c2);
  float b2 = blue(c2);
  color avg = color((r1+r2)/2, (g1+g2)/2, (b1+b2)/2);
  return avg;
}