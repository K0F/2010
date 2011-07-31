
int freq = 1;

String places[] = {"Praha","Kladno","Kralupy%20nad%20vltavou","Ricany","Cernosice","Benesov","Rakovnik","Louny","Mlada%20Boleslav","Pardubice","Prachatice","Brno","Ostrava","Olomouc","Plzen","Znojmo"};
Location loc[];

int minrun = 0;

int minute ,minuteLast;

void setup() {
  size(1680, 700, P2D);
  
  textFont(createFont("Helvetica",9,true));
  textMode(SCREEN);  
  frameRate(25);

  minute = minuteLast = minute();
  stroke(255);
  noFill();


  loc = new Location[places.length];

  for(int i = 0 ;i<loc.length;i++)
    loc[i] = new Location(places[i],this);

}


void draw(){
  
  minute = minute();
  if(minute!=minuteLast){    
    if(minrun%freq == 0){
     for(int i = 0 ;i<loc.length;i++)
      loc[i].update(); 
    }
    minrun++;

  background(0);

  for(int i = 0 ;i<loc.length;i++)
    loc[i].draw();// = new Loc(places[i]);

  line(0,height/2,width,height/2);

  }
  

  minuteLast = minute;

    
  
    
}

void keyPressed(){
  for(int i = 0 ;i<loc.length;i++)
      loc[i].update();
}









