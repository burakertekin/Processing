import processing.serial.*;

Serial myPort;
String val;
boolean firstContact = false;

void setup()
{
  size(200, 200);
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{ 
  if(myPort.available() > 0)
  {
    val = myPort.readStringUntil('\n'); //<>//
  }
  
  if(val != null)
  {
    println(val);
  }
}