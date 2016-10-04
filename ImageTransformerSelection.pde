class ImageTransformerSelection {
  // This algorithm selects the best matching Pixel at a point
  int actionsPerUpdate;
  PImage start;
  PImage goal;
  PImage result;
  ArrayList<Pixel> available;
  ArrayList<Pixel> compareto;


  ImageTransformerSelection(String pathFirst, String pathSecond, int actionsPerUpdate) {
    start = loadImage(pathFirst);
    start.resize(imgWidth, imgHeight);
    goal = loadImage(pathSecond);
    goal.resize(imgWidth, imgHeight);
    result = createImage(imgWidth, imgHeight, RGB);
    available = getPixelArrayList(start);
    compareto = getPixelArrayList(goal);
    this.actionsPerUpdate = actionsPerUpdate;
  }

  void update() {
    for (int j = 0; j < actionsPerUpdate; j++) {
      matchPixel();
    }
  }

  void matchPixel() {
    if (available.size() > 0 && compareto.size() > 0) {
      int randChoose = floor(random(compareto.size()));
      Pixel comp = compareto.get(randChoose);
      Pixel best = available.get(0);
      int bestIndex = 0;
      colorMode(HSB);
      float dbc = dstSqr(hue(best.c), saturation(best.c), brightness(best.c), hue(comp.c), saturation(comp.c), brightness(comp.c));
      for (int i = 1; i < available.size(); i++) {
        Pixel current = available.get(i);
        float dcc = dstSqr(hue(current.c), saturation(current.c), brightness(current.c), hue(comp.c), saturation(comp.c), brightness(comp.c));
        if (dcc < dbc) {
          best = current;
          bestIndex = i;
          dbc = dstSqr(hue(best.c), saturation(best.c), brightness(best.c), hue(comp.c), saturation(comp.c), brightness(comp.c));
        }
      }
      result.set(comp.x, comp.y, best.c);
      available.remove(bestIndex);
      compareto.remove(randChoose);
    }
  }

  void display() {
    image(start, 0, 0);
    image(result, imgWidth, 0);
    image(goal, imgWidth * 2, 0);
    surface.setTitle("Image Transformer - " + (100 - (available.size() * 100 / result.pixels.length)) + "% - " + int(frameRate*10)/10.0 + " fps");
  }

  ArrayList<Pixel> getPixelArrayList(PImage input) {
    ArrayList<Pixel> pxArrayList = new ArrayList<Pixel>();
    for (int y = 0; y < input.height; y++) {
      for (int x = 0; x < input.width; x++) {
        pxArrayList.add(new Pixel(x, y, input.get(x, y)));
      }
    }
    return pxArrayList;
  }

  float dstSqr(float x1, float y1, float z1, float x2, float y2, float z2) {
    float result = pow(x1-x2, 2) + pow(y1-y2, 2) + pow(z1-z2, 2);
    return result;
  }
}