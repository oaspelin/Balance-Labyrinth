
//ball positions
int ballX;
int ballY;
//same in both x and y
int offSet;
//velocity of the ball
int vx;
int vy;
//for reading the .txt file
String lines[];
//size of the map in terms of tiles
int mapsize;
//list of all the characters from the .txt file
ArrayList<Character> tiles = new ArrayList<Character>();
//position of the ball (x,y) used for collision detection
Position position;


void setup() {
  size(500, 500);
  background(255);
  ellipseMode(CENTER);
  
  readMap();
  
  //inits ball properties
  position= new Position(0,0); //where the ball starts
  ballX=20;
  ballY=20;
  offSet=20;
  vx=0;
  vy=0;
}

void readMap() {
  int index=2;
  lines=loadStrings("../maps/test.txt");
  mapsize=Integer.parseInt(lines[0]); //size of map defined in the .txt document
  while(index < lines.length-1) {
    //removes the "borders" from the map
    String temp= lines[index].substring(1);
    temp=temp.substring(0, temp.length()-1);
    for (char c : temp.toCharArray()) {
      tiles.add(c);
    }
    index = index + 1;
  }
}

void drawMap(){
  int tilesize= 500/mapsize; //mapsize now static, could be changed
  int column=0;
  int row=0;
  for(char tile: tiles){
    fill(0);
    if(tile=='o'){ellipse(tilesize*column+tilesize/2,tilesize*row+tilesize/2,60,60);} //hole
    fill(#A5370C);
    if(tile=='-'){rect(tilesize*column, tilesize*row,tilesize,5);} //horizontal wall up
    if(tile=='_'){rect(tilesize*column, tilesize*row+tilesize,tilesize,5);} //horizontal wall down
    if(tile=='|'){rect(tilesize*column, tilesize*row,5,tilesize);} //vertical wall left
    if(tile=='/'){rect(tilesize*column+tilesize, tilesize*row,5,tilesize);} //vertical wall right
    if(tile=='L'){rect(tilesize*column, tilesize*row,5,tilesize);rect(tilesize*column, tilesize*row+tilesize,tilesize,5);} //wall left and down
    if(tile=='J'){rect(tilesize*column+tilesize, tilesize*row,5,tilesize);rect(tilesize*column, tilesize*row+tilesize,tilesize,5);} //wall right and down
    column=(column+1)%5;
    if(column==0){row+=1;} //next row
  }
  
  //for testing
  /*
  for(int i=0; i<=5;i++){
    stroke(0);
    line(tilesize*i,0,tilesize*i,500);
    line(0, tilesize*i, 500,tilesize*i);
  }*/
}
void draw() {
  background(#A5370C);
  fill(255);  
  //kehys
  rect(5, 5, 490, 490);
  drawMap();
  drawBall();
}

//draws the ball
void drawBall() {
  noStroke();
  fill(#EA3232);
  updateBall();
  ellipse(ballX, ballY, 30, 30);
  noFill();
}

//updates ball coordinates
void updateBall() {
  ballX+=vx;
  ballY+=vy;
  checkCollision();
  position.update();
}

//only checks for borders atm
void checkCollision() {
  if (ballX+offSet>=500 || ballX-offSet<=0) {
    vx=0;
  }
  if (ballY+offSet>=500 || ballY-offSet<=0) {
    vy=0;
  }
}

//control of the ball
void keyPressed() {
  if (key == CODED) {
    if (keyCode==UP) {
      vy-=1;
    }
    if (keyCode==DOWN) {
      vy+=1;
    }
    if (keyCode==LEFT) {
      vx-=1;
    }
    if (keyCode==RIGHT) {
      vx+=1;
    }
  }
}

/* not really needed
 void keyReleased() {
 if (key == CODED) {
 if (keyCode==UP) {
 vy=0;
 }
 if (keyCode==DOWN) {
 vy=0;
 }
 if (keyCode==LEFT) {
 vx=0;
 }
 if (keyCode==RIGHT) {
 vx=0;
 }
 }
 }
 */
