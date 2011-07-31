import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class zednar extends PApplet {



AudioPlayer player;
Minim minim;



PImage pozadi,ruce,meridlo,buh;
float delta;

public void setup() {
  size(254,330);
  
  pozadi = loadImage("200804182209_god_geometry.png");

  


  minim = new Minim(this);

  ruce = loadImage("ruce.png");
  meridlo = loadImage("meridlo.png");
  buh = loadImage("bozidilo.png");

  delta = map(width - 50,width-50,width-40,0.8f,0.7f)-0.57f;

  player = minim.loadFile("measureDeMeasure.mp3", 2048);
  // play the file
  player.loop();

  smooth();
}


public void draw() {
  background(pozadi);

  pushMatrix();
  translate(174,240);
  rotate(radians(frameCount));
  image(buh,-buh.width/2,-buh.height/2);
  popMatrix();

  loadPixels();
  float it = 0;
  int wh = 0;
  int y = 235;
  for(int i = width-50;i<width-40;i++) {

    if(brightness(pixels[y*width+i])>it) {
      it = brightness(pixels[y*width+i]);
      wh = i;
    }

    if(i%2==0)
      y--;
  }

  delta += (wh-delta)/3.0f;

  image(ruce,0,0);

  pushMatrix();
  translate(180,147);
  rotate(map(delta,width-50,width-40,0.8f,0.7f)-0.57f);
  image(meridlo,-44,-3);
  popMatrix();
}


public void stop()
{
  // always close Minim audio classes when you are done with them
  player.close();
  minim.stop();

  super.stop();
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "zednar" });
  }
}
