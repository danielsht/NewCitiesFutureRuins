class Road {
  PVector location;
  Road() {
  }
  
  Road(int x, int y) {
    location = new PVector(200 + (x*sizer), 600, -150+(y*sizer));
  }
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    popMatrix();
  }
}
