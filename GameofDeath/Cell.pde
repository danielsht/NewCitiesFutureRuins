class Cell {
  PVector loc;
  color onColFIRE, offCol, curCol, onColTREE;
  Boolean offon, TREE, spread, DEER;
  float lifeFIRE, lifeTREE, randGrowthFIRE, randGrowthTREE;
  int num;
  
  Cell(PVector l, int n) {
    loc = l;
    num = n;
    spread = offon = false;
    TREE = false;
    onColFIRE = color(250,0,0);
    curCol = offCol = color(10,10,10);
    onColTREE = color(0,230,0);
    lifeFIRE = 0.0;
    lifeTREE = 0.0;
    randGrowthFIRE = random(0.01,0.05);
    randGrowthTREE = random(0.001,0.003);
  }
  void display() {
    noStroke();
    fill(curCol);
    rect(loc.x, loc.y, 5, 5);
    //ellipse(loc.x, loc.y, 5, 5);
    changeCol();
  }
  void setStateON() {
    spread = offon = true;
    curCol = onColFIRE;
    TREE = false;
  }
  void setStateOFF() {
    spread = TREE = offon = false;
    curCol = offCol;
    lifeTREE = lifeFIRE = 0.0;
  }
  void setStateGROW() {
    spread = offon = false;
    TREE = true; 
    curCol = offCol;
  }
  int getNum() {
    return num; 
  }
  void changeCol() {
    if(offon) {
      curCol = lerpColor(onColFIRE, offCol, lifeFIRE);
      if(lifeFIRE > 1.0) setStateOFF();
      else lifeFIRE+=randGrowthFIRE;
    }
    else if(TREE) {
      curCol = lerpColor(offCol, onColTREE, lifeTREE);
      if(lifeTREE > 1.0) lifeTREE = 1;
      else lifeTREE+=randGrowthTREE;
    }
  }
}