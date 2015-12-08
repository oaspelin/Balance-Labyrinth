//class for the ball
class Ball {
  int x, y;//tile
  int ballX, ballY; //coordinate
  boolean collisionRight, collisionLeft, collisionUp, collisionDown;

  Ball(int x, int y) {
    this.ballX=x*(screenWidth/mapsize)+screenWidth/2-250+min(screenWidth/mapsize,100)/2;
    this.ballY=y*(screenWidth/mapsize)+screenWidth/6+min(screenWidth/mapsize,100)/2;
    this.x=x;
    this.y=y;
    this.collisionRight=false;
    this.collisionLeft=false;
    this.collisionUp=false;
    this.collisionDown=false;
  }
  void update() {
    this.direction();
    this.checkHole();
    this.checkCollision();
    this.move();
    x=min(ballX/((screenWidth/mapsize)+(screenWidth/2-250)), mapsize-1);
    y=min(ballY/((screenWidth/mapsize)+screenWidth/6), mapsize-1);
  }
  //draws the ball
  void drawBall() {
    translate(ballX, ballY, 0);
    lights();
    noStroke();
    fill(1,200,255);
    sphere(20);
  }
  void move() {
    if (collisionRight && vx>=0) {
      vx=0;
    }
    if (collisionLeft && vx<=0) {
      vx=0;
    }
    if (collisionUp && vy<=0) {
      vy=0;
    }
    if (collisionDown && vy>=0) {
      vy=0;
    }
    ballX+=vx;
    ballY+=vy;
  }

  void direction() {
    if (use_board) {
      boolean scale = false;
      int coeff_scale = 2;
      int coeff_noscale = 100;

      float pressure_pad_1 = arduino.analogRead(0);
      float pressure_pad_2 = arduino.analogRead(1);
      float pressure_pad_3 = arduino.analogRead(2);
      float pressure_pad_4 = arduino.analogRead(4);

      float weigth_left = pressure_pad_1 + pressure_pad_2;
      float weigth_right = pressure_pad_3 + pressure_pad_4;
      float weigth_up = pressure_pad_1 + pressure_pad_4;
      float weigth_down = pressure_pad_2 + pressure_pad_3;

      vx = int(weigth_right - weigth_left);
      vy = int(weigth_down - weigth_up);

      if (scale) {
        float vx_0to2 = vx * 2 / 1024.0;
        float vy_0to2 = vy * 2 / 1024.0;
        float scaled_vx = pow(vx_0to2, 2) * coeff_scale;
        float scaled_vy = pow(vy_0to2, 2) * coeff_scale;

        if (vx < 0) scaled_vx *= -1;
        if (vy < 0) scaled_vy *= -1;

        vx = int(scaled_vx);
        vy = int(scaled_vy);
      } else {
        vx /= coeff_noscale;
        vy /= coeff_noscale;
      }
    } else {
      vx = (mouseX - 250) / 40;
      vy = (mouseY - 250) / 40;
    }
  }

