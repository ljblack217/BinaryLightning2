 import beads.*;
import java.util.Arrays;
import processing.net.*;

float sizeX = 1280;
float sizeY = 720;
int bitSize = 16;
adder[] adders;
flipFlop[] flipFlops;
String sInNum = "";
int iInNum;
int iOutNum;
boolean[] bInNum;
boolean[] bOutNum;
float clockX = 897.5;
float clockY = 0;
boolean clock = true;
boolean textOn;
int clockCount = 0;
boolean bClockCount = false;
PFont consolas;
PFont digit;
float shadowSize = 6;
float shadowLvl = 20;
int clearCount = 0;

AudioContext sound;
Noise test;
Gain g1;
Gain g2;
SamplePlayer[] peaks;
SamplePlayer bGBuzz;

Server out;
//Server serIn;


void setup() {
  consolas = createFont("Consolas.ttf", 32);
  digit = createFont("DS-DIGI.TTF", 32);
  textFont(consolas);
  bInNum = new boolean[bitSize];
  bOutNum = new boolean[bitSize];
  background(0);
  //size(1280, 720);
  fullScreen();
  frameRate(50);
  adders = new adder[bitSize];
  flipFlops = new flipFlop[bitSize];
  for (int i = 0; i < bitSize && i < 8; i++) { 
    adders[i] = new adder(width/5, height/9 + (height/9)*i - height/72);
    //println(sizeY/(bitSize+2)*i);
    flipFlops[i] = new flipFlop((width/5)*3, height/9 + (height/9)*i - height/72);
  }
  if (bitSize>8) {
    for (int i = 8; i < bitSize; i++) {
      adders[i] = new adder((width/5)*2, height/9 + height/9*(i-8)+height/72);
      flipFlops[i] = new flipFlop((width/5)*4, height/9 + height/9*(i-8)+height/72);
      //println(sizeY/(bitSize+2)*i);
    }
  }
  audioSetup();
  out = new Server(this, 12345);
  //serIn = new Server(this, 12346);
}

void draw() {
  stroke(0);
  fill(0, 50);
  rect(0, 0, width, height);
  stroke(255);
  strokeWeight(1.5);
  //drawing visuals
  if (clearCount>0) {
    clearCount--;
    //println(clearCount, clock);
  } else {
    clock = true;
  }
  if (clockCount>0) {
    clockCount --;
  } else if (bClockCount) {
    bInNum = new boolean[bitSize];
  }

  drawNumber(50, 20, sInNum);
  textFont(consolas);
  if (clock) {
    for (int g = 0; g< bitSize; g++) {
      stroke(97, 255, 252, 7);
      for (int w = 2; w<10; w = w+4) {
        strokeWeight(w);
        line(clockX, clockY, flipFlops[g].gAnd1.x, flipFlops[g].gAnd1.y);
        line(clockX, clockY, flipFlops[g].gAnd2.x, flipFlops[g].gAnd2.y);
      }
    }
    for (int c = 0; c<16; c++) {
      if (clock) {

        stroke(255);
        strokeWeight(1.5);
        line(clockX, clockY, flipFlops[c].gAnd1.x, flipFlops[c].gAnd1.y);
        line(clockX, clockY, flipFlops[c].gAnd2.x, flipFlops[c].gAnd2.y);
      }
    }
    
  }

  for (int i = 0; i < bitSize; i++) {
    buzzSwitch(clock);

    adders[i].drawAdderGlow(0, height/3 + height/48*i, i);
    flipFlops[i].drawFlipFlopGlow(i, width, height/3 + height/48*i);
    adders[i].drawAdder(0, height/3 + height/48*i, i);
    flipFlops[i].drawFlipFlop(i, width, height/3 + height/48*i);
  }
  //calculations
  for (int i = 0; i < bitSize; i++) {

    adders[i].calc(i, bInNum[i]);
    flipFlops[i].calc(i);
    bOutNum[i] = flipFlops[i].gAnd3.out1;
  }
  iOutNum = i16ToNum(bOutNum);
  //drawNumber(width-150, 20, ""+iOutNum);
  textFont(consolas);
  out.write(iOutNum+"\n");
}

void keyPressed() {
  if (key == 'w'|| key == 'a' || key == 's'|| key == 'd') {
  }
  if (key == '0'|| key =='1' ||key =='2' ||key =='3' ||key =='4'
    ||key == '5'|| key =='6' ||key =='7' ||key =='8' ||key =='9') {
    sInNum = sInNum + char(key);
    //println(sInNum);
  } else if (key == '+'||key == ENTER) {
    iInNum = int(sInNum);
    sInNum = "";
    bInNum = numTo16(iInNum);
    //println(bInNum);
    //for (int i = 0; i<16; i++) {
    //  if (bInNum[i]) {
    //    print(1);
    //  } else {
    //    print(0);
    //  }
    //}
    bClockCount = true;
    clockCount = 3;
  } else if (key == 'z') {
    if (textOn) {
      textOn = false;
    } else {
      textOn = true;
    }
  } else if (key == 'c') {
    if (clock) {
      clock = false;
    } else {
      clock = true;
    }
    buzzSwitch(clock);
  } else if (key == '.') {
    if (clock) {
      clock = false;
      clearCount = 100;
    }
  } else if (key == 's') {
    println(out.ip());
  }
}
//void mouseClicked(){
//  println("x= "+mouseX+ "  y= " + mouseY);
//}
boolean[] numTo16(int in) {
  //1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768 
  boolean[] processed = new boolean[16];
  ArrayList<Boolean> bitresults = new ArrayList<Boolean>(); 
  int div2 = in;
  //println(div2);
  if (div2<65536) {
    while (div2>=1) {
      //println(div2);
      if (div2 % 2 == 1) {
        bitresults.add(true);
        //println("true");
      } else {
        bitresults.add(false);
        //println("false");
      }
      div2 = div2/2;
    }
  } else {
    clock = false;
    clearCount = 100;
  }
  for (int i = 0; i<bitresults.size(); i++) {
    //println(i);
    processed[i] = bitresults.get(i);
  }

  return processed;
};

int i16ToNum(boolean[] inBits) {
  int result = 0;
  for (int i = 0; i<inBits.length; i++) {
    if (inBits[i]) {
      //println(result);
      result = result + int(pow(2, i));
      //println(i, result);
    }
  }

  return result;
};
void drawNumber(float x, float y, String in) {
  if (in == "") {
    in = "0";
  }
  textSize(24);
  fill(255, 0, 0);
  textFont(digit);
  text(in, x, y+20);
  //serIn.write(in+"\n");
}
