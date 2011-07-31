// Prace s promnennymi
// prirazeni hodnoty: =
//
// zakladnio operace: +,-,*,/
// prirustky: ++,--
// porovnavani: ==,!=,<,>
//
// dalsi operace: +=7,-=3,*=4,/=2
// zvlastni operace: % (modulo)
// (bitwise operace pro milovniky hexu &,|, a bit shifty - posuny: >> <<)
//
// dale matematicke operace:
// sq,sqrt,pow,dist,map,norm,constrain,round,ceil,roof,random..
// sin,cos,tan,atan,atan2 .. acos,asin
//
// zmeny datatypu.. "int nejakyInteger = (int)nejakyFloat";

// Vytvoreni promenne, zde se jedna o cele cislo - "int" - integer
int pocitadlo;
// lze vytvorit i s prirazenim hodnoty, napriklad: int pocitadlo = 0;
// promennou si muzeme nazvat jakkoli, zde "pocitadlo", doporuciji kratsi a vzdy vystizne :)

void setup(){
  size(200,200);
  stroke(255);
  // "stroke" barva kontury, v dalsim prikladu (_04_Kresba)

  pocitadlo = 0;
  // prirazeni hodnoty se provadi pomoci "=" 
  // promenna je vzdy vlevo, nova hodnota vpravo
}

void draw(){
  pocitadlo ++;
  // "++" toto je tzv increment - prirustek, promenna bude vzdy navysena o 1;
  // jedna se o zkreceny zapis "pocitadlo += 1;", nebo "pocitadlo = pocitadlo + 1;"
  // take mozne "--", decrement - ubytek

  background(pocitadlo); 
  // se zmenou v promenne se bude v case menit pozadi 0..255, cerna az bila
  // "background(color);"

  if(pocitadlo > 255) {
    pocitadlo = 0;
  }
  // jednoducha podminka, jestlize pocitadlo presahne 255 vrat zpet na nulu
  // vice nize..
}


/* .. k podminkam,
 podminky jsou velmi zakladnim nastrojem pro stavbu programu, utvari dej a odklonuji program do ruznych cest
 
 podminka se pise slovem "if", pak nasleduji kulate zavorky "( )" do nich patri dotaz,
 mohou nasledovat curly zavorky "{ }" v nich se pise to co ma byt spusteno jestlize je
 splnena predchozi podminka, tedy:
 if(neco > necoMensiho){ udelej toto }; 
 if(neco == 2){ udelej toto }; 
 
 nebo nejkratsi s booleanem:
 boolean b = true;
 if(b){ udelej toto }; 
 
 lze take napsat co se stane pokazde kdy neni splnena podminka, pomoci "else"
 
 if( 1 > 0 -coz neni) { udelal bych toto } else { jinak udelam toto };
 
 pracovat lze i s vicenasobnymi podminkami, "&&" znamena logicke A, "||" znamena logicke NEBO:
 if((neco > necoMensiho)&&(neco2 > necoMensiho)){ pri splneni obou podminek udelej toto };    
 if((neco > necoMensiho)||(neco2 > necoMensiho)){ pri splneni jedne ze dvou podminek udelej toto };
 
 pro dalsi pominkovani je jeste uzitecne:
 switch(neco){
 case 1: v pripade ze neco == 1, udelej toto; break;
 case 2: v pripade ze neco == 2, udelej neco jineho; break;
 case 3:....atd.
 } 
 
 a take:
 while(true){ delej dokud je pravda (nebo break;)} - dokud splnuje nejakou podminku opakuje prikazy v curly zavorece
 (while je blizsi smyckam "for"- tzv. iterace, vice v _07_Smycky)
 */