  //checks if ball enters a hole
  void checkHole() {
    if (tiles.get(x+mapsize*y)=='o' &&
      ((ballX>=(x*screenWidth/mapsize+offSet+10) &&
      ballX<=(min(mapsize, (x+1))*screenWidth/mapsize-offSet-10)) &&
      (ballY>=(y*screenWidth/mapsize+offSet+10) &&
      ballY<=(min(mapsize, (y+1))*screenWidth/mapsize-offSet-10)))) {
      //resets ball to starting position
      x=0;
      y=0;
    }
  }
  void checkCollision() {
    collisionRight=false;
    collisionLeft=false;
    collisionUp=false;
    collisionDown=false;
    //borders
    if (ballX+offSet>=screenWidth || ballX-offSet<=0) {
      if (ballX+offSet>=screenWidth) { 
        collisionRight=true;
      } else if (ballX-offSet<=0) { 
        collisionLeft=true;
      }
    }
    if (ballY+offSet>=screenWidth || ballY-offSet<=0) {
      if (ballY+offSet>=screenWidth) { 
        collisionDown=true;
      } else if (ballY-offSet<=0) { 
        collisionUp=true;
      }
    }

    if (x<4) {//otherwise array out of bounds
      //wall to the right
      if ((tiles.get(x+mapsize*y+1)=='|') && (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5))) {
        collisionRight=true;
      }
    }
    //wall to the left
    if ((tiles.get(x+mapsize*y)=='|') && (ballX<=((x)*(screenWidth/mapsize)+offSet))) {
      collisionLeft=true;
    }
    //wall to the right "/" wall
    if ((tiles.get(x+mapsize*y)=='/') && (ballX>=((x+1)*(screenWidth/mapsize)-offSet))) {
      collisionRight=true;
    }
    //wall down from up
    if ((tiles.get(x+mapsize*y)=='_') && (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5))) {
      collisionUp=true;
    }
    if (y>0) {
      //wall down from down
      if ((tiles.get(x+mapsize*y-mapsize)=='_') && (ballY<=((y)*(screenWidth/mapsize+offSet)))) {
        collisionDown=true;
      }
    }
    //wall up
    if ((tiles.get(x+mapsize*y)=='-') && (ballY<=((y)*(screenWidth/mapsize)+offSet))) {
      collisionUp=true;
    }
    if (y<4) {
      //wall up from up
      if ((tiles.get(x+mapsize*y+mapsize)=='-') && (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5))) {
        collisionDown=true;
      }
    }
    //L-shaped wall
    if (x<4) {//otherwise array out of bounds
      //wall to the right
      if ((tiles.get(x+mapsize*y+1)=='L') && (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5))) {
        collisionRight=true;
      }
    }
    //wall to the left
    if ((tiles.get(x+mapsize*y)=='L')) {
      if (ballX<=((x)*(screenWidth/mapsize)+offSet)) {
        collisionLeft=true;
      }
      if (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5)) {
        collisionDown=true;
      }
    }
    if (y>0) {
      if ((tiles.get(x+mapsize*y-mapsize)=='L') && (ballY<=((y)*(screenWidth/mapsize)+offSet))) {
        collisionUp=true;
      }
    }
    //J-shaped wall
    if (x>1) {//otherwise array out of bounds
      //wall to the left
      if ((tiles.get(x+mapsize*y-1)=='J') && (ballX<=((x)*(screenWidth/mapsize)+offSet))) {
        collisionLeft=true;
      }
    }
    //wall to the right
    if ((tiles.get(x+mapsize*y)=='J')) {
      if (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5)) {
        collisionRight=true;
      }
      if (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5)) {
        collisionDown=true;
      }
    }
    if (y>0) {
      if ((tiles.get(x+mapsize*y-mapsize)=='J') && (ballY<=((y)*(screenWidth/mapsize)+offSet))) {
        collisionUp=true;
      }
    }
    //not going through wall if the ball comes from the side
    // from down vertical wall ('L' & '|')
    if (((tiles.get(max(x+mapsize*(y-1), 0))=='|') || (tiles.get(max(x+mapsize*(y-1), 0))=='L'))
      && (ballY<=((y)*(screenWidth/mapsize)+offSet-5) && (ballX<=((x)*(screenWidth/mapsize))+offSet-5)&& ballX>=((x)*(screenWidth/mapsize)-offSet+10))) {
      collisionUp=true;
    }
    if (((tiles.get(max(x+mapsize*(y-1)+1, mapsize))=='|') ||(tiles.get(max(x+mapsize*(y-1)+1, mapsize))=='L'))
      && (ballY<=((y)*(screenWidth/mapsize)+offSet-5) && (ballX<=((x+1)*(screenWidth/mapsize))+offSet-5) && ballX>=((x+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionUp=true;
    }
    // from up vertical wall ('L' & '|')
    if (((tiles.get(min(x+mapsize*(y+1), mapsize*mapsize-1))=='|') || (tiles.get(min(x+mapsize*(y+1), mapsize*mapsize-1))=='L'))
      && (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5) && (ballX<=((x)*(screenWidth/mapsize))+offSet-5)&& ballX>=((x)*(screenWidth/mapsize)-offSet+10))) {
      collisionDown=true;
    }
    if (((tiles.get(min(x+mapsize*(y+1)+1, mapsize*mapsize-1))=='|') ||(tiles.get(min(x+mapsize*(y+1)+1, mapsize*mapsize-1))=='|'))
      && (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5) && (ballX<=((x+1)*(screenWidth/mapsize))+offSet-5) && ballX>=((x+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionDown=true;
    }

    // from down vertical wall ('/' & 'J')
    if (((tiles.get(max(x+mapsize*(y-1), 0))=='J') || (tiles.get(max(x+mapsize*(y-1), 0))=='/'))
      && (ballY<=((y)*(screenWidth/mapsize)+offSet-5) && (ballX<=((x+1)*(screenWidth/mapsize))+offSet-5)&& ballX>=((x+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionUp=true;
    }
    if (((tiles.get(max(x+mapsize*(y-1)-1, mapsize))=='J') ||(tiles.get(max(x+mapsize*(y-1)-1, 0))=='/'))
      && (ballY<=((y)*(screenWidth/mapsize)+offSet-5) && (ballX<=((x)*(screenWidth/mapsize))+offSet-5) && ballX>=((x)*(screenWidth/mapsize)-offSet+10))) {
      collisionUp=true;
    }
    // from up vertical wall ('/' & 'J')
    if (((tiles.get(min(x+mapsize*(y+1), mapsize*mapsize-1))=='J') || (tiles.get(min(x+mapsize*(y+1), mapsize*mapsize-1))=='/'))
      && (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5) && (ballX<=((x+1)*(screenWidth/mapsize))+offSet-5)&& ballX>=((x+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionDown=true;
    }
    if (((tiles.get(min(x+mapsize*(y+1)-1, mapsize*mapsize-1))=='J') ||(tiles.get(min(x+mapsize*(y+1)-1, mapsize*mapsize-1))=='/'))
      && (ballY>=((y+1)*(screenWidth/mapsize)-offSet+5) && (ballX<=((x)*(screenWidth/mapsize))+offSet-5) && ballX>=((x)*(screenWidth/mapsize)-offSet+10))) {
      collisionDown=true;
    }

    // from right horizontal wall ('-')
    if (((tiles.get(min(x+mapsize*y+1, mapsize*mapsize-1))=='-'))
      && (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5) && (ballY<=((y)*(screenWidth/mapsize))+offSet-5)&& ballY>=((y)*(screenWidth/mapsize)-offSet+10))) {
      collisionRight=true;
    }
    if (((tiles.get(min(x+mapsize*(y+1)+1, mapsize*mapsize-1))=='-'))
      && (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5) && (ballY<=((y+1)*(screenWidth/mapsize))+offSet-5)&& ballY>=((y+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionRight=true;
    }
    // from right horizontal wall ('_' & 'L' & 'J')
    if (((tiles.get(min(x+mapsize*y+1, mapsize*mapsize-1))=='_') || (tiles.get(min(x+mapsize*y+1, mapsize*mapsize-1))=='L') || (tiles.get(min(x+mapsize*y+1, mapsize*mapsize-1))=='J'))
      && (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5) && (ballY<=((y+1)*(screenWidth/mapsize))+offSet-5) && ballY>=((y+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionRight=true;
    }
    if (((tiles.get(max(x+mapsize*(y-1)+1, 0))=='_') || (tiles.get(max(x+mapsize*(y-1)+1, 0))=='L') || (tiles.get(max(x+mapsize*(y-1)+1, 0))=='J'))
      && (ballX>=((x+1)*(screenWidth/mapsize)-offSet+5) && (ballY<=((y)*(screenWidth/mapsize))+offSet-5)&& ballY>=((y)*(screenWidth/mapsize)-offSet+10))) {
      collisionRight=true;
    }

    // from left horizontal wall ('-')
    if (((tiles.get(max(x+mapsize*y-1, 0))=='-'))
      && (ballX<=((x)*(screenWidth/mapsize)+offSet-5) && (ballY<=((y)*(screenWidth/mapsize))+offSet-5)&& ballY>=((y)*(screenWidth/mapsize)-offSet+10))) {
      collisionLeft=true;
    }
    if (((tiles.get(min(x+mapsize*(y+1)-1, mapsize*mapsize-1))=='-'))
      && (ballX<=((x)*(screenWidth/mapsize)+offSet-5) && (ballY<=((y+1)*(screenWidth/mapsize))+offSet-5)&& ballY>=((y+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionLeft=true;
    }
    // from left horizontal wall ('_' & 'L' & 'J')
    if (((tiles.get(max(x+mapsize*y-1, 0))=='_') || (tiles.get(max(x+mapsize*y-1, 0))=='L') || (tiles.get(max(x+mapsize*y-1, 0))=='J'))
      && (ballX<=((x)*(screenWidth/mapsize)+offSet-5) && (ballY<=((y+1)*(screenWidth/mapsize))+offSet-5) && ballY>=((y+1)*(screenWidth/mapsize)-offSet+10))) {
      collisionLeft=true;
    }
    if (((tiles.get(max(x+mapsize*(y-1)-1, 0))=='_') || (tiles.get(max(x+mapsize*(y-1)-1, 0))=='L') || (tiles.get(max(x+mapsize*(y-1)-1, 0))=='J'))
      && (ballX<=((x)*(screenWidth/mapsize)+offSet-5) && (ballY<=((y)*(screenWidth/mapsize))+offSet-5)&& ballY>=((y)*(screenWidth/mapsize)-offSet+10))) {
      collisionLeft=true;
    }
  }
}
