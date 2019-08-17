ImageDisp[] img; //<>//
GifDisp[] gif;
StateDisp state;
PImage bgImage;
ArrayList<Integer> order = new ArrayList<Integer>(); // 表示順を格納
// 表示場所（画像の数だけ用意）
int[][][] pos_img = {
  {{100, 200}, {300, 200}, {300, 100}}, 
  {{200, 100}, {220, 250}, {50, 50}}, 
  {{320, 180}, {180, 240}, {100, 100}}, 
};
int[][][] pos_gif = {
  {{100, 200}, {200, 200}, {300, 100}}, 
  {{200, 100}, {220, 250}, {50, 50}}, 
  {{200, 300}, {320, 150}, {450, 250}}, 
};
int[] pos_state = {480, 360};

int IMG_SIZE = 3;
int GIF_SIZE = 3;

void setup() {
  frameRate(30);
  fullScreen();
  bgImage = loadImage("img/earth.jpg");

  // 通常画像
  img = new ImageDisp[IMG_SIZE];
  img[0] = new ImageDisp("img/terminal.jpg", pos_img[0][0][0], pos_img[0][0][0], 50);
  img[1] = new ImageDisp("img/warning.jpg", pos_img[1][0][0], pos_img[1][0][1], 30);
  img[2] = new ImageDisp("img/program.jpg", pos_img[2][0][0], pos_img[2][0][1], 45);
  order.add(0);
  order.add(1);
  order.add(2);

  // GIF画像
  gif = new GifDisp[GIF_SIZE];
  gif[0] = new GifDisp("gif/monitor2.gif", this, 50, 50, 50);
  gif[1] = new GifDisp("gif/cam2.gif", this, 100, 150, 100);
  gif[2] = new GifDisp("gif/randomnum2.gif", this, 300, 350, 100);
  order.add(3);
  order.add(4);
  order.add(5);

  // 状態画像
  state = new StateDisp(pos_state[0], pos_state[1], 21);
}

void draw() {
  image(bgImage, 0, 0);
  allDisplay();
}

void keyPressed() {
  if (!state.isDisp()) {
    switchImages();
    switchGifs();
  }
  switchState();
}

void allDisplay() {
  // 表示順に描画
  for (int i=0; i<order.size(); i++) {
    if (order.get(i) < IMG_SIZE) {
      // 通常画像の表示
      img[order.get(i)].draw();
    } else {
      // GIF画像の表示
      gif[order.get(i)-IMG_SIZE].draw();
    }
  }
  // 状態画像の表示
  state.draw();
}

void switchImages() {
  // 画像の表示
  for (int i=0; i<IMG_SIZE; i++) {
    // 表示しているものだけライフ減算
    if (img[i].isDisp()) {
      img[i].changeLife();
      continue;
    }

    // 表示要件を満たしていなければスキップ
    if (!img[i].canDisp()) {
      img[i].changeLife();
      continue;
    }

    // 非表示になっている場合は一定確率で再表示
    if (random(100) > 70) {
      int num = int(random(IMG_SIZE));
      //img[i].init(pos_img[i][num][0], pos_img[i][num][1]);
      img[i].init(int(random(100, 1000)), int(random(50, 500)));
      // 表示順の末尾に移動
      order.remove(order.indexOf(i));
      order.add(i);
    }
  }
}

void switchGifs() {
  // GIF画像の表示
  for (int i=0; i<GIF_SIZE; i++) {
    // 表示しているものだけライフ減算
    if (gif[i].isDisp()) {
      gif[i].changeLife();
      continue;
    }

    // 表示要件を満たしていなければスキップ
    if (!gif[i].canDisp()) {
      gif[i].changeLife();
      continue;
    }

    // 非表示になっている場合は一定確率で再表示
    if (random(100) > 50) {
      int num = int(random(GIF_SIZE));
      //gif[i].init(pos_gif[i][num][0], pos_gif[i][num][1]);
      gif[i].init(int(random(100, 1000)), int(random(50, 500)));
      // 表示順の末尾に移動
      order.remove(order.indexOf(i+IMG_SIZE));
      order.add(i+IMG_SIZE);
    }
  }
}

void switchState() {
  // 状態画像の表示
  // 表示している場合だけライフ減算
  if (state.isDisp()) {
    state.changeLife();
    return;
  }

  // 表示要件を満たしていなければスキップ
  if (!state.canDisp()) {
    state.changeLife();
    return;
  }

  // 非表示になっている場合は一定確率で再表示
  if (random(100) > 50) {
    state.init(pos_state[0], pos_state[1]);
  }
}
