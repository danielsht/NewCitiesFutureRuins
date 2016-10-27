//Touch to start fire
var grid = new(Grid);

function setup() {
  createCanvas(1400, 1000);
  background(10);
  grid = new Grid();
}

function draw() {
  background(10);
  grid.display();
}

function mouseClicked() { 
  grid.initialStartFIRE(createVector(mouseX,mouseY));
}

function keyPressed() {
 if(keyCode == 32) grid.extinguish(); // spacebar = extinguish
 if(keyCode == 67 || keyCode == 99) grid.clearForest(); //c = clear
}
  
  function Cell(l, n) {
    this.loc = l;
    this.num = n;
    this.spread = offon = false;
    this.TREE = false;
    this.onColFIRE = color(250,0,0);
    this.curCol = offCol = color(10,10,10);
    this.onColTREE = color(0,230,0);
    this.lifeFIRE = 0.0;
    this.lifeTREE = 0.0;
    this.randGrowthFIRE = random(0.01,0.05);
    this.randGrowthTREE = random(0.001,0.003);

  this.display = function() {
    noStroke();
    fill(curCol);
    rect(loc.x, loc.y, 5, 5);
    //ellipse(loc.x, loc.y, 5, 5);
    changeCol();
  }
  this.setStateON = function() {
    spread = offon = true;
    curCol = onColFIRE;
    TREE = false;
  }
  this.setStateOFF = function() {
    spread = TREE = offon = false;
    curCol = offCol;
    lifeTREE = lifeFIRE = 0.0;
  }
  this.setStateGROW = function() {
    spread = offon = false;
    TREE = true; 
    curCol = offCol;
  }
  this.getNum = function() {
    return num; 
  }
  this.changeCol = function() {
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
};

function Grid() {
	this.grid = [];
    this.START = this.allOFFON = false;
    this.chance = 5;
    this.chances = [];
    this.chances.push(10);
    this.chances.push(10);
    this.chances.push(10);
    this.chances.push(10);
    for(var y = 0, n = 0; y < 1000; y+=5) {
      for(var x = 0; x < 1400; x+=5) {
      	var newV = createVector(x, y);
      	var newCell = new Cell(newV, n)
        grid.push(newCell);
        n++;
      }
    }
  
  this.display = function() {
    for(c in grid) 
      c.display();
    growForest();
    affectOthersFIRE();
  }

  this.growForest = function() {
    for(c in grid) {
      var r = random(100);
      if(!c.offon && !c.TREE && r <= 0.5) c.setStateGROW(); 
    }
  }

  this.affectOthersFIRE = function() {
    if(START) {
      for(c in grid) {
        if(c.loc.x <= 0 || c.loc.x >= width-5 || c.loc.y <= 0 || c.loc.y >= height-5) {
          //do something special for borders?
        }
        else if(c.offon) {
          //check up,down,left,right 
          var r = random(100);
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
  this.activateALL = function() {
    allOFFON = true;
    for(c in grid)
      c.setStateON();
  }
  this.initialStartFIRE = function(l) {
    //int r = int(random(0,grid.size()-1));
    //Cell c = grid.get(r);
    //c.setStateON();
    for(c in grid) {
      if((c.loc.x <= l.x && c.loc.x + 5 > l.x) && (c.loc.y <= l.y && c.loc.y + 5 > l.y))
        c.setStateON();
    }
    START = true;
  }
  this.extinguish = function() {
    for(c in grid) {
      if(c.offon)
        c.setStateOFF();
    }
  }
  this.clearForest = function() {
    for(c in grid) {
      if(c.TREE) c.setStateOFF(); 
    }
  }
  this.getAbove = function(c) {
    return c.num-width/5;
  }
  this.getBelow = function(c) {
    return c.num+width/5;
  }
  this.getLeft = function(c) {
    return c.num-1;
  }
  this.getRight = function(c) {
    return c.num+1;
  }
  this.getAboveLeft = function(c) {
    return c.num-(width/5)-1; 
  }
  this.getBelowLeft = function(c) {
    return c.num+(width/5)-1; 
  }
  this.getAboveRight = function(c) {
    return c.num-(width/5)+1; 
  }
  this.getBelowRight = function(c) {
    return c.num+(width/5)+1; 
  }
};