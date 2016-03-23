int width = 70;
int height = 70;
int size = 10;
int circleRadius = 64;
int circleDistance = 64;
int count = 0;
int midX = width*size/2;
int midY = height*size/2;
float rotator = 0;
float rotationSpeed = 0.5;
int alphaVal=255;


//multithread parameters
int samples = 10000;
Thread[] t;
int threadcount = 16;