import java.util.ArrayList; 
import java.util.Iterator;

ArrayList<Square> matrix = new ArrayList( );
float x = 0;
float y = 0;
float w = 100;
float l = 100;

//please enter the start and end spots manually
float startX = 400;
float startY = 100;
float endX = 800;
float endY = 900;

int startIndex = convertIndex(startY, startX);
int endIndex = convertIndex(endY, endX);
 

//please enter in the walls manually
float[][] walls = { {600, 800}, 
                    {600, 700}, 
                    {600, 600},
                    {600, 500},
                    {500, 500}
                  };

//convert the coordinates given to indexes in the array list matrix
int convertIndex(float y, float x){
  int y1 = (int)y/100;
  int x1 = (int)x/100;  
  String temp = y1+""+x1;
  return Integer.parseInt(temp);
}

//prints out the contents of the matrix so you can see coordinates and booleans
void printList(){
  for(Square square : matrix){
    System.out.println(square);
  }
}

void moveRobot(float x, float y, PImage img){
  stroke(255);
  fill(0,0,255,255);
  img.resize(75,75);
  image(img, x+12,y+12);

}



//prints out the start, finish, and the wall squares.
void printSpecSquares(){ 
  Square startSquare = new Square(startX, startY, true, false, false);
  matrix.set(startIndex, startSquare);
  Square endSquare = new Square(endX, endY, false, true, false);
  matrix.set(endIndex, endSquare);
  fill(0,255,0,255);
  rect(startX, startY, w, l);
  fill(255,0,0,255);
  rect(endX, endY, w, l);
  
  for(int i = 0; i < walls.length; i++){
     Square wall = new Square(walls[i][0], walls[i][1], false, false, true);
     int index = convertIndex(walls[i][1], walls[i][0]);
     matrix.set(index, wall); 
     fill(255,255,0,255);
     rect(walls[i][0], walls[i][1],w,l);
  }
}

void setup(){
  size(1000,1000);
  background(0);
  drawGrid();
  printSpecSquares();
  PImage img;
  img = loadImage("chad1.jpg");
  moveRobot(startX, startY, img);
}

//draws the grid and loads the matrix with the square values
void drawGrid(){
  boolean wall = false;
  boolean start = false;
  boolean end = false;
  for(int i = 0; i < 100; i++){
    fill(0);
    stroke(255);
    rect(x,y,w,l);
    if(x % 100 ==0){
      Square temp = new Square(x,y,start, end, wall);
      matrix.add(temp);
      x+=100;      
    }
    if((x > 900)){
      x = 0;
      y+=100;
    }
  } 
}


//Square class holds the information for each square on the screen to 
//identify the coordinates and what type of square it is
class Square { 
  float x,y;
  int size = 10;
  boolean wall, start, end;
  Square (float x, float y, boolean start, boolean end, boolean wall) {  
    this.x = x; 
    this.y = y;
    this.start = start;
    this.end = end;
    this.wall = wall;  
  } 
  
@Override
public String toString() {
  return "X: " + x + ", Y: " + y + " End: " + end +  " Start: " + start + " Wall: " + wall;
  }
}

void draw(){
  printList();
  while(true){}
  
}
