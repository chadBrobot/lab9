/*
CS3120 Experimental Robotics
April 4 2020
Authors: Breann Thiessen and Jack Casey-Campbell

Summary: 
This program performs a simulations of grassfire algorithm and then the robot proceeds
to perform the greedy algorithm to find the best way to the target.
The target square is a red block, 
The walls are represented by blue blocks, and
The start square has a picture of "Adventurous Chad".

The global variables can me manipulated in the code to change the locations of the walls and
of the start and end square. After the program is started there is a 5 second delay so that the
use can see the result of the grassfire algorithm, after that multiple chads are printed to show
the best path and chad will finally land on the destination square. GOOD JOB CHAD!
Note: the console will have two outputs, the array before the path is found and the array after 
the path is found, this allows the user to see that the path is indeed generated by the greedy 
algorithm. 
*/

//enter in the start and finish coordinates
int xStart = 1;
int yStart = 0;
int xFin = 4;
int yFin = 7;

//numbers to represent the block types
int wall = -1;
int end = -2;
int visited = -5;

int count = 1;
int row = 10;
int col = 10;
int w = 75; //square width
int l = 75; //square height

//2-D array to represent the the walls and the grid
int[][] grid = new int[row][col];
int[][] walls = { {4, 6}, 
                  {5, 6}, 
                  {5, 7},
                  {6, 2},
                  {3, 5}
                 };                               

//loads the grid with the appropriate numbers
void loadGrid(){
  //load with 0's
  for(int i = 0; i < row; i++){
     for(int j = 0; j < col; j++){
       grid[i][j] = 0;
     }
   }
  //load walls
  for(int i = 0; i < walls.length; i++){
       int x = walls[i][0];
       int y = walls[i][1];
       grid[x][y] = wall;     
  }
  //add start and finish
  grid[xStart][yStart] = visited;
  grid[xFin][yFin] = end;
}

void drawGrid(){
  //draw the grid based on the value at the array
  for(int i = 0; i< row; i++){
      for(int j= 0; j< col; j++){
        if(grid[i][j] == visited){
          fill(106, 168, 79, 255);
        }
        else if(grid[i][j] == end){
          fill(204, 0 , 0, 255);
        }
        else if (grid[i][j] == wall){
          fill(61, 133, 198,255);          
        }
        else{
          fill(0);
        } 
        stroke(255);
        rect(i*w,j*l,w,l);
    }
  }
}

//prints the grid on the console
void printGrid(String title){
  System.out.println("~~~~~~~~" + title + "~~~~~~~");      
      for(int i = 0; i< 10; i++){
      for(int j= 0; j<10; j++){
      if(grid[i][j] >=10) System.out.print(grid[i][j] +"    ");
      else if (grid[i][j] <0) System.out.print(grid[i][j] +"    ");
      else  System.out.print(grid[i][j] +"     ");
    }
    System.out.println();
  }
}


//have the robot occupy the next square it would go to
void moveRobot(int x, int y, int transX, int transY, PImage img){
  img.resize(75,75);
  translate(transX, transY);
  stroke(255);
  fill(0,0,255,255);
  img.resize(75,75);
  image(img, x*w,y*l);
}

//perform grass fire algorithm
void wave(){

  while (count <30){ //unknown how lomg to run for, 30 should be more than enough
  for(int i = 0; i < row; i++){ //i is row
    for(int j = 0; j < col; j++){ //j is col
      if (grid[i][j] == end && count ==1){       
        try{ 
          if(grid[i+1][j] !=wall){
            grid[i+1][j] =count;}
        }
        catch (Exception e){}
        
      try{ 
        if(grid[i-1][j] != wall){
          grid[i-1][j] =count;
        }
      }
      catch (Exception e){}
      
      try{ 
        if(grid[i][j+1] != wall){
          grid[i][j+1] =count;
        }
      }
      catch (Exception e){}
      
      try {
        if (grid[i][j-1] != wall){
        grid[i][j-1] =count;
        }    
      }
      catch (Exception e){}
      }
      
      if(grid[i][j] == count-1 && count>1){ 
        if (!(grid[i][j] < 0)){
        textSize(24);
        fill(255);
        text(grid[i][j], i*w, j*l+l);
        }
        try{
        if(grid[i+1][j] == 0 && i+1 <10) grid[i+1][j] =count;
        }
        catch (Exception e){}
        try{ 
        if(grid[i-1][j] == 0 && i-1 >=0)grid[i-1][j] =count;
        }
        catch (Exception e){}
        try{
        if(grid[i][j+1] == 0 && j+1 <10)grid[i][j+1] =count;
        }
        catch (Exception e){}
        try {
        if(grid[i][j-1] == 0 && j-1 >=0)grid[i][j-1] =count;
        }
        catch (Exception e){}
      }   
    }
  }
  count++;    
  }
  printGrid("Grass Fire");
}  

