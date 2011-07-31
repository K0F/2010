// Sktript Ctyri
// Obraz a kod 2010

// vice v lexikonu _07_ smycky

int X,Y;

void setup(){

	size(320,240);
	
	rectMode(CENTER);
	
	fill(0);

}

void draw(){
	
	background(127);

	X = mouseX;
	Y = mouseY;

	for(int x = 0; x < width ; x+=5 ){
		for(int y = 0; y < height ; y+=5 ){
			// pseudonahodne cislo od 0 .. 255
			// map skaluje parametry (puvodni min, puvodni max, vysledny min, vysledny max)
			// vzdalenost se meri funkci dist(x1, y1, x2, y2);
			fill( map( dist(X,Y,x,y), 0, 100, 0, 255) ); 
			
			 // na kazde pozici udelej bod
			rect( x, y , 5, 5);
		}
	}

}

