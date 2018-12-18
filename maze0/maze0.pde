Player player;
PVector food;
Wall[] walls;
Enemy[] enemyArray1,enemyArray2,enemyArray3,enemyArray4,enemyArray5;
int scl=30, recordScore=0;
PImage gold,gold1;
//String[] highScore={"null"};


void setup() {
  size(1200, 750);
  frameRate(20);
  player = new Player(1,1);
  
  enemyArray1=new Enemy[3];
  enemyArray1[0]=new Enemy(2,4);
  enemyArray1[1]=new Enemy(4,8);
  enemyArray1[2]=new Enemy(6,12);
  
  enemyArray2=new Enemy[4];
  enemyArray2[0]=new Enemy(0,17);
  enemyArray2[1]=new Enemy(4,20);
  enemyArray2[2]=new Enemy(8,18);
  enemyArray2[3]=new Enemy(12,20);
  
  enemyArray3=new Enemy[7];
  enemyArray3[0]=new Enemy(26,2);
  enemyArray3[1]=new Enemy(28,18);
  enemyArray3[2]=new Enemy(30,4);
  enemyArray3[3]=new Enemy(32,16);
  enemyArray3[4]=new Enemy(34,6);
  enemyArray3[5]=new Enemy(36,14);
  enemyArray3[6]=new Enemy(38,8); 
  
  enemyArray4=new Enemy[3];
  enemyArray4[0]=new Enemy(9,0);
  enemyArray4[1]=new Enemy(12,8);
  enemyArray4[2]=new Enemy(15,16);
  
  enemyArray5=new Enemy[3];
  enemyArray5[0]=new Enemy(18,0);
  enemyArray5[1]=new Enemy(20,8);
  enemyArray5[2]=new Enemy(22,16);
  
  walls = new Wall[3];
  walls[0] = new Wall(8,0,1,17);
  walls[1] = new Wall(16,8,1,17);
  walls[2] = new Wall(24,5,1,24);
  
  pickLocation();


}

 

void draw() {
  background(0);
  noStroke();

  
  while(inWall(walls,food)){
     pickLocation();
  }
  
  if (player.eat(food)) {
    pickLocation();
    System.out.println("Speed up!");
    changeArraySpeed(enemyArray1,1.1);
    changeArraySpeed(enemyArray2,1.1);
    changeArraySpeed(enemyArray3,1.1);
    changeArraySpeed(enemyArray4,1.1);
    changeArraySpeed(enemyArray5,1.1);
  }
  
  player.beAttacked(enemyArray1);
  player.beAttacked(enemyArray2);
  player.beAttacked(enemyArray3);
  player.beAttacked(enemyArray4);
  player.beAttacked(enemyArray5);
   
  
  player.display();
  player.move(walls);
  
   gold1 = loadImage("gold.png");
   image(gold1,food.x, food.y, scl, scl);
   
  for(int i = 0; i < enemyArray1.length; i++){ //display and move the enemy
  fill(12,240,210);
    enemyArray1[i].display();
     enemyArray1[i].move1();
  }
  
  for(int i = 0; i < enemyArray2.length; i++){ //display and move the enemy
  fill(255, 0, 100);
    enemyArray2[i].display();
     enemyArray2[i].move2();
  }
  
   for(int i = 0; i < enemyArray3.length; i++){ //display and move the enemy
  fill(150,76,240);
    enemyArray3[i].display();
     enemyArray3[i].move3();
  }
  
    
   for(int i = 0; i < enemyArray4.length; i++){ //display and move the enemy
  fill(20,133,204);
    enemyArray4[i].display();
     enemyArray4[i].move4();
  }
  
   for(int i = 0; i < enemyArray5.length; i++){ //display and move the enemy
  fill(0,255,82);
  enemyArray5[i].display();//   display();
  enemyArray5[i].move5();
  }


  for(int i = 0; i < walls.length; i++){ //display walls
    walls[i].display();
  }

 
   drawStatus();
   
   if(player.hp<=0){
   gameOver();}
   

}

 void pickLocation() {
  int cols = width/scl;
  int rows = height/scl;
  food = new PVector(floor(random(cols)), floor(random(rows-1)));
  food.mult(scl);
  //for(int i = 0; i < walls.length; i++){}
  
}

   boolean inWall(Wall[] walls,PVector pos){
     boolean didCollide = false;
    for(int i = 0; i < walls.length; i++){
      if(((pos.x+scl) > walls[i].x) 
      && ((pos.x) < (walls[i].x + walls[i].w))
      && ((pos.y+scl )> walls[i].y )
      && ((pos.y) < walls[i].y + walls[i].h ))
     {
        didCollide = true;
        //System.out.println("it collides!");
      }
  }
     return didCollide;
   }
   
   void resetAll(Enemy[] enemyArray1,Enemy[] enemyArray2,Enemy[] enemyArray3,Enemy[] enemyArray4,Enemy[] enemyArray5){
     player=new Player(1,1);
     resetArraySpeed(enemyArray1);
     resetArraySpeed(enemyArray2);
     resetArraySpeed(enemyArray3);
     resetArraySpeed(enemyArray4);
     resetArraySpeed(enemyArray5);
   }
   
