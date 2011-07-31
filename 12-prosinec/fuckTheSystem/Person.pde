class Person implements Comparable {
  Splat s;
  String nameSkin = "genericB.gif";
  PGraphics face;
  PImage skin[] = new PImage[8];
  float x,y,ty,tx,px,py,lx,ly;
  int id;
  boolean msk[];
  int blood = 0;
  boolean bleeding = false;
  boolean dead = false;
  float deadAng = 0;
  int band = 0;
  // int target = (int)random(p.length);
  boolean once = true;
  color shirtC,hairC,trousC;
  
  float heading;
  int faze = 0;

  Person(int _id) {
    for(int i = 0;i<skin.length;i++) {
      skin[i] = loadTrans(nameSkin,i);
    }
    id =_id;
    x = width/2;
    y = height/2;
  }

  Person(int _x,int _y,String _skin,int _id) {
    id = _id;

    for(int i = 0;i<skin.length;i++) {
      skin[i] = loadTrans(nameSkin,i);
    }
    face = createGraphics(skin[faze].width,skin[faze].height,P2D);



    tx = x = _x;//(int)random(-60,60);
    ty = y = _y;//(int)random(-60,60);
  }

  Person(int _id,int _band) {
    id = _id;
    band = _band;

    String nameSkin;

    if(band==-1) {
      nameSkin = "generic.gif";
    }
    else {
      nameSkin = "genericB.gif";
      
        hairC = color(#270D06);
      shirtC = color(#DEDFE0);
    
      trousC = color(#444F95);
    }



    s = new Splat(10,x,y);
    s.time = 100;

    for(int i = 0;i<skin.length;i++) {
      skin[i] = loadTrans(nameSkin,i);
    }

    face = createGraphics(skin[faze].width,skin[faze].height,P2D);

    lx = tx = x = width/2;//band*200-(int)random(-60,60);
    ly = ty = y = height/2;//band*200-(int)random(-60,60);
  }

  void draw() {
    faze = getFaze();
    
    
    
  x+=(mouseX-x)/30.0;
  y+=(mouseY-y)/30.0;
    
    
    
    if(dist(lx,ly,x,y)>=1){
      heading = degrees(atan2((y-ly),(x-lx))+QUARTER_PI);
      lx = x;
      ly = y;
    }
    
    image(skin[faze],(int)x,(int)y);
  }




  int compareTo(Object o)
  {
    Person other = (Person)o;
    if(other.py>py)  
      return -1;
    if(other.py==py)
      return 0;
    else
      return 1;
  }

  PImage loadTrans(String name,int q)
  {
    PImage src = loadImage(name);
    msk = new boolean[src.width*src.height];
    PImage out = createImage(src.width/8,src.height,ARGB);
    PImage coll = createImage(src.width,src.height,ARGB);


    /*
    if (id ==0) {
     
     for(int i = 0;i<src.pixels.length;i++)
     println(src.pixels[i]);
     }*/

    src.loadPixels();


    for(int i = 0;i<src.pixels.length;i++) {
      if((src.pixels[i]!=-65321)) {


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
          coll.pixels[i] = src.pixels[i];
        }


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
        int idx2 = Y*(src.width)+(X+(q*12));
        if(msk[idx2])
        out.pixels[idx] = coll.pixels[idx2];
      }
    }



    return out;
  }
  
  
  int getFaze(){
    int wh = 0;
    
    
    float a = heading;
    
    if(a>=0 && a<45){
     wh = 2; 
    }else if(a>=45 && a<90){
     wh = 3; 
    }else if(a>=90 && a<135){
     wh = 4; 
    }else if(a>=135 && a<180){
     wh = 5; 
    }else if(a>=180 && a<225){
     wh = 6; 
    }else if(a>=225 && a<270){
     wh = 7; 
    }else if(a>=270 && a<315){
     wh = 0; 
    }else if(a>=315 && a<360){
     wh = 1; 
    }
    
   // wh = constrain((int)(heading%45),0,skin.length-1);
    
    if(heading<0)
    heading=359;
    else
    
    heading = heading%360;
    
    
   // println(heading+" : "+wh);
    
   return wh; 
  }
}

