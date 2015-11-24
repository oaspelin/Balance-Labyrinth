int ballX;
int ballY;
int vx;
int vy;

void setup() {
  size(500, 500);
  background(255);
  ballX=20;
  ballY=20;
  vx=0;
  vy=0;
}

void draw() {
  drawBall();
}

void drawBall() {
  fill(#EA3232);
  noStroke();
  ellipse(ballX+vx, ballY+vy, 25, 25);
  noFill();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode==UP) {
      vy+=1;
    }
    if (keyCode==DOWN) {
      vy-=1;
    }
    if (keyCode==LEFT) {
      vx-=1;
    }
    if (keyCode==RIGHT) {
      vx+=1;
    }
  }
}

