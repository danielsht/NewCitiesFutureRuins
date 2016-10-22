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
    stroke(30, 30, 30, 175);
//    noStroke();  
    beginShape();
    vertex(p1[0], p1[1], p1[2]);
    vertex(p2[0], p2[1], p2[2]);
    vertex(p3[0], p3[1], p3[2]);
    vertex(p4[0], p4[1], p4[2]);
    endShape(CLOSE);
  }

  void calculate() {
    color colorA = color(140, 60, 60, 175);
    color colorB = color(140, 120, 120, 175);
    switch(this.state) {
    case 0: // city
      this.c = color(255, 255, 255, 175);
      this.elev = 3;
      break;
    case 1: // lowest terrain
      this.c = lerpColor(colorA, colorB, .2);
      this.elev = 5;
      break;
    case 2: // medium-low terrain
      this.c = lerpColor(colorA, colorB, .4);
      this.elev = 4;
      break;
    case 3: // medium-hi terrain
      this.c = lerpColor(colorA, colorB, .6);
      this.elev = 2;
      break;
    case 4: // hi terrain
      this.c = lerpColor(colorA, colorB, .8);
      this.elev = 1;
      break;
    case 5: // river
      this.c = color(100, 200, 200, 175);
      this.elev = 0;
      break;
    case 6: // road
      this.c = color(125, 125, 125, 175);
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

