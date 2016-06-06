//Processing particle system tutorial
class Particle 
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) 
  {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.copy();
    lifespan = 90.0;
  }

  void run() 
  {
    update();
    display();
  }

  // Method to update location
  void update() 
  {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() 
  {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(location.x, location.y, 3, 3);
  }

  // Is the particle still useful?
  boolean isDead() 
  {
    if (lifespan < 0.0) 
    {
      return true;
    } else 
    {
      return false;
    }
  }
}