void resetArraySpeed(Enemy[] enemyArray){
    for(int i=0;i<enemyArray.length;i++){
    enemyArray[i].speed=5;
    enemyArray[i].xspeed=5;
    enemyArray[i].yspeed=5;
    enemyArray[i].grav=1;}
}

void changeArraySpeed(Enemy[] enemyArray,float n){
    for(int i=0;i<enemyArray.length;i++){
    enemyArray[i].speed*=n;
    enemyArray[i].xspeed*=n;
    enemyArray[i].yspeed*=n;}
}

//stop all
void stopAll(Enemy[] enemyArray1,Enemy[] enemyArray2,Enemy[] enemyArray3,Enemy[] enemyArray4,Enemy[] enemyArray5){
player.speed=0; 
stopArray(enemyArray1);
stopArray(enemyArray2);
stopArray(enemyArray3);
stopArray(enemyArray4);
stopArray(enemyArray5);
}

void stopArray(Enemy[] enemyArray){
    for(int i=0;i<enemyArray.length;i++){
    enemyArray[i].speed=0;
    enemyArray[i].xspeed=0;
    enemyArray[i].yspeed=0;
    enemyArray[i].grav=0;
    }
}

//void startAll(Enemy[] enemyArray1,Enemy[] enemyArray2,Enemy[] enemyArray3,Enemy[] enemyArray4,Enemy[] enemyArray5){
//player.speed=20;
//stopArray(enemyArray1);
//stopArray(enemyArray2);
//stopArray(enemyArray3);
//stopArray(enemyArray4);
//stopArray(enemyArray5);
//}

void reloadScore(){ 
   //System.out.println("The score in txt file is: "+this.highScore[0]);
  if(player.gold>this.recordScore){
    this.recordScore=player.gold;
    String[] highScore={"0"};
    highScore[0]=str(recordScore);
    saveStrings("highestScore.txt",highScore);
    //System.out.println("New high score: "+this.highScore[0]);
    }
  }

void gameOver(){
  //System.out.println("Game Over!");
  stopAll(enemyArray1,enemyArray2,enemyArray3,enemyArray4,enemyArray5);
 
  reloadScore();
  pushMatrix();
  translate(scl*5,scl*4);
  
  fill(255,255,255,200);
  noStroke();
  rect(0,0,scl*30,scl*15);   //rect at center
  
  textSize(scl*2);
  fill(255,215,0);
  text("Game over!",scl*9,scl*2);
  fill(255,7,184);
  text("Your score :"+player.gold,scl*8,scl*5);
  
  fill(255,7,184);
  text("Highest score :"+this.recordScore,scl*7,scl*8);
  System.out.println("New high score: "+this.recordScore);
  fill(18,177,178);
  text("Click to play again!",scl*6,scl*11);
  
  
    
  popMatrix();
  

  
  
  if(mousePressed){
    resetAll(enemyArray1,enemyArray2,enemyArray3,enemyArray4,enemyArray5);
  }
}

class Wall {

  float x;
  float y;
  float w;
  float h;

  Wall(float _x, float _y, float _w, float _h){
    x = _x*scl;
    y = _y*scl;
    w = _w*scl;
    h = _h*scl;
  }

  void display(){
    fill(255);
    rect(x,y,w,h);
  }
}


void drawStatus(){
  fill(255);
  stroke(0);
  textSize(scl);
  textAlign(LEFT, CENTER);
  pushMatrix();
  translate(0,height-scl);
  rect(0, 0, width, scl);

   fill(0);
   text("HP " + player.hp, scl, scl*0.4);
   //text("Lv." + player.lv + "   EXP " + player.exp, scl * 15, scl * 0.6f);


   gold = loadImage("gold-1.png");
   image(gold,  width-10*scl, 0, scl*0.9,scl*0.9);
   text("   GOLD " + player.gold, scl * 30, scl*0.4);
   // player.drawHp(scl * 4.5f, scl * 0.45f, scl * 9, scl / 2);
   
        
   //draw HP bar
   noFill(); 
   stroke(0);
   strokeWeight(2);
   rect(scl*4,scl*0.15,10*scl,scl*0.7);
  
   if(player.hp>0){
   fill(0);
   noStroke();
   rect(scl*4,scl*0.15,player.hp*scl,scl*0.7);}
   
   popMatrix();
   

}

