class Pixel {
  int x, y;
  int ex, ey;
  color c;
  
  Pixel(Pixel p) {
    x = p.x;
    y = p.y;
    ex = p.ex;
    ey = p.ey;
    c = p.c;
  }
  
  Pixel(int x, int y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
    ex = x;
    ey = y;
  }
  
  void updateEndPos(int newex, int newey) {
    ex = newex;
    ey = newey;
  }
}