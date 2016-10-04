//
// For this programm to work there must be a folder named art.
// Inside it there must be two pictures
//
// With a key press the algorithm toggles
//

int useTransformer = 0;
int swpActions = 50000;
int selActions = 100;
int imgWidth = 240*2;
int imgHeight = 320*2;
String pathPixels = "vangogh.jpg";
String pathGoal = "background.jpg";
boolean automated = false;
ImageTransformerSwap itSwp;
ImageTransformerSelection itSel;
Automation auto;

void setup() {
  size(1440, 640);
  if (automated) {
    auto = new Automation();
  } else {
    pathPixels = "art/" + pathPixels;
    pathGoal = "art/" + pathGoal;
    itSwp = new ImageTransformerSwap(pathPixels, pathGoal, swpActions);
    itSel = new ImageTransformerSelection(pathPixels, pathGoal, selActions);
  }
}

void draw() {
  if (!automated) {
    if (useTransformer == 0) {
      itSwp.update();
      itSwp.display();
    } else if (useTransformer == 1) {
      itSel.update();
      itSel.display();
    }
  } else {
    auto.update();
    auto.display();
  }
}

void keyPressed() {
  if (key != 's') {
    if (useTransformer == 0) {
      itSel = new ImageTransformerSelection(pathPixels, pathGoal, selActions);
      useTransformer = 1;
    } else if (useTransformer == 1) {
      itSwp = new ImageTransformerSwap(pathPixels, pathGoal, swpActions);
      useTransformer = 0;
    }
  } else {
    if (useTransformer == 0) {
      trySave(itSwp.result);
    } else if (useTransformer == 1) {
      trySave(itSel.result);
    }
  }
}

boolean fileExists(String fileName) {
  File file = new File(sketchPath(fileName));
  return(file.exists());
}

void trySave(PImage output) {
  trySave(output, "manualSave", "");
}

void trySave(PImage output, String folder, String name) {
  String newPath = folder + "/" + name; 
  if (name.length() == 0) newPath += match(pathGoal, "(?<=/).*?(?=\\.)")[0] + "From" + match(pathPixels, "(?<=/).*?(?=\\.)")[0] + ".png";
  if (!fileExists(newPath)) {
    output.save(newPath);
    println("Saved to: " + newPath);
  } else {
    println("Couldn't save");
  }
}