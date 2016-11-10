//needed for restful api calls
//import http.requests.*;

//import peasy.*;
//PeasyCam cam;
//final float radius = 0;

PImage p;
PImage b;
PImage t;

String fileName = "Map150x100.png";  // a 600 x 400 pixel image;
String bgFileName = "BG.jpg";
String textureFileName = "textureMap.png";

int xDim = 150;
int yDim = 100;
int zDim = 20;
color pixArray[][] = new color[xDim][yDim];
Cube matrix[][] = new Cube[xDim][yDim];
CellOrganism ca = new CellOrganism(xDim, yDim);
int sizer = 20;

//http values for restful API calls
//GetRequest get; 
String dataIn;
int previousTime;

void setup() {
  //frameRate(1);
  size(1200, 800, P3D);

  b = loadImage(bgFileName);
  background(b);
 
 t = loadImage(textureFileName);
 
  p = loadImage(fileName);
  p.loadPixels();
  
  loadTwoDim();
  initMatrix();
  ca.initGrid();
  readTerrain();
  //ca.createCenter(20,20);
  //ca.createCenter(24,24);
  //ca.createCenter(20,24);
  
  //Change later to server URL 
//  get = new GetRequest("http://localhost:5000/CAsequence");
}

void draw() {
  
  background(b);
//  background(160, 200, 200, 200);
  pushMatrix();
  translate(-width, 0 ,-1000);
  rotateX(-.4);
//  renderMatrix();
  
  textureMode(NORMAL);
tint(255, 175);
beginShape();
texture(t);
vertex(matrix[0][0].p1[0], matrix[0][0].p1[1], matrix[0][0].p1[2], 0, 0);
vertex(matrix[xDim-1][0].p1[0], matrix[xDim-1][0].p1[1], matrix[xDim-1][0].p1[2], 1, 0);
vertex(matrix[xDim-1][yDim-1].p1[0], matrix[xDim-1][yDim-1].p1[1], matrix[xDim-1][yDim-1].p1[2], 1, 1);
vertex(matrix[0][yDim-1].p1[0], matrix[0][yDim-1].p1[1], matrix[0][yDim-1].p1[2], 0, 1);
endShape();
  
  ca.update();
  ca.renderCells();
  popMatrix();
  
  String url = " http://10.0.1.100 ";
  String city1Message = "Cement Station\n\nPopulation:\n" + int(ca.centers.get(0)._spread * 10) + "k";
  String city2Message = "Lickskillet\n\nPopulation:\n" + int(ca.centers.get(1)._spread * 10) + "k";
  String city3Message = "Blackgold Bayou\n\nPopulation:\n" + int(ca.centers.get(2)._spread * 10) + "k";
  String buildMessage = "Visit "+url+" on your mobile device to add resrouces to a city.";
  fill(250);
  stroke(195);
  text(city1Message, 110, 160, 130, 130);
  text(city2Message, 940, 180, 130, 130);
  text(city3Message, 325, 230, 130, 130);
  text(buildMessage, 400, 50, 500, 50);
  noFill();
  rect(100, 150, 150, 150, 7);
  rect(930, 170, 150, 150, 7);
  rect(315, 220, 150, 150, 7);
  line(140, 300, 115, 440);
  line(970, 320, 935, 510);
  line(355, 370, 120, 620); 
  
  //String s = "1: city1.spread++, 2: city2.spread++, 3: city2.spread++, ENTER: default";
  //fill(250);
  //text(s, 10, 10, 120, 200);
  //String s1 = "SPREAD\ncity 1: " + ca.centers.get(0)._spread + "\ncity 2: " + ca.centers.get(1)._spread + "\ncity 3: " + ca.centers.get(2)._spread;
  //fill(250);
  //text(s1, 10, 80, 120, 200);
  //delay(500);
  //camera(200, 0, 700.0, // eyeX, eyeY, eyeZ
  //       width/2+100, height-100, 100, // centerX, centerY, centerZ
  //       0.0, 0.5, 0.0);
  //camera(0, 100, 0);
  
//  get.send();
//  dataIn = get.getContent();
//  buttonPress(dataIn);
  
}

void loadTwoDim() {
  int counter = 0;
  for (int i = 0; i < yDim; i ++) {
    for (int j = 0; j < xDim; j ++) {
      pixArray[j][i] = int((red(p.pixels[counter])+green(p.pixels[counter])+blue(p.pixels[counter]))/3);//p.pixels[counter];
      counter ++;
    }
  }
}

