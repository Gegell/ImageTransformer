PImage start;
PImage goal;
PImage result;
ArrayList<Pixel> available;
ArrayList<Pixel> compareto;

//For this programm to work there must be a folder named art.
//Inside it there must be two pictures named "firstPic.jpg" and "secondPic.jpg"

void setup() {
  size(720, 320);
  start = loadImage("art/firstPic.jpg");
  start.resize(240, 320);
  goal = loadImage("art/secondPic.jpg");
  goal.resize(240, 320);
  result = createImage(240, 320, RGB);
  available = getPixelArrayList(start);
  compareto = getPixelArrayList(goal);
}

void draw() {
  for (int j = 0; j < 100; j++) {
    if (available.size() > 0 && compareto.size() > 0) {
      int randChoose = floor(random(compareto.size()));
      Pixel comp = compareto.get(randChoose);
      Pixel best = available.get(0);
      int bestIndex = 0;
      colorMode(HSB);
      float dbc = dist(hue(best.c), saturation(best.c), brightness(best.c), hue(comp.c), saturation(comp.c), brightness(comp.c));
      for (int i = 1; i < available.size(); i++) {
        Pixel current = available.get(i);
        float dcc = dist(hue(current.c), saturation(current.c), brightness(current.c), hue(comp.c), saturation(comp.c), brightness(comp.c));
        if (dcc < dbc) {
          best = current;
          bestIndex = i;
          dbc = dist(hue(best.c), saturation(best.c), brightness(best.c), hue(comp.c), saturation(comp.c), brightness(comp.c));
        }
      }
      result.set(comp.x, comp.y, best.c);
      available.remove(bestIndex);
      compareto.remove(randChoose);
    }
  }
  image(start, 0, 0);
  image(result, 240, 0);
  image(goal, 480, 0);
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