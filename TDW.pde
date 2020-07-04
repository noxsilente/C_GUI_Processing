float zoom;
float DragX, DragY, prevX, prevY;
int BID, N;
String OB, n;
PShape sh, sh1;
float X, Y;
boolean F=false;
boolean L=false;
boolean act=false;
Button H = new Button ("buttons/H1.png", "buttons/H2.png", "buttons/H3.png", 20, 20, 50, 100, 3);
Controller C = new Controller (120, 50, 50, 50);
void settings() {
  size(1080, 720, P3D);
  PJOGL.setIcon("logo.png");
}
void setup() {
  background(0, 0, 30);
  frameRate(30);
  //PImage ico = loadImage("logo.png"); 
  String[] lines = loadStrings("obj_tmp.tmp");
  OB=lines[0];
  n=lines[1];
  N=int(n);
  surface.setLocation(50, 100);
  surface.setTitle(OB);
  X=width/2;
  Y=height/2;
  sh=loadShape(OB);
  sh1=loadShape(OB);
  if (N==2) { 
    L=true;
    sh1.scale(-1, 1);
  } 
  sh1.rotateY(PI);
  translate(X, Y);
  H.strt();
}
void draw() {
  translate(0, 0);
  background(0, 0, 30);
  pushMatrix();
  H.update();
  C.construct(this);
  stroke(255);
  line(120, 0, 120, 50);
  line(120, 50, 170, 50);
  line(170, 50, 170, 100);
  line(170, 100, 120, 100);
  line(120, 100, 50, 350);
  line(50, 350, 50, height-100);
  line(50, height-100, width, height-100);
  fill(255);
  text("MODEL CONTROL", 120,35);
  text("CUT HALF", 10, 150);
  text("LEFT MOUSE = ROTATE L/R U/D", width/8.5, height-50);
  text("CENTER MOUSE = MOVE", width/2.5, height-50);
  text("WHEEL MOUSE = ZOOM", width/2.5, height-20);
  text("RIGHT MOUSE = RETURN IN POSITION", width/1.5, height-50);
  popMatrix();
  if (L==true) {
    pointLight(250, 250, 250, -width/2, Y/3, 600);
    pointLight(250, 250, 250, width/2, -Y/3, -600);
  } else lights();
  sh.scale(1);
  sh1.scale(1);
  if (mouseX>100 && mouseX<width) {
    if (!mousePressed) {
      translate(X, Y);
      shape(sh);
      shape(sh1);
    }
    if (mousePressed) 
    { 
      if (mouseButton==CENTER) {
        translate(mouseX, mouseY);
        shape(sh);
        shape(sh1);
        X=mouseX;
        Y=mouseY;
      } 
      if (mouseButton==RIGHT) {
        X=width/2;
        Y=height/2;
        translate(X, Y);
        sh.resetMatrix();
        sh1.resetMatrix();
        if (N==2) { 
          L=true;
          sh1.scale(-1, 1);
        } 
        sh1.rotateY(PI);
      }
    }
  }
  switch(BID) {
  case 1:
    zoom+=0.5;
    sh.scale(zoom);
    sh1.scale(zoom);
    break;
  case 2:
    zoom-=-0.3;
    sh.scale(zoom);
    sh1.scale(zoom);
    break;
  case 3:
    if (F==false) {
      sh1.setVisible(F);
      F=true;
    } else {
      sh1.setVisible(F);
      F=false;
    }
    break;
  }
  BID=0;
  if (act==true) {
    translate(X, Y);
    rotateX(DragY);
    rotateY(DragX);
    shape(sh);
    shape(sh1);
  }
}
void mouseWheel(MouseEvent e) {
  zoom=e.getCount();
  if (zoom>0) BID=1;
  if (zoom<0) BID=2;
}
