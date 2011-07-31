import fullscreen.*;

FullScreen fs;

boolean change = false;

void setup(){
  
  size(640,480,P2D);
  
  frameRate(40);
  
  fs = new FullScreen(this);
  
  fs.enter();
  
}

void keyPressed(){
 fs.enter(); 
}

void draw(){
  
  if(frameCount%(mouseX+1)==0){
   change = !change; 
  }
  
  
  if(change){
   background(0); 
  }else{
   background(255); 
  }
  
}

