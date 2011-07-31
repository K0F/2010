class Entit {
  float x = 256;
  float y = 256;
  float tx,ty;
  int diameter = 3;
  float lx,ly;
  float prum;
  int tahy = 2;
  color c;
  float speed = 1.0;
  int counter = 0;
  
  String A,B;

  int roz = 1;


  Entit() {

    A = solvers[(int)random(solvers.length)];
    B = solvers[(int)random(solvers.length)];
    
    ly=x=width/2;
    lx=y=height-10;
    
    tx=width/2;
    ty=height/2;
    
   

    prum = 1.1;
    
    speed = 2.0;//random(10,100)/500.0;
    
    c = color(random(255),random(255),random(255));
  }

  void update() {
    float len = dist(x,y,lx,ly);

    for(float f =0;f<len;f+=roz) {
      float tempx = lerp(lx,x,f/len);
      float tempy = lerp(ly,y,f/len);



      pushMatrix();
      translate(tempx,tempy);
      rotate(atan2(ly-y,lx-x));
      prum+=(dist(lx,ly,x,y)/2.0-prum)/30.0;

      stroke(255,200);
      line(0,-prum/8.0*speed,0,-prum/2*speed);

      stroke(c,200);
      line(0,prum/8.0*speed,0,prum/2*speed);


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

    if(dist(x,y,tx,ty)<1.0||counter==0) {
      tx=mouseX;//random(width);
      ty=mouseY;//random(height);
     // speed = 0.2;//random(10,100)/500.0;
      reach();
      counter++;
    }
  }


  void reach() {


    Ani.to(this, speed, "x", tx, A);
    Ani.to(this, speed, "y", ty, B);
  }
}

