import processing.pdf.*;
String fileName = "BG.png";
color stratosphere = color(21, 62, 98, 200);
color sky = color(160, 200, 200, 200);
color earth = color(0, 0, 0, 200);
color tempColor;

void setup() {
size(1200, 800);
  beginRecord(PDF, fileName);
  noStroke();
  noLoop();
}

void draw() {
//  background(160, 200, 200, 200);
  fill(0, 0, 0, 200);
  rect(0, 300, 1200, 500);
  for (float i = 1; i < 300; i ++) {
    tempColor = lerpColor(stratosphere, sky, (i / 300));
    fill(tempColor);
    stroke(tempColor);
    print(1 - (i / 300) + " ");
    rect(0, i, 1200, 14);
  }
  for (float i = 1; i < 100; i ++) {
    stroke(lerpColor(sky, earth, i / 100));
    line(0, i + 300, 1200, i + 300);
  }
    
  endRecord();

}