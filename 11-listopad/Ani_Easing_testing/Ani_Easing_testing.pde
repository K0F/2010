/**
 * shows how to set a specific easing (character of movment)
 * list of all easing styles below:
 *
 * Ani.LINEAR
 * Ani.QUAD_IN
 * Ani.QUAD_OUT
 * Ani.QUAD_IN_OUT
 * Ani.CUBIC_IN
 * Ani.CUBIC_IN_OUT
 * Ani.CUBIC_OUT
 * Ani.QUART_IN
 * Ani.QUART_OUT
 * Ani.QUART_IN_OUT
 * Ani.QUINT_IN
 * Ani.QUINT_OUT
 * Ani.QUINT_IN_OUT
 * Ani.SINE_IN
 * Ani.SINE_OUT
 * Ani.SINE_IN_OUT
 * Ani.CIRC_IN
 * Ani.CIRC_OUT
 * Ani.CIRC_IN_OUT
 * Ani.EXPO_IN
 * Ani.EXPO_OUT
 * Ani.EXPO_IN_OUT
 * Ani.BACK_IN
 * Ani.BACK_OUT
 * Ani.BACK_IN_OUT
 * Ani.BOUNCE_IN
 * Ani.BOUNCE_OUT
 * Ani.BOUNCE_IN_OUT
 * Ani.ELASTIC_IN
 * Ani.ELASTIC_OUT
 * Ani.ELASTIC_IN_OUT
 * 
 * MOUSE
 * click           : set end position of the animations and trigger new one
 */

import de.looksgood.ani.*;

float x = 256;
float y = 256;
float tx,ty;
int diameter = 3;
float lx,ly;
float prum;
int tahy = 2;

int counter = 0;

int roz = 1;

void setup() {
  size(320,254,P2D);
  smooth();
  noStroke();

  lx=tx=x;
  ly=ty=y;

  strokeWeight(3);

  // you have to call always Ani.init() first!
  Ani.init(this);
  background(128);
  prum = 0;
}

void draw() {

  tint(255,0,0,254);
  image(g,0.5,1);
  //background(255);
  //stroke(0,200);
  // line(x,y,lx,ly);

  float len = dist(x,y,lx,ly);

  for(float f =0;f<len;f+=roz) {
    float tempx = lerp(lx,x,f/len);
    float tempy = lerp(ly,y,f/len);



    pushMatrix();
    translate(tempx,tempy);
    rotate(atan2(ly-y,lx-x));
    prum+=((dist(lx,ly,x,y))-prum)/3.0;

    stroke(100,200);
    line(0,-prum/4.0,0,-prum);

    stroke(255,200);
    line(0,prum/4.0,0,prum);


    popMatrix();
  }

  lx=x;
  ly=y;

  /*filter(BLUR,1.1);

  for(int y=0;y<width;y++) {
    for(int x=0;x<height;x++) {
      stroke(random(20),random(25));
      point(x,y);
    }
  }

  saveFrame("vid/blbost####.png");
*/

  if(dist(x,y,tx,ty)<1.0||frameCount==1) {
    tx=random(width);
    ty=random(height);
    reach();



  }
}


void reach() {


  Ani.to(this, 0.3, "x", tx, Ani.CIRC_IN);
  Ani.to(this, 0.3, "y", ty, Ani.CIRC_OUT);
}

void mouseReleased() {
}

