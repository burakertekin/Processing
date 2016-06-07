import peasy.*;
PeasyCam camera;

String filename = "moon.jpg";
PImage img;
int width;
int height;
int div = 3;
int pixelCount;
ArrayList<pixel> pts = new ArrayList<pixel>();

class pixel
{
  float x;
  float y;
  color col;
}
 //<>//
void setup()
{
  size(100,100, P3D);
  img = loadImage(filename);
  img.resize(img.width/div, img.height/div);
  width = img.width;
  height = img.height;
  frame.setSize(width, height);
  pixelCount = img.width * img.height;
  
  background(0);
  stroke(255);
  //noLoop();
  pushMatrix();
  //rotateX(60);
  camera(width, 0.0, 50.0, width/2, height/2, -10.0, 0.0, 1.0, 0.0);
  popMatrix();
  camera = new PeasyCam(this, width/2, height/2, 500, 255);
  camera.setMinimumDistance(50);
  camera.setMaximumDistance(10000);
  //camera.setYawRotationMode();
  //camera.setPitchRotationMode();
  //camera.setRollRotationMode();
}

void draw()
{
  //eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ
  //camera(0.0, 0.0, -1000.0, width, height, 0.0, 0.0, 1.0, 0.0);
  clear();
  getPts(); //<>//
}

void getPts()
{
  pts.clear();
  img.loadPixels();
  for(int i=0;i<width;++i)
  {
    for(int j=0;j<height;++j)
    {
      color c = img.get(i, j);
      int a = (c >> 24) & 0xFF;
      int r = (c >> 16) & 0xFF;
      int g = (c >> 8) & 0xFF;
      int b = c & 0xFF;
      if(r != 0) //<>//
      {
        //float len = pow(2, r)/pow(10,30);
        float len = 2 * r/100;
        stroke(r, r, r);
        strokeWeight(len);
        line(i, j, i, j, 0, len);
      }
    }
  }
}