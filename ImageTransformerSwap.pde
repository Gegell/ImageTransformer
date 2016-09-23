class ImageTransformerSwap {
  //This algorithm swaps two pixels and lokks whether they fit better
  int actionsPerUpdate;
  int swapsPerformed;
  PImage start;
  PImage goal;
  PImage result;

  ImageTransformerSwap(String pathFirst, String pathSecond, int actionsPerUpdate) {
    start = loadImage(pathFirst);
    start.resize(240, 320);
    goal = loadImage(pathSecond);
    goal.resize(240, 320);
    result = start.copy();
    this.actionsPerUpdate = actionsPerUpdate;
    swapsPerformed = 0;
  }

  void update() {
    for (int j = 0; j < actionsPerUpdate; j++) {
      swapPixel();
    }
  }

  void swapPixel() {
    result.loadPixels();
    int indexA = floor(random(result.pixels.length));
    int indexB = floor(random(result.pixels.length));
    color cA = result.pixels[indexA];
    color cB = result.pixels[indexB];
    color cgA = goal.pixels[indexA];
    color cgB = goal.pixels[indexB];
    float distBeforeA = dstSqr(hue(cA), saturation(cA), brightness(cA), hue(cgA), saturation(cgA), brightness(cgA));
    float distBeforeB = dstSqr(hue(cB), saturation(cB), brightness(cB), hue(cgB), saturation(cgB), brightness(cgB));
    float distAfterA = dstSqr(hue(cA), saturation(cA), brightness(cA), hue(cgB), saturation(cgB), brightness(cgB));
    float distAfterB = dstSqr(hue(cB), saturation(cB), brightness(cB), hue(cgA), saturation(cgA), brightness(cgA));
    if (distBeforeA > distAfterA && distBeforeB > distAfterB) {
      result.pixels[indexA] = cB;
      result.pixels[indexB] = cA;
      result.updatePixels();
      swapsPerformed++;
    }
  }

  void display() {
    image(start, 0, 0);
    image(result, 240, 0);
    image(goal, 480, 0);
    surface.setTitle("Image Transformer - " + swapsPerformed + " swaps - " + int(frameRate*10)/10.0 + " fps");
  }

  float dstSqr(float x1, float y1, float z1, float x2, float y2, float z2) {
    float result = pow(x1-x2, 2) + pow(y1-y2, 2) + pow(z1-z2, 2);
    return result;
  }
}