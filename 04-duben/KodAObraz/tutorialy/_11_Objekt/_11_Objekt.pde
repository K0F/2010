// processing 2 - NOD / Roxy 6.5. 2008 Praha
// :: krystof pesek

// 11 objekt, koncepce, zaklady

// objekt je ucelena sada funkci, promennych, operaci ktere
// se chovaji jako jednotne teleso
// objekty se pouzivaji pro organizaci kodu do srozumitelnejsiho tvaru
// pod objektem je mozno predstavit si cokoli, v tomto prikladu
// budeme pracovat s jadnoduchym objektem ktery bude reagovat na uzivateluv
// vstup a kreslit jednoduchy obrazec

// telo objektu vypada nasledovne:
// v processingu se definice omezuje na slovo "class" - tedy hrube prelozeno jako trida
// k zalozeni vlastni class piseme takto:

// class MujObjekt{
//  
// }

// timto se vytvorila class nazvana "MujObjekt"
// ta v sobe muze drzet neomezeny pocet funkci a promennych
// tak napriklad:

class MujObjekt{
  float x;
  float y;
  float rychlost;
  float w,h;

  // tzv. konstruktor je volan jen pri vytvoreni obejktu
  // konstruktor muze obsahovat i vstup promennych z vnejsku
  // napr.
  //  MujObjekt(float _x){
  // //prebrani promenne z vnesku do lokalni objektove
  //   x=_x;
  // }
  // konstruktoru muze byt i vice v jednom objektu
  // tedy objekt muze mit vice verzi zrodu
  // to se da napsat rozdilnymi argumenty v kulatych zavorkach konstruktoru
  //
  // MujObjekt(){ ... }
  // MujObjekt(float x, float y,int id){ ... }


  MujObjekt(){
    y = height/2.0;
    x = width/2.0;
    rychlost = 3.0;
    w = h = 5;
  }

  // funkce ktera pricte k "x" promennou "rychlost", pohyb doprava;
  void pohniSeDoprava(){
    x+=rychlost;
  }

  // funkce ktera odecte od "x" promennou "rychlost", pohyb doleva;
  void pohniSeDoleva(){
    x-=rychlost;
  }

  //funkce ktera vykresli objekt
  void vykresli(){

    // volani vnitrni promenne, i bez teckove syntaxe je srozumitelne
    // rovna se this.zustanNaPlose();
    zustanNaPlose();

    noStroke();
    fill(0);
    rect(x,y,w,h);
  }

  void zustanNaPlose(){
    x = constrain(x,0,width-w); 
    y = constrain(y,0,width-h);    
  }
}


//////////////////////////////////////////////////////////////
// voila
// nyni mame svuj jednoduchy objekt definovan, ten nemusi byt nezbytne na
// zacatku programu, muze byt kdekoli
// nize priklad jak se da pouzit..
//////////////////////////////////////////////////////////////


// vytvoreni objektu zde;
MujObjekt instanceObjektu;

void setup(){
  // tzv. cast objektu, zde se objekt vytvari - vola se konstruktor
  instanceObjektu = new MujObjekt(); 
  size(400,200); 
}

void draw(){
  background(255);
  
  //delici cara na polovine
  stroke(0,155);
  line(width/2.0,0,width/2.0,height);

  if(mouseX>width/2.0){
    // teckovou syntaxi se da takto zavolat funkce objetku
    instanceObjektu.pohniSeDoprava();    
  }
  else if(mouseX<width/2.0){
    instanceObjektu.pohniSeDoleva();    
  }

  //volani kreslici funkce do drawu
  instanceObjektu.vykresli();

  // na vnitrni funkce promenne cokoli se muzeme zvnejsi dostat teckovou syntaxi..
  println("X: "+instanceObjektu.x+"   Y: "+instanceObjektu.x);
}

// objekty maji dalsi zajimave vlastnosti, moho mezi sebou komunikovat
// navzajem se vytvaret, dedit svoje vlastnosti, modifikovat je atd..
// cela koncepce je prevzata z javy, temer cokoli co lze napsat jave
// lze i v processingu, vyjma nejakych poslednich specialit, processing
// defaultne bezi pod javou 1.4.2, tedy vse co je kompatibilni s touto javou
// jinak se da pouzit tzv processing expert pro custom nastaveni
//
// vice o objektech v java referencich:
// http://java.sun.com/docs/books/tutorial/java/concepts/index.html


// objekty mohou tvorit i pole
// v nasledujici sketchi bude popsan koncept poli objektu

