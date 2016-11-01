//import peasy.*;
//PeasyCam cam;
//final float radius = 0;

PImage p;
String fileName = "Map600x400.png";  // a 600 x 400 pixel image;

int xDim = 600;
int yDim = 400;
int zDim = 20;
color pixArray[][] = new color[xDim][yDim];
Cube matrix[][] = new Cube[xDim][yDim];
CellOrganism ca = new CellOrganism(xDim, yDim);
int sizer = 5;

void setup() {
  //frameRate(1);
  size(1200, 800, P3D);
  p = loadImage(fileName);
  p.loadPixels();
  loadTwoDim();
  initMatrix();
  ca.initGrid();
  readTerrain();
  //ca.createCenter(20,20);
  //ca.createCenter(24,24);
  //ca.createCenter(20,24);
}

void draw() {
  
  background(45);
  pushMatrix();
  translate(-width,0 ,-1000);
  rotateX(-.4);
  renderMatrix();
//  ca.update();
//  ca.renderCells();
  popMatrix();
  String s = "1: city1.spread++, 2: city2.spread++, 3: city2.spread++, ENTER: default";
  fill(250);
  text(s, 10, 10, 120, 200);
  //delay(500);
  //camera(200, 0, 700.0, // eyeX, eyeY, eyeZ
  //       width/2+100, height-100, 100, // centerX, centerY, centerZ
  //       0.0, 0.5, 0.0);
  //camera(0, 100, 0);
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
