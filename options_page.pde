public void DH(PApplet win, GWinData D) {
  MyWinData D2 = (MyWinData)D;
  win.pushMatrix();
  win.background(0);
  win.fill(c_mil_b);
  win.rect(100, 0, 300, 80);
  win.fill(c_mil_bar);
  win.rect(200, 20, 100, 40);
  win.fill(c_mil_sand_b);
  win.rect(100, 80, 300, 80);
  win.fill(c_mil_sand_bar);
  win.rect(200, 90, 100, 40);
  win.fill(c_easy_b);
  win.rect(100, 160, 300, 80);
  win.fill(c_easy_bar);
  win.rect(200, 180, 100, 40);
  win.fill(c_std_b);
  win.rect(100, 240, 300, 80);
  win.fill(c_std_bar);
  win.rect(200, 260, 100, 40);
  win.fill(c_bw_b);
  win.rect(100, 320, 300, 80);
  win.fill(c_bw_bar);
  win.rect(200, 340, 100, 40);
  win.fill(255);
  win.rect(10, 350, 20, 20);
  win.fill(0);
  win.text("OK", 11, 360);
  win.popMatrix();
  cp52 = new ControlP5 (win);
  String LANGs[] ={"", "DE", "EN", "ES", "FR", "IT"};
  LANGUAGES = cp52.addListBox(T_L, 10, 10, 50, 125);
  LANGUAGES.setItems(LANGs)
    .setColorBackground(0)
    .setColorLabel(color(255))
    .setColorActive(color(250))
    .setColorForeground(color(100, 72, 0))
    .setColorValue(color(220))
    .setFont(f)
    .setBarHeight(23)
    .setItemHeight(20)
    .setOpen(false)
    ;
  LANGUAGES.onClick(new CallbackListener() { 
    public void controlEvent(CallbackEvent theEvent) {
      L_VAL = theEvent.getController().getValue();
      if (L_VAL>0) {
        ck=int (L_VAL)+6;
      }
    }
  }
  );
  switch(ck) {
  case 7:
    Lang ="loc/DE.xml";
    T_L="DE";
    LANGUAGES.setOpen(false);
    break;
  case 8:
    Lang ="loc/EN.xml";
    T_L="EN";
    LANGUAGES.setOpen(false);
    break;
  case 9:
    Lang ="loc/ES.xml";
    T_L="ES";
    LANGUAGES.setOpen(false);
    rectpdate();
    break;
  case 10:
    Lang ="loc/FR.xml";
    T_L="FR";
    LANGUAGES.setOpen(false);
    break;
  case 11:
    Lang ="loc/IT.xml";
    T_L="IT";
    LANGUAGES.setOpen(false);
    break;
  }
  LANGUAGES.getCaptionLabel().set(T_L);
  if (!LANGUAGES.isOpen()) {
    LANGUAGES.setValue(0.0);
    win.stroke(255);
    win.fill(0);
    win.rect(9, 30, 51, 105);
  }
  if ((win.mousePressed)&&(win.mouseX>100)) {
    if (win.mouseY>0&& win.mouseY<80) {
      win.fill(255);
      win.text("Olive + "+T_L, 10, 390);
      c_=c_mil_b; 
      c_bar=c_mil_bar;
      c_t=c_t_W;
    }
    if (win.mouseY>80&& win.mouseY<160) {
      win.fill(255);
      win.text("Sand + "+T_L, 10, 390);
      c_=c_mil_sand_b; 
      c_bar=c_mil_sand_bar;
      c_t=c_t_W;
    }
    if (win.mouseY>160&& win.mouseY<240) {
      win.fill(255);
      win.text("BG + "+T_L, 10, 390);
      c_=c_easy_b; 
      c_bar=c_easy_bar;
      c_t=c_t_W;
    }
    if (win.mouseY>240&& win.mouseY<320) {
      win.fill(255);
      win.text("Standard + "+T_L, 10, 390);
      c_=c_std_b; 
      c_bar=c_std_bar;
      c_t=c_t_W;
    }
    if (win.mouseY>320&& win.mouseY<400) {
      win.fill(255);
      win.text("White + "+T_L, 10, 390);
      c_=c_bw_b; 
      c_bar=c_bw_bar;
      c_t=c_t_B;
    }
  }
  if ((win.mousePressed)&&(win.mouseX>10&&win.mouseX<30)) {
    if (win.mouseY>350&&win.mouseY<370) setup2(win);
  }
  D2.WINC=0;
}
private void setup2(PApplet x) {
  x.fill(0);
  x.rect(10, 350, 20, 20);
  x.fill(255);
  x.text("OK", 11, 360);
  background(c_);
  LANGUAGES.setColorBackground(c_bar);
  OBJECTS.setColorBackground(c_bar);
  OBJECTS.setColorLabel(c_t);
  OBJECTS.setColorValue(c_t);
  TEXT_INFO.setColor(c_t);
  String tmpl= (T_L);
  String tmpL=str(ck);
  String tmpb= str(c_);
  String tmpbc= str(c_bar);
  String tmpt=str(c_t);
  temp=createWriter("res/_.PAR");
  temp.println(tmpl);
  temp.println(tmpL);
  temp.println(tmpb);
  temp.println(tmpbc);
  temp.println(tmpt);
  temp.close();
  ck=0;
  delay(100);
  win.close();
}
class MyWinData extends GWinData {
  int WINC, check;
}
