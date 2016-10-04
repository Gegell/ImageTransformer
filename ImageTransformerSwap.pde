class ImageTransformerSwap {
  //This algorithm swaps two pixels and lokks whether they fit better
  int actionsPerUpdate;
  int swapsPerformed;
  int swapsLastPerformed;
  PImage start;
  PImage goal;
  PImage result;

  ImageTransformerSwap(String pathFirst, String pathSecond, int actionsPerUpdate) {
    start = loadImage(pathFirst);
    start.resize(imgWidth, imgHeight);
    goal = loadImage(pathSecond);
    goal.resize(imgWidth, imgHeight);
    result = start.copy();
    this.actionsPerUpdate = actionsPerUpdate;
    swapsPerformed = 0;
    swapsLastPerformed = 100;
  }

  void update() {
    swapsLastPerformed = 0;
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
      swapsLastPerformed++;
      if (animation) {
        a.swapPix(indexA ,indexB);
      }
    }
  }

  void display() {
    image(start, 0, 0);
    image(result, imgWidth, 0);
    image(goal, imgWidth * 2, 0);
    surface.setTitle("Image Transformer - " + swapsPerformed + " swaps - " + swapsLastPerformed + " last - "+ int(frameRate*10)/10.0 + " fps");
  }

  float dstSqr(float x1, float y1, float z1, float x2, float y2, float z2) {
    float result = pow(x1-x2, 2) + pow(y1-y2, 2) + pow(z1-z2, 2);
    return result;
  }
}