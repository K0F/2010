
class AV {

  Data d;
  PImage img;
  String fileName;
  float buff[];
  float x,y,w,h;
  int id;
  float a;

  AV(String _fileName,int _id) {
    fileName = _fileName;
    id = _id;



    x = width/2;//random(width);
    y = height/2;
    //random(height);
    
    regenerate();

    d = new Data();
    d.generate(id,buff);
    


    // adds the signal to the output
    out.addSignal(d);

  }
  
  void regenerate(){
    w = random(1,10)*22;
    h = random(1,10)*22;

    
    img = createImage((int)w,(int)h,ARGB);
    PGraphics tmp = regen();
    tmp.loadPixels();    
    img.loadPixels();
    
    for(int i =0;i<tmp.pixels.length;i++)
      img.pixels[i] = tmp.pixels[i];
    

    buff = new float[img.pixels.length];
    for(int i = 0;i<img.pixels.length;i++) {
      buff[i] = map(brightness(img.pixels[i]),0,255,-1,1);
    }


  }

  PGraphics regen() {
    PGraphics tmp = createGraphics((int)w,(int)h,JAVA2D);
    
    tmp.beginDraw();
    tmp.smooth();
    tmp.background(random(120,255));
    
    tmp.stroke(0);
    tmp.fill(0);
    tmp.strokeWeight(5);
    for(int i = 0;i<5;i++){
     tmp.line(random(w),random(h),random(w),random(h)); 
    }
    tmp.endDraw();
    
    
    
    return tmp;
  }

  AudioSignal getBuff() {
    return d;
  }

  void draw() {
    image(img,(int)(x-w/2),(int)(y-h/2));
  }
}

