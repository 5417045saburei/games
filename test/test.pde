class player{
  int px, py;
  int hp;
  
  void display() {
    px = mouseX;
    py = mouseY;
    
    stroke(255, 0, 0);
    fill(0);
    rect(px-15, py-15, 30, 30);
    line(px, py-15, px-15, py+15);
    line(px, py-15, px+15, py+15);
    line(px, py+15, px-15, py-15);
    line(px, py+15, px+15, py-15);
  }
  
  /*
  void judge() {
    if(bullet.x > x-30 && bullet.x < x + 30 ||
       bullet.y > y-30 && bullet.y < y + 30) {
      hp--;
    }
  }
  */
  
  void hp(int hp0) {
    hp = hp0;
  }
  
}



class Items{
  int p_x;
  int p_y;
  float[] x = new float[10];
  float[] y = new float[10];
  float[] xSpeed = new float[10];
  float[] ySpeed = new float[10];
  float[] items_random = new float[10];
  int[] items = new int[10];
  int[] get = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int[] bullet_ver = {1, 0, 0};
  int score = 0;
  int power = 0;
  
  void setItem(int x0, int y0){
    p_x = x0;
    p_y = y0;
  }

  void makeItems(){
    size(600, 800);
    for(int i = 0; i < 10; i++){
      items_random[i] = (float)random(0.0, 11.0);
      if(items_random[i] < 0.3){
        items[i] = 5;
      }else if(0.3 <= items_random[i] && items_random[i] < 0.6){
        items[i] = 4;
      }else if(0.6 <= items_random[i] && items_random[i] < 0.9){
        items[i] = 3;
      }else if(0.9 <= items_random[i] && items_random[i] < 8.0){
        items[i] = 2;
      }else{
        items[i] = 1;
      }
    
      x[i] = width / 2;
      y[i] = 50.0;
      xSpeed[i] = random(-5.0, 5.0);
      ySpeed[i] = random(-5.0, -0.1);
    }
  }

  void drawItem(){
    textSize(10);
    text("score:" + score, 300, 20);
    for(int i = 0; i < 10; i++){
      if(get[i] == 0){
        if(items[i] == 1){
          fill(255, 0, 0);
        }else if(items[i] == 2){
          fill(0, 0, 255);
        }else if(items[i] == 3){
          fill(0, 255, 255);
        }else if(items[i] == 4){
          fill(255, 255, 0);
        }else{
          fill(255, 0, 255);
        }
    
        rect(x[i], y[i], 10, 10);
        x[i] += xSpeed[i];
        y[i] += ySpeed[i];
        if(xSpeed[i] < 0.0){
          xSpeed[i] += 0.1;
        }
        if(xSpeed[i] > 0.0){
          xSpeed[i] -= 0.1;
        }
        ySpeed[i] += 0.05;
      
        if((p_x <= x[i] + 20.0 && x[i] <= p_x + 40.0) && (p_y <= y[i] + 20.0 && y[i] <= p_y + 40.0)){
          if(items[i] == 3){ 
            bullet_ver[0] = 1;
            bullet_ver[1] = 0;
            bullet_ver[2] = 0;
          }else if(items[i] == 4){
            bullet_ver[0] = 0;
            bullet_ver[1] = 1;
            bullet_ver[2] = 0;
          }else if(items[i] == 5){
            bullet_ver[0] = 0;
            bullet_ver[1] = 0;
            bullet_ver[2] = 1;
          }
      
          if(items[i] == 1){
            power++;
          }
          if(items[i] == 2){
            score++;
          } 
          get[i] = 1;
        }
      }
    }
  }
}

class bullet {
  int size = 10;
  float[] ballx = new float [1000];
  float[] bally = new float [1000];
  int clickCount = 0;
  int[] dx = new int [1000];
  int[] dy = new int [1000];
  int[] c = new int [1000];
  
  void MyMachineStart() { 
    for(int i = 0; i < dx.length; i++){
      dx[i] = 0;
      dy[i] = -3;
      c[i] = 1;
    }
  }
  
