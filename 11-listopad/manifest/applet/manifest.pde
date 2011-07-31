

String s = "Software  Is  A  Process,  Not  A  Product.";
String s2 = "kof";
float uhly[];

int siz = 24;

PFont f,f2;

void setup() {
  size(640,120);
  
  f = createFont("Monospace",siz);
  f2 = createFont("Monospace",siz/2);
 
  fill(0);

  uhly = new float[s.length()];

  for(int i = 0;i<uhly.length;i++) {
     uhly[i] = -noise(i+frameCount/100.0)*360;
  }
}


void draw() {
  background(255);


 textFont(f);
  pushMatrix();
  translate(20,20);
  for(int i = 0;i<s.length();i++) {
    pushMatrix();
    translate(i*map(siz,0,10,0,6),20);
    rotate(radians(uhly[i]));
    uhly[i] = -noise(i+frameCount/40.0)*360;
    text(s.charAt(i),(map(siz,0,30,0,-11.4)),(map(siz,0,30,0,8.2)));
    popMatrix();
  } 



 textFont(f2);
  popMatrix();

  pushMatrix();
  
  for(int i = 0;i<s2.length();i++) {
    pushMatrix();
    translate(width-100+i*map(siz,0,10,0,6/2),height-20);
    rotate(radians(uhly[i]));
    uhly[i*3] = -noise(i+frameCount/100.0)*360;
    text(s2.charAt(i),(map(siz,0,30,0,-11.4/2)),(map(siz,0,30,0,8.2/2)));
    popMatrix();
  }

  popMatrix();
}

void mousePressed(){
  link("http://freesoftwareart.org/readme100/manifesto/", "_new");
}

