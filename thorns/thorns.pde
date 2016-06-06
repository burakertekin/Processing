int width = 600;
int height = 600;
float rot = 0;
float size = width/2;
int count = 30;
float a = width/40;
float inc = TWO_PI/360.0;

ArrayList<Particle> particles = new ArrayList<Particle> ();
ArrayList<Particle> particles2 = new ArrayList<Particle> ();

void settings()
{
  size(width,height);
}

void setup()
{
  smooth(200);
  frameRate(20);
}

void draw()
{
  clear();
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  translate(width/2, height/2);
  color c = color(255,255,255);
  
  //drawChasingCircles(color(0,0,0), color(125,125,125), 0, 0, 200);
  rotate(rot);
  for(int i=0; i<count; ++i)
  {
    rotate(degrees(PI/6*count));
    c = color(random(0,255));
    PVector tip;
    tip = drawThorns(0, -size/4, size*random(1,1), c);
    PVector bot = new PVector(tip.x, tip.y+(size));
    
    particles.add(new Particle(tip));
    particles2.add(new Particle(bot));
    for(int j = particles.size()-1; j >= 0; j--)
    {
      Particle p = particles.get(i);
      Particle p2 = particles2.get(i);
      p.run();
      p2.run();
      if(p.isDead())
      {
        particles.remove(i);
      }
      if(p2.isDead())
      {
        particles2.remove(i);
      }
    }
  }
  //size += sin(a) * random(1,3);
  strokeWeight(sin(a) + random(1.0,2.5));
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

PVector drawThorns(float coord_x, float coord_y, float size, color strokeColor)
{
  noFill();
  stroke(strokeColor);
  //big half circle
  arc(coord_x, coord_y, size, size, HALF_PI, PI+HALF_PI);
  //opposite side half circle - down
  arc(coord_x, coord_y+size/4, size/2, size/2, -HALF_PI, HALF_PI);
  //opposite side half circle - up
  arc(coord_x, coord_y-size/4, size/2, size/2, PI/2, PI+HALF_PI);
  
  //returning the tip of the thorn to generate particles from
  PVector tip = new PVector(coord_x, coord_y-(size/2));
  return tip;
}