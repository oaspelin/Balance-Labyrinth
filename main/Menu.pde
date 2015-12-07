Button[] menuButtons;

void menuSetup() {
  menuButtons = new Button[3];
  menuButtons[0] = new Button("Play", new PVector(250, 130), 32);
  menuButtons[1] = new Button("Choose Map", new PVector(250, 230), 32);
  menuButtons[2] = new Button("Calibrate", new PVector(250, 330), 32);
}

void menuDraw() {
  background(#F09138);
  textSize(50);
  text("Balance Labyrinth", 250, 70);
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
    inGoal=false;
    startTime();
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
  color textColor;
  float size;
  String text;

  Button(String text, PVector pos, float size) {
    this.pos = pos;
    this.textColor = textColor;
    this.size = size;
    this.text = text;
    textSize(size);
    textAlign(CENTER);
  }

  void draw() {
    textSize(size);
    fill(#983F3F);
    if (containsMouse()) rect(pos.x-120, pos.y-20, 240, 90);
    else rect(pos.x-110, pos.y-10, 220, 70);
    fill(0);
    text(text, pos.x, pos.y + size);
  }

  boolean containsMouse() {
    if (mouseX > pos.x-100 && mouseX < pos.x + 100 && mouseY > pos.y-10 && mouseY < pos.y + 60 )
      return true;
    else return false;
  }
}
