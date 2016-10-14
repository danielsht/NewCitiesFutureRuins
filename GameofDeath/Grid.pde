class Grid {
  ArrayList<Cell> grid = new ArrayList();
  Boolean allOFFON, START;
  float chance;
  float[] chances = new float[4];
  
  Grid() {
    START = allOFFON = false;
    chance = 5;
    chances[0] = 10;
    chances[1] = 10;
    chances[2] = 10;
    chances[3] = 10;
    for(int y = 0, n = 0; y < height; y+=5) {
      for(int x = 0; x < width; x+=5) {
        grid.add(new Cell(new PVector(x, y), n));
        n++;
      }
    }
  }
  void display() {
    for(Cell c: grid)
      c.display();
    growForest();
    affectOthersFIRE();
  }
  void growForest() {
    for(Cell c: grid) {
      float r = random(100);
      if(!c.offon && !c.TREE && r <= 0.5) c.setStateGROW(); 
    }
  }
  void affectOthersFIRE() {
    if(START) {
      for(Cell c: grid) {
        if(c.loc.x <= 0 || c.loc.x >= width-5 || c.loc.y <= 0 || c.loc.y >= height-5) {
          //do something special for borders?
        }
        else if(c.offon) {
          //check up,down,left,right 
          float r = random(100);
          if(grid.get(getAbove(c)).TREE && c.spread && r <= chances[0]) {
            grid.get(getAbove(c)).setStateON();
          }
          else if(grid.get(getBelow(c)).TREE && c.spread && r <= chances[1]) {
            grid.get(getBelow(c)).setStateON();
          }
          else if(grid.get(getLeft(c)).TREE && c.spread && r <= chances[2]) {
            grid.get(getLeft(c)).setStateON();
          }
          else if(grid.get(getRight(c)).TREE && c.spread && r <= chances[3]) {
            grid.get(getRight(c)).setStateON();
          }
          //check all sides to see if any trees around
          //if not, fire dies off
          if(!grid.get(getAbove(c)).TREE && !grid.get(getBelow(c)).TREE 
          && !grid.get(getLeft(c)).TREE && !grid.get(getRight(c)).TREE) {
             c.spread = false;
          }
        }
      }
    }
  }
  void activateALL() {
    allOFFON = true;
    for(Cell c: grid)
      c.setStateON();
  }
  void initialStartFIRE(PVector l) {
    //int r = int(random(0,grid.size()-1));
    //Cell c = grid.get(r);
    //c.setStateON();
    for(Cell c : grid) {
      if((c.loc.x <= l.x && c.loc.x + 5 > l.x) && (c.loc.y <= l.y && c.loc.y + 5 > l.y))
        c.setStateON();
    }
    START = true;
  }
  void extinguish() {
    for(Cell c: grid) {
      if(c.offon)
        c.setStateOFF();
    }
  }
  void clearForest() {
    for(Cell c: grid) {
      if(c.TREE) c.setStateOFF(); 
    }
  }
  int getAbove(Cell c) {
    return c.num-width/5;
  }
  int getBelow(Cell c) {
    return c.num+width/5;
  }
  int getLeft(Cell c) {
    return c.num-1;
  }
  int getRight(Cell c) {
    return c.num+1;
  }
  int getAboveLeft(Cell c) {
    return c.num-(width/5)-1; 
  }
  int getBelowLeft(Cell c) {
    return c.num+(width/5)-1; 
  }
  int getAboveRight(Cell c) {
    return c.num-(width/5)+1; 
  }
  int getBelowRight(Cell c) {
    return c.num+(width/5)+1; 
  }
}