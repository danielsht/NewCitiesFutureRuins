class CityCenter {
  PVector location;
  float _spread;
  float _height;
  CityCenter() {
  }
  
  CityCenter(int x, int y) {
    location = new PVector(200 + (x*sizer), 600, -150+(y*sizer));
    _spread = 1;
    _height = 1;
  }
  void render() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    //sphere(100);
    popMatrix();
  }
  
  void incrementSpread() {
    _spread+= 0.1;
  }
  
  void decrementSpread() {
    if(_spread > 2)
      _spread-= 0.1;
  }
  
  void incrementHeight() {
    _height+= 0.1;
  }
  
  void decrementHeight() {
    if (_height > 1)
      _height -= 0.1; 
  }
  
  void setToDefaultHeight() {
    _height = 1;
  }
  
  void setToDefaultSpread() {
    _spread = 2;
  }
}