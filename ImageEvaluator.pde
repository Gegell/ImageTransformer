class ImageEvaluator {
  String[] contents;
  String path;
  JSONArray permutations;

  ImageEvaluator(String path) {
    this.path = path;
    getContents();
    permutations = getPermutations();
  }

  void getContents() {
    File dir = new File(sketchPath(path));
    contents = dir.list();
    for (int i = 0; i < contents.length; i++) {
      contents[i] = path + "/" + contents[i];
    }
    println(contents);
  }

  JSONArray getPermutations() {
    JSONArray json = new JSONArray();
    for (int i = 0; i < contents.length; i++) {
      for (int j = 0; j < contents.length; j++) {
        if (i != j) {
          JSONObject permutation = new JSONObject();
          permutation.setString("pixelPath", contents[i]);
          permutation.setString("shapePath", contents[j]);
          permutation.setInt("fitness", getFitness(contents[i], contents[j]));
          json.append(permutation);
        }
      }
    }
    //println(json);
    return json;
  }
  
  int getFitness(String path1, String path2) {
    PImage img1 = loadImage(path1);
    img1.resize(imgWidth, imgHeight);
    PImage img2 = loadImage(path2);
    img2.resize(imgWidth, imgHeight);
    float fitness = hue(avgColor(img1)) - hue(avgColor(img2));
    return int(fitness);
  }
  
  color avgColor(PImage img) {
    float avgHue = 0;
    float avgSat = 0;
    float avgBri = 0;
    colorMode(HSB);
    for (int i = 0; i < img.pixels.length; i++) {
      avgHue += hue(img.pixels[i]);
      avgSat += saturation(img.pixels[i]);
      avgBri += brightness(img.pixels[i]);
    }
    avgHue /= img.pixels.length;
    avgSat /= img.pixels.length;
    avgBri /= img.pixels.length;
    return color(avgHue, avgSat, avgBri);
  }
}