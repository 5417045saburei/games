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

void setup(){
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

void draw(){
  background(255);
  fill(0);
  ellipse(mouseX, mouseY, 30, 30);
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
      
      if(dist(mouseX, mouseY, x[i] + 5.0, y[i] + 5.0) <= 30){
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

void setup() {
  size(600,800);
}

void draw() {
  background(255);
}