//set up code to show graphical output
void setup() {
  PImage img; //ADVENTURE CHADDDDD
  img = loadImage("chad1.jpg");
  size(750,750);
  background(0);
  loadGrid();
  drawGrid();
  moveRobot(xStart, yStart, 0, 0, img);
  wave();
} 

//performs the greedy algorithm and calls the move robot function to move chad around
void draw(){
PImage img; //ADVENTURE CHADDDDD
img = loadImage("chad1.jpg");
int lowest = count;
int xtemp = xStart, ytemp = yStart;
boolean found = false;
String direct = "N"; //given direction is north, please check your startin direction
delay(5000);
while( !found ){
    
  if(direct == "N"){ //check for a place to move to, priority to north
     try{ if (grid[xStart+1][yStart] < lowest && grid[xStart+1][yStart] >0){
        lowest = grid[xStart+1][yStart];
        xtemp = xStart+1;
        ytemp = yStart;
         direct = "N";
      }}
     catch (Exception e){ }
     try{ if (grid[xStart][yStart+1] < lowest && grid[xStart][yStart+1] >0){
        lowest = grid[xStart][yStart+1];
        xtemp = xStart;
        ytemp = yStart+1;
         direct = "E";
      }}
      catch (Exception e){}
     try{  if (grid[xStart-1][yStart] < lowest && grid[xStart-1][yStart] >0){
        lowest = grid[xStart-1][yStart];
        xtemp = xStart-1;
        ytemp = yStart;
         direct = "S";
      }}
      catch (Exception e){}
     try{ if (grid[xStart][yStart-1] < lowest && grid[xStart][yStart-1] >0){
        lowest = grid[xStart][yStart-1];
        xtemp = xStart;
        ytemp = yStart-1;
        direct = "W";
      }}
      catch (Exception e){}
      //SET THE LOCATION AND PUT -5
      xStart = xtemp;
      yStart = ytemp;
      grid[xStart][yStart] = -5;     
      moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
  }
  else if(direct == "E"){
      try { if (grid[xStart][yStart+1] < lowest && grid[xStart][yStart+1] >0){
        lowest = grid[xStart][yStart+1];
        xtemp = xStart;
        ytemp = yStart+1;
        direct = "E";
      }}
      catch (Exception e){}
       try { if (grid[xStart-1][yStart] < lowest && grid[xStart-1][yStart] >0){
        lowest = grid[xStart-1][yStart];
        xtemp = xStart-1;
        ytemp = yStart;
        direct = "S";
      }}
      catch (Exception e){}
     try { if (grid[xStart][yStart-1] < lowest && grid[xStart][yStart-1] >0){
        lowest = grid[xStart][yStart-1];
        xtemp = xStart;
        ytemp = yStart-1;
        direct = "W";
      }}
      catch (Exception e){}
      try{ if (grid[xStart+1][yStart] < lowest && grid[xStart+1][yStart] >0){
        lowest = grid[xStart+1][yStart];
        xtemp = xStart+1;
        ytemp = yStart;
        direct = "N";
      }}
      catch (Exception e){}
      //SET THE LOCATION AND PUT -5
      xStart = xtemp;
      yStart = ytemp;
      grid[xStart][yStart] = -5;        
      moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
  }
  
 else if(direct == "S"){
    try{ if (grid[xStart-1][yStart] < lowest && grid[xStart-1][yStart] >0){
      lowest = grid[xStart-1][yStart];
      xtemp = xStart-1;
      ytemp = yStart;
      direct = "S";
    }}
    catch (Exception e){}
    try{ if (grid[xStart][yStart-1] < lowest && grid[xStart][yStart-1] >0){
      lowest = grid[xStart][yStart-1];
      xtemp = xStart;
      ytemp = yStart-1;
      direct = "W";
    }}
    catch (Exception e){}
    try{ if (grid[xStart+1][yStart] < lowest && grid[xStart+1][yStart] >0){
      lowest = grid[xStart+1][yStart];
      xtemp = xStart+1;
      ytemp = yStart;
      direct = "N";
    }}
    catch (Exception e){}
    try{ if (grid[xStart][yStart+1] < lowest && grid[xStart][yStart+1] >0){
      lowest = grid[xStart][yStart+1];
      xtemp = xStart;
      ytemp = yStart+1;
      direct = "E";
    }}
    catch (Exception e){}
    //SET THE LOCATION AND PUT -5
    xStart = xtemp;
    yStart = ytemp;
    grid[xStart][yStart] = -5;     
    moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
  }
   
  else if(direct == "W"){    
    try{ if (grid[xStart][yStart-1] < lowest && grid[xStart][yStart-1] >0){
      lowest = grid[xStart][yStart-1];
      xtemp = xStart;
      ytemp = yStart-1;
      direct = "W";
    }}
    catch (Exception e){}
   try{  if (grid[xStart+1][yStart] < lowest && grid[xStart+1][yStart] >0){
      lowest = grid[xStart+1][yStart];
      xtemp = xStart+1;
      ytemp = yStart;
      direct = "N";
    }}
    catch (Exception e){}
    try {if (grid[xStart][yStart+1] < lowest && grid[xStart][yStart+1] >0){
      lowest = grid[xStart][yStart+1];
      xtemp = xStart;
      ytemp = yStart+1;
      direct = "E";
    }}
    catch (Exception e){}
   try{ if (grid[xStart-1][yStart] < lowest && grid[xStart-1][yStart] >0){
      lowest = grid[xStart-1][yStart];
      xtemp = xStart-1;
      ytemp = yStart;
      direct = "S";
    }}
    catch (Exception e){}
    //SET THE LOCATION AND PUT -5
    xStart = xtemp;
    yStart = ytemp;
    grid[xStart][yStart] = -5;      
    moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
  }
  
        //check if goal is near by   
    try{
        if(grid[xStart+1][yStart] == -2){
        found =true; 
        //SET THE LOCATION AND PUT -5
        grid[xStart][yStart] = -5;        
        moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
        grid[xStart+1][yStart] = -5;        
        moveRobot(xStart+1, yStart, xStart-xtemp, yStart-ytemp, img);
      }
      }
        catch (Exception e){}
        try{ 
        if(grid[xStart-1][yStart] == -2){
          found =true;
          //SET THE LOCATION AND PUT -5
          grid[xStart][yStart] = -5;          
          moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
          grid[xStart-1][yStart] = -5;          
          moveRobot(xStart-1, yStart+1, xStart-xtemp, yStart-ytemp, img);
          
        }
      }
        catch (Exception e){}
        try{ 
          if(grid[xStart][yStart+1] == -2){
            found =true;
            //SET THE LOCATION AND PUT -5
            grid[xStart][yStart] = -5;            
            moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
            grid[xStart][yStart+1] = -5;           
            moveRobot(xStart, yStart-1, xStart-xtemp, yStart-ytemp, img);
           }
        }
        catch (Exception e){}
        try {
         if(grid[xStart][yStart-1] == -2) {
          found =true;
          //SET THE LOCATION AND PUT -5
          grid[xStart][yStart] = -5;          
          moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
          grid[xStart][yStart-1] = -5;          
          moveRobot(xStart, yStart, xStart-xtemp, yStart-ytemp, img);
          }
        }
        catch (Exception e){ }
  }
  System.out.println();
  printGrid("Greedy");
}
