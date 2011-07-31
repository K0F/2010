Pix [][] pix;
boolean blik = false;

void setup(){
	size(320,240,P2D);
	noSmooth();
	frameRate(40);

	pix = new Pix[width][height];

	for(int y = 0;y<height;y++)
		for(int x = 0;x<width;x++)
			pix[x][y] = new Pix(x,y);
}

void draw(){
//	blik = !blik;
	for(int y = 0;y<height;y++)
		for(int x = 0;x<width;x++)
			pix[x][y].draw(blik);

//		saveFrame("out/frame####.png");
}

class Pix{
	int x,y;
	//float c;
	//float cc,speed;

	Pix(int _x,int _y){
		x = _x;
		y = _y;
		//speed = random(10,1000);
	}

	void draw(boolean onOff){
		//cc+=speed/10.0;
		if(onOff)
			stroke(noise(((cos((noise(x+frameCount/10.0)+x)/44.34)+1)*3*(sin((y*noise(frameCount/300.0))/42.1133)+1)*3+frameCount+(sin(0.5*dist(x,y,mouseX,mouseY)) * 10.0) )/10.0)*255);
		else
			stroke(255-noise(((cos(x/44.34)+1)*3+(sin(y/42.1133)+1)*3+frameCount+(sin(0.05*dist(x,y,mouseX,mouseY)) * 30.0) )/10.0)*255);

		point(x,y);
		
		
	}
}
