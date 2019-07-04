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

player p1;

void setup() {
  size(800,800);
  p1 = new player();
  p1.hp(20);
}

void draw() {
  background(0);
  p1.display();
  //p1.judge();
}
