// Knihovny

/* Obrovskou silou processingu je moznost jeho rozsireni
  v soucasne dobe existuje nespocet moznych knihoven ke stazeni (primo na processing.org)
  
  Processing potrebuje mit vsechny knihovny nakopirovane ve slozce "libraries"
  pod rootem hlavniho programu
  
  V tomto prikladu je vyuzivana knihovna VIDEO, ktera je soucasti zakladniho baliku processingu
  stejne jako dalsi knihovny:
  DXF - pro praci s vektorovym vystupem autocad, 3d programy atd.
  XML - pro praci s tabulkami
  CANDY - pro nacitani vektorove grafikou ve formatu svg - Adobe Illustrator
  JAVASCRIPT - komunikace s prohlizeci servery skrze javascript
  PDF - specialni renderer pro tisk do PDF
  OPENGL - pristup processingu ke graficke akceleraci, velmi uzitecne pro narocnejsi kresleni
  SERIAL - seriova datova komunikace, od Arduina pres bluetooth az po buhvico 
  
  a konecne VIDEO - balik pro praci s videem, tato knihovna vyzaduje pro zakladni funkcnost nainstalovany quicktime
  take na nekterych Win pocitacich vhodny win-Vdig (quicktimovy hack pro javu)
  knihovna umi jak zobrazovat video, komunikovat s externimi zarizenimi (webkamerami), tak nahravat do souboru
     
 */

// prvni vec kterou jakakoli knihovna potrebuje, je prikaz "import"
// to se da napsat takto:
import processing.video.*;
// nebo jednoduseji vyberte ze zalozky SKETCH > IMPORT LIBRARY > VIDEO 

Movie mojeVideo;
// "Movie" je objekt z knihovny
// objekt je soubor funkci, promennych a sad nastroju(interfacu) pro jeho ovladani
// .. o objektech pozdeji


void setup() {
  size(640, 480, P3D);
  // pro rychlejsi render je zde pouzita zakladni akcelerace P3D..
  // je to dalsi moznost funkce "size(x,y,render)"
  // processing zatim nabizi tyto renderery:
  // "JAVA2D" - prednastaveny, klasicky, cisty a trochu pomalejsi
  // "P2D" - zatim nedopracovana 2D gradicka akcelerace - nepouzitelna 
  // "P3D" - velmi vykony pro carovou grafiku, obraz, mnoho objektu na scene, podporuje z dimenzi
  // "OPENGL" - vykony ale mene kompatibilni 3D renderer, obcas mi prijde cistsi nez P3D, vyzaduje importovani knihovny "OPENGL"
  
  // "PDF" - jen pro tisk do souboru *.pdf, vyzaduje import knihovny PDF
  
  background(0);
  // pozadi jedenkrat.. jsme v "setupu"
  
  // instanci knihovniho objektu "Movie" nazvanemu "mojeVideo" vytvorime takto:
  mojeVideo = new Movie(this, "station.mov");
  // zakladani objektu je vzdy velmi podobne
  // funnguje podobne jako promenna
  // klicove slovo "new" znaci vytvoreni objektu
  // nasleduje jmeno objektu s argumenty "this" a "nazvemSouboru.mov"
  // "this" - vetsinou potrebuji knihovny vedet pro svoji implementaci do naseho kodu
  // (odkazuje k tomuto kodu, ktery je vlastne take objektem, ..to nic, pozdeji)
    
  //instanci muzeme dat prikaz skrze "."+"knihovniFunkci()" asi takto: 
  mojeVideo.loop();
  // ".play()" spusti prehravani souboru, ".loop()" neustale prehravani, ".stop()" zastavi
  // ".jump(3.10)" - jde na pozici ve vterinach atd.. vice v referencich na processing.org  
}


void movieEvent(Movie mojeVideo) {
  mojeVideo.read();
}
// specialni funkce pro nacitani okenek, slouzi ke komunikaci s nasim kodem,
// "movieEvent()" je volan pokazde, kdyz je k dispozici dalsi okenko,
// pak tato funkce zavola ".read()" na nas objekt a nacita dalsi
// proces je zautomatizovan knihovnou, tuto funkci tudiz nemusime nikdy volat


void draw() {
  tint(255, 20);
  // nastavi pruhlednost obrazku
  // "tint(color)" - slouzi pro jednoduche barevne a pruhlednostni upravy obrazku
 
  image(mojeVideo, mouseX-mojeVideo.width/2, mouseY-mojeVideo.height/2);
  // konecne zde se zobrazuji okenka ze souboru
  // knihovna vraci klasicky obrazek (PImage) tedy, da se zobrazit prikazem
  // image( PImage , x , y );
  // pro nacentrovani na kurzor je zde pouzit jeste odecet poloviny sirky obrazku z x a y
  // chcete-li roztahnout obraz na celou plochu
  // da se pouzit image takto:
  // image( PImage , x , y , sirka , vyska )
  // tedy image(mojeVideo,0,0,width,height); ..u nekterych stroju to ovsem muze delat problemy
}
