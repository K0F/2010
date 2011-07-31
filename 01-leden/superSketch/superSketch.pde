import processing.opengl.*;

int a = 0;
ArrayList fonts;


void setup(){
  size(320,240,OPENGL);


  fonts = new ArrayList(0); //(PFont.list().length);
  
  Filler fontFiller = new Filler(this);
  fontFiller.start();

  textMode(SCREEN); 
  
  noStroke();   


  background(0);

}


void draw(){

  PFont q = (PFont)fonts.get((int)random(fonts.size()));
  textFont(q);

  fill(255,50);
  text("kof",random(width),a);

  //stroke(0);
  //line(0,a,width,a);

  a+=8;
  if(a>height){
    a = 0;//a % height;
    fill(0,5);
    rect(0,0,width,height);
  }

}

void keyPressed(){
  if(key == ' ')
    save("kofFsude.png");


}

public class Filler implements Runnable{

  public Filler(PApplet parent){
    parent.registerDispose(this);

    }

    public void start(){
      thread = new Thread(this);
      thread.start();    
    }

  public void run(){
    int n = 0;

    for(int q = 0 ;q<PFont.list().length; q++){
      println(PFont.list()[q]);
      fonts.add((PFont) createFont(PFont.list()[q],24));
      n++;
    }  
    println(n+" fonts created");
  }

  public void stop(){
    thread = null; 

  }

  public void dispose(){
    stop(); 

  }



}

