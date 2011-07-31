// Kresba a dalsi prace s promennymi

int pocitadlo;

void setup(){
  size(200,200);

  stroke( 255 , 128 , 0 );
  // "stroke" udava barvu kontur objektu, pro zadnou barvu "noStroke()"
  // (255,128,0) RGB - "takova oranzova" - viz. TOOLS > COLORSELECTOR
  
  fill(255);
  // "fill" nastavuje barvu vyplne
  noFill();
  // pro zadnou vypln prikaz "noFill()"  

  // v pripade ze jsme zavolali stroke,fill,noStroke,noFill jen jednou,
  // prikazy budou fungovat globalne k celemu programu
  // jestlize v prubehu nize zavolame jednu z funkci znovu
  // prepise se dokud nebude volana znovu ...
  
  pocitadlo = 0; 
  // nase promenna - "pocitadlo" na nulu
}

void draw(){
  background(0); 
  pocitadlo ++; 
  
  line(0,pocitadlo,width,pocitadlo);  
  // "line" je linka,usecka jeji pozice se urcuje (x1,y1,x2,y2)
  // x1 - pocatecni bod x, y1 - pocatecni bod y
  // x2 - konecny bod x, y2 - konecny bod y
  // "width" je globalni promenna programu ktera drzi informaci o sirce okna
  // pro vysku je tu "height"
  
  rect(width/2,pocitadlo,20,20);
  // "rect" - rectangle - obdelnik (x,y,sirka,vyska)
  // x,y je v defaultu nastaven jako levy horni roh obdelniku (je mozne zmenit za pomoci "rectMode")
  // do kolonky x je zde zapsan vypocet "width/2" tzn. polovina sirky okenka  
  
  ellipse(width/2+30,pocitadlo,20,20);
  // "ellipse" (x,y,prumerX,prumerY)
  // x,y jsou nasaveny jako stred elipsy (je mozne zmenit za pomoci "ellipseMode")


  if(pocitadlo > height) {
    pocitadlo = 0;
  }
}
