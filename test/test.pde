int ballCount = 10;
int[] zakoX = new int[ballCount];
int[] zakoY = new int[ballCount];
int zakoR = 30;
int[] stepX = new int[ballCount];
int[] stepY = new int[ballCount];
int bossX = 200;
int bossY = 20;
int bossR = 180;
int count = 0;
int bossStepX = 5;
int bossStepY = 2;

void setup() {
  size(400, 800);
  noStroke();
  for(int i = 0; i < ballCount; i++) {
    zakoX[i] = int(random(0, 380));
    zakoY[i] = int(random(15, 31));
    stepX[i] = int(random(1, 6));
    stepY[i] = int(random(1, 4));
  }
}

void draw() {
  background(255);
  for(int i = 0; i < zakoX.length; i++) {
    if(zakoX[i] < zakoR/2 || zakoX[i] > width - zakoR/2) {
      stepX[i] *= -1;
    }
    zakoX[i] += stepX[i];
    zakoY[i] += stepY[i];
    fill(0);
    triangle(zakoX[i], zakoY[i], zakoX[i] - zakoR/2, zakoY[i] - zakoR, zakoX[i] - zakoR/2, zakoY[i]);
    triangle(zakoX[i], zakoY[i], zakoX[i] + zakoR/2, zakoY[i] - zakoR, zakoX[i] + zakoR/2, zakoY[i]);
    fill(255, 10, 10);
    ellipse(zakoX[i], zakoY[i], zakoR, zakoR);
    if(zakoY[i] > height) {
      count++;
    }
  }
  if(count > 9) {
    if(bossX < bossR/2 || bossX > width - bossR/2) {
      bossStepX *= -1;
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
