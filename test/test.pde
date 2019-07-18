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
    
    fill(255);
    textSize(30);
    text("hp:" + hp, 470, 70);
  }
  
    int avo = 0; //一つの弾で多段攻撃を回避
    boolean judge(float bulletX[][], float bulletY[][], float myBallX[], float myBallY[], int c[], float BBX[], float BBY[]) {
    int size = 10; //弾の大きさ
    int i, j;
    
    if(hp <= 0) {// 自分がやられたかどうか
      return false;
    } 
    
    if(avo > timer) {//2秒間無敵
      //ダメージを受けない
      fill(0, 255, 0);
      rect(px-15, py-15, 30, 30);
      stroke(255, 0, 0);
      line(px, py-15, px-15, py+15);
      line(px, py-15, px+15, py+15);
      line(px, py+15, px-15, py-15);
      line(px, py+15, px+15, py-15);
      return true;
    } 
    
    for(i = 0; i < bulletX.length; i++) { //敵の弾に対する当たり判定
      for(j = 0; j < bulletX[i].length; j++) {
        if((px <= bulletX[i][j] + size && bulletX[i][j]-size <= px) && (py <= bulletY[i][j] + size && bulletY[i][j]-size <= py)) {
          hp--;
          avo = timer + 60;
          break;
        }
        if(avo > timer) {
          break;
        }
      }
    }
    
    for(i = 0; i < BBX.length; i++) { //ボスの弾に対する当たり判定
      if((px <= BBX[i] + size && BBX[i]-size <= px) && (py <= BBY[i] + size && BBY[i]-size <= py)) {
        hp--;
        avo = timer + 60;
        break;
      }
    }
    
    for(i = 0; i < myBallX.length; i++) { //自分の球に対する当たり判定
      if((px <= myBallX[i] + size && myBallX[i]-size <= px) && (py <= myBallY[i] + size && myBallY[i]-size <= py) && c[i] == 0) {
        hp--;
        avo = timer + 60;
        break;
      }
    }
   
    return true;
  }
  
  void hp(int hp0) {
    hp = hp0;
    avo = 0;
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
  int score = 0;
  int power = 0;
  int p = 1;
  
  void setItem(int x0, int y0){
    p_x = x0;
    p_y = y0;
    fill(255);
    textSize(30);
    text("score:" + score, 440, 30);
  }

  void makeItems(float zX[], float zY[], int de){
    size(600, 800);
    for(int i = 0; i < 10; i++){
      for(int j = 0; j < 10; j++) {
      }
      items_random[i] = (float)random(0.0, 11.0);
      if(items_random[i] < 0.3){
        items[i] = 4;
      }else if(0.3 <= items_random[i] && items_random[i] < 0.6){
        items[i] = 3;
      }else if(0.6 <= items_random[i] && items_random[i] < 4.0){
        items[i] = 2;
      }else{
        items[i] = 1;
      }
    
      x[i] = zX[de];
      y[i] = zY[de];
      println(zX[de]);
      xSpeed[i] = random(-5.0, 5.0);
      ySpeed[i] = random(-5.0, -0.1);
    }
  }

  void drawItem(){
    for(int i = 0; i < 10; i++){
      if(get[i] == 0){
        if(items[i] == 1){
          fill(255, 255, 0);
        }else if(items[i] == 2){
          fill(0, 255, 255);
        }else if(items[i] == 3){
          fill(0, 255, 0);
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
            b.delete();
          }else if(items[i] == 4){
            p1.hp = 5;
          }
      
          if(items[i] == 1){
            power++;
            if(power == 5) {
              p++;
              power = 0;
            }
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
  float[] ballx;
  float[] bally;
  int clickCount;
  float[] dx;
  float[] dy;
  int[] c;
  
  void MyMachineStart() {
    ballx = new float [1000];
    bally = new float [1000];
    clickCount = 0;
    dx = new float [1000];
    dy = new float [1000];
    c = new int [1000];
    
    for(int i = 0; i < dx.length; i++){
      dx[i] = 0;
      dy[i] = -3;
      c[i] = 1;
    }
  }
  
  void MyMachineBullet() {  
    for(int i = 0; i < clickCount; i++){
      if(c[i] == 1) {
        fill(0, 0, 255);
      } else {
        fill(255, 0, 0);
      }
      ellipse(ballx[i], bally[i], size, size);
      ballx[i] += dx[i];
      bally[i] += dy[i];
      if(bally[i]-size <= 0) {
        if(c[i] == 1) { //上の壁にあたる = 敵の球になる場合角度を変える
          dx[i] = random(-5, 5);
          c[i] = 0;
        } 
        dy[i] *= -1; 
      } 
      if(ballx[i]-size <= 0 || ballx[i]+size >= width){
        dx[i] *= -1;
      }
      if(bally[i]+size >= height){
        dy[i] *= -1;
      }
    }
  }
  
  void ClickBullet() {
    ballx[clickCount] = mouseX;
    bally[clickCount] = mouseY - 15;
    clickCount += 1;
  }
  
  
  int BulletTotal = 20;
  int enemyCount = 10;
  float[][] eBulletX;
  float[][] eBulletY;
  float[][] BulletSpeadX;
  float[][] BulletSpeadY;
  int[][] rand;
  int[][] Bulletjudge;
  int[] Btimer;
  
  void enemyBulletSet() {  
    int i, j;
    eBulletX = new float [enemyCount][BulletTotal];
    eBulletY = new float [enemyCount][BulletTotal];
    BulletSpeadX = new float [enemyCount][BulletTotal];
    BulletSpeadY = new float [enemyCount][BulletTotal];
    rand = new int [enemyCount][BulletTotal];
    Bulletjudge = new int [enemyCount][BulletTotal];
    Btimer = new int[enemyCount];
  
    for(i = 0; i < enemyCount; i++) {
      for(j = 0; j < BulletTotal; j++) {
        rand[i][j] = int(random(1, 5)) * 30; //どれぐらいの時間差で発射するか
        BulletSpeadX[i][j] = random(-5, 5);
        BulletSpeadY[i][j] = random(0, 4);
      }
    }
    
    for(i = 0; i < enemyCount; i++) {
      Btimer[i] = 0;
    }
    
    
  }
    
  void enemyBullet(float eX[], float eY[]){
    int i,j;
    
    for(i = 0; i < enemyCount; i++) {
      Btimer[i] += 1;
    }
    
    for(i = 0; i < enemyCount; i++) {
      for(j = 0; j < BulletTotal; j++) {
        if(j != 0 && Bulletjudge[i][j-1] != 1) {//処理を軽くするため
          break;
        }
        
        if(Btimer[i] > rand[i][j] && Bulletjudge[i][j] == 0) {
          eBulletX[i][j] = eX[i];
          eBulletY[i][j] = eY[i];
          Bulletjudge[i][j] = 1;
          Btimer[i] = 0; //時間差で発射するため
          break;
        }
        
      }
    }
    
    for(i = 0; i < enemyCount; i++) {
      for(j = 0; j < BulletTotal; j++) {
        if(Bulletjudge[i][j] == 1) {
          eBulletX[i][j] += BulletSpeadX[i][j];
          eBulletY[i][j] += BulletSpeadY[i][j];
          
          if(eBulletX[i][j]+size > width || eBulletX[i][j]-size < 0) {
            BulletSpeadX[i][j] *= -1;
          }
          if(eBulletY[i][j]+size > height || eBulletY[i][j]-size < 0) {
            BulletSpeadY[i][j] *= -1;
          }
          
          fill(255, 0, 0);
          ellipse(eBulletX[i][j], eBulletY[i][j], size, size);
        }
      }
    }
  }
  
  int BT = 200;
  float[] BBX = new float [BT]; //bossBulletX
  float[] BBY = new float [BT];
  float[] BSX = new float [BT]; //BossSpeadX
  float[] BSY = new float [BT];
  int[] BJ = new int [BT]; //BossJudge
  int rd;
  int[] BBT = new int [BT]; //BossBulletTime
  int BBTR = 0;
  
  void bigEnemySet() {
    int i;
    float stepX,stepY;
    rd = int(random(0, 2));
    if(rd == 0) {
      stepX = 0.5;
      stepY = 2;
      for(i = 0; i < BBX.length; i++) {
        BBT[i] = 10;
        BSX[i] = stepX;
        BSY[i] = stepY;
        if(stepX > 10) {
          stepX *= -1;
        }
        stepX += 1;
        BJ[i] = 0;
        BBX[i] = -30;
        BBY[i] = -30;
      }
    } else if(rd == 1){
      stepX = 0;
      stepY = 2;
      for(i = 0; i < BBX.length; i++) {
        if(i % 5 == 0) {
          BBT[i] = 90;
        }
        BSX[i] = stepX;
        BSY[i] = stepY;
        stepX += 0.5;
        if(stepX > 5) {
          stepX *= -1;
         
        }
        BJ[i] = 0;
        BBX[i] = -30;
        BBY[i] = -30;
      }
    }
  }
  
  void bigEnemyBullet(float boX,float boY) {
    int i;
   
    BBTR++;
    BJ[0] = 1;
    for(i = 1; i < BBX.length; i++) {
      if(BJ[i] == 0 && BBT[i] <= BBTR && BJ[i-1] == 1) {
        BBX[i] = boX;
        BBY[i] = boY;
        BJ[i] = 1;
        BBTR = 0;
      }
    }
    
    for(i = 0; i < BBX.length; i++) {
      if(BJ[i] == 1) {
        BBX[i] += BSX[i];
        BBY[i] += BSY[i];
        if(BBX[i]+size > width || BBX[i]-size < 0) {
          BSX[i] *= -1;
        }
        if(BBY[i]+size > height || BBY[i]-size < 0) {
          BSY[i] *= -1;
        }
      
        fill(255, 0 ,0);
        ellipse(BBX[i], BBY[i], size, size);
      }
    }
    
  }
  
  void delete() { //弾を全て消す
    int i, j;
    for(i = 0; i < enemyCount; i++) {
      for(j = 0; j < BulletTotal; j++) {
        eBulletX[i][j] = -15;
        eBulletY[i][j] = -15;
      }
    }
    
    for(i = 0; i < clickCount; i++) {
      ballx[i] = -15;
      bally[i] = -15;
    }
    
    for(i = 0; i < BBX.length; i++) {
      BBX[i] = -15;
      BBY[i] = -15;
    }
    
  }
}

class Enemy {
  int ballCount = 10;
  float[] zakoX = new float[ballCount];
  float[] zakoY = new float[ballCount];
  int zakoR = 30;
  float[] stepX = new float[ballCount];
  float[] stepY = new float[ballCount];
  float bossX;
  float bossY;
  int bossR = 160;
  float bossStepX = 2;
  float bossStepY = 1;
  int[] easyEnemyHp = new int[ballCount];
  int bigEnemyHp;
  
  void setEnemy() {
    for(int i = 0; i < ballCount; i++) {
      zakoX[i] = random(15, 380);
      zakoY[i] = random(20, 31);
      stepX[i] = random(-5, 5);
      stepY[i] = random(0, 3);
    }
    
    for(int i = 0; i < ballCount; i++) {
      easyEnemyHp[i] = 5;
    }
    bigEnemyHp = 150;
    bossX = 200;
    bossY = 150;
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
  
  
  int[] k = new int[ballCount];
  float[] dpX = new float[ballCount];//deathPositionX
  float[] dpY = new float[ballCount];
  int enemyDamege(float bX[], float bY[], int c[]) {
    int i, j;
    for(i = 0; i < ballCount; i++) {
      for(j = 0; j < bX.length; j++) {
        if((zakoX[i] <= bX[j] + 10 && bX[j] - 10 <= zakoX[i]) && (zakoY[i] <= bY[j] + 10 && bY[j]-10 <= zakoY[i]) && c[j] == 1) {
          easyEnemyHp[i] -= item.p;
          bX[j] = -15;
          bY[j] = -15;
          if(easyEnemyHp[i] <= 0) {
            dpX[i] = zakoX[i];
            dpY[i] = zakoY[i];
            zakoX[i] = -100;
            zakoY[i] = -5;
            k[i] = 1;
          }
        }
      }
    }
    for(i = 0; i < ballCount; i++) {
      if(k[i] == 1) {
        k[i] = 2;
        return i;
      }
    }
   
    return -1;
  }
  
  void bigEnemy() {
    if(bossX < bossR/2 || bossX > width - bossR/2) {
      bossStepX *= -1;
    }
    if(bossY < +150 || bossY > height - 150) {
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
    fill(255);
    ellipse(bossX, bossY, 50, 50);
    fill(0);
    ellipse(bossX, bossY, 25, 30);
  }
  
  boolean bigEnemyDamege(float bX[], float bY[], int c[]) {
    int i;
    if(bigEnemyHp < 0) {
      t = 3;
      return false;
    }
    for(i = 0; i < bX.length; i++) {
      if(((bossX-bX[i])*(bossX-bX[i])) + ((bossY-bY[i])*(bossY-bY[i])) <= (bossR/2)*(bossR/2) && c[i] == 1) {
        bX[i] = -15;
        bY[i] = -15;
        bigEnemyHp--;
      }
    }
    return true;
  }
  
  boolean easyEnemyIn() { //画面内に全てのザコ敵がいるかどうか
    int i, count = 0;
    for(i = 0; i < ballCount; i++) {
      if(zakoY[i] > height + zakoR + zakoR/2) {
        count++;
      }
    }
    if(count == 10) {
      return false;
    } else {
      return true;
    }
  }
}

class Title{
  private int ti;
  
  void display(){
    fill(100);
    textSize(80);
    text("Cyber Space I", 30, 250);
    fill(255, 0, 0);
    textSize(79);
    text("Cyber Space I", 30, 250);
    fill(0);
    rect(215, 490, 110, 50);
    textSize(50);
    fill(255);
    text("start", 215, 530);
  }
  
  void judge(){
    if((215 < mouseX && mouseX < 325) && (490 < mouseY && mouseY < 540)){
      if(mousePressed == true){
        ti = 1;
      }
    }
  }
  
  void setTitle(int t0){
    ti = t0;
    mousePressed = false;
  }
  
  int getTitle(){
    return ti;
  }
}

PImage bg;
Title title;
Items item;
player p1;
bullet b;
Enemy e;

int t = 0;
int timer = 0;
int de1 = -1;
int de2 = -1;
int end = 0;

void setup() {
  size(600,800);
  noStroke();
  frameRate(30);
  
  title = new Title();
  p1 = new player();
  item = new Items();
  b = new bullet();
  e = new Enemy();  
  
  p1.hp(5);
  b.MyMachineStart();
  b.enemyBulletSet();
  e.setEnemy();
  b.bigEnemySet();
  title.setTitle(t);
}

void draw() {
  bg = loadImage("haikei.jpeg");
  image(bg, 0, 0, 600, 800);
  
  if(t == 0){
    title.display();
    title.judge();
    t = title.getTitle();
  }else if(t == 1){
    if(timer > 1*30) { //1秒後スタート
      p1.display();
      item.setItem(p1.px, p1.py);
    
      if(p1.judge(b.eBulletX, b.eBulletY, b.ballx, b.bally, b.c, b.BBX, b.BBY) == false){ //当たったらhp減少 falseでゲームオーバー
        t = 2;
        return;
      }
      b.MyMachineBullet();
    
    
      if(e.easyEnemyIn() == true) {//画面内に全てのザコ敵が消えたら出力しない
        e.easyEnemy();
      }
      
      de1 = e.enemyDamege(b.ballx, b.bally, b.c);
      if(de1 != -1 || de2 != -1) {
        if(de1 != -1) {
          de2 = de1;
          item.makeItems(e.dpX, e.dpY, de2);
        }
        item.drawItem();
      }
      b.enemyBullet(e.zakoX,e.zakoY);
    
      if(timer > 30*30) {//ボスが何秒後に出現するか
        if(e.bigEnemyDamege(b.ballx, b.bally, b.c) == true) {
          b.bigEnemyBullet(e.bossX, e.bossY);
          e.bigEnemy();
        }
      }
    }
    timer++;
  }else if(t == 2){
    fill(100);
    textSize(80);
    text("score:" + item.score, 150, 250);
    fill(0);
    rect(210, 490, 110, 50);
    textSize(50);
    fill(255);
    text("exit!", 210, 530);
        
    if((210 < mouseX && mouseX < 320) && (490 < mouseY && mouseY < 540)){
      if(mousePressed == true){
        t = 0;
        title.setTitle(t);
        p1.hp(5);
        b.MyMachineStart();
        b.enemyBulletSet();
        e.setEnemy();
        b.bigEnemySet();
        timer = 0;
      }
    }
  }else{
    if(end == 0){
      item.score += 100;
      end++;
    }
    fill(255, 0, 30);
    textSize(100);
    text("Mission", 100, 120);
    text("Complete", 80, 220);
    fill(0, 255, 125);
    textSize(40);
    text("score:" + item.score, 200, 400);
    fill(0);
    rect(210, 490, 110, 50);
    textSize(50);
    fill(255);
    text("exit!", 210, 530);
        
    if((210 < mouseX && mouseX < 320) && (490 < mouseY && mouseY < 540)){
      if(mousePressed == true){
        t = 0;
        title.setTitle(t);
        p1.hp(5);
        b.MyMachineStart();
        b.enemyBulletSet();
        e.setEnemy();
        b.bigEnemySet();
        timer = 0;
      }
    }
  }
}

void mousePressed() {
  b.ClickBullet();
}

void keyPressed() {
  if(key == 'b' || key == 'B') {//弾を消す
    b.delete();
  }
  
  if(key == 'a' || key == 'A'){
    b.ClickBullet();
  }
  
  if(key == 'r' || key == 'R') {//リスタート
    p1.hp(5);
    b.MyMachineStart();
    b.enemyBulletSet();
    e.setEnemy();
    b.bigEnemySet();
    timer = 0;
    t = 0;
  }
}
