PImage bck;
Person hero;
PGraphics canvas;

int cx,cy;

void setup() {
  size(400,300,P2D);
  bck = loadImage("street.gif");


  hero = new Person(0,1);

   // p[i] = new Person(i,band);
  

  canvas = createGraphics(width*2,height*2+35*2,P2D);

  noSmooth();

  noFill();
  stroke(0);

  cy = cx = 0;
}


void draw() {
  background(bck);
  image(canvas,0,0,width,height);
  
  
  hero.draw();
/*



  Arrays.sort(p);
  for(int i = 0 ;i<p.length;i++) {

    p[i].draw();
  }*/
}

void world() {
  translate(width/2,height/2,-height/2);
  rotateX(radians(60));
  rotateZ(radians(-45));
  ortho(-width/2, width/2, -height/2, height/2, -width/2, width/2);
  // translate(-190,-160,0);
}

void keyPressed() {
  if(keyCode==LEFT) {
    hero.x-=2;
  }
  else if(keyCode==RIGHT) {
    hero.x+=2;
  }
  else if(keyCode==UP) {
    hero.y-=2;
  }
  else if(keyCode==DOWN) {
    hero.y+=2;
  }
  //println(cx + " und "+cy);
}

