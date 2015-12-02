//class for map graphics

class Map {
  int goalx, goaly, dim;

  Map () {
    this.goalx=0;
    this.goaly=0;
    this.dim = 5;
  }

  void findGoal() {
    int row = 0;
    int col = 0;    
    for (char tile : tiles) {
      if (col > dim) {
        col = 1;
        row += 1;
      } 
      col += 1;
      
      if (tile == 'g') {
        goalx = col;
        goaly = row;
      }
    }
  }


  void drawMap() {
    int tilesize= 500/mapsize; //mapsize now static, could be changed
    int column=0;
    int row=0;
    for (char tile : tiles) {
      fill(0);
      if (tile=='o') {
        ellipse(tilesize*column+tilesize/2, tilesize*row+tilesize/2, 40, 40);
      } //hole
      fill(#A5370C);
      if (tile=='-') {
        rect(tilesize*column, tilesize*row, tilesize, 5);
      } //horizontal wall up
      if (tile=='_') {
        rect(tilesize*column, tilesize*row+tilesize, tilesize, 5);
      } //horizontal wall down
      if (tile=='|') {
        rect(tilesize*column, tilesize*row, 5, tilesize);
      } //vertical wall left
      if (tile=='/') {
        rect(tilesize*column+tilesize, tilesize*row, 5, tilesize);
      } //vertical wall right
      if (tile=='L') {
        rect(tilesize*column, tilesize*row, 5, tilesize);
        rect(tilesize*column, tilesize*row+tilesize, tilesize, 5);
      } //wall left and down
      if (tile=='J') {
        rect(tilesize*column+tilesize, tilesize*row, 5, tilesize);
        rect(tilesize*column, tilesize*row+tilesize, tilesize, 5);
      } //goal
      if (tile == 'g') {
        fill(45, 33, 23);
        ellipse(tilesize*column+tilesize/2, tilesize*row+tilesize/2, 40, 40);
        findGoal();
        fill(255);
      }



      //wall right and down
      column=(column+1)%5;
      if (column==0) {
        row+=1;
      } //next row
    }
  }
}

