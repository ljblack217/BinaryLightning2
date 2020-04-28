class adder {
  boolean cIn;
  boolean cOut;
  boolean out;
  float posX;
  float posY;
  xor gXor1;
  xor gXor2;
  and gAnd1;
  and gAnd2;
  or gOr1;
  adder(float x, float y) {
    cOut = false;
    out = false;
    posX = x;
    posY = y;
    gXor1 = new xor(posX-40, posY-20);
    gXor2 = new xor(posX+7, posY-20);
    gAnd1 = new and(posX-40, posY+20, false);
    gAnd2 = new and(posX, posY, false);
    gOr1 = new or(posX+40, posY+20);
  }
  void drawAdder(float in1X, float in1Y, int bit) {
    textSize(12);
    stroke(255);
    noFill();
    //in 1 to xor1 and and1
    if (textOn)text("in" + (bit+1), in1X, in1Y);
    if (bInNum[bit]== true) {
      float inbx;
      float inby;
      changeSound();
      inbx = gXor1.x/2;
      inby = (gXor1.y-in1Y)/2;
      line(in1X, in1Y, gXor1.x, gXor1.y);
      beginShape();
      curveVertex(in1X, in1Y);
      curveVertex(inbx, in1Y+inby);
      curveVertex(gAnd1.x, gAnd1.y);
      curveVertex(gAnd1.x, gAnd1.y);
      endShape();

      //curve(inbx,gXor1.y,inbx, in1Y+inby, gAnd1.x, gAnd1.y,gAnd1.x,gAnd1.y);

      //line(in1X, in1Y, gAnd1.x, gAnd1.y);
      //curve(in1X, in1Y-inby, in1X, in1Y, gAnd1.x, gAnd1.y, gAnd1.x, gAnd1.y);
    }
    //flip flop out to xor1 and and1
    //if (flipFlops[bit].out == true) {
    //  stroke(0, shadowLvl);

    //  for (float i = 1.5; i<shadowSize; i++) {
    //    strokeWeight(i);
    //    bezier(flipFlops[bit].gAnd3.x, flipFlops[bit].gAnd3.y, 
    //      flipFlops[bit].gAnd3.x+100, flipFlops[bit].gAnd3.y-20, 
    //      gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //      gXor1.x, flipFlops[bit].gAnd3.y-20);

    //    bezier(gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //      gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //      gXor1.x-50, gXor1.y-10, 
    //      gXor1.x, gXor1.y);

    //    bezier(gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //      gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //      gXor1.x-100, gXor1.y-15, 
    //      gAnd1.x, gAnd1.y);
    //  }

    //  strokeWeight(1.5);
    //  stroke(255);
    //  bezier(flipFlops[bit].gAnd3.x, flipFlops[bit].gAnd3.y, 
    //    flipFlops[bit].gAnd3.x+100, flipFlops[bit].gAnd3.y-20, 
    //    gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //    gXor1.x, flipFlops[bit].gAnd3.y-20);

    //  bezier(gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //    gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //    gXor1.x-50, gXor1.y-10, 
    //    gXor1.x, gXor1.y);

    //  bezier(gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //    gXor1.x, flipFlops[bit].gAnd3.y-20, 
    //    gXor1.x-100, gXor1.y-15, 
    //    gAnd1.x, gAnd1.y);
    //}

    //cIn to xor2 and and2

    if (bit>0 && adders[bit-1].gOr1.out1 == true) {
      //stroke(0, shadowLvl);

      //for (float i = 1.5; i<shadowSize; i++) {
      //  strokeWeight(i);
      //  bezier(adders[bit-1].gOr1.x, adders[bit-1].gOr1.y, 
      //    ((flipFlops[bit].posX-adders[bit-1].gOr1.x)/5)+adders[bit-1].gOr1.x, adders[bit-1].gOr1.y, 
      //    (gAnd2.x/3)*2, (gAnd2.y - gXor2.y)/2+gXor2.y, 
      //    (gXor2.x - gXor1.x)/3 + gXor1.x, (gAnd1.y - gXor2.y)/2+gXor2.y);
      //  bezier((gXor2.x - gXor1.x)/3 + gXor1.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
      //    gXor2.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
      //    (gXor2.x-gXor1.x)/2+gXor1.x, gXor2.y, 
      //    gXor2.x, gXor2.y);
      //  bezier((gXor2.x - gXor1.x)/3 + gXor1.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
      //    gAnd2.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
      //    (gXor2.x - gXor1.x)/3 + gXor1.x, gAnd2.y, 
      //    gAnd2.x, gAnd2.y);
      //}
      stroke(255);
      strokeWeight(1.5);
      bezier(adders[bit-1].gOr1.x, adders[bit-1].gOr1.y, 
        ((flipFlops[bit].posX-adders[bit-1].gOr1.x)/5)+adders[bit-1].gOr1.x, adders[bit-1].gOr1.y, 
        (gAnd2.x/3)*2, (gAnd2.y - gXor2.y)/2+gXor2.y, 
        (gXor2.x - gXor1.x)/3 + gXor1.x, (gAnd1.y - gXor2.y)/2+gXor2.y);
      bezier((gXor2.x - gXor1.x)/3 + gXor1.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
        gXor2.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
        (gXor2.x-gXor1.x)/2+gXor1.x, gXor2.y, 
        gXor2.x, gXor2.y);
      bezier((gXor2.x - gXor1.x)/3 + gXor1.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
        gAnd2.x, (gAnd1.y - gXor2.y)/2+gXor2.y, 
        (gXor2.x - gXor1.x)/3 + gXor1.x, gAnd2.y, 
        gAnd2.x, gAnd2.y);
    }

    //xor1 to zor2 and and2
    if (textOn) {
      text("xor1" + bit, gXor1.x, gXor1.y);
      text("xor2" + bit, gXor2.x, gXor2.y);
    }

    if (gXor1.out1 == true) {
      
      stroke(255);
      strokeWeight(1.5);
      line(gXor1.x, gXor1.y, gXor2.x, gXor2.y);

      curve(gXor1.x - ((gAnd2.x - gXor1.x)*3), gXor1.y, gXor1.x, gXor1.y, gAnd2.x, gAnd2.y, gAnd2.x + ((gAnd2.x - gXor1.x)/4), gAnd2.y );
    }

    //and1 to or1
    if (textOn) {
      text("and1" + bit, gAnd1.x, gAnd1.y);
      text("or1" + bit, gOr1.x, gOr1.y);
    }
    if (gAnd1.out1 == true) {
      changeSound();
      line(gAnd1.x, gAnd1.y, gOr1.x, gOr1.y);
      //curve(gAnd1.x, gAnd1.y, gAnd1.x, gAnd1.y, gOr1.x, gOr1.y, gOr1.x, gOr1.y );
    }
    //and2 to or1
    if (textOn) text("and2" + bit, gAnd2.x, gAnd2.y);
    if (gAnd2.out1 == true) {
      changeSound();
      line(gAnd2.x, gAnd2.y, gOr1.x, gOr1.y);
      //curve(gAnd1.x, gAnd1.y, gAnd1.x, gAnd1.y, gOr1.x, gOr1.y, gOr1.x, gOr1.y );
    }
  }
  void calc(int bit, boolean in) {
    //out calcs
    gXor1.calc();
    gXor2.calc();
    out = gXor2.out1;
    gAnd1.calc();
    gAnd2.calc();
    gOr1.calc();
    cOut = gOr1.out1;


    //in 1 to xor1 and and1
    gXor1.in1 = in;
    gAnd1.in1 = in;
    //flip flop out to xor1 and and1
    gXor1.in2 = flipFlops[bit].out;
    gAnd1.in2 = flipFlops[bit].out;
    //cIn to xor2 and and2
    if (bit>0) {
      gXor2.in1 = adders[bit-1].cOut;
      gAnd2.in1 = adders[bit-1].cOut;
    }
    //xor1 to zor2 and and2
    gXor2.in2 = gXor1.out1;
    gAnd2.in2 = gXor1.out1;
    //and1 to or1
    gOr1.in1 = gAnd1.out1;
    //and2 to or1
    gOr1.in2 = gAnd2.out1;
  }
}
