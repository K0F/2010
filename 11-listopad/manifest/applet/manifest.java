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

public class manifest extends PApplet {



String s = "Software  Is  A  Process,  Not  A  Product.";
String s2 = "kof";
float uhly[];

int siz = 24;

PFont f,f2;

public void setup() {
  size(640,120);
  
  f = createFont("Monospace",siz);
  f2 = createFont("Monospace",siz/2);
 
  fill(0);

  uhly = new float[s.length()];

  for(int i = 0;i<uhly.length;i++) {
     uhly[i] = -noise(i+frameCount/100.0f)*360;
  }
}


public void draw() {
  background(255);


 textFont(f);
  pushMatrix();
  translate(20,20);
  for(int i = 0;i<s.length();i++) {
    pushMatrix();
    translate(i*map(siz,0,10,0,6),20);
    rotate(radians(uhly[i]));
    uhly[i] = -noise(i+frameCount/40.0f)*360;
    text(s.charAt(i),(map(siz,0,30,0,-11.4f)),(map(siz,0,30,0,8.2f)));
    popMatrix();
  } 



 textFont(f2);
  popMatrix();

  pushMatrix();
  
  for(int i = 0;i<s2.length();i++) {
    pushMatrix();
    translate(width-100+i*map(siz,0,10,0,6/2),height-20);
    rotate(radians(uhly[i]));
    uhly[i*3] = -noise(i+frameCount/100.0f)*360;
    text(s2.charAt(i),(map(siz,0,30,0,-11.4f/2)),(map(siz,0,30,0,8.2f/2)));
    popMatrix();
  }

  popMatrix();
}

public void mousePressed(){
  link("http://freesoftwareart.org/readme100/manifesto/", "_new");
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "manifest" });
  }
}
