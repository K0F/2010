// Sktript Tri
// Obraz a kod 2010


void setup(){

	size(640,480,P2D);
	noFill();
	
	// stroke s dvame parametry (bila,pruhlednost) 0 .. 255
	stroke(255,15);
	rectMode(CENTER);
	background(0);

}



void draw(){

	//bez pozdaji se pozadi nemaze
	
	// mouseX a mouseY jsou promenne ktere zjisti aktualni
	// pozici mysi na plose
	
	//random pro pseudo-nahodne cislo bud random(5) 0 .. 5 nebo random(0,6)
	rect( mouseX, mouseY, random(60,90), random(30,60));

}
