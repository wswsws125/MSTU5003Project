

Player player;
wall[] walls;
int speed=10;
float r=10.5;
final int ChipSize = 32;
PImage gold;

void setup() {

  size(1200, 750);
  textSize(ChipSize);
  textAlign(LEFT, CENTER);

  player = new Player(50,300);

  walls = new wall[3];
  walls[0] = new wall(250,0,40,500);
  walls[1] = new wall(500,250,40,500);
  walls[2] = new wall(700,150,40,700);

}
void draw() {

  background(255, 255, 255);
  noStroke();

  player.draw();
  player.move(walls);

  for(int i = 0; i < walls.length; i++){
    walls[i].draw();


  }
   drawStatus();

}


class Player {

  float x;
  float y;
  int lv, hp, maxHp, atk, def, exp, gold,floor;
    int[] expToNextLevel={10,20,30,50,80,130,210};

  Player(float _x, float _y){
    x = _x;
    y = _y;

        lv=1;hp=10;atk=130;def=130;exp=0;gold=0;
        x=400;y=50;floor=0;
  }

  void draw(){
    fill(128);
    ellipse(x,y,25,25);

  }

  void move(wall[] walls){

    float possibleX = x;
    float possibleY = y;

    if (keyPressed==true) {

      println(key);

      if (keyCode == LEFT) {
        possibleX= possibleX - speed;
      }
      if (keyCode == RIGHT) {
        possibleX = possibleX + speed;
      }
      if (keyCode == UP) {
        possibleY = possibleY - speed;
      }
      if (keyCode == DOWN) {
        possibleY = possibleY + speed;
      }
    }

    boolean didCollide = false;

    if((possibleX-r) < 0 || (possibleX+r) > width // keep in the screen
      || (possibleY-r) < 0 || (possibleY+r) > height-ChipSize * 1.5f){
        didCollide = true;
    }

    for(int i = 0; i < walls.length; i++){
      if((possibleX+r) > walls[i].x && (possibleX-r) < (walls[i].x + walls[i].w)
      && (possibleY+r )> walls[i].y && (possibleY-r) < walls[i].y + walls[i].h )
     {
        didCollide = true;
      }
    }

    if(didCollide == false){
      x = possibleX;
      y = possibleY;
    }

  }

}

class wall {

  float x;
  float y;
  float w;
  float h;

  wall(float _x, float _y, float _w, float _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }

  void draw(){
    fill(0);
    rect(x,y,w,h);
  }

}

void drawStatus(){
  fill(0);
  stroke(0);
  translate(0,height-ChipSize * 1.5f);
  rect(0, 0, width, ChipSize * 1.5f);




   fill(255);
   text("HP " + player.hp, ChipSize, ChipSize * 0.6f);
   text("Lv." + player.lv + "   EXP " + player.exp, ChipSize * 15, ChipSize * 0.6f);


   gold = loadImage("gold-1.png");
   image(gold,  ChipSize * 25-12, 4, ChipSize * 1.2f,ChipSize * 1.2f);
   text("   GOLD " + player.gold, ChipSize * 25, ChipSize * 0.6f);
   // player.drawHp(ChipSize * 4.5f, ChipSize * 0.45f, ChipSize * 9, ChipSize / 2);

}

void drawHp(float x, float y, float w, float h) {
    fill(255, 0, 0); rect(x, y, w, h);
    fill(255, 255, 0); rect(x, y, player.hp / (float)player.maxHp * w, h);
  }
