int dimension = 50;
int horCount = 10;
int verCount = 10;

Flag flag = new Flag(0, 0, dimension);

void setup() {
  size(dimension*horCount, dimension*verCount,P2D);
  noStroke();
  smooth();
  
  colRed = #F52C4B; //#FF0000;
  colBlue = #2281F2; //#0000FF;
  colYellow = #FFE621; //#FFFF00;
  colWhite = #ECF2EB; //#FFFFFF;
  colBlack = #252726; //#000000;
}

void draw() {
}

int horCoor, verCoor = 0;

void keyTyped() {
  println("pressed — keycode:" + int(key) + ", character:" + key + " and horCoor:" + horCoor);
  
  flag.setGlyph(key);
  flag.draw();
  
  if(horCoor != width-dimension) {
    horCoor += dimension;
  }
  else {
    horCoor = 0;
    if(verCoor != height-dimension) {
      verCoor += dimension;
    }
    else {
      verCoor = 0;
    }
  }
  
  flag.setPosition(horCoor, verCoor, dimension);
  
}
