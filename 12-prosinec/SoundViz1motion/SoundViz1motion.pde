import processing.opengl.*;
import javax.media.opengl.GL;
import ddf.minim.*;
import sms.*;


PGraphicsOpenGL pgl; //need to use this to stop screen tearing
GL gl;

Minim minim;
AudioInput in;


float sc = 1.5;
float rovno = 0;
int[] vals;

void setup()
{
  size(screen.width, screen.height, OPENGL);
// size(720,576, OPENGL);

  frameRate(50);

  pgl = (PGraphicsOpenGL) g; //processing graphics object
  gl = pgl.beginGL(); //begin opengl
  gl.setSwapInterval(1); //set vertical sync on
  pgl.endGL(); //end opengl

  minim = new Minim(this);
  minim.debugOn();

  noCursor();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, (int)(width*sc));
  smooth();
}

int start = 0;

void draw()
{
 // background(0);
  // stroke(255);


  float trsh = 0.012;
  noStroke();

  //start = 0;

  for(int i = 0; i < 200 ; i++)
  {


    if(in.right.get(i)<0.01) {
      if(in.right.get(i+1)<0.01) {

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
  
   vals = Unimotion.getSMSArray();
 // println(vals[0] + " " + vals[1] + " " + vals[2]);

 pushMatrix();
 translate(width/2,height/2);
 
 rotate(radians(map(vals[0]+rovno,255,-255,90,-90)));
// println(vals[0]);
 
  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    stroke(map(in.right.get(int(i)),0.01,.04,0,255),map(in.right.get(int(i)),0.01,.04,0,255),0);
    pushMatrix();
    translate(-start,0);
    line(i-width/1.5,-height,i-width/2,height+height/2);
    //line(0,i,width,i);
    popMatrix();
    //stroke(2550*in.right.get(int(i)),120);
    //line(0,map(i,0,in.bufferSize(),start,height), width,map(i,0,in.bufferSize(),start,height));
    //in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    //  stroke(255,in.left.get(i)*5000);
    // line(0,map(i,0,width,0,height),width,map(i,0,width,0,height));
    //line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  
  popMatrix();
}


void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  minim.stop();

  super.stop();
}

void keyPressed(){
 rovno = -vals[0]; 
}

