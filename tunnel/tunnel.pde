int tunnelRadius = 30;
int tunnelSides = 18;
int tunnelDepth = 50;//50;
int cylinderRadius = 5;
int cylinderHeight = 20;
coord[] c;
float rot = 0.02;
int rot_count = 75;
boolean forward = true;

class coord
{
  float x, y, z, angle;
  int rot;
  
  coord(float _x, float _y, float _z, float _angle)
  {
    x = _x;
    y = _y;
    z = _z;
    angle = _angle;
    rot = 0;
  }
}

void cylinder(float bot, float top, float h, int sides)
{
  //cone drawing function Cylinder retrieved from:
  //"https://forum.processing.org/one/topic/draw-a-cone-cylinder-in-p3d.html"
  pushMatrix();
  translate(0, h/2, 0);

  float angle;
  float[] x = new float[sides+1];
  float[] z = new float[sides+1];

  float[] x2 = new float[sides+1];
  float[] z2 = new float[sides+1];

  //get the x and z position on a circle for all the sides
  for (int i=0; i < x.length; ++i)
  {
    angle = TWO_PI/(sides) * i;
    x[i] = sin(angle) * bot;
    z[i] = cos(angle) * bot;
  }

  for (int i=0; i < x.length; ++i)
  {
    angle = TWO_PI/(sides) * i;
    x2[i] = sin(angle) * top;
    z2[i] = cos(angle) * top;
  }

  //draw the bottom of the cylinder
  beginShape(TRIANGLE_FAN);
  vertex(0, -h/2, 0);

  for (int i=0; i < x.length; ++i)
  {
    vertex(x[i], -h/2, z[i]);
  }
  endShape();

  //draw the center of the cylinder
  beginShape(QUAD_STRIP);
  for (int i=0; i < x.length; ++i)
  {
    vertex(x[i], -h/2, z[i]);
    vertex(x2[i], h/2, z2[i]);
  }
  endShape();

  //draw the top of the cylinder
  beginShape(TRIANGLE_FAN);
  vertex(0, h/2, 0);

  for (int i=0; i < x.length; ++i)
  {
    vertex(x2[i], h/2, z2[i]);
  }
  endShape();

  popMatrix();
}

void setup()
{
  size(600, 600, P3D);
  background(0);
  //frameRate(24);

  c = new coord[(tunnelSides) * tunnelDepth];
  //tunnel coordinates
  int count = 0;
  float angle;
  for (int z=0; z < tunnelDepth; z++)
  {
    for (int i=0; i < tunnelSides; ++i)
    { //<>//
      angle = TWO_PI/(tunnelSides) * i;
      float x = sin(angle) * tunnelRadius;
      float y = cos(angle) * tunnelRadius;
      angle = (TWO_PI/tunnelSides*(tunnelSides/2)) - angle;//0.34906587 for 18 sides - 20 degrees angle
      
      c[count] = new coord(x, y, -z, angle);
      count++;
    }
  }
}

void draw()
{
  clear();
  pushMatrix();
  //push to center
  translate(300, 300, 460);

  for(int i=0; i < c.length; ++i)
  {
    //draw cone
    pushMatrix();
    translate(c[i].x, c[i].y, c[i].z + (c[i].z * cylinderRadius * 2));
    
    if(c[i].rot == rot_count)
    {
      forward = false;
    }
    else if(c[i].rot == -75)
    {
      forward = true;
    }
    
    if(forward)
    {
      c[i].angle += rot;// - (c[i].z * 0.005);// + noise(c[i].x,c[i].y,c[i].z)*0.1;
      //c[i].angle += noise(c[i].x,c[i].y)*0.01 - (c[i].z * 0.005); 
      c[i].rot++;
    }
    else
    {
      c[i].angle -= rot;// - (c[i].z * 0.005);// + noise(c[i].x,c[i].y,c[i].z)*0.1;
      //c[i].angle -= noise(c[i].x,c[i].y)*0.01 - (c[i].z * 0.005); 
      c[i].rot--;
    }
    
    rotateZ(c[i].angle);
    
    //stroke(random(0,255),0,random(0,255));
    fill(125,125,125);
    cylinder(cylinderRadius, 0, cylinderHeight, 12);
    popMatrix();
  }
  popMatrix();
}