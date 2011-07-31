// processing 2 - NOD / Roxy 6.5. 2008 Praha
// :: krystof pesek

// 10 pole objektu a jejich vzajemna interakce//

// promenna drzici pocet castic
int pocetCastic = 500;

// zde se vytvari pole objektu "[]"
// zatim je abstraktne velke
Castice castice[];

void setup(){
  size(400,400,P3D);
  background(0);
  
  // zde si urcime velikost pole
  castice = new Castice[pocetCastic];
  
  // a naplnime ho vicenasobnym castem naseho objektu..
  for(int i = 0;i< pocetCastic;i++){
    // posleme do kazdeho objektu "[i]" - "i" promennou, ktera se promeni
    // v objektu v "id".. viz nize
    castice[i] = new Castice(i); 
  }
}



void draw(){  
  // syckou kazdy obekt zavolame k behu
  // tedy vypocte a vykresli se zde 500 objektu kazde okno
  for(int i = 0;i< pocetCastic;i++){
    castice[i].spust(); 
  }
}


// definice class "Castice"
class Castice{
  // jeji lokalni promenne
  float x,y;
  float speed = 10000.0;
  int id;
  float vzdalenost;
  float okruh = 100.0;
  boolean visible = true;

  // jeji konstruktor
  Castice(int _id){
    // prevzeti promenne ktera bude posleze pouzita pro identifikaci objektu
    id=_id;

    //width a height jsou globlani promenne ktere objekt zna, jako kterekoli jine globalni promenne
    x=random(width); 
    y=random(height);    
  }

  // funkce ktera pouze spousti lokalni funkce, navenek bude srozumitelnejsi
  void spust(){
    pocitej();
    
    if(visible){
      kresli();    
    }
  }
  
  
  // funkce zajistujici vypocet pohybu
  void pocitej(){
    for(int i = 0;i< castice.length;i++){
      if(id!=i){
        vzdalenost = dist(x,y,castice[i].x,castice[i].y);          
        if(vzdalenost < okruh/3.0){
          x -= (castice[i].x-x) / (speed*0.2);
          y -= (castice[i].y-y) / (speed*0.2);
        }else if(vzdalenost < okruh){
          x += (castice[i].x-x) / speed;
          y += (castice[i].y-y) / speed;
        }
      }
    }
    hranice();        
  }

  void hranice(){
    x=constrain (x,0,width);
    y=constrain (y,0,height);

  }

  void kresli(){
    noStroke();
    fill(255,5);
    rect(x,y,3,3);
  }
}


// timto zpusobem se daji programy vrstvit a rozdelovat,
// pro prehlednejsi usporadani a lepsi orientaci v kodu

