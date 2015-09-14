// Logo design fro iSci, 
// This is the visualised data part of the original design by Playnicely

float imageSize = 500;
float centerPoint = imageSize/2;
float scale = 5;
float greyScale = 0; //changing the fill as we go
float [] raw= { 
  200.56, 270.82, 350.50, 200.5, 239.89, 200.50, 300, 350, 390
}; // the raw data from somewhere -this will determins point B

FloatList angle;  //making a list with the raw data
FloatList line;

void setup() {
  background(255);
  size((int)imageSize, (int)imageSize);
  angle = new FloatList(); //the data list (lentght of the line and size of the angle
  line = new FloatList();

  for (int i = 0; i < raw.length; i++) {
    angle.append(raw[i]); //add the raw data to the list
    line.append(raw[i]); //add the raw data to the list
  }
  for (int i = 1; i < raw.length; i++) {
    angle.set(i, angle.get(i) + angle.get(i-1)); //accumalating the value of the angles
  }
  noLoop();
}

void draw() {
  translate(centerPoint, centerPoint);
  for (int i = 1; i <= raw.length; i++) {
    if (i == raw.length) {
      //get the angles
      float angleA = map(angle.get(i-1), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      float angleB = map(angle.get(0), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      //get the line length for A
      float lineLengthA = map(line.get(i-1), 0, raw.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointA = cos(angleA)*lineLengthA; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointA = sin(angleA)*lineLengthA;
      //get the line length for B
      float lineLengthB = map(line.get(0), 0, raw.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointB = cos(angleB)*lineLengthB; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointB = sin(angleB)*lineLengthB;
      //draw the image
      greyScale = map(line.get(i), line.min(), line.max(), 50, 200);
      stroke(greyScale);
      fill(greyScale);
      triangle(0, 0, xPointA, yPointA, xPointB, yPointB);
      noFill();
      stroke(126, 100);
      ellipse(xPointB, yPointB, 5, 5);
    } else {
      //get the angles
      float angleA = map(angle.get(i), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      float angleB = map(angle.get(i-1), 0, angle.max(), 0, TWO_PI); // angle is the current co2 value mapped to a circle 
      //get the line length for A
      float lineLengthA = map(line.get(i), 0, raw.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointA = cos(angleA)*lineLengthA; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointA = sin(angleA)*lineLengthA;
      //get the line length for B
      float lineLengthB = map(line.get(i-1), 0, raw.length, 0, scale);  //map the raw data to a value that fits in the screen
      float xPointB = cos(angleB)*lineLengthB; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
      float yPointB = sin(angleB)*lineLengthB;
      //draw the image
      greyScale = map(line.get(i), line.min(), line.max(), 50, 200);
      stroke(greyScale);
      fill(greyScale);
      triangle(0, 0, xPointA, yPointA, xPointB, yPointB);
      noFill();
      stroke(100, 100);
      ellipse(xPointA, yPointA, 8, 8);
    }
  }
}
