/* //<>//
 visual boxes made by Jared "BlueThen" C.
 http://www.openprocessing.org/sketch/5671
 www.bluethen.com
*/

import processing.serial.*;

Serial myPort;
String val = " asda ";
float a;

void setup()
{
  size(500, 500);
  colorMode(RGB, 6);
  stroke(0);
  frameRate(30);
  //noStroke();//3Dish look

  //serial settings
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{ 
  if (myPort.available() > 0)
  {
    val = myPort.readStringUntil('\n');
  }

  if (val != null)
  {
    //println(val);

    background(6);//white

    //****************************************************************************************************************************************
    // y values varies between -25 and 25
    //****************************************************************************************************************************************

    //float multiplier = map(random(320, 340), 320, 340, -25, 25);
    float multiplier = map(float(val), 100, 200, -25, 25);
    //multiplier = multiplier/14;

    a -= 0.03;

    for (int x = -7; x < 7; x++) 
    {
      for (int z = -7; z < 7; z++) 
      {
        //outer
        if (x < -5 || x > 4 || z < -5 || z > 4)
        {
          //float y = int(multiplier * cos(0.75 * distance(x, z, 0, 0) + a));
          float y = float(val)/10;
          drawWaves(x, y, z);
        }
        //mid
        else if (x < -2 || x > 2 || z < -2 || z > 2)
        {
          float y = int(multiplier * cos(0.75 * distance(x, z, 0, 0) + a));
          drawWaves(x, y, z);
        }
        //inner
        else
        {
          float y = int(multiplier * cos(0.75 * distance(x, z, 0, 0) + a));
          drawWaves(x, y, z);
        }
      }
    }
  }
}

void drawWaves(int x, float y, int z)
{     
  float xm = x*17 -8.5;
  float xt = x*17 +8.5;
  float zm = z*17 -8.5;
  float zt = z*17 +8.5;

  int halfw = (int)width/2;
  int halfh = (int)height/2;

  int isox1 = int(xm - zm + halfw);
  int isoy1 = int((xm + zm) * 0.5 + halfh);
  int isox2 = int(xm - zt + halfw);
  int isoy2 = int((xm + zt) * 0.5 + halfh);
  int isox3 = int(xt - zt + halfw);
  int isoy3 = int((xt + zt) * 0.5 + halfh);
  int isox4 = int(xt - zm + halfw);
  int isoy4 = int((xt + zm) * 0.5 + halfh);

  //side quads
  fill (2);
  quad(isox2, isoy2-y, isox3, isoy3-y, isox3, isoy3+40, isox2, isoy2+40);
  fill (4);
  quad(isox3, isoy3-y, isox4, isoy4-y, isox4, isoy4+40, isox3, isoy3+40);

  //top quads
  fill(4 + y * 0.05);
  quad(isox1, isoy1-y, isox2, isoy2-y, isox3, isoy3-y, isox4, isoy4-y);
}

float distance(float x, float y, float cx, float cy) 
{
  return sqrt(sq(cx - x) + sq(cy - y));
}