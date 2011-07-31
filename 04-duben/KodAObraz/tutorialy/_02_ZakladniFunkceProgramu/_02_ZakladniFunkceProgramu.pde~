// Zakladni funkce programu
// pro pochopeni processingu je dobre zacit s dvemi zakladnimi funkcemi:
// (o funkcich obecne, vice v prikladu _06_Funkce) 

// 1. "setup()" - funkce, ktera je spustena na zacatku programu, pouze jednou
// slouzi k vychozimu nastaveni programu
void setup(){ // "{" znamenko znacici pocatek funkce
  // hned prvni udaj by mel rikat jak je ramecek velky, prikaz "size"
  size(200,200); //velikost ramecku v "size(int x,int y)" - x a y v pixelech
  
  frameRate(15); //"frameRate(int kolik)" - snimku za vterinu, bez tohoto prikazu prednastaveno 60fps 
  
  println("tisk ze setup-u! " + frameCount); // tisk do konzole, tento bude spusten jednou
  // zajimava promenna "frameCount" uchovava pocet vykreslenych okenek
  // ze "setupu" to bude vzdy = 0
  
}// "}" znamenko znacici konec funkce


// 2. "draw()" - funkce, ktera je spoustana cyklicky, nekolikrat do vteriny - podle "frameRate" - nyni 15x za vterinu
void draw(){
  // v teto smycce se vetsinou provadi kresba, animace, zivy vypocet, prvni co je dobre vykreslit je pozadi
  background(0); //"background" vyplni celou plochu barvou, s jednim udajem od 0..255 - color
  println("tisk z draw-u! " + frameCount);  // tisk do konzole je cyklicky opakovan, "frameCount" vraci udaj o poctu prekresleni
}// "}" znamenko znacici konec funkce
