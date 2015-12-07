String goal;
Button continueButton;

void Goal() {
  background(#F09138);
  textSize(20);
  float t = getTime();

  goal = "You completed level " + mapnum + " in " + t + " seconds";
  text(goal, 250, 70);
  
  continueButton = new Button("Continue", new PVector(250, 130), 32);
  continueButton.draw();
}
