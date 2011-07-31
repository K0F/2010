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

public class SoundViz1 extends PApplet {

//import processing.opengl.*;
//import javax.media.opengl.GL;



//PGraphicsOpenGL pgl; //need to use this to stop screen tearing
//GL gl;

Minim minim;
AudioInput in;

float sc = 1.5f;

public void setup()
{
  size(640,300, P2D);

  frameRate(50);

 // pgl = (PGraphicsOpenGL) g; //processing graphics object
 // gl = pgl.beginGL(); //begin opengl
 // gl.setSwapInterval(1); //set vertical sync on
 // pgl.endGL(); //end opengl

  minim = new Minim(this);
  minim.debugOn();

  noCursor();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, (int)(width*sc));
  noSmooth();
}

int start = 0;

public void draw()
{
 // background(0);
  // stroke(255);


  float trsh = 0.012f;
  noStroke();

  //start = 0;

  for(int i = 0; i < 200 ; i++)
  {


    if(in.right.get(i)<0.01f) {
      if(in.right.get(i+1)<0.01f) {

        for(int q = 2;q<100;q++) {
          if(abs(in.right.get(i+q)-0)>trsh) {
            start = i;
            break;
          }
        }
        break;
      }
    }
  }

  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    stroke(map(in.right.get(PApplet.parseInt(i)),0.01f,.04f,0,255),200);
    pushMatrix();
    translate(-start,0);
    line(i,0,i,height);
    popMatrix();
    //stroke(2550*in.right.get(int(i)),120);
    //line(0,map(i,0,in.bufferSize(),start,height), width,map(i,0,in.bufferSize(),start,height));
    //in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    //  stroke(255,in.left.get(i)*5000);
    // line(0,map(i,0,width,0,height),width,map(i,0,width,0,height));
    //line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
}


public void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

/*void keyPressed(){
 save("screen.png"); 
  
}*/
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "SoundViz1" });
  }
}
