
void setup(){
 size(100,100); 
}

int X,Y;

void draw(){  
  X = mouseX;
  Y = mouseY;
  
  for(int x = 0; x < width ; x+=5 ){
    for(int y = 0; y < height ; y+=5 ){
      stroke( map(dist(X,Y,x,y),0,100,0,255) ); //pseudonahodne cislo od 0..255 - pro kazdy pixel jina barevna (cernobila) hodnota
      point(x,y); // na kazde pozici udelej bod
    } 
  }
  
}




