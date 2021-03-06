class Cube {

  float p1[] = new float[3];
  float p2[] = new float[3];
  float p3[] = new float[3];
  float p4[] = new float[3];
  int x;
  int y;
  int state;
  int elev;
  color c;

  Cube(int x, int y, int state) {
    this.x = x;
    this.y = y;
    this.state = state;
    this.calculate();
  }

  void display() {
    fill(c);
    stroke(171, 100, 45, 125);
//    noStroke();  
    beginShape();
    vertex(p1[0], p1[1], p1[2]);
    vertex(p2[0], p2[1], p2[2]);
    vertex(p3[0], p3[1], p3[2]);
    vertex(p4[0], p4[1], p4[2]);
    endShape(CLOSE);
  }

  void calculate() {
    float alphaValue = 200;
    switch(this.state) {
    case 0: // city
      this.c = color(255, 255, 255, alphaValue);
      this.elev = 3;
      break;
    case 1: // highest terrain
      this.c = color(171, 100, 45, alphaValue);
      this.elev = 5;
      break;
    case 2: // medium-high terrain
      this.c = color(212, 175, 122, alphaValue);
      this.elev = 4;
      break;
    case 3: // medium-low terrain
      this.c = color(208, 171, 84, alphaValue);
      this.elev = 2;
      break;
    case 4: // lowest terrain
      this.c = color(220, 194, 133, alphaValue);
      this.elev = 1;
      break;
    case 5: // river
      this.c = color(100, 200, 200, alphaValue);
      this.elev = 0;
      break;
    case 6: // road
      this.c = color(125, 125, 125, alphaValue);
      this.elev = 3;
      break;
    }
    this.p1[0] = (this.x*sizer - (.25 * sizer))+200;
    this.p1[1] = 600 - elev;
    this.p1[2] = (this.y*sizer - (.25 * sizer))-150;

    this.p2[0] = (this.x*sizer + (.25 * sizer))+200;
    this.p2[1] = 600 - elev;
    this.p2[2] = (this.y*sizer - (.25 * sizer))-150;

    this.p3[0] = (this.x*sizer + (.25 * sizer))+200;
    this.p3[1] = 600 - elev;
    this.p3[2] = (this.y*sizer + (.25 * sizer))-150;

    this.p4[0] = (this.x*sizer - (.25 * sizer))+200;
    this.p4[1] = 600 - elev;
    this.p4[2] = (this.y*sizer + (.25 * sizer))-150;
  }
}
