Button[] mapButtons;
//PImage menubg;

void mapMenuSetup() {
  mapButtons = new Button[4];
  mapButtons[0] = new Button("Map 1", new PVector(screenWidth/2, 180+(screenWidth-500)/2),220, 30);
  mapButtons[1] = new Button("Map 2", new PVector(screenWidth/2, 280+(screenWidth-500)/2),220, 30);
  mapButtons[2] = new Button("Map 3", new PVector(screenWidth/2, 380+(screenWidth-500)/2),220, 30);
  mapButtons[3] = new Button("Back to Menu", new PVector(screenWidth/2-20, 480+(screenWidth-500)/2),260, 30);
  menubg = loadImage("../backgrounds/wooden_menu.jpg");
  menubg.resize(screenWidth,screenWidth);
}

void mapMenuDraw() {
  background(0);
  image(menubg,0,0);
  textSize(50);
  fill(255);
  //text("Balance Labyrinth", 250, 70);
  displayMapMenu();
}

void displayMapMenu() {
  for (int i = 0; i <4; i++) {
    mapButtons[i].draw();
  }
}


