class SacredGeo extends Thread
{
  boolean running;
  
SacredGeo()
{
}

void start()
{
  running = true;
  super.start();
}

void run()
{
  while(running)
  {
    for(int i = 0; i<samples; ++i)
    {
      
    }
  }
}

void quit()
{
  running = false;
  interrupt();
}

}