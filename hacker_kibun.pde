ImageDisp[] img;
GifDisp[] gif;
PImage bgImage;
ArrayList<Integer> order = new ArrayList<Integer>(); // 表示順を格納
// 表示場所（画像の数だけ用意）
int[][][] pos_img = {
  {{100, 200}, {200, 200}, {300, 100}},
  {{200, 100}, {220, 250}, {50, 50}},
  {{320, 180}, {180, 240}, {100, 100}},
};
int[][][] pos_gif = {
  {{100, 200}, {200, 200}, {300, 100}},
  {{200, 100}, {220, 250}, {50, 50}},
};

int IMG_SIZE = 3;
int GIF_SIZE = 2;

void setup() {
  frameRate(30);
  size(1280, 720); //<>//
  bgImage = loadImage("img/background.jpg");
  //fullScreen();
  
  img = new ImageDisp[IMG_SIZE];
  img[0] = new ImageDisp("img/kato.jpg", pos_img[0][0][0], pos_img[0][0][0], 100);
  img[1] = new ImageDisp("img/jal.png", pos_img[1][0][0], pos_img[1][0][1], 60);
  img[2] = new ImageDisp("img/graph.png", pos_img[2][0][0], pos_img[2][0][1], 45);
  order.add(0);
  order.add(1);
  order.add(2);
  
  gif = new GifDisp[GIF_SIZE];
  gif[0] = new GifDisp("gif/13.gif", this, 50, 50, 80);
  gif[1] = new GifDisp("gif/017.gif", this, 100, 150, 120);
  order.add(3);
  order.add(4);
}

void draw() {
  background(bgImage);
  allDisplay();
}

void keyPressed() {
  switchImages();
}

void allDisplay() {
  for (int i=0; i<order.size(); i++) {
    if (order.get(i) < IMG_SIZE) {
      img[order.get(i)].draw();
    } else {
      gif[order.get(i)-IMG_SIZE].draw();
    }
  }
}

void switchImages() {
  // 画像の表示
  for (int i=0; i<IMG_SIZE; i++) {
    if (img[i].isDisp()) {
      // 表示しているものだけライフ減算
      img[i].changeLife();
    } else {
      // 表示要件を満たしていなければスキップ
      if (!img[i].canDisp()) {
        img[i].changeLife();
        continue;
      }
      
      // 非表示になっている場合は一定確率で再表示
      if (random(100) > 70) {
        int num = int(random(IMG_SIZE));
        img[i].init(pos_img[i][num][0], pos_img[i][num][1]);
        // 表示順の末尾に移動
        order.remove(order.indexOf(i));
        order.add(i);
      }
    }
  }
  // GIF画像の表示
  for (int i=0; i<GIF_SIZE; i++) {
    if (gif[i].isDisp()) {
      // 表示しているものだけライフ減算
      gif[i].changeLife();
    } else {
      // 表示要件を満たしていなければスキップ
      if (!gif[i].canDisp()) {
        gif[i].changeLife();
        continue;
      }
      
      // 非表示になっている場合は一定確率で再表示
      if (random(100) > 50) {
        int num = int(random(GIF_SIZE));
        gif[i].init(pos_gif[i][num][0], pos_gif[i][num][1]);
        // 表示順の末尾に移動
        order.remove(order.indexOf(i+IMG_SIZE));
        order.add(i+IMG_SIZE);
      }
    }
  }
}
