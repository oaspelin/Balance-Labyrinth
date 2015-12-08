Button[] menuButtons;
PImage menubg;

void menuSetup() {
  menuButtons = new Button[3];
  menuButtons[0] = new Button("Play", new PVector(screenWidth/2, 180+(screenWidth-500)/2), 220, 30);
  menuButtons[1] = new Button("Choose Map", new PVector(screenWidth/2, 280+(screenWidth-500)/2), 220, 30);
  menuButtons[2] = new Button("Calibrate", new PVector(screenWidth/2, 380+(screenWidth-500)/2), 220, 30);
  menubg = loadImage("../backgrounds/wooden_menu.jpg");
  menubg.resize(screenWidth, screenWidth);
}

void menuDraw() {
  background(0);
  image(menubg, 0, 0);
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
  if (menu) {
    if (menuButtons[0].containsMouse()) {
      menu=false;
    }
    if (menuButtons[1].containsMouse()) {
      menu=false;
      mapMenu=true;
    }
    if (menuButtons[2].containsMouse()) {
      //implement
    }
  }
  else if (mapMenu) {
    if (mapButtons[0].containsMouse()) {
      mapnum=0;
      //readMap();
      ball= new Ball(0, 0);
      mapMenu=false;
    }
    if (mapButtons[1].containsMouse()) {
      mapnum=1;
      readMap();
      ball= new Ball(0, 0);
      mapMenu=false;
    }
    if (mapButtons[2].containsMouse()) {
      mapnum=2;
      readMap();
      ball= new Ball(0, 0);
      mapMenu=false;
    }
    if (mapButtons[3].containsMouse()) {
      menu=true;
      mapMenu=false;
    }
  }
}

class Button {
  PVector pos;
  //color textColor;
  float size, textsize;
  String text;

  Button(String text, PVector pos, float size, float textsize) {
    this.pos = pos;
    //this.textColor = 255;
    this.size = size;
    this.text = text;
    this.textsize=textsize;
    textSize(textsize);
    textAlign(CENTER);
  }

  void draw() {
    textSize(textsize);
    noStroke();
    fill(41, 191, 191, 200);
    if (containsMouse()) rect(pos.x-120, pos.y-20, size+20, 90);
    else rect(pos.x-110, pos.y-10, size, 70);
    fill(255);
    if (size==260) {
      text(text, pos.x+20, pos.y + textsize + 5);
    } else text(text, pos.x, pos.y + textsize + 5);
  }

  boolean containsMouse() {
    if (mouseX > pos.x-100 && mouseX < pos.x + 100 && mouseY > pos.y-10 && mouseY < pos.y + 60 )
      return true;
    else return false;
  }
}

