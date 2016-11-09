class Cell {
  PVector location;
  int size;
  color c;
  boolean life;
  float sizer;
  float alpha;
  float status;
  float sizeModifier = 0.75;
  
  public Cell() {
  }
  public Cell(int size, PVector location) {
    this.size = size;
    this.location = location;
    life = false;
    sizer = 10;
    alpha = 100;
    status = 0;
  }
  
  void update() {
    
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    if (life) {
      //switch(status){
      //  case(0):
      //    fill(255, 0, 0, alpha - ((status%1)*100));
      //    break;
      //  case(1):
      //    fill(0, 255, 0, alpha - ((status%1)*100));
      //    break;
      //  case(2):
      //    fill(0, 0, 255, alpha - ((status%1)*100));
      //    break;
      //}
      
      int alphaVal = 75;
      color c1 = color(100, 150, 200, alphaVal);
      color c2 = color(25, 65, 100, alphaVal);
      
      if(status == 0) {
//        fill(0, 0, 0, 0);
        fill(25, 25, 25, 0);
        stroke(255);
      } else if(status == 2.5) {
  fill(lerpColor(c1, c2, 1));
//        fill(100, 100, 0, 50+abs((status-1)*100));
  stroke(55);
//        noStroke();
        box(size*sizeModifier);
      } else if(status > 0){
  fill(lerpColor(c1, c2, .66));
//        fill(150, 255-(150-((status-1)*100)), 0, 50+((status-1)*100));
  stroke(55);
//        noStroke();
        box(size*sizeModifier);
      } 
      else {
  fill(lerpColor(c1, c2, .33));
//        fill(255, 200, 0, (abs(status)*100));
  stroke(lerpColor(c1, c2, 0));
//        stroke(255, 0, 0, (abs(status)*100));
        box(size*sizeModifier);
      }
  stroke(255); point(0,0,0);

    } else {
      fill(0, 0, 0, 0);
      stroke(255);
    }
       
  popMatrix();
  }
  
  void decreaseStatus() {
    //if (status > 0) {
      status-= 0.2;
    //}
  }
}