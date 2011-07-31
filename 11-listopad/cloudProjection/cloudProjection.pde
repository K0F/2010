import processing.opengl.*;

int q ;

int step = 30;

float [] rnd;
color [] c;
void setup() {
  size(1024,768,OPENGL);  
  stroke(255);
  noFill();
  //noCursor();
  smooth();

  
  q = 0;
  for(int i = 10 ; i< height ; i += step){
   q++; 
  }
  
  rnd = new float[q];
  c = new color[q];
  
  
  for(int i = 0 ; i< rnd.length ; i += 1){
   rnd[i] = random(-500,500)/300000.0; 
   c[i] = color(random(255));
  }
  
}

void draw() {
  background(0);
  
  strokeWeight(5);
 // translate(width/2,height/2);

  stroke(255);
  /*
  q = 0;
  for(int i = 30 ; i< height ; i += step){
    stroke(c[q]);
    arc(0, 0, i, i, radians(noise(frameCount*rnd[q])*width) , radians(noise(frameCount*rnd[q])*width+rnd[q])+PI-1.2);
    q++;  
}
  */
  
  q = 0;
  for(int i = 30 ; i< height ; i += step){
  
  float base = (sin(frameCount/15.0)+1)*50+i;
  rect(base,base,width-2*base,height-2*base);
  }
  //if(frameCount%50==0)
 // q = (int)((sin(frameCount/6.0)+1)*50)+4;
  //for(int i = 0;i<width;i+=q){
    //line(i,0,i,height);
    
  //}

}

