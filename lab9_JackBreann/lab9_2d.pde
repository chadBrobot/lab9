//enter in the start and finish coordinates
int xStart = 5;
int yStart = 1;
int xFin = 8;
int yFin = 9;

//numbers to represent the block types
int wall = -1;
int end = -2;
int start = -3;
int visited = -5;

int count;
int row = 10;
int col = 10;
int w = 75; //square width
int l = 75; //square height


//2-D array to represent the the walls and the grid
int[][] grid = new int[row][col];
int [][] walls = {{3, 8}, 
                  {3, 7}, 
                  {3, 6},
                  {3, 5},
                  {3, 5}
                 };
                
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
  grid[xStart][yStart] = start;
  grid[xFin][yFin] = end;
}

void drawGrid(){
  //draw the grid based on the value at the array
  for(int i = 0; i< row; i++){
      for(int j= 0; j< col; j++){
        if(grid[i][j] == start){
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

//have the robot occupy the next square it would go to
void moveRobot(int x, int y, PImage img){
  stroke(255);
  fill(0,0,255,255);
  img.resize(75,75);
  image(img, x*w,y*l);
}

//perform grass fire algorithm
void wave(){
  count = 1;
  while (count <30){ //unknown how lomg to run for, 30 should be more than enough
  for(int i = 0; i < row; i++){ //i is row
    for(int j = 0; j < col; j++){ //j is col
      if (grid[i][j] == end && count ==1){       
        try{grid[i+1][j] =count;}
        catch (Exception e){
          ;
          }
        try{ grid[i-1][j] =count;}
        catch (Exception e){
          ;
          }
        try{ grid[i][j+1] =count;}
        catch (Exception e){
          ;
          }
        try {grid[i][j-1] =count;}
        catch (Exception e){
          ;
          }
      }
      
      if(grid[i][j] == count-1 && count>1){ 
        textSize(24);
        fill(255);
        text(grid[i][j], i*w, j*l+l);
        try{
        if(grid[i+1][j] == 0 && i+1 <10) grid[i+1][j] =count;
        }
        catch (Exception e){
          ;
          }
        try{ 
        if(grid[i-1][j] == 0 && i-1 >=0)grid[i-1][j] =count;
        }
        catch (Exception e){
          ;
          }
        try{
        if(grid[i][j+1] == 0 && j+1 <10)grid[i][j+1] =count;
        }
        catch (Exception e){
          ;
          }
        try {
        if(grid[i][j-1] == 0 && j-1 >=0)grid[i][j-1] =count;
        }
        catch (Exception e){
          ;
          }
      }   
    }
  }
  count++;    
  }
}  

void setup() {
  size(750,750);
  background(0);
  loadGrid();
  drawGrid();
  PImage img; //ADVENTURE CHADDDDD
  img = loadImage("chad1.jpg");
  img.resize(75,75);
  moveRobot(xStart, yStart, img);
  wave();
} 

void draw(){

}
