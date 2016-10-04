class Animation {
  Pixel[] pixs;
  PImage inp;
  int w, h;

  Animation(PImage p) {
    inp = p;
    w = p.width;
    h = p.height;
    genPixs();
  }

  void swapPix(int i, int i2) {
    int tx = pixs[i].ex;
    int ty = pixs[i].ey;
    pixs[i].updateEndPos(pixs[i2].ex, pixs[i2].ey);
    pixs[i2].updateEndPos(tx, ty);
  }

  void genPixs() {
    pixs = new Pixel[w*h];
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        pixs[y*w+x] = new Pixel(x, y, inp.pixels[y*w+x]);
      }
    }
  }

  void genFile() {
    Table t = new Table();
    t.addColumn("x");
    t.addColumn("y");
    t.addColumn("ex");
    t.addColumn("ey");
    for (Pixel p : pixs) {
      TableRow tr = t.addRow();
      tr.setInt("x", p.x);
      tr.setInt("y", p.y);
      tr.setInt("ex", p.ex);
      tr.setInt("ey", p.ey);
    }
    saveTable(t, "animation/animation.csv");
  }
}