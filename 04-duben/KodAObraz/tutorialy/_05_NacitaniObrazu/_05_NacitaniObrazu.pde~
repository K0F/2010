// Prace s obrazem

PImage obrazek;
// Obrazky processing drzi pod objektem "PImage"
// nejdrive si musime vytvorit jednu instanci objektu - "obrazek"

void setup(){
 obrazek = loadImage("obrazek.jpg");
 // nacteni obrazku z disku pomoci "loadImage(String cesta)"
 // prikaz prednasavene saha do adresare "./data" v vasi sketchi

  size(400,400); 
  background(0);
  
}

void draw(){  
  image(obrazek,mouseX,mouseY);
  // funkce "image" zobrazi obraz v okne, dalsi parametry
  // udavaji osu x a y, zde pouzivam "mouseX" a "mouseY"
// to jsou promenne ktere umeji vratit aktualni hodnotu kurzoru
}

// kazdy obraz je nacitan do pameti javy z disku
// trva to vcelku dost casu, nedoporucuje se nacitat obrazy
// pri chodu "draw()" smycky, lepsi je, pokudmozno, vse nacist
// najednou v setupu

// muze se stat, ze se priliz velke obrazy nevejdou do ram pameti
// v tom pripade program hlasi neco jako: "problem with java heap space"
// to se da vyresit nastavenim processingu, nebo mozna lepe, zmensenim zdrojovych
// souboru


// pristup k jednotlivym pixelum skrze "obrazek.pixels"(int[]), vetsinou musi predchazet "loadPixels()"
// jinak program hlasi neco jako: "array out of length", 
//
//("[]"- hranate zavorky jsou tzv. arrays, pole - skladuji v sobe [x] promennych,objektu..)
// ..ale k arrays pozdeji
