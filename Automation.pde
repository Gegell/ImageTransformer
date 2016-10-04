class Automation {
  ImageEvaluator ie;
  ImageTransformerSwap it;
  int iteration = 0;
  JSONObject permutation;

  Automation() {
    ie = new ImageEvaluator("art");
    permutation = ie.permutations.getJSONObject(iteration);
    nextPermutation();
  }

  void nextPermutation() {
    if (iteration < ie.permutations.size()) {
      permutation = ie.permutations.getJSONObject(iteration);
      println(permutation);
      it = new ImageTransformerSwap(permutation.getString("pixelPath"), permutation.getString("shapePath"), swpActions);
      iteration++;
    } else {
      exit();
    }
  }

  void update() {
    if (it.swapsPerformed < 150000 && it.swapsLastPerformed > 0) {
      it.update();
    } else {
      trySave(it.result, "automatedSave", match(permutation.getString("shapePath"), "(?<=/).*?(?=\\.)")[0] + "From" + match(permutation.getString("pixelPath"), "(?<=/).*?(?=\\.)")[0] + "_" + it.swapsPerformed + "_" + permutation.getInt("fitness") + ".png");
      nextPermutation();
    }
  }

  void display() {
    it.display();
  }
}