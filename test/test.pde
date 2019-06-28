float[] ballx = new float [1000];
float[] bally = new float [1000];
int clickCount = 0;
int[] dx = new int [1000];
int[] dy = new int [1000];

void setup(){
  size(800, 800);
  for(int i = 0; i < dx.length; i++){
    dx[i] = 0;
    dy[i] = -3;
  }
}

void draw(){
  int size = 10;
  
  background(255);
  for(int i = 0; i < clickCount; i++){
    ellipse(ballx[i], bally[i], size, size);
    ballx[i] += dx[i];
    bally[i] += dy[i];
    if(ballx[i]-size <= 0 || ballx[i]+size >= width){
      dx[i] *= -1;
    }
    if(bally[i]-size <= 0 || bally[i]+size >= height){
      dy[i] *= -1;
    }
  }
}
    
void mousePressed() {
  ballx[clickCount] = mouseX;
  bally[clickCount] = mouseY;
  clickCount += 1;
  println(clickCount);
}
