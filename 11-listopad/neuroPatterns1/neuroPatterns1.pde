int velikost = 300;
int sc = 1;

BX bx;

int shiftx = 2;
int shifty = 0;

boolean matix[][];

color c1 = color(255,128,0);
color c2 = color(0);

void setup(){
  matix = new boolean[velikost*2][velikost];
  size(600,300,P2D);

  frameRate(60);

  for(int y = 0;y<matix[0].length;y++) {

    for(int x = 0;x<matix.length;x++) {
      matix[x][y] = (random(20)>10) ? true : false;
    }
  }

  noStroke();
  noSmooth();

  bx = new BX(width/2,height);
}

void draw(){

  c1 = color(255);
  shiftx = (int)((noise(-frameCount/3003.12)-0.5)*width);
  shifty = (int)((noise(frameCount/3000.0)-0.5)*height);
  for(int y = 0;y<matix[0].length;y++) {
    for(int x = 0;x<matix.length;x++) {
      fill((matix[x][y])?c1:c2,80);
      rect(x*sc,y*sc,sc,sc);
    }

    /* for(int x = 0;x<matix.length/2;x++) {
     fill((matix[x][y])?c1:c2,80);
     rect(x*sc,y*sc,sc,sc);
     }
     
     for(int x = matix.length/2;x<matix.length;x++) {
     fill((matix[matix.length-x][y])?c1:c2,80);
     rect(x*sc,y*sc,sc,sc);
     }*/
  }

  pushStyle();
  noFill();
  strokeWeight(5);
  stroke(0);
  rect(0,0,width,height);
  popStyle();  

  /*  bx.update();
   bx.pix.loadPixels();
   
   for(int y = 0;y<bx.h;y++) {
   for(int x = 0;x<bx.w;x++) {
   if(brightness(bx.pix.pixels[y*bx.w+x])>20){
   matix[x+width/2][y] = false;
   }
   }
   
   }*/

  randomize((int)(noise(frameCount/230.2)*20));
}



void randomize(int kolik) {
  for(int y = 0;y<matix[0].length;y++) {
    for(int x = 0;x<matix.length;x++) {


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
/*

 void keyPressed(){
 save("screen.png"); 
 }*/
