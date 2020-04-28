import beads.*;
import java.util.Arrays;


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
float shadowSize = 6;
float shadowLvl = 20;

AudioContext sound;
Noise test;
Gain g1;
Gain g2;
SamplePlayer[] peaks;
SamplePlayer bGBuzz;

void setup() {
  consolas = createFont("Consolas.ttf", 32);
  textFont(consolas);
  bInNum = new boolean[bitSize];
  bOutNum = new boolean[bitSize];
  background(0);
  size(1280, 720);
  frameRate(50);
  adders = new adder[bitSize];
  flipFlops = new flipFlop[bitSize];
  for (int i = 0; i < bitSize && i < 8; i++) { 
    adders[i] = new adder(256, 80 + 80*i - 10);
    //println(sizeY/(bitSize+2)*i);
    flipFlops[i] = new flipFlop(768, 80 + 80*i - 10);
  }
  if (bitSize>8) {
    for (int i = 8; i < bitSize; i++) {
      adders[i] = new adder(512, 80 + 80*(i-8)+10);
      flipFlops[i] = new flipFlop(1024, 80 + 80*(i-8)+10);
      //println(sizeY/(bitSize+2)*i);
    }
  }
  audioSetup();
  
  
}

void draw() {
  stroke(0);
  fill(0,40);
  rect(0,0,width,height);
  stroke(255);
  strokeWeight(1.5);
  //drawing visuals
  
  if (clockCount>0) {
    clockCount --;
  } else if (bClockCount) {
    bInNum = new boolean[bitSize];
  }
  
  drawNumber(50, 20, sInNum);
  for (int i = 0; i < bitSize; i++) {
    if (clock) {
      line(clockX, clockY, flipFlops[i].gAnd1.x, flipFlops[i].gAnd1.y);
      line(clockX, clockY, flipFlops[i].gAnd2.x, flipFlops[i].gAnd2.y);
    }
    adders[i].drawAdder(0, 240 + 15*i, i);
    flipFlops[i].drawFlipFlop(i, sizeX, 240 + 15*i);
    
    
  }
  //calculations
  for (int i = 0; i < bitSize; i++) {
    adders[i].calc(i, bInNum[i]);
    flipFlops[i].calc(i);
    bOutNum[i] = flipFlops[i].gAnd3.out1;
  }
  iOutNum = i16ToNum(bOutNum);
  drawNumber(width-150, 20, ""+iOutNum);
  
}

void keyPressed() {
  if(key == 'w'|| key == 'a' || key == 's'|| key == 'd'){
    
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
  text(in, x, y);
}
