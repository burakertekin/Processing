int width = 400;
int height = 400;
float rot = 0;
float size = width/2;
int count = 20;
float a = width/40;
float inc = TWO_PI/360.0;

void settings()
{
  size(width,height);
}

void setup()
{
  background(102);
  strokeWeight(width/800);
  smooth(20);
  frameRate(120);
}

void draw()
{
  //thorns distributed around a circle
  //rotating and going towards center
  //psy/hypnotising
  clear();
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  //background(0);
  translate(width/2, height/2);
  color c = color(255,255,255);
  
  //drawChasingCircles(color(0,0,0), color(125,125,125), 0, 0, 200);
  rotate(rot);
  for(int i=0; i<count; ++i)
  {
    rotate(degrees(PI/6*count));
    c = color(random(0,255));
    drawThorns(0, -size/4, size*random(1,1), c);
  }
  size += sin(a) * random(1,3);
  rot -= .3;
  a += inc;
}

void drawChasingCircles(color back, color front, float coord_x, float coord_y, float size)
{
  fill(front);
  ellipse(coord_x, coord_y, size, size);
  pushMatrix();
  translate(0,size/4);
  fill(back);
  ellipse(coord_x, coord_y, size/2, size/2);
  popMatrix();
  pushMatrix();
  arc(coord_x, coord_y, size, size, PI/2, PI+HALF_PI);
  popMatrix();
  pushMatrix();
  translate(0, -size/4);
  fill(front);
  ellipse(coord_x, coord_y, size/2, size/2);
  popMatrix();
} //<>//

void drawThorns(float coord_x, float coord_y, float size, color strokeColor)
{
  noFill();
  stroke(strokeColor);
  //big half circle
  arc(coord_x, coord_y, size, size, HALF_PI, PI+HALF_PI);
  //opposite side half circle - down
  arc(coord_x, coord_y+size/4, size/2, size/2, -HALF_PI, HALF_PI);
  //opposite side half circle - up
  arc(coord_x, coord_y-size/4, size/2, size/2, PI/2, PI+HALF_PI);
}