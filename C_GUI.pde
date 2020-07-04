//importing libraries
import g4p_controls.*;
import controlP5.*;
import java.util.*;
XML xml, xml1, xml2, xml3;   //defining xml files
XML[] child, child2, child3;  // and childs
int BID, ck, N; // defining int for button id, "in" "mm" button check, and N for defining how many cartridges are in a object 
PImage img; 
PFont f;
PrintWriter temp;
int WW=1024;
int WH=768;
//--------------------
String  obj, c, sh, loc, r, er, err; // name of the object, string from main sketch, shape location, language localization, reference, additional reference
int LOC; 
int s=15; // size of font
int B=0;
String [] OBJ=new String [255]; // 255 is too big for the object name
//--------------------
//various strings for kind of cartridge, measures, name for the 3d viewer, name of the object, image 
//language, short form language, new version message file, info of the object
// float language (on the option_page tab) value and selected object value
String ch, CH, ref, ver, OB, SUBJ, IMG, IN, Lang, T_L, AD, INFO_T;  
float L_VAL, S_VAL;
//---------------------
//defining colors tu use called in the option_page tab
color c_std_b=(color(0));
color c_std_bar=(color(0, 0, 50));
color c_mil_b=(color(55, 68, 32));
color c_mil_bar=(color(80, 80, 0));
color c_mil_sand_b=(color(166, 145, 80));
color c_mil_sand_bar=(color(194, 178, 128));
color c_easy_b=(color(0, 0, 80));
color c_easy_bar=(color(0, 40, 0));
color c_bw_b=(color(255));
color c_bw_bar=(color(155));
color c_t_W=(color(255));
color c_t_B=(color(0));
int c_, c_bar, c_t;
//---------------------
//creating button objects using the Button class and "homemade checkbox" class 
//in the classes tab
Button P = new Button ("res/buttons/B_P.png", "res/buttons/B_PO.png", WW/45, WH/7, 100, 50, 1 );
Button R = new Button ("res/buttons/B_R.png", "res/buttons/B_RO.png", WW/45, WH/4, 100, 50, 2 );
Button S = new Button ("res/buttons/B_S.png", "res/buttons/B_SO.png", WW/45, WH/3, 100, 50, 3 );
Button D = new Button ("res/buttons/3D.png", "res/buttons/3D_O.png", WW/2-100, (WH/12*5)-60, 50, 50, 4 );
Button INFO = new Button ("res/buttons/i.png", "res/buttons/io.png", WW/2-25, 10, 20, 20, 21);
Button OPTION = new Button ("res/buttons/opt.png", "res/buttons/opt_O.png", WW/2-50, 10, 20, 20, 22 );
CB c1 =new CB ("in", WW/5, WH/4, 5);
CB c2 =new CB ("mm", WW/5, WH/3, 6);
//creating the dropdown lists, the option window, listbox and the text area (from ControlP5)
ControlP5 cp5, cp52;
GWindow win;
ListBox LANGUAGES, OBJECTS;
Textarea TEXT_INFO;
boolean test = false; 
boolean tdw = false;
//int cnt;
void setup() {
  String lines[]=loadStrings("res/_.VERSION");
  String par[]=loadStrings("res/_.PAR");
  int tmpc= int(par[2]);
  int tmpcb= int(par[3]);
  int tmpt=int(par[4]);
  if (tmpc==0) {
    c_=c_std_b;
    c_bar=c_std_bar;
    c_t=c_t_W;
  } else {
    c_= tmpc;
    c_bar= tmpcb;
    c_t=tmpt;
  }
  size(1024, 637);
  //frameRate(30);
  img=loadImage("res/logo.png");
  ver=lines[1];
  if (lines[0].equals(ver)==false) {
    String ADDED[] = loadStrings("res/agg");
    AD="";
    for (int i=0; i<ADDED.length; i++) {
      AD+="\n"+ADDED[i];
    }
    G4P.showMessage(this, AD, "NEW VERSION!", G4P.INFO_MESSAGE);
    temp=createWriter("res/_.VERSION");
    temp.println(ver);
    temp.println(ver);
    temp.close();
  }
  surface.setTitle("CARTRIDGES "+ver);
  surface.setIcon(img);
  surface.setLocation(100, 100);
  f = createFont("res/font/arial.ttf", 15, true);
  Lang="loc/"+par[0]+".xml";
  T_L=par[0];
  background(c_);
  smooth(2); 
  cp5 = new ControlP5 (this);
  TEXT_INFO = cp5.addTextarea("INFO")
    .setPosition(WW/2+10, 10)
    .setSize(WW/2-10, (WH/12*5)-10)
    .setFont(createFont("res/font/arial.ttf", 13))
    .setColor(c_t)
    .setColorForeground(color(200))
    .setColorActive(color(100, 72, 0))
    ;
  OBJECTS=cp5.addListBox("", 250, 10, 200, 250);
  OBJECTS.setColorBackground(c_bar)
    .addItem("---", 0)
    .setColorLabel(c_t)
    .setColorActive(color(120,120,120))
    .setColorForeground(color(100, 72, 0))
    .setColorValue(c_t)
    .setFont(createFont("res/font/arial.ttf", 10, true))
    .setBarHeight(25)
    .setItemHeight(15)
    .setOpen(false)
    ;
  ck=int(par[1]);
  OBJ[0]="---";
}

