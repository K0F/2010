import processing.core.*; 
import processing.xml.*; 

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

public class neuroPatterns1 extends PApplet {

int velikost = 300;
int sc = 1;



int shiftx = 2;
int shifty = 0;

boolean matix[][];

int c1 = color(255,128,0);
int c2 = color(0);

public void setup() {
  matix = new boolean[velikost*2][velikost];
  size(600,300,P2D);

  frameRate(60);

  for(int y = 0;y<matix[0].length;y++) {

    for(int x = 0;x<matix[0].length;x++) {
      matix[x][y] = (random(20)>10) ? true : false;
    }
  }
  noStroke();
  noSmooth();
}

public void draw() {
   c1 = color(255);
  shiftx = (int)((noise(-frameCount/33.12f)-0.5f)*width);
  shifty = (int)((noise(frameCount/300.0f)-0.5f)*height);
  for(int y = 0;y<matix[0].length;y++) {

    for(int x = 0;x<matix.length/2;x++) {
      fill((matix[x][y])?c1:c2,80);
      rect(x*sc,y*sc,sc,sc);
    }

    for(int x = matix.length/2;x<matix.length;x++) {
      fill((matix[matix.length-x][y])?c1:c2,80);
      rect(x*sc,y*sc,sc,sc);
    }
  }

  pushStyle();
  noFill();
  strokeWeight(5);
  stroke(0);
  rect(0,0,width,height);
  popStyle();  

  randomize((int)(noise(frameCount/230.2f)*20));
}


int cnt = 0;
public void randomize(int kolik) {
  for(int y = 0;y<matix[0].length;y++) {
    for(int x = 0;x<matix[0].length;x++) {


      if((random(1000))<kolik) {
        matix[x][y] = !matix[x][y];
      }
      else if(matix[(x+width-shiftx)%(width/sc-1)][y]) {
        matix[x][y] = matix[(x+width+2)%(width/sc-1)][y];
      }
      else {
        matix[x][y] = matix[x][(y+height-shifty)%(height/sc-1)];
      }
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "neuroPatterns1" });
  }
}
