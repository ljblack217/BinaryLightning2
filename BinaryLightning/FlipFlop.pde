class flipFlop {
  boolean out; 
  boolean calc8;
  and gAnd1;
  and gAnd2;
  and gAnd3;
  and gAnd4;
  float posX;
  float posY;
  flipFlop(float x, float y) {
    out = false;
    posX = x;
    posY = y;
    gAnd1 = new and(posX-width/27, posY-height/36, true);
    gAnd1.out1 = false;
    gAnd2 = new and(posX-width/27, posY+height/36, true);
    gAnd2.out1 = false;
    gAnd3 = new and(posX+width/21, posY-height/36, true);
    gAnd3.out1 = false;
    gAnd4 = new and(posX+width/21, posY+height/36, true);
    gAnd4.out1 = true;
  }

  void drawFlipFlop(int bit, float outBitX, float outBitY) {
    //in1 to and1 and and2
    textSize(12);
    stroke(255);
    noFill();
    if (adders[bit].gXor2.out1 == true) {
      line(adders[bit].gXor2.x, adders[bit].gXor2.y, gAnd2.x - (gAnd4.x - gAnd2.x)/2, (gAnd2.y - gAnd1.y)/2 + gAnd1.y);
      //line(adders[bit].gXor2.x, adders[bit].gXor2.y, gAnd1.x, gAnd1.y);
      bezier(gAnd2.x - (gAnd4.x - gAnd2.x)/2, (gAnd2.y - gAnd1.y)/2 + gAnd1.y, 
        gAnd2.x, (gAnd2.y - gAnd1.y)/2 + gAnd1.y, 
        gAnd2.x - (gAnd4.x - gAnd2.x)/2, gAnd1.y, 
        gAnd1.x, gAnd1.y);
      //line(adders[bit].gXor2.x, adders[bit].gXor2.y, gAnd2.x, gAnd2.y);
      bezier(gAnd2.x - (gAnd4.x - gAnd2.x)/2, (gAnd2.y - gAnd1.y)/2 + gAnd1.y, 
        gAnd2.x, (gAnd2.y - gAnd1.y)/2 + gAnd1.y, 
        gAnd2.x - (gAnd4.x - gAnd2.x)/2, gAnd2.y, 
        gAnd2.x, gAnd2.y);
    }

    //clk to and 1 and and2
    //if (clock) {
    //  line(clockX, clockY, gAnd1.x, gAnd1.y);
    //  line(clockX, clockY, gAnd2.x, gAnd2.y);
    //}

    //and1 to and3
    if (textOn) text("fAnd1 "+bit, gAnd1.x, gAnd1.y);
    if (gAnd1.out1 == true) {
      line(gAnd1.x, gAnd1.y, gAnd3.x, gAnd3.y);
    }
    //and2 to and4
    if (textOn) text("fAnd2 " +bit, gAnd2.x, gAnd2.y);
    if (gAnd2.out1 == true) {
      line(gAnd2.x, gAnd2.y, gAnd4.x, gAnd4.y);
    }
    //and3 to out and or2 and and1 and adder.xor 1 and Out
    if (textOn) text("fand3 "+bit, gAnd3.x, gAnd3.y);
    if (gAnd3.out1 == true) {
      //line(gAnd3.x, gAnd3.y, gAnd4.x, gAnd4.y);
      bezier(gAnd3.x, gAnd3.y, 
        gAnd3.x+40, gAnd3.y+10, 
        gAnd4.x-40, gAnd4.y-10, 
        gAnd4.x, gAnd4.y);

      //line(gAnd3.x, gAnd3.y, gAnd1.x, gAnd1.y);
      bezier(gAnd3.x, gAnd3.y, 
        gAnd3.x+50, gAnd3.y-10, 
        gAnd1.x -50, gAnd1.y-10, 
        gAnd1.x, gAnd1.y);
      line(gAnd3.x, gAnd3.y, outBitX, outBitY);

      if (flipFlops[bit].out == true) {
        stroke(0, shadowLvl);

        for (float i = 1.5; i<shadowSize; i++) {
          strokeWeight(i);
          bezier(gAnd3.x, gAnd3.y, 
            gAnd3.x+100, gAnd3.y-20, 
            adders[bit].gXor1.x, flipFlops[bit].gAnd3.y-20, 
            adders[bit].gXor1.x, flipFlops[bit].gAnd3.y-20);

          bezier(adders[bit].gXor1.x, gAnd3.y-20, 
            adders[bit].gXor1.x, gAnd3.y-20, 
            adders[bit].gXor1.x-50, adders[bit].gXor1.y-10, 
            adders[bit].gXor1.x, adders[bit].gXor1.y);

          bezier(adders[bit].gXor1.x, gAnd3.y-20, 
            adders[bit].gXor1.x, gAnd3.y-20, 
            adders[bit].gXor1.x-100, adders[bit].gXor1.y-15, 
            gAnd1.x, gAnd1.y);
        }

        strokeWeight(1.5);
        stroke(255);
        bezier(flipFlops[bit].gAnd3.x, gAnd3.y, 
          flipFlops[bit].gAnd3.x+100, gAnd3.y-20, 
          adders[bit].gXor1.x, gAnd3.y-20, 
          adders[bit].gXor1.x, gAnd3.y-20);

        bezier(adders[bit].gXor1.x, gAnd3.y-20, 
          adders[bit].gXor1.x, gAnd3.y-20, 
          adders[bit].gXor1.x-50, adders[bit].gXor1.y-10, 
          adders[bit].gXor1.x, adders[bit].gXor1.y);

        bezier(adders[bit].gXor1.x, gAnd3.y-20, 
          adders[bit].gXor1.x, gAnd3.y-20, 
          adders[bit].gXor1.x-100, adders[bit].gXor1.y-15, 
          gAnd1.x, gAnd1.y);
      }
    }
    // gAnd4 to and3 and and2
    if (textOn) text("fand4 "+bit, gAnd4.x, gAnd4.y);
    if (gAnd4.out1 == true) {
      //line(gAnd4.x, gAnd4.y, gAnd3.x, gAnd3.y);
      bezier(gAnd4.x, gAnd4.y, 
        gAnd4.x+40, gAnd4.y-10, 
        gAnd3.x-40, gAnd3.y+10, 
        gAnd3.x, gAnd3.y);
      //line(gAnd4.x, gAnd4.y, gAnd2.x, gAnd2.y);
      bezier(gAnd4.x, gAnd4.y, 
        gAnd4.x+50, gAnd4.y+10, 
        gAnd2.x-50, gAnd2.y+10, 
        gAnd2.x, gAnd2.y);
    }
  }
  void calc(int bit) {

    //in1 to and1 and and2
    gAnd1.in1 = adders[bit].gXor2.out1;
    gAnd1.in2 = clock;
    gAnd1.calc();

    boolean inflip;
    if (adders[bit].gXor2.out1) {
      inflip = false;
    } else {
      inflip = true;
    }
    gAnd2.in1 = inflip;

    //clk to and 1 and and2
    gAnd2.in2 = clock;
    gAnd2.calc();

    //and1 to or1
    gAnd3.in1 = gAnd1.out1;
    gAnd3.in2 = gAnd4.out1;
    gAnd3.calc();
    //and2 to or2
    gAnd4.in1 = gAnd1.out1;


    //or1 to out and or2 and and1 and adder.xor 1 and Out
    out = gAnd3.out1;
    gAnd4.in2 = gAnd3.out1;
    //outcalcs



    gAnd4.calc();


    out = gAnd3.out1;
  }
}
