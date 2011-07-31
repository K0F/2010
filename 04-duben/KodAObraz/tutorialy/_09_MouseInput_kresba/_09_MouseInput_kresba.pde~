// processing 2 - NOD / Roxy 6.5. 2008 Praha
// :: krystof pesek

// 09 jednoducha kresba - mouse input //

float x,y; //zalozeni globalnich promennych x a y
float speed; // promenna speed bude urcovat rychlost castic
boolean kliknuto = false;

int cnt = 0;

void setup(){
  size(400,400);
  background(25); 

  // "rectMode" pro zpusob zakladani obdelniku.. moznosti CORNER, CORNERS, CENTER, nebo RADIUS
  // defaultne je nastaven CORNER
  rectMode(CENTER);

  //vypln bila s pruhlednosti
  fill(255,15); 
  // bez kontury
  noStroke();

  speed = 0.15;
}

void draw(){  
  //rovnice pro vypocet "x" a "y" promenne, je updatovan kazde okenko
  //"x" a "y" k sobe vzdy pricita zlomek rozdilu mezi svoji pozici a pozici kurzoru
  x += speed*(mouseX-x); 
  y += speed*(mouseY-y); 

  //podminka se naplni kdyz je zmacknuto leve tlacitko viz. nize
  if(kliknuto){   
    // ctverec
    rect(x,y,5,5);
  }
}

// moznosti vstupu jsou pestre
// 3 funkce vypsane nize reaguji na podnet mysi 

// 1 tato funkce se spusti (jednou) vzdy na stisknuti jakehokoli tlacitka mysi
// dotazem na nativni promennou "mouseButton" se pak dozvime ktere ze tlacitko
// bylo stisknuto
void mousePressed(){
  // jestlize leve tlacitko?
  if(mouseButton==LEFT){
    println("leve tlacitko zmacknuto"); 
    // cnt pocitadlo okenek pri tahu, zde jen ilustrativne
    cnt = 0;
    // kliknuto true pro splneni podminky v drawu
    kliknuto = true;
  }
  // jestlize prave tlacitko?
  else if(mouseButton==RIGHT){
    println("prave tlacitko zmacknuto"); 
    // smaz cmaranici pozadim
    background(25);
  }
  else{
    // volanim mouseButon se muzeme dozvedet i dalsi tlacika
    // jestlize tedy bude jine nez leve nebo prave zde se dozvime jak se jmenuje
    // a muzeme ho pak namapovat na akci
    println("jine tlacitko zmacknuto, kod: "+mouseButton);
  }
}

// funkce opakovana cyklicky pri tazeni nakliknute mysi
void mouseDragged(){
  // pocitej
  cnt++;
  // a tiskni
  println(cnt+" okenek tahu");
}

// funkce zavolana processingem kdyz zdetekuje odkliknuti mysi, reaguje i na odlkiknuti
// mimo ram programu
void mouseReleased(){
  if(mouseButton==LEFT){
    println("leve tlacitko uvolneno"); 
    // zde se vrati promenna zpet na false
    kliknuto = false;
    // a "x" a "y" se vynuluji na pozici kurzoru, detail
    x=mouseX;
    y=mouseY;
  }
  else if(mouseButton==RIGHT){
    println("prave tlacitko uvolneno"); 
  }
  else{
    println("jine tlacitko uvolneno");
  }
}


