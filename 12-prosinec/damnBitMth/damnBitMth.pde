void setup() {
  size(320,320,P2D);
  loadPixels();
  colorMode(HSB,MAX_INT);

  for(int i = 0;i<pixels.length;i++)
    pixels[i] = color(120);//color(random(255));
}

int z;

void draw() {
 // tint(255,0,255,20);  
  image(g,1,0);
 
  
  
  loadPixels();
  for(int y = 0;y<height;y++) {
    for(int x = 0;x<width;x++) {
      int idx = y*width+x;
      
       if(((x^y)|(x&y))%((frameCount%((frameCount%90)+1)+1))==(frameCount%2)){
        pixels[idx] = ((x&y)+1)-MAX_INT;// (pixels[idx] >> 2 & 0xff0000) / 100.0; 
       }
       
    }
  }
  updatePixels();
}

