//class for the ellipse
class Position {
  int x, y;
  boolean locked, rotate, scale;
  Position(int x, int y) {
    this.x=x;
    this.y=y;
  }
  void update() {
    x=ballX/(500/mapsize);
    y=ballY/(500/mapsize);
    this.checkCollision();
  }
  void checkCollision() {
    if (x<4) {
      if ((tiles.get(x+mapsize*y+1)=='|') && (ballX>=((x+1)*(500/mapsize)-offSet+5))) {
        vx=0;
      }
    }
    if ((tiles.get(x+mapsize*y)=='/') && (ballX>=((x+1)*(500/mapsize)-offSet))) {
      vx=0;
    }
  }
}

