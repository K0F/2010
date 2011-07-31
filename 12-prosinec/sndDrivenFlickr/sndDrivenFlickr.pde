import processing.opengl.*;
import javax.media.opengl.GL;
import ddf.minim.*;

PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;



Minim minim;
AudioInput in;

int fr = 80;
float trsh = 0.01;

void setup()
{
  size(640,300, OPENGL);

  frameRate(fr);

  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl

  minim = new Minim(this);
  minim.debugOn();


  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, fr);
  noSmooth();
}



void draw() {

  trsh+=(in.right.get(frameCount%fr)/1.01-trsh)/1000.0;

  if(in.right.get(frameCount%fr)>trsh) {
    background(255);

    /*
    for(int i = 0; i < in.bufferSize() - 1; i++)
     {
     stroke(0,map(in.right.get(int(i)),0.01,.04,0,255));
     pushMatrix();
     //  translate(-start,0);
     line(i,0,i,height);
     popMatrix();
     }*/
  }
  else {
    background(0) ;
    /*
  for(int i = 0; i < in.bufferSize() - 1; i++)
     {
     stroke(255,map(in.right.get(int(i)),0.01,.04,0,255));
     pushMatrix();
     // translate(-start,0);
     line(i,0,i,height);
     popMatrix();
     }*/
  }
}



void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

