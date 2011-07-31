// Prace s funkcemi

// Funkce,
// pro usporadani kodu je sikovne pouzit funkce
// uvadeji se prikazem "void" a dale nazvem funkce
// do zavorek se da priradi jakakoli vstupni hodnota
// promenne uvnitr funkce nejsou dostupne zvenci
// funkce ovsem muze pracovat i s vnejsimi hodnotami

PImage obrazek;

void setup(){
  obrazek = loadImage("obrazek.jpg");
  size(obrazek.width*10,obrazek.height*10); 
  background(0);

  int sirka = width;
  // jelikoz "setup" je take vlasne funkci, promenna "sirka" bude 
  // na konci setupu znicena
  tiskniDoKonzoleCislo( sirka );
  // takto vypada spusteni funkce .. tato "tiskniDoKonzoleCislo(int hodnota)" je definovana nize
  // funkce se poznaji tak, ze konci "()" -kulatymi zavorkami
  // do zavorek je mozne vepsat i promennou kterou prijmou jako vstupni hodnotu
  //  
}

void tiskniDoKonzoleCislo(int _docasnaPromenna){
  int abc = _docasnaPromenna; 
  println(abc); 
}
// jednoducha funkce spoustena ze setupu

void draw(){  
  kresliObraz(mouseX,mouseY,55.0);  
}
// "draw()" - tedy hlavni processingova kreslici smycka je take funkci


// definice vlastnich funkci mohou byt temer kdekoli v kodu,
// to ze jsou zde na konci nevadi, processing o nich bude vedet jelikoz
// budou nacitany prioritne

void kresliObraz(float _x,float _y,float _alpha){
  tint(255,_alpha);
  image(obrazek,_x,_y);  
}

void uplnePrimitivniFunkce(){
 println("..."); 
}

void funkceVeFunkci(){ 
 uplnePrimitivniFunkce(); //spusteni 1. funkce
 kresliObraz(10,10,50); //spusteni 2. funkce
  // atd...
}
// usporadani se muze i vetvit,
// vsechny funkce mohou uvnitr spoustet neomezeny pocet dalsich dalsi
// to se hodi k prehlednosti a organizaci kodu

