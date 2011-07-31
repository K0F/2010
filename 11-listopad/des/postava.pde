

class Person implements Comparable {
  Splat s;
  PGraphics face;
  PImage skin;
  float x,y,ty,tx,px,py;
  int id;
  boolean msk[];
  int blood = 0;
  boolean bleeding = false;
  boolean dead = false;
  float deadAng = 0;
  int band = 0;
  int target = (int)random(p.length);
  boolean once = true;
  color shirtC,hairC,trousC;

  Person(int _id) {
    skin = loadTrans("generic.gif");
    id =_id;
    x = width/2;
    y = height/2;
  }

  Person(String _skin,int _id) {
    id = _id;

    skin = loadTrans(_skin);
    face = createGraphics(skin.width,skin.height,P2D);

    tx = x = (int)random(-60,60);
    ty = y = (int)random(-60,60);
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
      shirtC = color(random(120),random(130),random(110));
      hairC = color(random(30),random(20),random(10));
      trousC = color(random(130),random(130),random(130));
    }



    s = new Splat(10,x,y);
    s.time = 100;

    skin = loadTrans(nameSkin);


    face = createGraphics(skin.width,skin.height,P2D);

    tx = x = band*200-(int)random(-60,60);
    ty = y = band*200-(int)random(-60,60);
  }

  void draw() {

    int r =0;

    if(!dead) {



      tx += (int)random(-1.9,2);
      ty += (int)random(-1.9,2);
      
      tx += (-tx)/200.0;
ty += (-ty)/200.0;

      x += (tx-x)/3.0;
      y += (ty-y)/3.0;

      px = x;
      py = y;
      
      


      for(int q = 0;q<p.length;q++) {

        r = (int)random(p.length);

        if((p[r].band!=band) && 
          (!p[r].dead) && (abs(x - p[r].x)<1.0) &&
          (abs(y - p[r].y)<1.0) && 
          (p[r].id!=id)) {

          s = new Splat((int)random(80),0,0);
          
          tx -= (p[r].x-tx)/((dist(x,y,p[r].x,p[r].y)+1.1)*30.0);
          ty -= (p[r].y-ty)/((dist(x,y,p[r].x,p[r].y)+1.1)*3.0);

          for(int i = 0;i<200;i++) {
            int xx = (int)random(skin.width);
            int yy = (int)random(skin.height);

            if(msk[yy*skin.width+xx]) {
              face.beginDraw();
              face.stroke(random(255),10,10);
              face.point(xx,yy);
              face.endDraw();
              blood ++;
            }
          }
        }
      }

      if(blood>170) {
        bleeding = true;

        canvas.beginDraw();
        canvas.noSmooth();
        canvas.pushMatrix();
        canvas.noFill();
        canvas.stroke(random(255),10,10,30);
        canvas.translate(canvas.width/2,canvas.height/2);    
        for(int i = 0;i<blood/10;i++) {
          canvas.point(x*2+random(-2,2),y*2+random(-2,2));
        }
        canvas.popMatrix();
        canvas.endDraw();
      }
    }

    if(blood>200 && !dead) {
      dead = true;
      deadAng = atan2(y-p[r].y,x-p[r].x);
      px = x;
      py = -2000;
    }
    //y = (int)(sin(frameCount/10.0)*30);
    //resetMatrix();


/*
    if(blood > 100){
      if(band==1){
     target = (int)random(p.length/2,p.length-1);
     // x-=2;y-=2; 
      }else{
      //  x+=2;y+=2;
        target = (int)random(0,p.length/2);      
      }*/
      //tx += (p[target].x-tx)/230.0;
     //ty += (p[target].y-ty)/300.0;
    //}
    
    

    if(p[target].dead || p[target].band==band || (frameCount%(id+3) == 0)){
      target = (int)(random(p.length));
      
    }
      
     

    

    tx += (p[target].x-x)/150.0;
    ty += (p[target].y-y)/150.0;
    
    for(int i = 0 ;i<40;i++){
      tx -= (p[i].x-tx)/((dist(x,y,p[i].x,p[i].y)+1.1)*30.0);
      ty -= (p[i].y-ty)/((dist(x,y,p[i].x,p[i].y)+1.1)*60.0);
    }



    pushMatrix();
    rotateX(radians(-90));
    rotateY(radians(-45));

    translate(x-(int)(skin.width/2),y+skin.height,-50);

    pushMatrix();
    if(dead && once) {
      canvas.beginDraw();
      canvas.noSmooth();
      canvas.pushMatrix();
      canvas.noFill();

      canvas.translate(canvas.width/2,canvas.height/2);    

      for(int i = 0;i<450;i++) {
        canvas.stroke(random(255),10,10,65);
        canvas.point(x*2+random(-80,80),y*2+random(-80,80));
      }
      canvas.popMatrix();
      canvas.endDraw();
      once = false;
    }
    else if (dead) {

      if((random(11)<10)) {

        canvas.beginDraw();
        canvas.pushMatrix();
        canvas.stroke(random(255),10,10,5);
        canvas.translate(canvas.width/2,canvas.height/2);    
        canvas.point(x*2, y*2);
        canvas.popMatrix();
        canvas.endDraw();
        y += (-90-y) / 10.0;
        x += (-62-x) / 22.0;
      }
    }
    else if(!dead) {

      //rotateX(radians(-90));
      // rotateZ(radians(mouseX)-QUARTER_PI);

      //rotateY(radians(random(-20,20)));
      image(skin,0,0);
      image(face,0,0);


      s.animate();
    }

    popMatrix();

    popMatrix();
    // line(0,0,0,width);
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

  PImage loadTrans(String name) {
    PImage src = loadImage(name);
    msk = new boolean[src.width*src.height];
    PImage out = createImage(src.width,src.height,ARGB);


    if (id ==0) {
      src.loadPixels();
      for(int i = 0;i<src.pixels.length;i++)
        println(src.pixels[i]);
    }

    src.loadPixels();
    for(int i = 0;i<src.pixels.length;i++)
      if((src.pixels[i]!=-65321)) {


        if(src.pixels[i]==-16776961) {
          out.pixels[i] = shirtC;
        }


        else if(src.pixels[i]==-65536) {
          out.pixels[i] = hairC;
        }

        else if(src.pixels[i]==-16711936) {
          out.pixels[i] = trousC;
        }


        else {
          out.pixels[i] = src.pixels[i];
        }


        msk[i] = true;
      }
      else {
        msk[i] = false;
      }

    return out;
  }
}

