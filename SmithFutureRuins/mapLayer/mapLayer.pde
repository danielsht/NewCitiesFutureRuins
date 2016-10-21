PImage p;
String fileName = "Underlayment.png";  // a 2500 x 2500 pixel image;
color pixArray[][] = new color[60][40];
int xDim = 60;
int yDim = 40;
int matrix[][] = new int[xDim][yDim];

void setup() {
  size(700, 700);
  p = loadImage(fileName);
  p.loadPixels();
  loadTwoDim();
  initMatrix();
  noLoop();
}

void draw() {
  int sizer = 10;
  for (int i = 0; i < xDim; i ++) {
    for (int j = 0; j < yDim; j ++) {
      noStroke();
      fill(color(0, (1 + matrix[i][j]) * 40, 0));
      rect(i*sizer, j*sizer, sizer, sizer);
    }
  }
}

void loadTwoDim() {
 int counter = 0;
  for (int i = 0; i < 40; i ++) {
    for (int j = 0; j < 60; j ++) {
      pixArray[j][i] = int((red(p.pixels[counter])+green(p.pixels[counter])+blue(p.pixels[counter]))/3);//p.pixels[counter];
      counter ++;
    }
  } 
}

void initMatrix() { //0-city 1-gray1 2-gray2 3-gray3 4-gray4 5-river 6-road
  for (int i = 0; i < yDim; i ++) {
    for (int j = 0; j < xDim; j ++) {
          if (pixArray[j][i] == 255) {
            matrix[j][i] = 0;
          }  
          if (pixArray[j][i] == 200) {
            matrix[j][i] = 1;
          }  
          if (pixArray[j][i] == 175) {
            matrix[j][i] = 2;
          }
          if (pixArray[j][i] == 150) {
            matrix[j][i] = 3;
          }
          if (pixArray[j][i] == 125) {
            matrix[j][i] = 4;
          }
          if (pixArray[j][i] == 100) {
            matrix[j][i] = 5;
          }
          if (pixArray[j][i] == 0) {
            matrix[j][i] = 6;
          }
    } 
  }
}
