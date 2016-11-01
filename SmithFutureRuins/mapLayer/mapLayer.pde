//import peasy.*;
//PeasyCam cam;
//final float radius = 50;

PImage p;
String fileName = "Untitled-1.png";  // a 2500 x 2500 pixel image;
color pixArray[][] = new color[600][400];
int xDim = 600;
int yDim = 400;
Cube matrix[][] = new Cube[xDim][yDim];
int sizer = 10;

void setup() {
  size(2000, 1000, P3D);
  p = loadImage(fileName);
  p.loadPixels();
  loadTwoDim();
  initMatrix();
  //  noLoop();
//  cam = new PeasyCam(this, 150);
//  cam.setMinimumDistance(150);
//  cam.setMaximumDistance(250);
}

void draw() {
//  camera(mouseX, mouseY, 500.0, // eyeX, eyeY, eyeZ
//        width/2, height/2, 100, // centerX, centerY, centerZ
//        0.0, 1.0, 0.0);
  background(0);
  color c = color(0, 0, 0);
  int elev = 0;
  int sizer = 6;
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

void loadTwoDim() {
  int counter = 0;
  for (int i = 0; i < 400; i ++) {
    for (int j = 0; j < 600; j ++) {
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

