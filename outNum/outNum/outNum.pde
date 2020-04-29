import processing.net.*;
String num;
Client c;
PFont digit;

void setup() {
  fullScreen();
  c = new Client(this, "10.0.0.54", 12345);
  frameRate(50);
  digit = createFont("DS-DIGI.TTF",32);
  textFont(digit);
  textAlign(RIGHT, CENTER);
  textSize(512);
}

void draw() {
  if (c.available()>0) {
    num = c.readString();
    num = num.substring(0, num.indexOf("\n"));
  }
  background(0);
  fill(255,0,0);
  //text("00000", width, height/2);
  if (num =="") {
    text(0, width, height/2);
  } else {
    text(num, width, height/2);
  }
}
