class StateDisp {
 PImage[] img;
 int my_x = 0, my_y = 0; // 現在位置
 int my_life = 0; // 現在ライフ
 int init_x = 0, init_y = 0; // 初期位置
 int init_life = 0; // 初期ライフ
 int state = 0;
 boolean is_disp = true;
 
 int STATE_SIZE = 6;
 
 StateDisp(int x, int y, int life) {
   img = new PImage[STATE_SIZE];
   for (int i=0; i<STATE_SIZE; i++) {
     img[i] = loadImage("state/00"+str(i+1)+".jpg");
   }
   init_x = x;
   init_y = y;
   init_life = life;
   my_life = life;
   move(x, y);
 }
 
 void init(int x, int y) {
   // 初期位置へ移動
   move(x, y);
   my_life = init_life;
   state = 0;
   is_disp = true;
 }
 
 void draw() {
   image(img[state], my_x, my_y);
 }
 
 void undisplay() {
   // 画面外に移動
   move(10000, 10000);
   is_disp = false;
 }
 
 void move(int x, int y) {
   my_x = x;
   my_y = y;
 }
 
 void changeLife() {
   my_life--;
   if (my_life > 0) {
     int band = int(init_life/STATE_SIZE);
     state = STATE_SIZE - int(my_life/band);
     if (state >= STATE_SIZE) {
       state = STATE_SIZE - 1;
     }
   } else {
     undisplay();
   }
 }
 
 boolean isDisp() {
   return is_disp;
 }
 
 boolean canDisp() {
   return (my_life < -200);
 }
}
