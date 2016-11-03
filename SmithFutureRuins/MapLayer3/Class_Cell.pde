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
      if(status == 0) {
        fill(0, 0, 0, 0);
        stroke(255);
      } else if(status == 2.3) {
        fill(200, 180, 0, 50+abs((status-1)*100));
        noStroke();
        box(size*sizeModifier);
      } else if(status > 0){
        fill(250, 200-(100-((status-1)*100)), 0, 50+((status-1)*100));
        noStroke();
        box(size*sizeModifier);
      } 
      else {
        fill(255, 100, 0, (abs(status)*1000));
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