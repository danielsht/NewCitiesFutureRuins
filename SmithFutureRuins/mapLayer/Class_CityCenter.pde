class CityCenter {
  PVector location;
  float _diameter;
  float _height;
  CityCenter() {
  }
  
  CityCenter(int x, int y) {
    location = new PVector(200 + (x*sizer), 600, -150+(y*sizer));
  }
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    //sphere(100);
    popMatrix();
  }
}