class Cell {
  PVector location;
  int size;
  color c;
  boolean life;
  float sizer;
  float alpha;
  
  public Cell() {
  }
  public Cell(int size, PVector location) {
    this.size = size;
    this.location = location;
    life = false;
    sizer = 10;
    alpha = 100;
  }
  
  void update() {
    
  }
  
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    if (life) {
      fill(alpha, alpha, alpha, alpha);
      noStroke();
      //stroke(255);
      box(size*.75);
    } else {
      fill(0, 0, 0, 0);
      stroke(255);
    }
    popMatrix();
  }
}