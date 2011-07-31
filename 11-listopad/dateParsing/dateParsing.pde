String dates[];
PFont font;


void setup() {

  size(320,240,P2D);
  background(50);

  font = createFont("Anivers",9);
  textFont(font);
  textMode(SCREEN);



  println(dates); 

  dates = generate(20);
}

void draw() {
  if(frameCount%5==0) {
    dates = generate(1);
    saveResult();  
}

  background(50);
  fill(200);

  for(int i = 0 ;i<dates.length;i++)
    text(dates[i],10,i*11+11);
}

String[] generate(int kolik) {

  int yea[] = new int[kolik];
  int mont[] = new int[kolik];
  int minu[] = new int[kolik];
  int hou[] = new int[kolik];
  int da[] = new int[kolik];
  int sec[] = new int[kolik];
  String[] result = new String[kolik];


  for(int i = 0 ;i < kolik;i++) {
    yea[i] = 2010;
    da[i] = (int)random(1,30);
    mont[i] = (int)random(0,12);
    hou[i] = (int)random(0,24);
    minu[i]  = (int)random(0,60);
    sec[i] = (int)random(0,60);
    result[i] = yea[i]+
      "_"+nf(da[i],2)+
      "_"+nf(mont[i],2)+
      "_"+nf(hou[i],2)+
      "_"+nf(minu[i],2)+
      "_"+nf(sec[i],2);
  }

  return result;
}

void keyPressed() {
  if(key == ' ') {
    saveResult();
  }
}

void saveResult() {

  for (int i = 0 ; i < dates.length; i++) {
    saveStrings(sketchPath+"/videa/"+dates[i]+".mov",new String[] {
      "data","data","data"
    }
    );
  }
}

