// Logo design fro iSci, 
// This is the visualised data part of the original design by Playnicely

import controlP5.*; //adding buttons
ControlP5 cp5;
int greyLOW = 20; //darkest shade of grey
int greyHIGH =240; //lightest shade of grey
int imageSize = 700;
float centerPoint = imageSize/2;
float scale = 3; //scale of data
float greyScale = 0; //will map the grey scale to the data

// DATA SETS 
String Co2Raw= "RAW";
float [] co2Raw= { 
  916, 172, 314, 342, 450, 59, 100.33//from http://data.okfn.org/data/core/co2-fossil-global/r/global.csv for 2010
}; // the raw data -this will determins point B
String Random = "RANDOM";
float[] random= {
  160, 280.2, 200.56, 270.82, 300.50, 100.5, 180, 300, 400 //random
};
String Simple = "SIMPLE";
float [] simple= {
  450, 405, 200, 100, 290, 245, 300
};

FloatList angle;  //making a list with the raw data
FloatList line;


void setup() {
  background(255);
  size((int)imageSize, (int)imageSize);
  noLoop();
}
void draw() {
  translate(centerPoint, centerPoint);
  triangleMaker(simple, Simple);
  // other options (todo: make a button and toggle betwem these)
  //  triangleMaker(random, Random); 
  //  triangleMaker(co2Raw, Co2Raw);
}

void triangleMaker(float[] data, String name) {
  textAlign(CENTER);
  text(name, 0, 40); //text position is longest possible 
  angle = new FloatList(); //the data list (lentght of the line and size of the angle
  line = new FloatList();
  for (int i = 0; i < data.length; i++) {
    angle.append(data[i]); //add the raw data to the list
    line.append(data[i]); //add the raw data to the list
  }
  for (int i = 1; i < data.length; i++) {
    angle.set(i, angle.get(i) + angle.get(i-1)); //accumalating the value of the angles
  }

  for (int i = 1; i <= data.length; i++) {
    if (i == data.length) {

      //get angles
      float angleA = map(angle.get(i), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      float angleB = map(angle.get(0), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      // get A line lengths and points
      float lineLengthA = map(line.get(i-1), 0, data.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointA = cos(angleA)*lineLengthA; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointA = sin(angleA)*lineLengthA;
      // get B line lengths and points
      float lineLengthB = map(line.get(0), 0, data.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointB = cos(angleB)*lineLengthB; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointB = sin(angleB)*lineLengthB;

      // make image
      greyScale = map(line.get(i-1), line.min(), line.max(), greyLOW, greyHIGH);
      stroke(greyScale);
      fill(greyScale);
      triangle(0, 0, xPointA, yPointA, xPointB, yPointB);
      noFill();
      stroke(100, 100);
      ellipse(xPointB, yPointB, 8, 8);
    } else {

      //get angles
      float angleA = map(angle.get(i), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      float angleB = map(angle.get(i-1), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      // get A line lengths and points
      float lineLengthA = map(line.get(i), 0, data.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointA = cos(angleA)*lineLengthA; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointA = sin(angleA)*lineLengthA;
      // get B line lengths and points
      float lineLengthB = map(line.get(i-1), 0, data.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointB = cos(angleB)*lineLengthB; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointB = sin(angleB)*lineLengthB;

      // make image
      greyScale = map(line.get(i-1), line.min(), line.max(), greyLOW, greyHIGH);
      stroke(greyScale);
      fill(greyScale);
      triangle(0, 0, xPointA, yPointA, xPointB, yPointB);
      noFill();
      stroke(100, 100);
      ellipse(xPointA, yPointA, 8, 8);
    }
  }
}
