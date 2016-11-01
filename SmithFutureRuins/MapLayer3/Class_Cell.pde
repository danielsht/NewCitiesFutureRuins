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
      if(status == 0) {
        fill(0, 0, 0, 0);
        stroke(255);
      } else if(status == 2.5) {
        fill(200, 200, 0, 50+abs((status-1)*100));
        noStroke();
        box(size*sizeModifier);
      } else if(status > 0){
        fill(150, 255-(150-((status-1)*100)), 0, 50+((status-1)*100));
        noStroke();
        box(size*sizeModifier);
      } 
      else {
        fill(255, 200, 0, (abs(status)*100));
        stroke(255, 0, 0, (abs(status)*100));
        box(size*sizeModifier);
      }
      
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