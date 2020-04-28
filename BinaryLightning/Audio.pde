void audioSetup() {
  println("ye? " );
  sound = new AudioContext();
  peaks = new SamplePlayer[6];
  bGBuzz = new SamplePlayer(sound, SampleManager.sample(dataPath("")+"/ON.wav"));
  bGBuzz.setLoopType(SamplePlayer.LoopType.LOOP_ALTERNATING);
  bGBuzz.setKillOnEnd(false);
  
  //g1 for peaking events
  g1 = new Gain(sound, 1, 0.2);
  //g2 for the background buzzing
  g2 = new Gain(sound, 1, 0.2);
  g2.addInput(bGBuzz);
  
  //peaks
  for (int n = 0; n<6; n++) {
    //println(dataPath("")+"/Peak" + (n+1) + ".wav");
    peaks[n] = new SamplePlayer(sound, SampleManager.sample(dataPath("")+"/Peak" + (n+1) + ".wav"));
    peaks[n].setKillOnEnd(false);
    peaks[n].setToEnd();
    g1.addInput(peaks[n]);
  }
  sound.out.addInput(g1);
  sound.out.addInput(g2);
  sound.start();
  bGBuzz.start();
}
void changeSound() {
  
  int i = int(random(6));
  
  peaks[i].setToLoopStart();
  peaks[i].start();
}
void buzzSwitch(boolean c){
  if(c){
    bGBuzz.pause(false); 
  } else if(c == false){
    bGBuzz.pause(true); 
  }
}