void draw() {
  // delay(25);
  noStroke();
  pushMatrix();
  INFO.update(true);
  OPTION.update(true);
  P.update(true);
  R.update(true);
  D.update(tdw);
  S.update(true);
  c1.make();
  c2.make();
  if (c_t==-16777216)stroke(0);
  else stroke(255);
  line(0, WH/12*5, WW, WH/12*5);
  line(WW/2, 0, WW/2, WH);
  popMatrix();
  if (IN!=null) {
    fill(c_);
    rect(WW/2+1, 0, WW/2-1, (WH/12*5)-1);
  } else {
    TEXT_INFO.setText("");
    fill(c_);
    rect(WW/2+1, 0, WW/2-1, (WH/12*5)-1);
  }
  if (mouseX>20&&mouseX<WW) nextStep();
}
//--------------------------------------
void nextStep() {
  //println(ck, "   ", INFO_T, "   ", cnt++, "   ", mouseX, "   ", mouseY);
  //-----------------------
  OBJECTS.onClick(new CallbackListener() { 
    public void controlEvent(CallbackEvent theEvent) {
      S_VAL = theEvent.getController().getValue();
      if (S_VAL>0 && CH!=null) 
      {
        B=int(S_VAL)-1;
        TEXT_INFO.setText("");
        OBJECTS.setOpen(false);
        rectpdate();
        data();
      }
      rectpdate();
    }
  }
  );
  if ( mousePressed && OBJECTS.isOpen()==true && CH==null && S_VAL==0) {
    OBJECTS.setOpen(false);
    rectpdate();
  }
  //-------------------------------
  if (tdw==true)    D.update(tdw);
  if (IMG!=null)  TI();
  //--------------------------------- 
  if (OB!=null) {
    tdw=true;
    temp = createWriter("TDW/obj_tmp.tmp");
    String tmp =OB.substring(4);
    temp.println(tmp);
    temp.println(N);
    temp.close();
  }
  if (ch!=null) {
    CH=ch;
    ch=null;
    xml1= loadXML("res/rif.xml");
    child=xml1.getChildren(CH);
    //rectpdate();
    for (int i=0; i<child.length; i++)  
    {
      OBJ[i]= child[i].getString("obj");
      OBJECTS.addItem(OBJ[i], i+1);
    }
    //OBJECTS.clear();
    //----------------------------
  }
  //--------------------------------- 
  Select();
}
//--------------------------------------    
void TI() {
  if (OB!=null) {
    img=loadImage(IMG);
    if (img!=null) {
      float w, h;
      w=img.width;
      h=img.height;
      fill(250);
      rect(WW/2, WH/12*5, WW/2, WH/12*5);
      if (w>h) {
        if (w/h>=2.8) {
          img.resize(WW/2, WH/3);
          image(img, WW/2, WH/12*5);
        } else {
          img.resize(WW/2, WH/12*5);
          image(img, WW/2, WH/12*5);
        }
      }
      if (w<h) {
        img.resize(WW/3, WH/12*5);
        image(img, WW/8*5, WH/12*5);
      }
      fill(c_);
    }
  } else {
    fill(0);
    rect(WW/2, WH/12*5, WW/2, WH/2);
  }
}
//-----------------------------------
void rectpdate() {
  noStroke();
  fill(c_);
  rect(9, 14, 20, 20);
  fill(c_t);
  textFont(f,15);
  text(T_L, 10, 15);
    OBJECTS.getCaptionLabel().set(OBJ[B]);
  if (!OBJECTS.isOpen()) {
    OBJECTS.setValue(0.0);
    stroke(255);
    fill(c_);
    rect(249, 30, 201, 230);
  }
  if (test==false) {
    fill(c_);
    rect(WW/2, 0, WW/2, WH/2);
    rect(WW/2, WH/12*5, WW/2, WH/2);
  }
  if (IN!=null) {
    fill(c_);
    rect(WW/2+1, 0, WW/2-1, (WH/12*5)-1);
  } else {
    TEXT_INFO.setText("");
    fill(c_);
    rect(WW/2+1, 0, WW/2-1, (WH/12*5)-1);
  }
  test=true;
  if (ch!=null)
  data();
}
//----------------------------------
void data() {
  xml3= loadXML(Lang);
  child=xml1.getChildren(CH);
  SUBJ=child[B].getString("obj");
  r=child[B].getString("ref");
  INFO_T=child[B].getString("ref2");
  N=child[B].getInt("N");
  fill(c_);
  rect(0, WH/12*5, WW/2, WH/12*5);
  rect(WW/2, WH/12*5, WW/2, WH/12*5);
  fill(c_t);
  xml2= loadXML(r);
  if (T_L=="DE") s=11;
  child3=xml3.getChildren("b");
  child2=xml2.getChildren("b");
  for (int z=0; z<child2.length; z++) {
    int id=child2[z].getInt("id");
    loc=child3[id].getContent();
    textFont(f, s);
    text(loc, 20, (WH/12*5)+(80+20*z));
    err=child2[z].getContent();
    text(err, 200, (WH/12*5)+(80+20*z));
  }
  s=15;
  textFont(f, 18);
  text(OBJ[B], 50, (WH/12*5)+20);
  //BID=0;
  OB= child[B].getString("sh");
  IMG=OB+".png";
  OB=OB+".obj";
  if (INFO_T!=null) {
    xml=loadXML(INFO_T);
    XML child[]=xml.getChildren(T_L);
    //println(child.length);
    for (int i=0; i<child.length; i++) {
      IN=child[i].getContent();
    }
    TEXT_INFO.setText(IN);
    INFO_T=null;
  }
}
//-----------------------------------
void Select() {
  switch(ck) {
  case 5:
    noStroke();
    fill(c_);
    rect(WW/2-30, (WH/12*5)-30, 30, 30);
    fill(c_t);
    text("In", WW/2-25, (WH/12*5)-15); 
    c1.on();
    c2.off();
    break;
  case 6:
    noStroke();
    fill(c_);
    rect(WW/2-30, (WH/12*5)-30, 30, 30);
    fill(c_t);
    text("mm", WW/2-25, (WH/12*5)-15); 
    c1.off();
    c2.on();
    break;
  }
  if (BID==1&&ck==5) {
    test=false;
    OBJECTS.setOpen(false);
    OBJECTS.clear().addItem("---", 0);
    ch="PRS_I"; 
    BID=0;
    ck=0;
  }
  if (BID==1&&ck==6) {
    test=false;
    OBJECTS.setOpen(false);
    OBJECTS.clear().addItem("---", 0);
    ch="PRS_M"; 
    BID=0;
    ck=0;
  }
  if (BID==2&&ck==5) {
    test=false;
    OBJECTS.setOpen(false);
    OBJECTS.clear().addItem("---", 0);
    ch="CRS_I"; 
    BID=0;
    ck=0;
  }
  if (BID==2&&ck==6) {
    test=false;
    OBJECTS.setOpen(false);
    OBJECTS.clear().addItem("---", 0);
    ch="CRS_M"; 
    BID=0;
    ck=0;
  }
  if (BID==3) {
    test=false;
    OBJECTS.setOpen(false);
    OBJECTS.clear().addItem("---", 0);
    ch="BC"; 
    BID=0;
  }
  if (BID==4) {
    BID=0;
    launch(sketchPath("")+"starter.bat");
    D.update(false);
  }
  if (BID==21) {
    BID=0;
    IN="";
    String info[] = loadStrings("res/info");
    for (int i=0; i<info.length; i++) {
      IN+="\n"+info[i];
    }
    G4P.showMessage(this, IN, "INFO", G4P.INFO_MESSAGE);
  }
  if (BID==22) {
    BID=0;
    win = GWindow.getWindow(this, "OPTIONS", WW/2, WH/2, 400, 400, JAVA2D);
    win.addDrawHandler(this, "DH");
    win.addData(new MyWinData());
    win.setActionOnClose(G4P.CLOSE_WINDOW);
  }
}