void initMatrix() { //0-city 1-gray1 2-gray2 3-gray3 4-gray4 5-river 6-road
  for (int i = 0; i < yDim; i ++) {
    for (int j = 0; j < xDim; j ++) {
      if ((pixArray[j][i] <= 255) && (pixArray[j][i] > 225)) {
        matrix[j][i] = new Cube(j, i, 0);
      }  
      if ((pixArray[j][i] <= 225) && (pixArray[j][i] > 190))  {
        matrix[j][i] = new Cube(j, i, 1);
      }  
      if ((pixArray[j][i] <= 190) && (pixArray[j][i] > 163))  {
        matrix[j][i] = new Cube(j, i, 2);
      }
      if ((pixArray[j][i] <= 163) && (pixArray[j][i] > 133))  {
        matrix[j][i] = new Cube(j, i, 3);
      }
      if ((pixArray[j][i] <= 133) && (pixArray[j][i] > 113))  {
        matrix[j][i] = new Cube(j, i, 4);
      }
      if ((pixArray[j][i] <= 113) && (pixArray[j][i] > 55))  {
        matrix[j][i] = new Cube(j, i, 5);
      }
      if (pixArray[j][i] <= 55) {
        matrix[j][i] = new Cube(j, i, 6);
      }
    }
  }
}



void renderMatrix() {
  for (int i = 0; i < xDim-1; i ++) {
    for (int j = 0; j < yDim-1; j ++) {
      matrix[i][j].display();
      fill(matrix[i][j].c);
      beginShape();
      vertex(matrix[i][j].p2[0], matrix[i][j].p2[1], matrix[i][j].p2[2]);
      vertex(matrix[i+1][j].p1[0], matrix[i+1][j].p1[1], matrix[i+1][j].p1[2]);
      vertex(matrix[i+1][j].p4[0], matrix[i+1][j].p4[1], matrix[i+1][j].p4[2]);
      vertex(matrix[i][j].p3[0], matrix[i][j].p3[1], matrix[i][j].p3[2]);
      endShape(CLOSE);
      beginShape();
      vertex(matrix[i][j].p3[0], matrix[i][j].p3[1], matrix[i][j].p3[2]);
      vertex(matrix[i+1][j].p4[0], matrix[i+1][j].p4[1], matrix[i+1][j].p4[2]);
      vertex(matrix[i+1][j+1].p1[0], matrix[i+1][j+1].p1[1], matrix[i+1][j+1].p1[2]);
      vertex(matrix[i][j+1].p2[0], matrix[i][j+1].p2[1], matrix[i][j+1].p2[2]);
      endShape(CLOSE);
      beginShape();
      vertex(matrix[i][j].p4[0], matrix[i][j].p4[1], matrix[i][j].p4[2]);
      vertex(matrix[i][j].p3[0], matrix[i][j].p3[1], matrix[i][j].p3[2]);
      vertex(matrix[i][j+1].p2[0], matrix[i][j+1].p2[1], matrix[i][j+1].p2[2]);
      vertex(matrix[i][j+1].p1[0], matrix[i][j+1].p1[1], matrix[i][j+1].p1[2]);
      endShape(CLOSE);
    }
  }
}

void readTerrain() {
  for (int i = 0; i < xDim; i++) {
    for(int j = 0; j < yDim; j++) {
      switch(matrix[i][j].state) {
        //city
        case 0:
          ca.createCenter(i, j);
          break;
        //river
        case 5:
          ca.createRiver(i, j);
          break;
        //road
        case 6:
          ca.createRoad(i, j);
          break;
      }
    }
  }
}

void keyPressed() {
  println(key);
  if (key == 'a') {
    ca.incrementHeight();
  } else if (key == 's') {
    ca.decrementHeight();
  }
  if (key == 'z') {
    ca.incrementDiameter();
  } else if (key == 'x') {
    ca.decrementDiameter();
  }
  if(key == '1') {
    if (ca.centers.get(0) != null)
      ca.centers.get(0).incrementSpread();
  } else if (key == '2') {
    if (ca.centers.get(1) != null)
      ca.centers.get(1).incrementSpread();
  } else if (key == '3') {
    if (ca.centers.get(2) != null)
      ca.centers.get(2).incrementSpread();
  }
  
  if(key == 'q') {
    if (ca.centers.get(0) != null)
      ca.centers.get(0).decrementSpread();
  } else if (key == 'w') {
    if (ca.centers.get(1) != null)
      ca.centers.get(1).decrementSpread();
  } else if (key == 'e') {
    if (ca.centers.get(2) != null)
      ca.centers.get(2).decrementSpread();
  }
  
  if(key == ENTER) {
    for (int i = 0; i < ca.centers.size(); i++) {
      ca.centers.get(i).setToDefaultSpread();
    }
  }
  
}
/*
void buttonPress(String dataIn) {
  //not an empty get 
  if ( !dataIn.equals("") ) {
    JSONObject json = JSONObject.parse(dataIn); //make into a JSON Object for easy parsing
    int timeCode = json.getInt("time"); //make sure it is not a repeated add/click
    if(timeCode != previousTime){
      String city = json.getString("user");
      println(city);
      switch(city) {
        case "city1":
          incrementCitySpread(0); //if city 1 pressed add to city
          break;
        case "city2":
          ca.centers.get(1).incrementSpread(); //if city 2 pressed add to city
          break;
        case "city3": 
          ca.centers.get(2).incrementSpread(); //if city 3 pressed add to city
          break;
      }
      previousTime = timeCode; //reset previous time code
    }
  }
}

void incrementCitySpread(int i) {
  if (ca.centers.get(i) != null)
      ca.centers.get(i).incrementSpread();
}
*/