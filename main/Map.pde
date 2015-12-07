//class for map graphics

class Map {
  int goalx, goaly, dim, wallWidth;
  PImage goal;
  PImage wall;

  Map () {
    this.goalx=0;
    this.goaly=0;
    this.dim = 5;
    this.wallWidth=5;
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
        goalx = col - 1;
        goaly = row;
      }
    }
  }
  
  void drawMap() {
    goal = loadImage("../backgrounds/goal.jpg");
    wall = loadImage("../backgrounds/wall.jpg");
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
        //image(wall,tilesize*column, tilesize*row);
        rect(tilesize*column, tilesize*row, tilesize, wallWidth);
      } //horizontal wall up
      if (tile=='_') {
        rect(tilesize*column, tilesize*row+tilesize, tilesize, wallWidth);
      } //horizontal wall down
      if (tile=='|') {
        rect(tilesize*column, tilesize*row, wallWidth, tilesize);
      } //vertical wall left
      if (tile=='/') {
        rect(tilesize*column+tilesize, tilesize*row, wallWidth, tilesize);
      } //vertical wall right
      if (tile=='L') {
        rect(tilesize*column, tilesize*row, wallWidth, tilesize);
        rect(tilesize*column, tilesize*row+tilesize, tilesize, 5);
      } //wall left and down
      if (tile=='J') {
        rect(tilesize*column+tilesize, tilesize*row, wallWidth, tilesize);
        rect(tilesize*column, tilesize*row+tilesize, tilesize, wallWidth);
      } //goal
      if (tile == 'g') {
        translate(0, -50);
        image(goal,tilesize*column+tilesize/2, tilesize*row+tilesize/2);
        translate(0, 50);
        //rect(tilesize*column+tilesize/2, tilesize*row+tilesize/2, 40, 40);
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