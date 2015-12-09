Button[] LevelCompleteButtons;
String complete;

void levelCompleteSetup() {
  LevelCompleteButtons = new Button[2];
  LevelCompleteButtons[0] = new Button("Next Level", new PVector(screenWidth/2, 180+(screenWidth-500)/2), 220, 30);
  LevelCompleteButtons[1] = new Button("Back to Menu", new PVector(screenWidth/2, 280+(screenWidth-500)/2), 220, 30);
    //menubg.resize(screenWidth,screenWidth);
}

void levelCompleteDraw() {
  background(0);
  image(ground,0,0);
  textSize(30);
  fill(255);
  if(mapnum < 3){
    displayLevelComplete();
  } else {
    displayGameFinished();
  }
}

void displayGameFinished() {
  complete = "You completed level 3 in " + getTime() + " seconds";
  text(complete, screenWidth/2, 80+(screenWidth-500)/2);
  LevelCompleteButtons[1].draw();
  
}

void displayLevelComplete() {
  complete = "You completed level " + mapnum + " in " + getTime() + " seconds";
  text(complete, screenWidth/2, 80+(screenWidth-500)/2);
  for (int i = 0; i <2; i++) {
    LevelCompleteButtons[i].draw();
  }}
