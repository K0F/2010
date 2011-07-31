// processing 2 - NOD / Roxy 6.5. 2008 Praha
// :: krystof pesek

// 10 pole, neb arrays  - skladovani promennych //

// pole jsou vhodne pro uchovavani vetsich poctu promennych
// pod kontrolou, hodi se temer vsude
// pole se pozna tak, ze je vzdy znaceno hranatymi zavorkami "[]"
// jestlize budeme premyslet textualne, promenna je jako pismeno
// ve slove a slovo je sada techto promennych, veta pak muze byt sada
// sad promennych, atd..
// pole mohou obsahovat jakekoli promenne od booleanu, pres floaty az po kompletni objekty

// v praxi to znamena, mame-li 3 promenne
int prvni = 1;
int druhy = 3;
int treti = 5;
// muzeme si z nich udelat jednu
int cisla[] = {prvni, druhy, treti};

// dalsi, temer obvyklejsi zpusoby vytvareni:
// int cisla[] = new int[20]; //vytvori prazdne pole o dvaceti integrech
// int[] cisla = new int[20]; //da se napsat i takto bez rozdilu v ucinku
// int cisla[]; //vytvori prazdne pole s nespecifikovanou delkou*
//             
/*
  void setup(){
   cisla = new int[10]; //*specifikovat nelze mimo  beh programu.. draw nebo loop, tzn. 
  }
*/


// tisk je pripraven na pole tak ze vytiskne vsechny hodnoty v nem obsazene
println(cisla);
println();

// chceme-li se dostat ke konkretni promenne, jak pro zapis tak cteni,
// vpiseme do zavorek
// na jakem miste se nachazi (!pozor na "[0]" znaci prvni promennou v poli)
// tj. 
println("1. promenna: "+cisla[0]);
println("2. promenna: "+cisla[1]);
println("3. promenna: "+cisla[2]);
println();

// pri praci s polemi je neocenitelna smycka ktera nas usetri hodne psani
// ".length" vraci velikost pole
for(int i = 0;i<cisla.length;i++){
 println("loop cislo "+i+"..."+(i+1)+". promenna: "+cisla[i]); 
}


//...
// pole moho byt jedo/dvou/vicedimenzonalni
// tak napr.
int dvouRozmernePole[][] = new int[3][3];
// vytvori prazdne pole o 9 promennych
// na kazdou jednotlivou se muzeme odkazat nasledovne:
dvouRozmernePole[0][2] = 9;

//se dvou rozmernymi polemi se da pak pracovat takto:
println("\n'dvouRozmernePole': ");
for(int x = 0;x<dvouRozmernePole.length;x++){
  for(int y = 0;y<dvouRozmernePole[x].length;y++){
    dvouRozmernePole[x][y] = (int)random(100);
    println("x:"+x+", y:"+y+" ... "+dvouRozmernePole[x][y]);
  }
}

//dalsi zajimave operace pro prace s poli..
//expand(),sort(),reverse(),splice(),arraycopy(),append(),subset(),concat(), a kdo vi co jeste..

// pozn, pri vytvareni vicerozmernych poli se nasobi velikosti kazdeho z nich:
// pole[5][5] .. 25 
// pole[5][5][5] .. 125
// pole[50][50][5][5] .. 62500
// ! pozor na skladovani, nesetrne operovani s priliz velkymi poli muze znacne zpomalit program

  



