int width = 500;
int height = 500;

void settings()
{
  size(width, height, P3D);
}

void setup()
{
  background(0);
  noFill();
  stroke(255);
}

void draw()
{
  clear();
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  sphere(200);
}