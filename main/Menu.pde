Button[] menuButtons;
PImage menubg;

void menuSetup() {
  menuButtons = new Button[3];
  menuButtons[0] = new Button("Play", new PVector(screenWidth/2, 180+(screenWidth-500)/2), 30);
  menuButtons[1] = new Button("Choose Map", new PVector(screenWidth/2, 280+(screenWidth-500)/2), 30);
  menuButtons[2] = new Button("Calibrate", new PVector(screenWidth/2, 380+(screenWidth-500)/2), 30);
  menubg = loadImage("../backgrounds/menu.jpg");
}

void menuDraw() {
  background(0);
  image(menubg,screenWidth/2-250,(screenWidth-500)/2);
  textSize(50);
  fill(255);
  //text("Balance Labyrinth", 250, 70);
  displayMenu();
}

void displayMenu() {
  for (int i = 0; i <3; i++) {
    menuButtons[i].draw();
  }
}

void mousePressed() {
  if (menuButtons[0].containsMouse()) {
    menu=false;
  }
  if (menuButtons[1].containsMouse()) {
    //implement
  }
  if (menuButtons[2].containsMouse()) {
    //implement
  }
}

class Button {
  PVector pos;
  //color textColor;
  float size;
  String text;

  Button(String text, PVector pos, float size) {
    this.pos = pos;
    //this.textColor = 255;
    this.size = size;
    this.text = text;
    textSize(size);
    textAlign(CENTER);
  }

  void draw() {
    textSize(size);
    noStroke();
    fill(41, 191, 191, 200);
    if (containsMouse()) rect(pos.x-120, pos.y-20, 240, 90);
    else rect(pos.x-110, pos.y-10, 220, 70);
    fill(255);
    text(text, pos.x, pos.y + size + 5);
  }

  boolean containsMouse() {
    if (mouseX > pos.x-100 && mouseX < pos.x + 100 && mouseY > pos.y-10 && mouseY < pos.y + 60 )
      return true;
    else return false;
  }
}
