
color bck = color(0);

PImage src[];

String name = "test2.gif";
int faze = 10;
int interval = 2;

int sc = 4;
int cntr = 0;

void setup() {

  reload();

  size(src[0].width*sc,src[0].height*sc);

  frameRate(30);

  noSmooth();
}

void draw() {

  if(frameCount%interval==0) {

    background(bck);
    image(src[cntr++],0,0,width,height);
    //cntr++;
    if(cntr>=faze){cntr=0;reload();}
  }
}

void reload() {
  src = new PImage[faze];
  for(int i  = 0;i<faze;i++) {
    src[i] = loadTrans(name,i);
  }
}

void keyPressed() {
  reload();
}


PImage loadTrans(String name,int q)
{
  PImage src = loadImage(name);
  boolean msk[] = new boolean[src.width*src.height];
  PImage out = createImage(src.width/faze,src.height,ARGB);
  PImage coll = createImage(src.width,src.height,ARGB);


  /*
    if (id ==0) {
   
   for(int i = 0;i<src.pixels.length;i++)
   println(src.pixels[i]);
   }*/

  src.loadPixels();

  int al = src.pixels[0];
  for(int i = 0;i<src.pixels.length;i++) {
    if((src.pixels[i]!=al)) {

      /*
        if(src.pixels[i]==-16776961) {
       coll.pixels[i] = shirtC;
       }
       
       
       else if(src.pixels[i]==-65536) {
       coll.pixels[i] = hairC;
       }
       
       else if(src.pixels[i]==-16711936) {
       coll.pixels[i] = trousC;
       }
       
       
       else {
       */

      coll.pixels[i] = src.pixels[i];

      //}


      msk[i] = true;
    }
    else {
      msk[i] = false;
    }
  }

  out.loadPixels();
  coll.loadPixels();

  for(int Y = 0;Y<src.height;Y++) {
    for(int X = 0;X<out.width;X++) {

      int idx = Y*out.width+X;
      int idx2 = Y*(src.width)+(X+(q*(src.width/faze)));
      if(msk[idx2])
        out.pixels[idx] = coll.pixels[idx2];
    }
  }



  return out;
}

