public class Button {
  PImage Bimg, Bimgh, Bimgc, Bimt;
  int x, y, w, h, id;
  String Bim, Bimh, Bimc;
  Button(String BIMG, String BIMGH, String BIMGC, int X, int Y, int W, int H, int ID) {
    x=X;
    y=Y;
    w=W;
    h=H;
    Bim=BIMG;
    Bimh=BIMGH;
    Bimc=BIMGC;
    id=ID;
  }
    void strt(){
    Bimg=loadImage(Bim);
    Bimgh=loadImage(Bimh);
    Bimgc=loadImage(Bimc);
    image(Bimg, x, y, w, h);
    Bimt=Bimg;
    }
  void update() {
    image(Bimt, x, y, w, h);
    if (mouseX>x && mouseX<x+w && mouseY>y && mouseY<h+y) {
      image(Bimgh, x, y, w, h);
      if (mousePressed && F==false) {
        image(Bimgc, x, y, w, h);
        Bimt=Bimgc;
        BID=id;
        delay(500);
      }
      if (mousePressed && F==true) {
        // image(Bimg, x, y, w, h);
        Bimt=Bimg;
        BID=id;
        delay(500);
      }
    }
  }
}
public class Controller {
  int X, Y, W, H;
  float dgX, dgY;
  Controller (int x, int y, int w, int h) {
    X=x;
    Y=y;
    W=w;
    H=h;
  }
  void construct(PApplet app) {
    fill(0);
    rect(X, Y, W, H);
    move(false);
  }
  void move(boolean active) {
    if ((mouseX>X&&mouseX<X+W)&&(mouseY>Y&&mouseY<Y+H)) {
      ellipse(mouseX, mouseY, W/10, H/10);
      if (mousePressed) {
        active=true;
        fill(200);
        ellipse(mouseX, mouseY, W/10, H/10);
        DragX=map(mouseX, X, Y, -10, 10);
        DragY=map(mouseY, X, Y, -10, 10);
        println ("X: ", DragX, "  Y: ", DragY);
        delay(100);
      } else 
      {
        active=false;
        DragX=0;
        DragY=0;
        fill(0);
      }
    }
    act=active;
  }
}
