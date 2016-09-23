//
// For this programm to work there must be a folder named art.
// Inside it there must be two pictures named "firstPic.jpg" and "secondPic.jpg"
//
// With a key press the algorithm toggles
//

int useTransformer = 0;
int swpActions = 500000;
int selActions = 100;
String pathPixels = "art/vangogh.jpg";
String pathGoal = "art/monalisa.jpg";
ImageTransformerSwap itSwp;
ImageTransformerSelection itSel;

void setup() {
  size(720, 320);
  itSwp = new ImageTransformerSwap(pathPixels, pathGoal, swpActions);
  itSel = new ImageTransformerSelection(pathPixels, pathGoal, selActions);
}

void draw() {
  if (useTransformer == 0) {
    itSwp.update();
    itSwp.display();
  } else if (useTransformer == 1) {
    itSel.update();
    itSel.display();
  }
}

void keyPressed() {
  if (useTransformer == 0) {
    itSel = new ImageTransformerSelection(pathPixels, pathGoal, selActions);
    useTransformer = 1;
  } else if (useTransformer == 1) {
    itSwp = new ImageTransformerSwap(pathPixels, pathGoal, swpActions);
    useTransformer = 0;
  }
}