//class for the ball
class Ball {
  int x, y;//tile
  int ballX, ballY; //coordinate
  boolean collision;
  Ball(int ballX, int ballY) {
    this.ballX=ballX;
    this.ballY=ballY;
    this.x=0;
    this.y=0;
    this.collision=false;
  }
  void update() {
    //if (!collision) {
      ballX+=vx;
      ballY+=vy;
    //}
    x=ballX/(500/mapsize);
    y=ballY/(500/mapsize);
    this.checkCollision();
  }
  //draws the ball
  void drawBall() {
    noStroke();
    fill(#EA3232);
    ellipse(ballX, ballY, 30, 30);
    noFill();
  }
  
  void direction(){
    vx=(mouseX-250)/10;
    vy=(mouseY-250)/10;
  }
  void checkCollision() {
    //borders
    if (ballX+offSet>=500 || ballX-offSet<=0) {
      vx=0;
      collision=true;
    }
    if (ballY+offSet>=500 || ballY-offSet<=0) {
      vy=0;
      collision=true;
    }

    if (x<4) {//otherwise array out of bounds
      //wall to the right
      if ((tiles.get(x+mapsize*y+1)=='|') && (ballX>=((x+1)*(500/mapsize)-offSet+5))) {
        vx=0;
        collision=true;
      }
    }
    //wall to the left
    if ((tiles.get(x+mapsize*y)=='|') && (ballX<=((x)*(500/mapsize)+offSet))) {
      vx=0;
      collision=true;
    }
    //wall to the right "/" wall
    if ((tiles.get(x+mapsize*y)=='/') && (ballX>=((x+1)*(500/mapsize)-offSet))) {
      vx=0;
      collision=true;
    }
    //wall down from up
    if ((tiles.get(x+mapsize*y)=='_') && (ballY>=((y+1)*(500/mapsize)-offSet+5))) {
      vy=0;
      collision=true;
    }
    if (y>0) {
      //wall down from down
      if ((tiles.get(x+mapsize*y-mapsize)=='_') && (ballY<=((y)*(500/mapsize+offSet)))) {
        vy=0;
        collision=true;
      }
    }
    //wall up
    if ((tiles.get(x+mapsize*y)=='-') && (ballY<=((y)*(500/mapsize)+offSet))) {
      vy=0;
      collision=true;
    }
    if (y<4) {
      //wall up from up
      if ((tiles.get(x+mapsize*y+mapsize)=='-') && (ballY>=((y+1)*(500/mapsize)-offSet+5))) {
        vy=0;
        collision=true;
      }
    }
    //L-shaped wall
    if (x<4) {//otherwise array out of bounds
      //wall to the right
      if ((tiles.get(x+mapsize*y+1)=='L') && (ballX>=((x+1)*(500/mapsize)-offSet+5))) {
        vx=0;
        collision=true;
      }
    }
    //wall to the left
    if ((tiles.get(x+mapsize*y)=='L')) {
      if (ballX<=((x)*(500/mapsize)+offSet)) {
        vx=0;
        collision=true;
      }
      if (ballY>=((y+1)*(500/mapsize)-offSet+5)) {
        vy=0;
        collision=true;
      }
    }
    if (y>0) {
      if ((tiles.get(x+mapsize*y-mapsize)=='L') && (ballY<=((y)*(500/mapsize)+offSet))) {
        vy=0;
        collision=true;
      }
    }
    //J-shaped wall
    if (x>1) {//otherwise array out of bounds
      //wall to the left
      if ((tiles.get(x+mapsize*y-1)=='J') && (ballX<=((x)*(500/mapsize)+offSet))) {
        vx=0;
        collision=true;
      }
    }
    //wall to the right
    if ((tiles.get(x+mapsize*y)=='J')) {
      if (ballX>=((x+1)*(500/mapsize)-offSet+5)) {
        vx=0;
        collision=true;
      }
      if (ballY>=((y+1)*(500/mapsize)-offSet+5)) {
        vy=0;
        collision=true;
      }
    }
    if (y>0) {
      if ((tiles.get(x+mapsize*y-mapsize)=='J') && (ballY<=((y)*(500/mapsize)+offSet))) {
        vy=0;
        collision=true;
      }
    }
    else{
      collision=false;
    }
  }
}