//-------------------------------------Player
PImage img=new PImage(); 
class Player {
  float x = 0;
  float y = 0;
  int gold=0,hp=10;
  int speed=20;
  /*int lv, hp, maxHp, atk, def, exp, gold,floor;
    int[] expToNextLevel={10,20,30,50,80,130,210};*/

Player(){}

  public Player(int x, int y){
     this.x=scl*x;
     this.y=scl*y;
     this.gold=0;
     this.hp=10;
  }

  public void display(){
    img = loadImage("hero.png");
   image(img, x, y, scl*1.2,scl*1.2);
  }
  
  public void hpUp(){
  if(player.hp<10){this.hp+=1;}}
  
  public void hpDown(){
  if(player.hp>0){this.hp-=1;}}
  
  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < scl*0.9) {
      this.gold++;
      hpUp();
      System.out.println("you eat a food!");
      return true;
    } else {
      return false;
    }
  }
  
  boolean beAttacked(Enemy[] enemyArray) {
    boolean bAttack=false;
     for(int i = 0; i < enemyArray.length; i++){
    float d = dist(x, y, enemyArray[i].x, enemyArray[i].y);
    if (d < scl) {
      hpDown();
      //System.out.println("You are attacked!");
       bAttack= true;
    } else {
       bAttack=false;
    }
  }
  return bAttack;
  }

  public void move(Wall[] walls){

   float possibleX=x;
    float possibleY=y;

    if (keyPressed==true) {

      println(key);

      if (keyCode == LEFT) {
        possibleX-= speed;
      }
      if (keyCode == RIGHT) {
        possibleX += speed;
      }
      if (keyCode == UP) {
        possibleY -= speed;
      }
      if (keyCode == DOWN) {
       possibleY += speed;
      }
    }


    possibleX = constrain(possibleX, 0, width - scl);
    possibleY = constrain(possibleY, 0, height - scl*2);
    /*if((possibleLocation.x-r) < 0 || (possibleLocation.x+r) > width // keep in the screen
      || (possibleLocation.y-r) < 0 || (possibleLocation.y+r) > height-ChipSize * 1.5f){
        didCollide = true;
    }*/
    
     boolean didCollide = false;

    for(int i = 0; i < walls.length; i++){
      if(((possibleX+scl) > walls[i].x) 
      && ((possibleX) < (walls[i].x + walls[i].w))
      && ((possibleY+scl )> walls[i].y )
      && ((possibleY) < walls[i].y + walls[i].h ))
     {
        didCollide = true;
        //System.out.println("it collides!");

      }
    }

    if(didCollide == false){
    x=possibleX;
    y=possibleY;
    }

  }

}

//===============================Enemy Class

class Enemy extends Player{
  int speed=5;
  float xspeed=speed, yspeed=speed,grav=1;
  
  Enemy(){}
  
   Enemy(int x, int y)
  { super(x,y);}
  
  //void changeSpeed(){
  //  speed+=1;
  //}
  
  void display(){
    rect(x,y,scl,scl); }
  
  void move1()
  {  x+=speed;
    if((x>scl*7)||(x<0))
    {
      speed=-speed;
    }
  }
  
  void move2()
  { x+=xspeed/1.4;
    y+=yspeed/1.4;
    if((y>height-scl*2)||(y<scl*17))
    {
     yspeed=-yspeed;
      //System.out.println("you go outside the canvas!");
    }
    if((x<0)||(x>scl*16)){
    xspeed=-xspeed;}
  }

  
   void move3()
  { yspeed+=grav;
    y+=yspeed*0.7;
    //System.out.println(y);
    if((y>height-scl*1.5))
    {
     y=0;
     yspeed=speed;
    }}
    
     void move4()
  { x+=speed; 
    y+=speed;
    if((x<scl*9)||(x>scl*15))
    {
      speed=-speed;
    }
  }
  
  void move5()
  {  y+=speed*2;
    if((y<0)||(y>height-2*scl))
    {
      speed=-speed;
    }
  }
  }
