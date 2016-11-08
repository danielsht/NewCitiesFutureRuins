class CityCenter {
  PVector location;
  float _spread;
  float _height;
  float modifier = 0.2;
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
    _spread+= modifier;
  }
  
  void decrementSpread() {
    if(_spread > 1)
      _spread-= modifier;
  }
  
  void incrementHeight() {
    _height+= modifier;
  }
  
  void decrementHeight() {
    if (_height > 1)
      _height -= modifier; 
  }
  
  void setToDefaultHeight() {
    _height = 1;
  }
  
  void setToDefaultSpread() {
    _spread = 1;
  }
}