  void MyMachineBullet() {  
    for(int i = 0; i < clickCount; i++){
      ellipse(ballx[i], bally[i], size, size);
      ballx[i] += dx[i];
      bally[i] += dy[i];
      if(ballx[i]-size <= 0 || ballx[i]+size >= width){
        dx[i] *= -1;
        c[i] = 0;
      }
      if(bally[i]-size <= 0 || bally[i]+size >= height){
        
        dy[i] *= -1;
        c[i] = 0;
      }
    }
  }
  
  void ClickBullet() {
    ballx[clickCount] = mouseX;
    bally[clickCount] = mouseY;
    clickCount += 1;
    println(clickCount);
  }
  
  void enemyBullet() {
    
  }
}


Items item;
player p1;
bullet b;

/*void setup() {
  size(600,800);
  p1 = new player();
  item = new Items();
  b = new bullet();
  p1.hp(20);
  item.makeItems();
  b.MyMachineStart();
}

void draw() {
  background(255);
  p1.display();
  item.setItem(p1.px, p1.py);
  //p1.judge();
  item.drawItem();
  b.MyMachineBullet();
}*/



class Enemy {
  int ballCount = 10;
  int[] zakoX = new int[ballCount];
  int[] zakoY = new int[ballCount];
  int zakoR = 30;
  int[] stepX = new int[ballCount];
  int[] stepY = new int[ballCount];
  int bossX = 200;
  int bossY = 20;
  int bossR = 160;
  int bossStepX = 4;
  int bossStepY = 1;

  
  void setEnemy() {
    for(int i = 0; i < ballCount; i++) {
      zakoX[i] = int(random(10, 380));
      zakoY[i] = int(random(15, 31));
      stepX[i] = int(random(1, 6));
      stepY[i] = int(random(1, 4));
    }
  }
    
  void easyEnemy() {
    for(int i = 0; i < zakoX.length; i++) {
      if(zakoX[i] < zakoR/2 || zakoX[i] > width - zakoR/2) {
        stepX[i] *= -1;
      }
      zakoX[i] += stepX[i];
      zakoY[i] += stepY[i];
      fill(0);
      noStroke();
      triangle(zakoX[i], zakoY[i], zakoX[i] - zakoR/2, zakoY[i] - zakoR, zakoX[i] - zakoR/2, zakoY[i]);
      triangle(zakoX[i], zakoY[i], zakoX[i] + zakoR/2, zakoY[i] - zakoR, zakoX[i] + zakoR/2, zakoY[i]);
      fill(255, 10, 10);
      noStroke();
      ellipse(zakoX[i], zakoY[i], zakoR, zakoR);
    }
  }
  
  void bigEnemy() {
    if(bossX < bossR/2 || bossX > width - bossR/2) {
      bossStepX *= -1;
    }
    if(bossY < -150 || bossY > height + 150) {
      bossStepY *= -1;
    }
    bossX += bossStepX;
    bossY += bossStepY;
    fill(192);
    noStroke();
    ellipse(bossX, bossY, bossR, bossR);
    stroke(255, 10, 10);
    line(bossX - 10, bossY, bossX - 50, bossY - 40);
    line(bossX + 10, bossY, bossX + 50, bossY - 40);
    line(bossX, bossY + 10, bossX - 40, bossY + 50);
    line(bossX, bossY + 10, bossX + 40, bossY + 50);
  }
  
}

Enemy e;
int timer = 0;

void setup() {
  size(600,800);
  p1 = new player();
  item = new Items();
  b = new bullet();
  p1.hp(20);
  item.makeItems();
  b.MyMachineStart();
  noStroke();
  e = new Enemy();
  e.setEnemy();
  frameRate(30);
}

void draw() {
  background(255);
  p1.display();
  item.setItem(p1.px, p1.py);
  //p1.judge();
  item.drawItem();
  b.MyMachineBullet();
  e.easyEnemy();
  if(timer > 30*30) {
    e.bigEnemy();
  }
  timer++;
}

void mousePressed() {
  b.ClickBullet();
  
}
