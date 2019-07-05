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

bullet b;

void setup(){
  size(400, 800);
  b = new bullet();
  b.MyMachineStart();
}

void draw(){
  background(255);
  b.MyMachineBullet();
  
}
    
void mousePressed() {
  b.ClickBullet();
  
}
