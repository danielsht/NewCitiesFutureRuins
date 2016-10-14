//Touch to start fire
Grid grid;
void setup() {
  size(1400, 1000);
  background(10);
  grid = new Grid();
}

void draw() {
  background(10);
  grid.display();
}
void mouseClicked() { 
  grid.initialStartFIRE(new PVector(mouseX,mouseY));
}
void keyPressed() {
 if(keyCode == 32) grid.extinguish(); // spacebar = extinguish
 if(keyCode == 67 || keyCode == 99) grid.clearForest(); //c = clear
}