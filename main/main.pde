import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;
import processing.serial.*;
import cc.arduino.*;

//draws menu if true
boolean menu;
//draws "mapMenu"
boolean mapMenu;
//draws level complete screen
boolean mapComplete;
//offset of the ball
int offSet;
//velocity of the ball
int vx;
int vy;
//for reading the .txt file
String lines[];
//size of the map in terms of tiles
int mapsize;
int mapnum;
//list of all the characters from the .txt file
ArrayList<Character> tiles = new ArrayList<Character>();
ArrayList<String> mapbg = new ArrayList<String>();
//position of the ball (x,y) used for collision detection
Ball ball;
Map map;
Arduino arduino;
boolean use_board = false;
PImage bg1, bg2, bg3, ground;
AudioPlayer player;
Minim minim;//audio context
int screenWidth;
int mapOffsetX;
int mapOffsetY;
int previousGoalX;
int previousGoalY;
float timeStart;
float timeStop;

void setup() {
  screenWidth=displayHeight;
  print(displayHeight, displayWidth);
  size(displayHeight, displayWidth, P3D);
  //arduino = new Arduino(this, Arduino.list()[5], 57600);
  bg1 = loadImage("../backgrounds/wooden-bg.jpg");
  bg2  = loadImage("../backgrounds/white-bg.jpg");
  bg2.resize(600, 600);
  bg3 = loadImage("../backgrounds/bigger.jpg");
  bg3.resize(700, 700);
  ground = loadImage("../backgrounds/ground.jpg");
  ground.resize(displayHeight, displayWidth);
  menu=true;
  menuSetup();
  mapMenu=false;
  mapMenuSetup();
  mapComplete=false;
  levelCompleteSetup();
  ellipseMode(CENTER);
  mapbg.add("../maps/map1.txt");
  mapbg.add("../maps/map2.txt");
  mapbg.add("../maps/map3.txt");
  map = new Map();
  readMap();
  //inits ball properties
  ball = new Ball(0, 0); //where the ball starts
  offSet=20;
  vx=0;
  vy=0;
  minim = new Minim(this);
  player = minim.loadFile("../music/Happy.mp3");
  player.play();
}

void readMap() {
  int index = 2;
  tiles = new ArrayList<Character>();
  lines = loadStrings(mapbg.get(mapnum));
  mapsize = Integer.parseInt(lines[0]); //size of map defined in the .txt document
  while (index < lines.length-1) {
    //removes the "borders" from the map
    String temp= lines[index].substring(1);
    temp=temp.substring(0, temp.length()-1);
    for (char c : temp.toCharArray ()) {
      tiles.add(c);
    }
    index = index + 1;
  }
}
//for testing
/*
  for(int i=0; i<=5;i++){
 stroke(0);
 line(tilesize*i,0,tilesize*i,screenWidth);
 line(0, tilesize*i, screenWidth,tilesize*i);
 }*/

void draw() {
  background(ground);
  if (menu) {
    menuDraw();
  }//Draws menu
  else if (mapMenu) { //"mapmenu"
    mapMenuDraw();
  }
 else if (mapComplete) { //level completed
  levelCompleteDraw();
 } else {
    if (mapnum == 0) {
      mapOffsetX=screenWidth/2-bg1.width/2;
      mapOffsetY=screenWidth/2-bg1.width/2;
      image(bg1, mapOffsetX, mapOffsetY);
    } else if (mapnum == 1) {
      mapOffsetX=screenWidth/2-bg2.width/2;
      mapOffsetY=screenWidth/2-bg2.width/2;
      image(bg2, mapOffsetX, mapOffsetY);
    } else {
      mapOffsetX=screenWidth/2-bg3.width/2;
      mapOffsetY=screenWidth/2-bg3.width/2;
      image(bg3, mapOffsetX, mapOffsetY);
    }
    map.drawMap();
    ball.update();
    checkMapCompleted();
    ball.drawBall();
  }
  //println(ball.x, ball.y, map.goalx, map.goaly);
}


boolean checkMapCompleted() {
  boolean ret=false;
  if (ball.x == map.goalx && ball.y == map.goaly) {
    stopTime();
    mapnum +=1;
    ret=true;
    println(map.goalx, map.goaly);
    if (mapnum < mapbg.size()) {
      mapComplete=true;
      readMap();
    } else { 
      mapComplete=true;
      //menu=true;
      //mapnum=0;
      //readMap();
      ball= new Ball(0, 0);
    }
    ball.x=0;
    ball.y=0;
  }
  return ret;
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
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

void startTime(){
  timeStart = millis();
}
void stopTime() {
  timeStop = millis();
}
float getTime() {
  float t = round((timeStop - timeStart)/10);
  return t/100;
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
