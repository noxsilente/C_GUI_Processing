public class Button {
  PImage Bimg, Bimgo;
  int x, y, w, h, id;
  String Bim, Bimo;
  Button(String BIMG, String BIMGO, int X, int Y, int W, int H, int ID) {
    x=X;
    y=Y;
    w=W;
    h=H;
    Bim=BIMG;
    Bimo=BIMGO;
    id=ID;
  }
  void update(boolean tf) {
    if (tf==true) {
      Bimg=loadImage(Bim);
      Bimgo=loadImage(Bimo);
      image(Bimg, x, y, w, h);
      mouseevent();
    }
  }
  void mouseevent() {
    if (mouseX>x && mouseX<x+w && mouseY>y && mouseY<h+y) {
      image(Bimgo, x, y, w, h);
      if (mousePressed) {
        test=false;
        BID=id;
      }
    }
  }
}

class CB {
  String c;
  int x, y, id, t;
  CB (String C, int X, int Y, int ID) {
    c=C;
    x=X;
    y=Y;
    id=ID;
  }
  void make() {
    stroke(255);
    fill(c_);
    rect(x, y, 30, 20);
    fill(c_t);
    textFont(f, 15);
    text(c, x+5, y+15);
    if (mousePressed &&(mouseX>x&&mouseX<=x+30)&&(mouseY>y&&mouseY<=y+20)) {
      delay(150);
      if (t==1) t=0;
      else t=1 ;
      draw();
    }
  }
  void draw() {
    switch (t) {
    case 1:
      on();
      ck=id;
      break;
    case 0:
      off();
      break;
    }
  }
  void on() {
    fill(255);
    rect(x, y, 30, 20);
    fill(0);
    text(c, x+5, y+15);
  }
  void off() {
    fill(c_);
    rect(x, y, 30, 20);
    fill(c_t);
    text(c, x+5, y+15);
  }
}
