//import processing.opengl.*;

PImage bck;
Person p[];
PGraphics canvas;



int cx,cy;

void setup() {
  size(400,300,P3D);
  bck = loadImage("street.gif");


  p = new Person[120];

  for(int i = 0 ;i<p.length;i++) {
    int band = (random(100)>=50)?-1:1;
    p[i] = new Person(i,band);
  }

  canvas = createGraphics(width*2,height*2+35*2,P2D);

  noSmooth();

  noFill();
  stroke(0);

  cy = cx = 0;
}

void keyPressed() {
  if(keyCode==LEFT) {
    cx-=10;
  }
  else if(keyCode==RIGHT) {
    cx+=10 ;
  }
  else if(keyCode==UP) {
    cy-=10 ;
  }
  else if(keyCode==DOWN) {
    cy+=10;
  }
  println(cx + " und "+cy);
}


void draw() {
  background(bck);
  image(canvas,0,12,width,height);
  world(); 
  /*
  translate(
   map(mouseX,0,width,-width/2,width/2),
   map(mouseY,0,height,-height/2,height/2),
   -100);
   */

  // box(10);


  Arrays.sort(p);

  for(int i = 0 ;i<p.length;i++) {

    if(i==0 || i == p.length-1)
      p[i].target=(int)random(p.length);


    p[i].draw();
  }
}

void world() {


  translate(width/2,height/2,-height/2);
  rotateX(radians(60));
  rotateZ(radians(-45));
  ortho(-width/2, width/2, -height/2, height/2, -width/2, width/2);
  // translate(-190,-160,0);
}

void mousePressed() {
  println((mouseX-width/2) +" : "+(mouseY-height/2)) ;
}



class Hero {
}

class Bullet {
}

