import processing.pdf.*;

int[][] field;
Signal s[];
int NUM = 90;
boolean change[][];

Recorder r;
boolean rec = false;

int tl = 1;

int cout = 0;

boolean render = false;

void setup() {

// a3 = 4960 x 3507 
  size(3506/2, 4960/2 ,P2D);


  frameRate(25);

  field = new int[width][height];
  for(int ii = 0; ii< field[0].length;ii++) {
    for(int i = 0; i< field.length;i++) {
      field[i][ii] = 5;//(int)random(8);
      //print(field[i][ii]);
    }
  }


  change = new boolean[width][height];
  for(int ii = 0; ii< change[0].length;ii++) {
    for(int i = 0; i< change.length;i++) {
      change[i][ii] = false;//(int)random(8);
      //print(field[i][ii]);
    }
  }

  s = new Signal[NUM];
  for(int i = 0;i<s.length;i++)
    s[i] = new Signal();


  if(rec) {

    r = new Recorder("fields","timeLapse"+tl);
  }

  background(0);


  if(render) {
    beginRecord(PDF, "screen.pdf");
 
  }
}


void draw() {


if(!render){
 //   if(frameCount<10)
   //   background(0);

    //colorizeField();

    //
}

    change = new boolean[width][height];
    for(int ii = 0; ii< change[0].length;ii++) {
      for(int i = 0; i< change.length;i++) {
        change[i][ii] = false;//(int)random(8);
        //print(field[i][ii]);
      }
    }

    cout = s.length*2;

    for(int i = 0;i<s.length;i++)
      s[i].update();


if(frameCount>1100){
	fade(5);
    for(int i = 0;i<s.length;i++)
      s[i].draw();
      if(frameCount>1450){
      save("print.png");
      exit();
      }
      }else{
      println(frameCount);
      }


    if(rec&&frameCount%tl==0) {
      //filter(BLUR,1.5);
      r.add();
    }
  }

  void keyReleased() {
    if(key=='q') {
      if(rec)
        r.finish();
      exit();
    }
    else if(key == 'r') {
      endRecord();
      exit();
    }
  }

  void fade(int al) {
    fill(0,al);
    noStroke();
    rect(0,0,width,height);
  }

  void colorizeField() {
    for(int yy = 0;yy<height;yy++) {
      for(int xx = 0;xx<width;xx++) {
        if(field[xx][yy]%2==0) {
          	fill(255,15);
		noStroke();
        }
        else {
		fill(0,15);
          noStroke();
        }
        //stroke(lerpColor(#ff0000,#00ff00,norm(field[xx][yy],0,7) ), 15);
        rect(xx,yy,1,1);
      }
    }
  }

  class Signal {

    int x,y;
    int nx,ny;

    Signal() {
      x = (int)random(width);
      y = (int)random(height);
    }

    Signal(int _x,int _y) {
      x = _x;
      y = _y;
    }

    void update() {

      if(field[x][y]==0) {
        nx = (x + width - 1)%width;
        ny = (y + height - 1)%height;
      }
      else if(field[x][y]==1) {
        nx = (x + width + 0)%width;
        ny = (y + height - 1)%height;
      }
      else if(field[x][y]==2) {
        nx = (x + width + 1)%width;
        ny = (y + height - 1)%height;
      }
      else if(field[x][y]==3) {
        nx = (x + width + 1)%width;
        ny = (y + height + 0)%height;
      }
      else if(field[x][y]==4) {
        nx = (x + width + 1)%width;
        ny = (y + height + 1)%height;
      }
      else if(field[x][y]==5) {
        nx = (x + width + 0)%width;
        ny = (y + height + 1)%height;
      }
      else if(field[x][y]==6) {
        nx = (x + width - 1)%width;
        ny = (y + height + 1)%height;
      }
      else if(field[x][y]==7) {
        nx = (x + width - 1)%width;
        ny = (y + height + 0)%height;
      }

      if(!change[x][y]) {
        field[x][y] = (field[x][y]+2)%8;//(int)random(4);
        change[x][y] = true;
      }

      if(frameCount%10==0&&s.length<=cout&&random(100)<5) {

        expa();
      }

      x = nx;
      y = ny;
    }

    void expa() {
      s = (Signal[])expand(s,s.length+1);
      s[s.length-1] = new Signal((x+1)%width,y);
    }

    void draw() {
      pushMatrix();
      translate(x,y);
      //noStroke();
      stroke(255,100);//map(frameCount,0,100,0,120));
      point(0,0);
      popMatrix();
    }

    int computeNextStep() {
      int tmp = 0;


      return tmp;
    }
  }

