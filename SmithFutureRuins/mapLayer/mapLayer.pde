PImage p;
String fileName = "Underlayment.png";  // a 2500 x 2500 pixel image;
color pixArray[][] = new int[2500][2500];
int xDim = 500;
int yDim = 500;
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
  
  for (int i = 0; i < xDim; i ++) {
    for (int j = 0; j < yDim; j ++) {
      stroke(color(matrix[i][j] * 40));
      point(i + 100, j + 100);
    }
  }
}

void loadTwoDim() {
 int counter = 0;
  for (int i = 0; i < xDim; i ++) {
    for (int j = 0; j < yDim; j ++) {
      pixArray[i][j] = p.pixels[counter];
//      print(pixArray[i][j]+" ");
      counter ++;
    }
//    println();
  } 
  /*
  for (int i = 0; i < xDim; i ++) {
    for (int j = 0; j < yDim; j ++) {
      stroke(pixArray[i][j]);
      point(i, j);
    }
  }*/ 
}

void initMatrix() { //0-city 1-gray1 2-gray2 3-gray3 4-river 5-road
  for (int i = 0; i < 500; i ++) {
    for (int j = 0; j < 200; j ++) {
 //     float view = i * (xDim * i) + j; // counting
          if (pixArray[i*5][j*5] == color(255)) {
            matrix[i][j] = 0;
          }  
          if (pixArray[i*5][j*5] == color(200)) {
            matrix[i][j] = 1;
          }  
          if (pixArray[i*5][j*5] == color(175)) {
            matrix[i][j] = 2;
          }
          if (pixArray[i*5][j*5] == color(125)) {
            matrix[i][j] = 3;
          }
          if (pixArray[i*5][j*5] == color(100)) {
            matrix[i][j] = 4;
          }
          if (pixArray[i*5][j*5] == color(150)) {
            matrix[i][j] = 5;
          }
          if (pixArray[i*5][j*5] == color(0)) {
            matrix[i][j] = 6;
          }
          print(matrix[i][j]);
    } 
    println();
  }
}
