import peasy.*;

PeasyCam cam;
int width = 500;
int height = 500;
int diam = 200;
float rot = 0;

void settings()
{
  size(width, height, P3D);
}

void setup()
{
  background(125,125,125);
  //noFill();
  //stroke(255);
  noStroke();

  //cam = new PeasyCam(this,0);
  //cam.setMinimumDistance(50);
  //cam.setMaximumDistance(500);
}

void draw()
{
  translate(width/2, height/2);
  clear();
  int r = 50;
  draw2D();
  /*
  rotateY(rot);
  halfSphere(24,24,50);
  rotateZ(90);
  translate(0,25,0);
  halfSphere(24,24,50);
  rot += 0.01;
  */
}

void halfSphere(int scaleX, int scaleY, float radius)
{
  //https://www.opengl.org/discussion_boards/showthread.php/159402-half-sphere
  
  float[][] v = new float[scaleX*scaleY][3];
  for(int i=0; i<scaleX;++i)
  {
    for(int j=0; j<scaleY;++j)
    {
      v[i*scaleY+j][0] = radius * cos(j*2*PI/scaleY)*cos(i*PI/(2*scaleX));
      v[i*scaleY+j][1] = radius * sin(i*PI/(2*scaleX));
      v[i*scaleY+j][2] = radius * sin(j*PI/scaleY)*cos(i*PI/(2*scaleX));     
    }
  }
  
  beginShape(QUADS);
  for(int i=0;i<scaleX-1;++i)
  {
    for(int j=0;j<scaleY;++j)
    {
      vertex(v[i*scaleY+j][0],v[i*scaleY+j][1],v[i*scaleY+j][2]);
      vertex(v[i*scaleY+(j+1)%scaleY][0],v[i*scaleY+(j+1)%scaleY][1],v[i*scaleY+(j+1)%scaleY][2]);
      vertex(v[(i+1)*scaleY+(j+1)%scaleY][0],v[(i+1)*scaleY+(j+1)%scaleY][1],v[(i+1)*scaleY+(j+1)%scaleY][2]);
      vertex(v[(i+1)*scaleY+j][0],v[(i+1)*scaleY+j][1],v[(i+1)*scaleY+j][2]);
    }
  }
  endShape();
}

void draw3D()
{

}

void draw2D()
{
  //http://www.openprocessing.org/sketch/200670
  pushMatrix();
  rotateX(rot);
  fill(0);
  arc(0,0,diam, diam, PI/2,PI+PI/2);
  popMatrix();
  pushMatrix();
  rotateZ(rot);
  fill(255);
  arc(0,0,diam, diam, PI+PI/2,TWO_PI+PI/2);
  popMatrix();
  pushMatrix();
  rotateX(rot);
  fill(0);
  ellipse(0,-diam/4, diam/2, diam/2);
  popMatrix();
  pushMatrix();
  rotateZ(rot);
  fill(255);
  ellipse(0,diam/4, diam/2, diam/2);
  popMatrix();
  pushMatrix();
  rotateX(rot);
  fill(0);
  ellipse(0,diam/4, diam/8, diam/8);
  popMatrix();
  pushMatrix();
  rotateZ(rot);
  fill(255);
  ellipse(0,-diam/4, diam/8, diam/8);
  popMatrix();
  rot += 0.1;
}