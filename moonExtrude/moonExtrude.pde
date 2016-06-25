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
  colorMode(RGB,800);
  noLoop();
  
  //camera = new PeasyCam(this, width, height, 500, 125);
  //camera.setMinimumDistance(50);
  //camera.setMaximumDistance(10000);
  //camera.setYawRotationMode();
  //camera.setPitchRotationMode();
  //camera.setRollRotationMode();
}

void draw()
{
  //eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ
  //camera(0.0, 0.0, -500.0, width, height, 0.0, 0.0, 1.0, 0.0);
  rotateY(32);
  //translate(width, 0);
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
      //GRADIENT COLOR DEGISIMLERIYLE YUKSEKLIK BELLI ET EXTRUSION ISTEDIGIMIZ ETKIYI VERMEDI
      color c = img.get(i, j);
      int a = (c >> 24) & 0xFF;
      int r = (c >> 16) & 0xFF;
      int g = (c >> 8) & 0xFF;
      int b = c & 0xFF;
      if(r > 180) //<>//
      {
        //float len = pow(2, r)/pow(10,30);
        //float len = 2 * r;
        float len = pow(2,r/33);
        float h = random(i,j)/30;
        float s = random(i,j)/30;
        float ba = random(i,j)/30;
        stroke(i, j, 255);
        fill(i,j,0);
        //strokeWeight(len);
        //line(i, j, i, j, 0, len);
        pushMatrix();
        translate(i,j);
        box(3,3,len);
        popMatrix();
      }
    }
  }
}