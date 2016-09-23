//For this programm to work there must be a folder named art.
//Inside it there must be two pictures named "firstPic.jpg" and "secondPic.jpg"

int useTransformer = 0;
ImageTransformerSwap itSwp;
ImageTransformerSelection itSel;

void setup() {
  size(720, 320);
  itSwp = new ImageTransformerSwap("art/vangogh.jpg", "art/background.jpg", 50000);
  itSel = new ImageTransformerSelection("art/vangogh.jpg", "art/background.jpg", 100);
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
    itSel = new ImageTransformerSelection("art/vangogh.jpg", "art/background.jpg", 100);
    useTransformer = 1;
  } else if (useTransformer == 1) {
    itSwp = new ImageTransformerSwap("art/vangogh.jpg", "art/background.jpg", 50000);
    useTransformer = 0;
  }
}