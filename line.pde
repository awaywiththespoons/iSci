// Logo design fro iSci, 
// This is the visualised data part of the original design by Playnicely

float imageSize = 500;
float centerPoint = imageSize/2;
float scale = 100;

float [] co2Raw= { 
  233, 279.2, 300.4, 200.56, 270.82, 309.50, 300.5, 239.89, 209.50, 230.5
}; // the raw data from somewhere -this will determins point B

FloatList xLocations;
FloatList yLocations;
FloatList co2;  //making a list with the raw data
float maxB = 20; // the max value you want the star points to be at
//float angle; //make the angle that each line rotates

void setup() {
  background(255);
  size((int)imageSize, (int)imageSize);
  co2 = new FloatList(); //the data list (lentght of the line and size of the angle
  xLocations = new FloatList(); //storing the locations of x and y for making triangualtion
  yLocations = new FloatList();
  for (int i = 0; i < co2Raw.length; i++) {
    co2.append(co2Raw[i]); //add the raw data to the list
  }
  noLoop();
}
void draw() {


  translate(centerPoint, centerPoint);
  for (int i = 0; i< co2Raw.length; i++) {

    float angle = map(co2.get(i), 0, co2.max(), 0, TWO_PI/co2Raw.length); // angle is the co2 value mapped to a circle / number of vaues in range
    float lineLength = map(co2.get(i), 0, co2.max(), 0, scale);  //map the raw data to a value that fits in the screen
    float xPoint = cos(angle)*lineLength; // x position is cosine of the angle / the length of the line CAH (soh cah toa)
    float ySquared = sq(lineLength)-sq(xPoint); // y position is a2+b2=c2
    float yPoint = sqrt(ySquared);
    stroke(90);
    rotate(angle); //angle between each segment
    line(0, 0, xPoint, yPoint); //draw a line
    noStroke();
    fill(90);
    ellipse(xPoint, yPoint, 3, 3);
    xLocations.append(xPoint);
    yLocations.append(yPoint);


    if (i >=1) {
      stroke(90);
      line(xLocations.get(i-1), yLocations.get(i-1), xLocations.get(i), yLocations.get(i));
    }
    
    //NEXT: reference xpoint and y point[i] to draw a line betwee. 
    //maybe use an if i => 1, and an if last i in sequance to keep with dimentaions

    print("i = " + i);
    print ("  ");
    print("line "+lineLength);
    print ("  ");
    print("angle = ");
    print(angle);
    print ("  ");
    print("centerPoint = " + centerPoint); 
    print ("  ");
    print("xPoint = " + xPoint);
    print ("  ");
    println("yPoint = " + yPoint);
  }
}
