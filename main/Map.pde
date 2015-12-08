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
    int tilesize= 100; //mapsize now static, could be changed
    int column=0;
    int row=0;
    image(wall,mapOffsetX,mapOffsetY,mapsize*tilesize,wallWidth);
    image(wall,mapOffsetX,screenWidth-mapOffsetY,mapsize*tilesize,wallWidth);
    image(wall,mapOffsetX,mapOffsetY,wallWidth,mapsize*tilesize);
    image(wall,screenWidth-mapOffsetX,mapOffsetY,wallWidth,mapsize*tilesize);
    for (char tile : tiles) {
      fill(0);
      if (tile=='o') {
        ellipse(tilesize*column+tilesize/2+mapOffsetX, tilesize*row+tilesize/2+mapOffsetY, 40, 40);
      } //hole
      fill(#A5370C);
      if (tile=='-') {
        //image(wall,tilesize*column, tilesize*row);
        image(wall, tilesize*column+mapOffsetX, tilesize*row+mapOffsetY, tilesize, wallWidth);
      } //horizontal wall up
      if (tile=='_') {
        image(wall, tilesize*column+mapOffsetX, tilesize*row+tilesize+mapOffsetY, tilesize, wallWidth);
      } //horizontal wall down
      if (tile=='|') {
        image(wall, tilesize*column+mapOffsetX, tilesize*row+mapOffsetY, wallWidth, tilesize);
      } //vertical wall left
      if (tile=='/') {
        image(wall, tilesize*column+tilesize+mapOffsetX, tilesize*row+mapOffsetY, wallWidth, tilesize);
      } //vertical wall right
      if (tile=='L') {
        image(wall, tilesize*column+mapOffsetX, tilesize*row+mapOffsetY, wallWidth, tilesize);
        image(wall, tilesize*column+mapOffsetX, tilesize*row+tilesize+mapOffsetY, tilesize, 5);
      } //wall left and down
      if (tile=='J') {
        image(wall, tilesize*column+tilesize+mapOffsetX, tilesize*row+mapOffsetY, wallWidth, tilesize);
        image(wall, tilesize*column+mapOffsetX, tilesize*row+tilesize+mapOffsetY, tilesize, wallWidth);
      } //goal
      if (tile == 'g') {
        translate(0, -50);
        image(goal,tilesize*column+tilesize/2+mapOffsetX, tilesize*row+tilesize/2+mapOffsetY);
        translate(0, 50);
        //rect(tilesize*column+tilesize/2, tilesize*row+tilesize/2, 40, 40);
        findGoal();
        fill(255);
      }

      //wall right and down
      column=(column+1)%mapsize;
      if (column==0) {
        row+=1;
      } //next row
    }
  }
}
